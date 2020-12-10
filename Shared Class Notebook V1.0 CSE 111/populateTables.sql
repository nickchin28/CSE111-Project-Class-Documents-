/*populate account*/
insert into account (a_name, a_pass, a_ID, a_type) values 
("mang","pang", ABS(RANDOM()) % (999 - 100) + 100, "prof"), 
("brian","dang", ABS(RANDOM()) % (999 - 100) + 100, "stu"),
("minh","ngu", ABS(RANDOM()) % (999 - 100) + 100, "stu"),
("tang","alang", ABS(RANDOM()) % (999 - 100) + 100, "stu"),
("poke","okie", ABS(RANDOM()) % (999 - 100) + 100, "prof"),
("aye","lmao", ABS(RANDOM()) % (999 - 100) + 100, "stu"),
("potato","tomato", ABS(RANDOM()) % (999 - 100) + 100, "stu"),
("heyo","mayo", ABS(RANDOM()) % (999 - 100) + 100, "stu"),
("pringles","single", ABS(RANDOM()) % (999 - 100) + 100, "stu"),
("lays","plays", ABS(RANDOM()) % (999 - 100) + 100, "stu"),
("tango","mango", ABS(RANDOM()) % (999 - 100) + 100, "prof");

insert into account (a_name, a_pass, a_ID, a_type) values 
("boba","poba", ABS(RANDOM()) % (999 - 100) + 100, "prof"),
("hay","lay", ABS(RANDOM()) % (999 - 100) + 100, "prof"),
("noaa","faa", ABS(RANDOM()) % (999 - 100) + 100, "prof"),
("dot","lot", ABS(RANDOM()) % (999 - 100) + 100, "prof"),
("cold","hot", ABS(RANDOM()) % (999 - 100) + 100, "prof"),
("ama","zon", ABS(RANDOM()) % (999 - 100) + 100, "prof"),
("data","base", ABS(RANDOM()) % (999 - 100) + 100, "prof");

/*populate student*/
insert into student(s_name, s_ID, s_age, s_year) 
SELECT a_name, a_ID, ABS(RANDOM()) % (24 - 18) + 18, ABS(RANDOM()) % (6 - 1) + 1
from account
where a_type != "prof";

/*populate professor*/
insert into professor(p_name, p_class, p_ID)
select a_name, "Math-237", a_ID
from account
where a_type = "prof" and 
a_name = "mang";

insert into professor(p_name, p_class, p_ID)
select a_name, "Wri-101", a_ID
from account
where a_type = "prof" and 
a_name = "poke";

insert into professor(p_name, p_class, p_ID)
select a_name, "SCI-241", a_ID
from account
where a_type = "prof" and 
a_name = "tango";

insert into professor(p_name, p_class, p_ID)
select a_name, "Math-321", a_ID
from account
where a_type = "prof" and 
a_name = "boba";

insert into professor(p_name, p_class, p_ID)
select a_name, "Math-485", a_ID
from account
where a_type = "prof" and 
a_name = "hay";

insert into professor(p_name, p_class, p_ID)
select a_name, "Wri-871", a_ID
from account
where a_type = "prof" and 
a_name = "noaa";

insert into professor(p_name, p_class, p_ID)
select a_name, "SCI-964", a_ID
from account
where a_type = "prof" and 
a_name = "dot";

insert into professor(p_name, p_class, p_ID)
select a_name, "CSE-120", a_ID
from account
where a_type = "prof" and 
a_name = "cold";

insert into professor(p_name, p_class, p_ID)
select a_name, "CSE-111", a_ID
from account
where a_type = "prof" and 
a_name = "ama";
 
insert into professor(p_name, p_class, p_ID)
select a_name, "CSE-140", a_ID
from account
where a_type = "prof" and 
a_name = "data";

insert into professor(p_name, p_class, p_ID)
select a_name, "CSE-175", a_ID
from account
where a_type = "prof" and 
a_name = "ama";

insert into professor(p_name, p_class, p_ID)
select a_name, "CSE-150", a_ID
from account
where a_type = "prof" and 
a_name = "ama";



