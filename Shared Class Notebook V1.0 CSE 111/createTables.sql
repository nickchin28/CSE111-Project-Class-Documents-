CREATE TABLE account(
            a_name VARCHAR(50) not null,
            a_pass VARCHAR(50) not null,
            a_ID INT not null,
            a_type VARCHAR(10) not null,
            constraint un unique(a_ID));

DROP TABLE account;

CREATE TABLE student(
            s_name VARCHAR(50) not null,
            s_ID INT not null,
            s_age INT not null,
            s_year INT not null);
drop table student;

CREATE TABLE classFolder(
            class_name VARCHAR(50) not null,
            class_cID INT not null,
            class_lTime TEXT not null);
            --constraint cl unique(class_cID));

DROP TABLE classFolder;

CREATE TABLE notePages(
            n_docName VARCHAR(50) not null,
            n_timeStamp TEXT not null,
            n_cID INT not null,
            n_content TEXT not null,
            n_nID int not null);
            --constraint note unique(n_nID));
drop table notePages;

CREATE TABLE professor(
            p_name VARCHAR(50) not null,
            p_class INT not null,
            p_ID INT not null);            
DROP TABLE professor;

CREATE TABLE classRoster(
            cl_name VARCHAR(50) not null,
            cl_ID INT not null,
            cl_cID INT not null);     
drop table classRoster;

CREATE TABLE classCatalog(
            cla_name VARCHAR(50) not null,
            cla_cID INT not null);    

DROP TABLE classCatalog;       

CREATE TABLE department(
            d_name VARCHAR(50) not null,
            d_ID int not null,
            d_dept VARCHAR(50) not null);   

DROP TABLE department;    

CREATE TABLE images(
            i_docName VARCHAR(50) not null,
            i_timeStamp TEXT not null,
            i_cID INT not null,
            i_content BLOB not null,
            i_nID int not null);   

DROP TABLE images;

CREATE TABLE files(
            f_docName VARCHAR(50) not null,
            f_timeStamp TEXT not null,
            f_cID INT not null,
            f_content TEXT not null,
            f_nID int not null);
DROP TABLE files;   

CREATE TABLE request(
            r_Name VARCHAR(50) not null,
            r_ID INT not null,
            r_cID INT not null,
            r_pName VARCHAR(50) not null,
            r_Action VARCHAR(50) not null);     
                   
DROP TABLE request;

CREATE TABLE ticket(
            t_Name VARCHAR(50) not null,
            t_ID INT not null,
            t_cID INT not null,
            t_pName VARCHAR(50) not null,
            t_pID INT not null,
            t_Action VARCHAR(50) not null);     
                   
DROP TABLE ticket;

CREATE TABLE proDep(
            pd_Name VARCHAR(50) not null,
            pd_ID INT not null,
            pd_cName VARCHAR(50) not null,
            pd_depart VARCHAR(50) not null);     
                   
DROP TABLE proDep;

            