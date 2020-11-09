CREATE TABLE account(
            a_name VARCHAR(50) not null,
            a_pass VARCHAR(50) not null,
            a_ID INT not null,
            a_type VARCHAR(10) not null);

DROP TABLE account

CREATE TABLE student(
            s_name VARCHAR(50) not null,
            s_ID INT not null,
            s_age INT not null,
            s_year INT not null);

CREATE TABLE classesRegistered(
            reg_cName VARCHAR(50) not null,
            reg_cID INT not null,
            reg_ID INT not null);

CREATE TABLE classFolder(
            class_name VARCHAR(50) not null,
            class_cID INT not null,
            class_lTime TEXT not null);

DROP TABLE classFolder

CREATE TABLE notePages(
            n_docName VARCHAR(50) not null,
            n_timeStamp TEXT not null,
            n_cID INT not null,
            n_content TEXT not null);

CREATE TABLE professor(
            p_name VARCHAR(50) not null,
            p_cID INT not null,
            p_ID INT not null);            
DROP TABLE professor

CREATE TABLE classRoster(
            cl_name VARCHAR(50) not null,
            cl_ID INT not null,
            cl_cID INT not null);     

CREATE TABLE classCatalog(
            cla_name VARCHAR(50) not null,
            cla_cID INT not null);    
DROP TABLE classCatalog                