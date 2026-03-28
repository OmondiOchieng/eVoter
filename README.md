🗳️e-Voter is  a secure USSD-based voting system built with PHP + MySQL + MobileSasa SMS API.
It supports OTP verification, constituency-based candidate selec
---

🚀 Features

📲 USSD-based voting (any phone)

👤 Voter registration (Name + ID + Polling Station)

🔐 OTP verification via SMS

🗺️ Automatic constituency & ward detection

🧑‍⚖️ Dynamic MP, Women Rep, MCA candidates

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
    polling_station VARCHAR(100),
    constituency VARCHAR(100),
    ward VARCHAR(100),
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
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


---

📍 Polling Stations (Mapping Table)

CREATE TABLE polling_stations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    station_name VARCHAR(100),
    constituency VARCHAR(100),
    ward VARCHAR(100)
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

Sends OTP during registration

Sends vote confirmation after voting

Includes voter name + unique vote code



---

🧠 SYSTEM FLOW

1️⃣ Registration

Name → ID Number → Polling Station

2️⃣ OTP Verification

System sends OTP via SMS → user confirms

3️⃣ Voting

MP → Women Rep → MCA

4️⃣ Completion

Vote saved + SMS sent:
"Hi John, you voted successfully. Code: RK485676"


---

🛡️ SECURITY FEATURES

✔ One phone number = one vote

✔ OTP verification before voting

✔ Unique vote ID generation

✔ Duplicate voting prevention

✔ Prepared SQL statements



---

📩 SMS SAMPLE

Hi John Doe,
You have successfully voted.
Your confirmation code: RK485676


---

📊 TECH STACK

PHP (Backend)

MySQL (Database)

USSD Gateway (Africa’s Talking / others)

MobileSasa API (SMS)

cURL (API communication)



---

🚀 FUTURE IMPROVEMENTS

📊 Admin dashboard (live vote counting)

📱 React frontend voting panel

🛰️ GPS-based polling verification

📈 Real-time analytics charts

🔐 Blockchain vote audit trail



---

🏆 PROJECT STATUS

✔ Hackathon-ready
✔ Scalable architecture
✔ Real-world election logic
✔ Secure voting system design


---

👨‍💻 AUTHOR

Built as a secure civic-tech solution for digital voting innovation.


---

If you want next level 🔥 I can also:

Design a GitHub banner image

Create a live demo pitch script (for judges)

Build a React admin dashboard for results

Package it into a deployable hosting setup (cPanel ready)


Just say 👍
