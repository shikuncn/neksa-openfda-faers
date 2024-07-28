--  ||-----  BEGIN TO IMPORT DATABASE faers --- ;
USE faers;
--SET SQL_MODE='';  -- because some fileds contains slash resulting errors
---
DROP TABLE faers_drug;

 LOAD DATA INFILE '/Users/liuhaoran/PycharmProjects/Faers/data/FAERS_DATA/faers_ascii_2017Q1/ascii/DRUG17Q1.txt' INTO TABLE faers_drug FIELDS TERMINATED BY '$' ENCLOSED BY '"' LINES TERMINATED BY '\n'  IGNORE 1 ROWS;

 LOAD DATA INFILE '/Users/liuhaoran/PycharmProjects/Faers/data/FAERS_DATA/faers_ascii_2017Q2/ascii/DRUG17Q2.txt' INTO TABLE faers_drug FIELDS TERMINATED BY '$' ENCLOSED BY '"' LINES TERMINATED BY '\n'  IGNORE 1 ROWS;

 LOAD DATA INFILE '/Users/liuhaoran/PycharmProjects/Faers/data/FAERS_DATA/faers_ascii_2017Q3/ascii/DRUG17Q3.txt' INTO TABLE faers_drug FIELDS TERMINATED BY '$' ENCLOSED BY '"' LINES TERMINATED BY '\n'  IGNORE 1 ROWS;

 LOAD DATA INFILE '/Users/liuhaoran/PycharmProjects/Faers/data/FAERS_DATA/faers_ascii_2017Q4/ascii/DRUG17Q4.txt' INTO TABLE faers_drug FIELDS TERMINATED BY '$' ENCLOSED BY '"' LINES TERMINATED BY '\n'  IGNORE 1 ROWS;

 LOAD DATA INFILE '/Users/liuhaoran/PycharmProjects/Faers/data/FAERS_DATA/faers_ascii_2018Q1/ascii/DRUG18Q1.txt' INTO TABLE faers_drug FIELDS TERMINATED BY '$' ENCLOSED BY '"' LINES TERMINATED BY '\n'  IGNORE 1 ROWS;

 LOAD DATA INFILE '/Users/liuhaoran/PycharmProjects/Faers/data/FAERS_DATA/faers_ascii_2018Q2/ascii/DRUG18Q2.txt' INTO TABLE faers_drug FIELDS TERMINATED BY '$' ENCLOSED BY '"' LINES TERMINATED BY '\n'  IGNORE 1 ROWS;

 LOAD DATA INFILE '/Users/liuhaoran/PycharmProjects/Faers/data/FAERS_DATA/faers_ascii_2018Q3/ascii/DRUG18Q3.txt' INTO TABLE faers_drug FIELDS TERMINATED BY '$' ENCLOSED BY '"' LINES TERMINATED BY '\n'  IGNORE 1 ROWS;

 LOAD DATA INFILE '/Users/liuhaoran/PycharmProjects/Faers/data/FAERS_DATA/faers_ascii_2018Q4/ascii/DRUG18Q4.txt' INTO TABLE faers_drug FIELDS TERMINATED BY '$' ENCLOSED BY '"' LINES TERMINATED BY '\n'  IGNORE 1 ROWS;

 LOAD DATA INFILE '/Users/liuhaoran/PycharmProjects/Faers/data/FAERS_DATA/faers_ascii_2019Q1/ascii/DRUG19Q1.txt' INTO TABLE faers_drug FIELDS TERMINATED BY '$' ENCLOSED BY '"' LINES TERMINATED BY '\n'  IGNORE 1 ROWS;

 LOAD DATA INFILE '/Users/liuhaoran/PycharmProjects/Faers/data/FAERS_DATA/faers_ascii_2019Q2/ascii/DRUG19Q2.txt' INTO TABLE faers_drug FIELDS TERMINATED BY '$' ENCLOSED BY '"' LINES TERMINATED BY '\n'  IGNORE 1 ROWS;

 LOAD DATA INFILE '/Users/liuhaoran/PycharmProjects/Faers/data/FAERS_DATA/faers_ascii_2019Q3/ascii/DRUG19Q3.txt' INTO TABLE faers_drug FIELDS TERMINATED BY '$' ENCLOSED BY '"' LINES TERMINATED BY '\n'  IGNORE 1 ROWS;

 LOAD DATA INFILE '/Users/liuhaoran/PycharmProjects/Faers/data/FAERS_DATA/faers_ascii_2019Q4/ascii/DRUG19Q4.txt' INTO TABLE faers_drug FIELDS TERMINATED BY '$' ENCLOSED BY '"' LINES TERMINATED BY '\n'  IGNORE 1 ROWS;

 LOAD DATA INFILE '/Users/liuhaoran/PycharmProjects/Faers/data/FAERS_DATA/faers_ascii_2020Q1/ASCII/DRUG20Q1.txt' INTO TABLE faers_drug FIELDS TERMINATED BY '$' ENCLOSED BY '"' LINES TERMINATED BY '\n'  IGNORE 1 ROWS;

 LOAD DATA INFILE '/Users/liuhaoran/PycharmProjects/Faers/data/FAERS_DATA/faers_ascii_2020Q2/ASCII/DRUG20Q2.txt' INTO TABLE faers_drug FIELDS TERMINATED BY '$' ENCLOSED BY '"' LINES TERMINATED BY '\n'  IGNORE 1 ROWS;

 LOAD DATA INFILE '/Users/liuhaoran/PycharmProjects/Faers/data/FAERS_DATA/faers_ascii_2020Q3/ASCII/DRUG20Q3.txt' INTO TABLE faers_drug FIELDS TERMINATED BY '$' ENCLOSED BY '"' LINES TERMINATED BY '\n'  IGNORE 1 ROWS;

 LOAD DATA INFILE '/Users/liuhaoran/PycharmProjects/Faers/data/FAERS_DATA/faers_ascii_2020Q4/ASCII/DRUG20Q4.txt' INTO TABLE faers_drug FIELDS TERMINATED BY '$' ENCLOSED BY '"' LINES TERMINATED BY '\n'  IGNORE 1 ROWS;

 LOAD DATA INFILE '/Users/liuhaoran/PycharmProjects/Faers/data/FAERS_DATA/faers_ascii_2021Q1/ASCII/DRUG21Q1.txt' INTO TABLE faers_drug FIELDS TERMINATED BY '$' ENCLOSED BY '"' LINES TERMINATED BY '\n'  IGNORE 1 ROWS;

 LOAD DATA INFILE '/Users/liuhaoran/PycharmProjects/Faers/data/FAERS_DATA/faers_ascii_2021Q2/ASCII/DRUG21Q2.txt' INTO TABLE faers_drug FIELDS TERMINATED BY '$' ENCLOSED BY '"' LINES TERMINATED BY '\n'  IGNORE 1 ROWS;

 LOAD DATA INFILE '/Users/liuhaoran/PycharmProjects/Faers/data/FAERS_DATA/faers_ascii_2021Q3/ASCII/DRUG21Q3.txt' INTO TABLE faers_drug FIELDS TERMINATED BY '$' ENCLOSED BY '"' LINES TERMINATED BY '\n'  IGNORE 1 ROWS;

 LOAD DATA INFILE '/Users/liuhaoran/PycharmProjects/Faers/data/FAERS_DATA/faers_ascii_2021Q4/ASCII/DRUG21Q4.txt' INTO TABLE faers_drug FIELDS TERMINATED BY '$' ENCLOSED BY '"' LINES TERMINATED BY '\n'  IGNORE 1 ROWS;

 LOAD DATA INFILE '/Users/liuhaoran/PycharmProjects/Faers/data/FAERS_DATA/faers_ascii_2022Q1/ASCII/DRUG22Q1.txt' INTO TABLE faers_drug FIELDS TERMINATED BY '$' ENCLOSED BY '"' LINES TERMINATED BY '\n'  IGNORE 1 ROWS;

 LOAD DATA INFILE '/Users/liuhaoran/PycharmProjects/Faers/data/FAERS_DATA/faers_ascii_2022Q2/ASCII/DRUG22Q2.txt' INTO TABLE faers_drug FIELDS TERMINATED BY '$' ENCLOSED BY '"' LINES TERMINATED BY '\n'  IGNORE 1 ROWS;

 LOAD DATA INFILE '/Users/liuhaoran/PycharmProjects/Faers/data/FAERS_DATA/faers_ascii_2022Q3/ASCII/DRUG22Q3.txt' INTO TABLE faers_drug FIELDS TERMINATED BY '$' ENCLOSED BY '"' LINES TERMINATED BY '\n'  IGNORE 1 ROWS;

 LOAD DATA INFILE '/Users/liuhaoran/PycharmProjects/Faers/data/FAERS_DATA/faers_ascii_2022Q4/ASCII/DRUG22Q4.txt' INTO TABLE faers_drug FIELDS TERMINATED BY '$' ENCLOSED BY '"' LINES TERMINATED BY '\n'  IGNORE 1 ROWS;

 LOAD DATA INFILE '/Users/liuhaoran/PycharmProjects/Faers/data/FAERS_DATA/faers_ascii_2023Q1/ASCII/DRUG23Q1.txt' INTO TABLE faers_drug FIELDS TERMINATED BY '$' ENCLOSED BY '"' LINES TERMINATED BY '\n'  IGNORE 1 ROWS;

 LOAD DATA INFILE '/Users/liuhaoran/PycharmProjects/Faers/data/FAERS_DATA/faers_ascii_2023Q2/ASCII/DRUG23Q2.txt' INTO TABLE faers_drug FIELDS TERMINATED BY '$' ENCLOSED BY '"' LINES TERMINATED BY '\n'  IGNORE 1 ROWS;

 LOAD DATA INFILE '/Users/liuhaoran/PycharmProjects/Faers/data/FAERS_DATA/faers_ascii_2023Q3/ASCII/DRUG23Q3.txt' INTO TABLE faers_drug FIELDS TERMINATED BY '$' ENCLOSED BY '"' LINES TERMINATED BY '\n'  IGNORE 1 ROWS;

 LOAD DATA INFILE '/Users/liuhaoran/PycharmProjects/Faers/data/FAERS_DATA/faers_ascii_2023Q4/ASCII/DRUG23Q4.txt' INTO TABLE faers_drug FIELDS TERMINATED BY '$' ENCLOSED BY '"' LINES TERMINATED BY '\n'  IGNORE 1 ROWS;

 LOAD DATA INFILE '/Users/liuhaoran/PycharmProjects/Faers/data/FAERS_DATA/faers_ascii_2024Q1/ASCII/DRUG24Q1.txt' INTO TABLE faers_drug FIELDS TERMINATED BY '$' ENCLOSED BY '"' LINES TERMINATED BY '\n'  IGNORE 1 ROWS;

-- --  FINSH IMPORTING DATABASE faers ----- ;
