-- #3.
-- putting prof in the class
insert into classRoster(cl_name,cl_ID,cl_cID)
select p_name, p_ID, cla_cID
from professor, classcatalog
where p_class = cla_name AND
p_ID = cla_ID;


-- #13
-- Updates ClassFolder to the latest time the folder was modified
update classFolder 
set class_lTime = max(n_timeStamp)
WHERE class_cID = n_cID and
n_cID = 21 and 
class_lTime <= n_timeStamp;