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
("brian", 593, 69),
("brian", 593, 71),
("brian", 593, 58),
("minh", 412, 69),
("minh", 412, 58),
("tang", 113, 69),
("tang", 113, 71),
("tang", 113, 58),
("aye", 357, 58),
("potato", 667, 69),
("heyo", 260, 71),
("pringles", 334, 71),
("lays", 202, 69);

/*student seeing what class they are registered in*/
select * 
from classRoster
where cl_id ="593";

/*creating initial timestamp of folder access*/
insert into classFolder (class_name, class_cID, class_lTIme)
select cla_name, cl_cID, dateTime()
from classRoster, classcatalog
where cl_cID = cla_cID;