
select * from notePages where n_cID = (Select cl_cID from classRoster where cl_ID = 844);
select cla_name, cla_cID, p_Name from classCatalog, professor where cla_ID = p_ID;

select rtc_className from rosterToCatalog where rtc_name = "lays";

insert into classCatalog(cla_name, cla_ID, cla_cID)
select ca_name, ca_ID, ca_cID
from QclassCatalog;

UPDATE classCatalog
SET cla_cID = 42
WHERE cla_name = "CSE-111";

select a_name, a_type 
from classRoster, account 
where a_ID = cl_ID AND
cl_cID = 54;