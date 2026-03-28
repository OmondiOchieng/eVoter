CREATE DATABASE voting_system;
USE voting_system;

-- Voters
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

-- Votes
CREATE TABLE votes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    phone_number VARCHAR(20),
    position VARCHAR(50),
    candidate VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Polling Station Mapping
CREATE TABLE polling_stations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    station_name VARCHAR(100),
    constituency VARCHAR(100),
    ward VARCHAR(100)
);

-- MP Candidates
CREATE TABLE mp_candidates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    constituency VARCHAR(100),
    candidate_name VARCHAR(100)
);

-- Women Rep
CREATE TABLE women_rep_candidates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    constituency VARCHAR(100),
    candidate_name VARCHAR(100)
);

-- MCA
CREATE TABLE mca_candidates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ward VARCHAR(100),
    candidate_name VARCHAR(100)
);
