-- #1
-- creates timestamp of folder access
UPDATE classFolder
SET class_lTime = dateTime()
WHERE class_cID = "85";                     -- depends on what class they are trying to access

-- #2
-- view classes registered by student with their ID number
SELECT * 
FROM classRoster
WHERE cl_id ="689";                         -- Depends on the person logged in

-- #3
-- Displays all of their accessible class folders
SELECT class_name, class_cID, class_lTime
FROM classFolder , classRoster, student
WHERE s_ID = "689"                          --  depends on who is logged in
    AND s_ID = cl_ID
    AND cl_cID = class_cID;

-- #4.
-- show all students enrolled in database
SELECT *
FROM account 
WHERE a_type = "stu";              -- Looks for one type

-- #5.
-- will take student info when logged in and access the classnotes 
SELECT * 
FROM notePages
WHERE n_cID = "77";                -- depends on which class's notes they are looking for

-- #6.
-- return all listed CSE classes
SELECT * 
FROM classCatalog 
WHERE cla_name LIKE "CSE%";   -- Can change depending on what the user is looking for

-- #7.
-- return all of student available notes
SELECT n_docName, n_timeStamp, n_cID, n_content 
FROM notePages, classRoster, Student 
WHERE n_cID = cl_cID 
    AND cl_ID = s_ID 
    AND s_ID = "689";                               -- depends on who is logged in

-- #8
-- Changes Description of Notes, dependent on user input
UPDATE notepages 
SET n_content = " MORE CONTENT ", 
    n_timeStamp = dateTime(),
    n_docName = "lectureNotes.pdf"
WHERE n_cID = "77" 
AND n_nID = "30";

-- #9
-- Displays all registered students in a particular class
SELECT cl_name, cl_ID 
FROM classRoster, professor, classCatalog  
WHERE p_ID = cla_ID 
    AND p_ID = "556"                         -- Depends on the class that is selected
    AND cla_cID = cl_cID;

-- # 10
-- deletes a specific note
DELETE 
FROM notePages 
WHERE n_nID = "18";  -- Depends on the specific file that would be deleted

-- #11
-- returns all of the classes a professor is teaching
SELECT *
FROM professor
WHERE p_ID = "309";   -- Depends on which professor is logged in

-- #12
-- Add new student to class roster for CSE 111
INSERT INTO classRoster (cl_name, cl_ID,cl_cID)
SELECT s_name, s_ID , cla_cID
FROM student, classCatalog
WHERE s_ID = "770"
    AND cla_cID = "70";   -- Depending on inputs from user, this would determine who is inputted to where

-- #13
-- Inserts a newly uploaded note for a specific class
insert into notePages (n_docName, n_timeStamp, n_cID, n_content, n_nID) 
SELECT "DOC #1", dateTime(), class_cID, "INSERT DOCUMENTATION", ABS(RANDOM()) % (99 - 1) + 1
from classFolder
where class_cID = "29";   -- Depending on what is selected that class would be selected

-- #14
-- Creation of a new Student Account
INSERT INTO account(a_name, a_pass, a_ID, a_type)
VALUES ("sql","light", ABS(RANDOM()) % (999 - 100) + 100, "stu"); -- name and account type would be inputed

-- #15
-- The addition of a new course for professor with ID 710
INSERT INTO classCatalog (cla_name,cla_cID,cla_ID)
SELECT "CSE-150", ABS(RANDOM()) % (99- 10) + 10 , p_ID   -- class name would be inputed
FROM professor
WHERE p_ID = "309"

-- #16
-- Similar to 15 when a class is created a classFolder would be created for the same class
INSERT INTO classFolder (class_name, class_cID, class_lTIme)
SELECT cla_name, cla_cID, dateTime()
FROM classCatalog
WHERE cla_name = "CSE-150";

-- #17
-- Delete's Student from roster
DELETE
FROM classRoster
WHERE cl_ID = "770"
    AND cl_cID = "95";

-- #18
-- Show all students who are registered in the professor's CSE class 
SELECT DISTINCT s_name, s_ID
FROM student, classRoster, classCatalog , professor
WHERE p_ID = "725"
    AND p_ID = cla_ID
    AND cla_cID = cl_cID
    AND cl_ID = s_ID;


-- #19
-- Updating of a user's password
UPDATE account
SET a_pass = "warm"   -- would depend on input
WHERE a_ID = "725";    -- would depend on who is logged in

-- #20
-- Show all students in the Database who are in their 5th year AND taking at least one Math Classes
SELECT DISTINCT s_name, s_ID
FROM student,classRoster, classCatalog
WHERE s_year = "5"
    AND s_ID = cl_ID
    AND cl_cID = cla_cID
    AND cla_name LIKE "Math%";

-- #21
-- Displays all the professors and the classes they are supposed to teach
SELECT DISTINCT p_name, p_class
FROM professor  INNER JOIN classCatalog
ON p_ID = cla_ID;

-- #22
-- List all those registered for a CSE class

SELECT cl_name, cl_ID, cla_name
FROM classRoster JOIN classCatalog
ON cl_cID = cla_cID
WHERE cla_name LIKE "CSE%";

--- #23
-- Count of all students taking a CSE class
SELECT COUNT(DISTINCT s_name)
FROM student
WHERE s_ID IN (SELECT s_ID
    FROM student, classRoster, classCatalog
    WHERE s_ID = cl_ID
    AND cl_cID = cla_cID
    AND cla_name LIKE "CSE%");