--  for the first time: create database faers;

-- ---- csv: format ------
use faers;
DROP TABLE IF EXISTS  faers_demo;
CREATE TABLE faers_demo (
    PRIMARYID VARCHAR(255) NOT NULL,
    CASEID VARCHAR(255) NOT NULL,
    CASEVERSION VARCHAR(255) NOT NULL,
    I_F_COD VARCHAR(255) NOT NULL,
    EVENT_DT VARCHAR(255),
    MFR_DT VARCHAR(255),
    INIT_FDA_DT VARCHAR(255),
    FDA_DT VARCHAR(255),
    AGE VARCHAR(255),
    SEX VARCHAR(255),
    WT VARCHAR(255),
    REPT_DT VARCHAR(255),
    OCCP_COD VARCHAR(255),
    REPORTER_COUNTRY VARCHAR(255),
    OCCR_COUNTRY VARCHAR(255),
    PRIMARY KEY (PRIMARYID, CASEID, CASEVERSION)
);

-- -- csv: primaryid,caseid,drug_seq,role_cod,drugname
use faers;
DROP TABLE IF EXISTS  faers_drug;
CREATE TABLE faers_drug (
    PRIMARYID VARCHAR(255) NOT NULL,
    CASEID VARCHAR(255) NOT NULL,
    DRUG_SEQ VARCHAR(255) NOT NULL,
    ROLE_COD VARCHAR(255),
    DRUGNAME TEXT NOT NULL,
    PROD_AI  VARCHAR(1024),
    PRIMARY KEY (PRIMARYID, CASEID, DRUG_SEQ)
);

-- ---- csv: format ------
use faers;
DROP TABLE IF EXISTS  faers_reac;
CREATE TABLE faers_reac (
    PRIMARYID VARCHAR(255) NOT NULL,
    CASEID VARCHAR(255) NOT NULL,
    PT VARCHAR(1024),
    SOC VARCHAR(1024),
    SOC_CODE VARCHAR(1024)
);

-- ---- csv: format ------
use faers;
DROP TABLE IF EXISTS  faers_outc;
CREATE TABLE faers_outc (
    PRIMARYID VARCHAR(255) NOT NULL,
    CASEID VARCHAR(255) NOT NULL,
    OUTC_COD VARCHAR(255) NOT NULL
);

-- --------------- TXT file below -----------------
use faers;
DROP TABLE IF EXISTS  faers_ther;
CREATE TABLE faers_ther (
    PRIMARYID VARCHAR(32) NOT NULL,
    CASEID VARCHAR(32) NOT NULL,
    DSG_DRUG_SEQ VARCHAR(4) NOT NULL,
    START_DT VARCHAR(16),
    END_DT VARCHAR(16),
    DUR VARCHAR(16),
    DUR_COD VARCHAR(16)
);

-- - txt:
use faers;
DROP TABLE IF EXISTS   faers_indi;
CREATE TABLE faers_indi (
    PRIMARYID VARCHAR(255) NOT NULL,
    CASEID VARCHAR(255) NOT NULL,
    INDI_DRUG_SEQ VARCHAR(255) NOT NULL,
    INDI_PT TEXT,
    PRIMARY KEY (PRIMARYID,CASEID,INDI_DRUG_SEQ)
);

-- - txt
use faers;
DROP TABLE IF EXISTS  faers_rpsr;
CREATE TABLE faers_rpsr (
    PRIMARYID VARCHAR(255) NOT NULL,
    CASEID VARCHAR(255) NOT NULL,
    RPSR_COD VARCHAR(255) NOT NULL,
    PRIMARY KEY (PRIMARYID,CASEID,RPSR_COD)
);

-- - txt
use faers;
DROP TABLE IF EXISTS faers.pt_soc_mapping;
CREATE TABLE faers.pt_soc_mapping (
    pt_order int,
    pt_name VARCHAR(255) NOT NULL,
    pt_code bigint,
    soc_name VARCHAR(255) NOT NULL,
    soc_code bigint,
    PRIMARY KEY (pt_order,pt_code)
);
LOAD DATA INFILE '/Users/liuhaoran/PycharmProjects/Faers/data/meddra_data/pt_soc_mapping.csv' REPLACE INTO TABLE faers.pt_soc_mapping FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n'  IGNORE 1 ROWS;
-- ---