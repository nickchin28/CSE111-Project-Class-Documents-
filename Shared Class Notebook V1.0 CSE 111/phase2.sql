/*creating initial timestamp of folder access*/
insert into classFolder (class_name, class_cID, class_lTIme)
select cla_name, cl_cID, dateTime()
from classRoster, classcatalog
where cl_cID = cla_cID;

/*view classes registered by student with ID 593*/
select * 
from classRoster
where cl_id ="611";

/*putting prof in the class*/
insert into classRoster(cl_name,cl_ID,cl_cID)
select p_name, p_ID, cla_cID
from professor, classcatalog
where p_class = cla_name AND
p_ID = cla_ID;

/* show all students enrolled  */
select *
from account 
where a_type = "stu";

/* will take student info when logged in and access the classnotes*/ 
select * 
from notePages
where n_cID = "69";

/* return all math classes */
select * 
from classCatalog 
where cla_name like "Math%"; 

/* return all of student available notes */
select n_docName, n_timeStamp, n_cID, n_content 
from notePages, classRoster, Student 
where n_cID = cl_cID and 
cl_ID = s_ID and 
s_ID = 336;

/* */ 
update notepages 
set n_content = " MORE CONTENT ", 
    n_timeStamp = dateTime(),
    n_docName = " hola "
where n_cID = "21" and 
n_nID = "user input";

/* */
select cl_name, cl_ID 
from classRoster, professor, classCatalog  
where p_ID = cla_ID and 
cla_ID = 398 and 
cla_cID = cl_cID;

/* delete */
delete 
from notePages 
where n_nID = 3;

/* THIS IS FOR YOU NICK CHIN */
update classFolder 
set class_lTime = max(n_timeStamp)
WHERE class_cID = n_cID and
n_cID = 21 and 
class_lTime <= n_timeStamp;


