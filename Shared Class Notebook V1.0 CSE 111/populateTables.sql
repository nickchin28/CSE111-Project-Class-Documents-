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
("Vincent","Chin", ABS(RANDOM()) % (999 - 100) + 100, "prof"),
("Nick","Zhu", ABS(RANDOM()) % (999 - 100) + 100, "prof"),
("Jason","Nguyen", ABS(RANDOM()) % (999 - 100) + 100, "prof"),
("James","Mac", ABS(RANDOM()) % (999 - 100) + 100, "prof");


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
a_name = "Nick";

insert into professor(p_name, p_class, p_ID)
select a_name, "Math-485", a_ID
from account
where a_type = "prof" and 
a_name = "James";

insert into professor(p_name, p_class, p_ID)
select a_name, "Wri-871", a_ID
from account
where a_type = "prof" and 
a_name = "Vincent";

insert into professor(p_name, p_class, p_ID)
select a_name, "SCI-964", a_ID
from account
where a_type = "prof" and 
a_name = "Jason";

/*populate classCatalog*/
insert into classCatalog(cla_name, cla_ID, cla_cID)
select p_class, p_ID, ABS(RANDOM()) % (99- 10) + 10 
from professor;

/*putting prof in the class*/
insert into classRoster(cl_name,cl_ID,cl_cID)
select p_name, p_ID, cla_cID
from professor, classcatalog
where p_class = cla_name AND
p_ID = cla_ID;

/*putting students in class*/ 
insert into classRoster(cl_name, cl_ID, cl_cID) values 
("brian", 336, 50),
("brian", 336, 17),
("brian", 336, 72),
("minh", 611, 17),
("minh", 611, 72),
("tang", 732, 86),
("tang", 732, 60),
("tang", 732, 19),
("aye", 453, 21),
("potato", 574, 50),
("heyo", 416, 86),
("pringles", 916, 21),
("lays", 112, 60);


/*creating initial timestamp of folder access*/
insert into classFolder (class_name, class_cID, class_lTIme)
select cla_name, cla_cID, dateTime()
from classcatalog;

/*initialized first doc for each class*/
insert into notePages (n_docName, n_timeStamp, n_cID, n_content, n_nID) 
SELECT "DOC #1", dateTime(), class_cID, "INSERT DOCUMENTATION", ABS(RANDOM()) % (99 - 1) + 1
from classFolder;

