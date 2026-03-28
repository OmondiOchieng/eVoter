<?php
require_once("config.php");

function sendSMS($phone, $message) {

    $url = "https://api.mobilesasa.com/v1/send/message";

    $data = [
        "phone_number" => $phone,
        "message" => $message,
        "sender_id" => SMS_SENDER_ID
    ];

    $headers = [
        "Authorization: Bearer " . SMS_API_KEY,
        "Content-Type: application/json"
    ];

    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);

    curl_exec($ch);
    curl_close($ch);
}
?>
