CREATE DATABASE voting_system;
USE voting_system;

-- ==============================
-- 1. VOTERS
-- ==============================
CREATE TABLE voters (
    id INT AUTO_INCREMENT PRIMARY KEY,
    phone_number VARCHAR(20) UNIQUE,
    full_name VARCHAR(100),
    id_number VARCHAR(20),
    polling_station VARCHAR(150),
    ward VARCHAR(100),
    constituency VARCHAR(100),
    county VARCHAR(100), -- ✅ NEW (important)
    otp VARCHAR(10),
    is_verified TINYINT DEFAULT 0,
    has_voted TINYINT DEFAULT 0,
    vote_code VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==============================
-- 2. VOTES
-- ==============================
CREATE TABLE votes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    phone_number VARCHAR(20),
    position VARCHAR(50),
    candidate VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (phone_number, position) -- ✅ prevents double voting per seat
);

-- ==============================
-- 3. POLLING STATIONS (UPDATED)
-- ==============================
CREATE TABLE polling_stations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    station_name VARCHAR(150) UNIQUE,
    ward VARCHAR(100),
    constituency VARCHAR(100),
    county VARCHAR(100) -- ✅ NEW
);

-- ==============================
-- 4. PRESIDENT CANDIDATES (NEW)
-- ==============================
CREATE TABLE president_candidates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    candidate_name VARCHAR(100)
);

INSERT INTO president_candidates (candidate_name) VALUES
('Candidate P1'),
('Candidate P2'),
('Candidate P3');

-- ==============================
-- 5. GOVERNOR CANDIDATES (NEW)
-- ==============================
CREATE TABLE governor_candidates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    county VARCHAR(100),
    candidate_name VARCHAR(100)
);

INSERT INTO governor_candidates (county, candidate_name) VALUES
('Nairobi', 'Governor A'),
('Nairobi', 'Governor B'),
('Nairobi', 'Governor C');

-- ==============================
-- 6. MP CANDIDATES
-- ==============================
CREATE TABLE mp_candidates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    constituency VARCHAR(100),
    candidate_name VARCHAR(100)
);

-- ==============================
-- 7. WOMEN REP
-- ==============================
CREATE TABLE women_rep_candidates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    constituency VARCHAR(100),
    candidate_name VARCHAR(100)
);

-- ==============================
-- 8. MCA
-- ==============================
CREATE TABLE mca_candidates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ward VARCHAR(100),
    candidate_name VARCHAR(100)
);

-- ==============================
-- 9. INDEXES (PERFORMANCE BOOST)
-- ==============================
CREATE INDEX idx_constituency_mp ON mp_candidates(constituency);
CREATE INDEX idx_constituency_wr ON women_rep_candidates(constituency);
CREATE INDEX idx_ward_mca ON mca_candidates(ward);
CREATE INDEX idx_county_gov ON governor_candidates(county);

-- ==============================
-- 10. SAMPLE POLLING DATA
-- ==============================
INSERT INTO polling_stations (station_name, ward, constituency, county) VALUES
('Kibra Primary School', 'Laini Saba', 'Kibra', 'Nairobi'),
('Olympic Primary School', 'Woodley/Kenyatta Golf', 'Kibra', 'Nairobi'),
('Ayany Primary School', 'Makina', 'Kibra', 'Nairobi');

-- ==============================
-- 11. SAMPLE MP DATA
-- ==============================
INSERT INTO mp_candidates (constituency, candidate_name) VALUES
('Kibra', 'MP Candidate 1'),
('Kibra', 'MP Candidate 2'),
('Kibra', 'MP Candidate 3');

-- ==============================
-- 12. SAMPLE WOMEN REP DATA
-- ==============================
INSERT INTO women_rep_candidates (constituency, candidate_name) VALUES
('Kibra', 'Women Rep 1'),
('Kibra', 'Women Rep 2'),
('Kibra', 'Women Rep 3');

-- ==============================
-- 13. SAMPLE MCA DATA
-- ==============================
INSERT INTO mca_candidates (ward, candidate_name) VALUES
('Laini Saba', 'MCA 1'),
('Laini Saba', 'MCA 2'),
('Laini Saba', 'MCA 3');