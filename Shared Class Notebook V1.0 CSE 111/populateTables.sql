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
("brian", 878, 43),
("brian", 878, 14),
("brian", 878, 78),
("minh", 306, 47),
("minh", 306, 30),
("tang", 843, 25),
("tang", 843, 27),
("tang", 843, 59),
("aye", 589, 35),
("aye", 589, 17),
("potato", 728, 43),
("heyo", 673, 14),
("heyo", 673, 17),
("pringles", 642, 78),
("pringles", 642, 47),
("pringles", 642, 30),
("lays",277,25),
("lays",277,27),
("lays",277,59),
("lays",277,35);


/*creating initial timestamp of folder access*/
insert into classFolder (class_name, class_cID, class_lTIme)
select cla_name, cla_cID, dateTime()
from classcatalog;

/*initialized first doc for each class*/
insert into notePages (n_docName, n_timeStamp, n_cID, n_content, n_nID) 
SELECT "DOC #1", dateTime(), class_cID, "INSERT DOCUMENTATION", ABS(RANDOM()) % (99 - 1) + 1
from classFolder;

