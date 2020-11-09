INSERT INTO account(a_name, a_pass, a_ID, a_type)
VALUES ("student2000",1234,1000,"student");
INSERT INTO account(a_name, a_pass, a_ID, a_type)
VALUES ("student2001",1234,1001,"student");
INSERT INTO account(a_name, a_pass, a_ID, a_type)
VALUES ("student2002",1234,1002,"student");
INSERT INTO account(a_name, a_pass, a_ID, a_type)
VALUES("student2003",1234,1003,"student");
INSERT INTO account(a_name, a_pass, a_ID, a_type)
VALUES("frusu",1234,1004,"professor");
INSERT INTO account(a_name, a_pass, a_ID, a_type)
VALUES ("student1000",1234,1005,"student");
INSERT INTO account(a_name, a_pass, a_ID, a_type)
VALUES("student1001",1234,1006,"student");
INSERT INTO account(a_name, a_pass, a_ID, a_type)
VALUES ("student1002",1234,1007,"student");
INSERT INTO account(a_name, a_pass, a_ID, a_type)
VALUES ("student1003",1234,1008,"student");
INSERT INTO account(a_name, a_pass, a_ID, a_type)
VALUES("student1004",1234,1009,"student");

INSERT INTO student(s_name, s_ID,s_age, s_year)
VALUES ("Student 2000", 1000, 21, "Senior"),
("Student 2001", 1001, 21, "Senior"),
("Student 2002", 1002, 21, "Senior"),
("Student 2003", 1003, 21, "Senior"),
("Student 1000", 1004, 21, "Senior"),
("Student 1001", 1005, 19, "Sophomore"),
("Student 1002", 1006, 18, "Freshman"),
("Student 1003", 1007, 20, "Junior"),
("Student 1004", 1008, 20, "Junior");

INSERT INTO classesRegistered(reg_cName,reg_cID,reg_ID)
VALUES ("CSE 111", 111, 1000),
("CSE 111", 111, 1000),
("CSE 111", 111, 1001),
("CSE 111", 111, 1002),
("CSE 111", 111, 1003),
("CSE 111", 111, 1004),
("CSE 111", 111, 1005),
("CSE 111", 111, 1006),
("CSE 111", 111, 1007),
("CSE 111", 111, 1008)

INSERT INTO classFolder(class_name , class_cID , class_lTime )
VALUES ("CSE 111", 111,"Monday - Friday"),
        ("CSE 155", 155, "Tuesday and Thursday, 12:30 pm to 1:45 pm")

INSERT INTO notePages(n_docName, n_timeStamp, n_cID, n_content)
VALUES ("projectphase2.pdf", "2:30pm Monday, November 9th, 2020", 111, "Project Documentation")

INSERT INTO professor(p_name, p_cID, p_ID)
VALUES ("Florin Rusu", 111 , 1004 )

INSERT INTO classRoster(cl_name, cl_ID, cl_cID)
VALUES ("CSE 111",1000 , 111),
("CSE 111", 1001, 111),
("CSE 111", 1002, 111),
("CSE 111", 1003, 111),
("CSE 111", 1004, 111),
("CSE 111", 1005, 111),
("CSE 111", 1006, 111),
("CSE 111", 1007, 111),
("CSE 111", 1008, 111),
("CSE 111", 1009, 111),
("CSE 155", 1002, 155),

INSERT INTO classCatalog(cla_name,cla_cID)
VALUES ("CSE 111", 111),
("CSE 150", 150),
("CSE 160", 160),
("CSE 120", 120),
("CSE 175", 175);