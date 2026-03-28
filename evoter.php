
<?php
require_once("dbconnector.php");
require_once("sms.php");

$phoneNumber = $_POST["phoneNumber"];
$text = $_POST["text"];

$level = explode("*", $text);
$phoneNumber = preg_replace('/^0/', '254', $phoneNumber);

/* ---------------- CHECK DOUBLE VOTE ---------------- */
$check = $conn->prepare("SELECT has_voted FROM voters WHERE phone_number=?");
$check->bind_param("s", $phoneNumber);
$check->execute();
$res = $check->get_result();
$row = $res->fetch_assoc();

if ($row && $row['has_voted'] == 1) {
    echo "END Sorry, you have already voted.";
    exit;
}

/* ---------------- FLOW START ---------------- */

if ($text == "") {
    echo "CON Welcome to SmartVote\nEnter Full Name:";
    exit;
}

/* NAME */
if (count($level) == 1) {

    $name = $level[0];

    $stmt = $conn->prepare("INSERT INTO voters (phone_number, full_name) 
    VALUES (?, ?) 
    ON DUPLICATE KEY UPDATE full_name=VALUES(full_name)");

    $stmt->bind_param("ss", $phoneNumber, $name);
    $stmt->execute();

    echo "CON Enter ID Number:";
    exit;
}

/* ID NUMBER */
if (count($level) == 2) {

    $id = $level[1];

    $stmt = $conn->prepare("UPDATE voters SET id_number=? WHERE phone_number=?");
    $stmt->bind_param("ss", $id, $phoneNumber);
    $stmt->execute();

    echo "CON Enter Polling Station:";
    exit;
}

/* POLLING STATION + CONSTITUENCY MAPPING */
if (count($level) == 3) {

    $station = $level[2];

    $stmt = $conn->prepare("UPDATE voters SET polling_station=? WHERE phone_number=?");
    $stmt->bind_param("ss", $station, $phoneNumber);
    $stmt->execute();

    // GET CONSTITUENCY + WARD
    $stmt = $conn->prepare("SELECT constituency, ward FROM polling_stations WHERE station_name=?");
    $stmt->bind_param("s", $station);
    $stmt->execute();
    $data = $stmt->get_result()->fetch_assoc();

    $constituency = $data['constituency'];
    $ward = $data['ward'];

    // SAVE
    $stmt = $conn->prepare("UPDATE voters SET constituency=?, ward=? WHERE phone_number=?");
    $stmt->bind_param("sss", $constituency, $ward, $phoneNumber);
    $stmt->execute();

    // LOAD MP
    $res = $conn->query("SELECT candidate_name FROM mp_candidates WHERE constituency='$constituency'");

    $response = "CON MP Candidates ($constituency):\n";
    $i = 1;
    while ($row = $res->fetch_assoc()) {
        $response .= $i . ". " . $row['candidate_name'] . "\n";
        $i++;
    }

    echo $response;
    exit;
}

/* MP VOTE */
if (count($level) == 4) {

    saveVote($conn, $phoneNumber, "MP", $level[3]);

    $constituency = getUser($conn, $phoneNumber, "constituency");

    $res = $conn->query("SELECT candidate_name FROM women_rep_candidates WHERE constituency='$constituency'");

    $response = "CON Women Rep:\n";
    $i = 1;
    while ($row = $res->fetch_assoc()) {
        $response .= $i . ". " . $row['candidate_name'] . "\n";
        $i++;
    }

    echo $response;
    exit;
}

/* WOMEN REP */
if (count($level) == 5) {

    saveVote($conn, $phoneNumber, "Women Rep", $level[4]);

    $ward = getUser($conn, $phoneNumber, "ward");

    $res = $conn->query("SELECT candidate_name FROM mca_candidates WHERE ward='$ward'");

    $response = "CON MCA Candidates:\n";
    $i = 1;
    while ($row = $res->fetch_assoc()) {
        $response .= $i . ". " . $row['candidate_name'] . "\n";
        $i++;
    }

    echo $response;
    exit;
}

/* MCA + FINAL VOTE */
if (count($level) == 6) {

    saveVote($conn, $phoneNumber, "MCA", $level[5]);

    $voteCode = "RK" . rand(100000, 999999);

    $stmt = $conn->prepare("UPDATE voters SET has_voted=1, vote_code=? WHERE phone_number=?");
    $stmt->bind_param("ss", $voteCode, $phoneNumber);
    $stmt->execute();

    $name = getUser($conn, $phoneNumber, "full_name");

    sendSMS($phoneNumber, "Hi $name, you voted successfully. Code: $voteCode");

    echo "END Voted Successfully\nCode: $voteCode";
    exit;
}

/* ---------------- FUNCTIONS ---------------- */

function saveVote($conn, $phone, $position, $choice) {

    $candidates = [
        "MP" => ["Auto"],
        "Women Rep" => ["Auto"],
        "MCA" => ["Auto"]
    ];

    $stmt = $conn->prepare("INSERT INTO votes (phone_number, position, candidate) VALUES (?, ?, ?)");
    $stmt->bind_param("sss", $phone, $position, $choice);
    $stmt->execute();
}

function getUser($conn, $phone, $field) {
    $stmt = $conn->prepare("SELECT $field FROM voters WHERE phone_number=?");
    $stmt->bind_param("s", $phone);
    $stmt->execute();
    return $stmt->get_result()->fetch_assoc()[$field];
}
?>
