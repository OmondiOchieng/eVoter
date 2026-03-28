🗳️ e-Voter (SmartVote)

e-Voter is a secure USSD-based voting system built with PHP + MySQL + MobileSasa SMS API.
It enables citizens to vote using any mobile phone while ensuring security, accuracy, and real-time validation.

---

🚀 Features

📲 USSD-based voting (works on any phone)
👤 Voter registration (Name + ID + Polling Station)
🔐 OTP verification via SMS
🗺️ Automatic County, Constituency & Ward detection
🧑‍⚖️ Dynamic candidates per region:

- President (National)
- Governor (County-based)
- MP (Constituency-based)
- Women Rep (Constituency-based)
- MCA (Ward-based)

🚫 One-person-one-vote protection
📩 SMS confirmation with unique vote code
🗳️ Secure vote recording in database

---

🏗️ Project Structure

/smartvote
│── index.php
│── config.php
│── dbconnector.php
│── sms.php
│── database.sql
│── README.md

---

🗄️ DATABASE SETUP (FULL SQL)

📌 Create Database

CREATE DATABASE voting_system;
USE voting_system;

---

👤 Voters Table

CREATE TABLE voters (
    id INT AUTO_INCREMENT PRIMARY KEY,
    phone_number VARCHAR(20) UNIQUE,
    full_name VARCHAR(100),
    id_number VARCHAR(20),
    polling_station VARCHAR(150),
    ward VARCHAR(100),
    constituency VARCHAR(100),
    county VARCHAR(100),
    otp VARCHAR(10),
    is_verified TINYINT DEFAULT 0,
    has_voted TINYINT DEFAULT 0,
    vote_code VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

---

🗳️ Votes Table

CREATE TABLE votes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    phone_number VARCHAR(20),
    position VARCHAR(50),
    candidate VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (phone_number, position)
);

---

📍 Polling Stations (Mapping Table)

CREATE TABLE polling_stations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    station_name VARCHAR(150) UNIQUE,
    ward VARCHAR(100),
    constituency VARCHAR(100),
    county VARCHAR(100)
);

---

🏛️ President Candidates

CREATE TABLE president_candidates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    candidate_name VARCHAR(100)
);

---

🏙️ Governor Candidates

CREATE TABLE governor_candidates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    county VARCHAR(100),
    candidate_name VARCHAR(100)
);

---

🏛️ MP Candidates

CREATE TABLE mp_candidates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    constituency VARCHAR(100),
    candidate_name VARCHAR(100)
);

---

👩 Women Representative Candidates

CREATE TABLE women_rep_candidates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    constituency VARCHAR(100),
    candidate_name VARCHAR(100)
);

---

🏘️ MCA Candidates

CREATE TABLE mca_candidates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ward VARCHAR(100),
    candidate_name VARCHAR(100)
);

---

⚙️ CONFIGURATION

📌 config.php

define("DB_HOST", "localhost");
define("DB_USER", "root");
define("DB_PASS", "");
define("DB_NAME", "voting_system");

define("SMS_API_KEY", "YOUR_API_KEY");
define("SMS_SENDER_ID", "MOBILESASA");

---

📡 SMS INTEGRATION (MobileSasa)

- Sends OTP during registration
- Sends vote confirmation after voting
- Includes voter name + unique vote code

---

🧠 SYSTEM FLOW

1️⃣ Registration

Name → ID Number → Polling Station

2️⃣ OTP Verification

System sends OTP via SMS → user confirms

3️⃣ Voting Flow

President → Governor → MP → Women Rep → MCA

4️⃣ Completion

Vote saved + SMS sent:

«Hi John, you voted successfully. Code: SV583920»

---

🛡️ SECURITY FEATURES

✔ One phone number = one vote
✔ OTP verification before voting
✔ Unique vote code generation
✔ Duplicate voting prevention (per position)
✔ Prepared SQL statements (SQL injection safe)

---

📩 SMS SAMPLE

Hi John Doe,
You have successfully voted.
Your confirmation code: SV583920

---

📊 TECH STACK

- PHP (Backend)
- MySQL (Database)
- USSD Gateway (Africa’s Talking / others)
- MobileSasa API (SMS)
- cURL (API communication)

---

🚀 FUTURE IMPROVEMENTS

📊 Admin dashboard (live vote counting)
📱 React frontend voting panel
🛰️ GPS-based polling verification
📈 Real-time analytics charts
🔐 Blockchain vote audit trail

---

🏆 PROJECT STATUS

✔ Scalable architecture
✔ Real-world election logic
✔ Secure voting system design

---

👨‍💻 AUTHOR

Acacia Solutions
Building secure civic-tech solutions for digital voting innovation.