/*populate classCatalog*/
insert into classCatalog(cla_name, cla_cID)
select p_class, ABS(RANDOM()) % (99- 10) + 10 
from professor;


/*putting prof in the class*/
insert or IGNORE into classRoster(cl_name,cl_ID,cl_cID)
select p_name, p_ID ,cla_cID
from professor, classcatalog
where (p_class = cla_name);

/*putting students in class*/ 
insert into classRoster(cl_name, cl_ID, cl_cID) values 
("brian", 277, 15),
("brian", 277, 63),
("brian", 277, 52),
("minh", 749, 25),
("minh", 749, 17),
("tang", 545, 96),
("tang", 545, 58),
("tang", 545, 92),
("aye", 669, 82),
("aye", 669, 37),
("potato", 591, 27),
("heyo", 403, 58),
("heyo", 403, 15),
("pringles", 539, 63),
("pringles", 539, 52),
("pringles", 539, 25),
("lays", 341,17),
("lays", 341,96),
("lays", 341,58),
("lays", 341,92);


/*creating initial timestamp of folder access*/
insert into classFolder (class_name, class_cID, class_lTIme)
select cla_name, cla_cID, dateTime()
from classcatalog;

/*initialized first doc for each class*/
insert into notePages (n_docName, n_timeStamp, n_cID, n_content, n_nID) 
SELECT "DOC #1", dateTime(), class_cID, "INSERT DOCUMENTATION", ABS(RANDOM()) % (99 - 1) + 1
from classFolder;

INSERT into department (d_name, d_ID, d_dept)
SELECT DISTINCT p_name, p_ID, "CSE"
FROM professor, classCatalog
WHERE p_class LIKE "CSE%";

INSERT into department (d_name, d_ID, d_dept)
SELECT DISTINCT p_name, p_ID, "Wri"
FROM professor, classCatalog
WHERE p_class LIKE "Wri%";

INSERT into department (d_name, d_ID, d_dept)
SELECT DISTINCT p_name, p_ID, "SCI"
FROM professor, classCatalog
WHERE p_class LIKE "SCI%";

insert into files (f_docName, f_timeStamp, f_cID, f_content, f_nID) 
SELECT "DOC #1", dateTime(), class_cID, "INSERT DOCUMENTATION", ABS(RANDOM()) % (99 - 1) + 1
from classFolder;

insert into images (i_docName, i_timeStamp, i_cID, i_content, i_nID) 
SELECT "DOC #1", dateTime(), class_cID, "INSERT DOCUMENTATION", ABS(RANDOM()) % (99 - 1) + 1
from classFolder;

insert into proDep (pd_Name, pd_ID, pd_cName, pd_depart) 
SELECT DISTINCT p_name, p_ID, p_class, d_dept
from professor JOIN department
ON p_name = d_name;

insert into request (r_Name, r_ID, r_cID, r_pName, r_Action) 
SELECT DISTINCT s_name, s_ID, 82 , p_name, "ADD"
from student, professor, classCatalog, classRoster
WHERE s_name = "brian"
    AND cla_cID = cl_cID
    AND cl_ID = p_ID
    AND cl_cID = 82;

insert into request (r_Name, r_ID, r_cID, r_pName, r_Action) 
SELECT DISTINCT s_name, s_ID, 82 , p_name, "ADD"
from student, professor, classCatalog, classRoster
WHERE s_name = "minh"
    AND cla_cID = cl_cID
    AND cl_ID = p_ID
    AND cl_cID = 82;

insert into request (r_Name, r_ID, r_cID, r_pName, r_Action) 
SELECT DISTINCT s_name, s_ID, 63 , p_name, "ADD"
from student, professor, classCatalog, classRoster
WHERE s_name = "tang"
    AND cla_cID = cl_cID
    AND cl_ID = p_ID
    AND cl_cID = 63;


insert into ticket (t_Name, t_ID, t_cID, t_pName, t_pID, t_Action) 
SELECT DISTINCT r_name, r_ID, r_cID, p_name, p_ID, r_Action
from professor JOIN request
ON p_name = r_Pname;


