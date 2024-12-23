DROP TABLE Student;
DROP TABLE Course;
DROP TABLE Grade;
  


CREATE TABLE Student (
    StudentID           NUMBER(20),
    Student_Name		VARCHAR(70),
    Address		        VARCHAR(70),
    Grade_yr	        INT,

     PRIMARY KEY (StudentID)
);

CREATE TABLE Course (
	Course_Name		VARCHAR(70),
	Department      VARCHAR(20),
	Credits	        NUMBER(2),

        PRIMARY KEY (Course_Name)
	
);

CREATE TABLE Grade (
    SID  NUMBER(20),
    CName      VARCHAR(100),
    Grade      DECIMAL(3, 2), 

    FOREIGN KEY (SID) REFERENCES Student(StudentID),
    FOREIGN KEY (CName) REFERENCES Course(Course_Name),
    PRIMARY KEY (SID, CName)
);


INSERT INTO Student VALUES (888665555, 'James E Borg', '450 Stone, Houston, TX', 2024);
INSERT INTO Student VALUES (987654321, 'Jennifer S Wallace', '291 Berry, Bellaire, Tx', 2024);
INSERT INTO Student VALUES (333445555, 'Franklin T Wong', '638 Voss, Houston, TX', 2026);
INSERT INTO Student VALUES (123456789, 'John B Smith', '731 Fondren, Houston, TX', 2025);
INSERT INTO Student VALUES (999887777, 'Alicia J Zelaya', '3321 castle, Spring, TX',  2024);

INSERT INTO Course VALUES ('Intro to Python Progamming', 'CDM', 4);
INSERT INTO Course VALUES ('Data Analytics', 'Business', 3);
INSERT INTO Course VALUES ('Organic Chemistry', 'Chemistry', 5);

INSERT INTO Grade VALUES (888665555,'Intro to Python Progamming', 3.8);
INSERT INTO Grade VALUES (333445555,'Data Analytics', 3.72);
INSERT INTO Grade VALUES (123456789,'Organic Chemistry', 2.8);
INSERT INTO Grade VALUES (987654321,'Intro to Python Progamming', 4.0);
INSERT INTO Grade VALUES (999887777,'Data Analytics',  2.6);

--Q1: Display the list of student IDs and names for the students who graduated in the
-- most recent year. You can assume that GradYear is an integer, but your query
--is not allowed to assume any particular year.

SELECT
   StudentID, Student_Name
FROM
    STUDENT
WHERE 
    Grade_yr = (SELECT MIN(Grade_yr) FROM STUDENT);



--Q2: Display student names and their taken course names for all students with the
-- middle name of ‘Erickson’. You may assume that name is always written as
-- ‘First Middle Last’. Your query output should be sorted by grade.

SELECT
    StudentID, Student_Name, CName
FROM
    STUDENT
JOIN 
    GRADE ON GRADE.SID = STUDENT.STUDENTID
WHERE 
    STUDENT.STUDENT_NAME LIKE '% Erickson %'
ORDER BY 
    GRADE.GRADE;



--Q3: For students who are either not enrolled in any courses or are enrolled in only
--2 or less courses, list those student’s names and graduation years
SELECT
    Student_Name, Grade_yr
FROM
    STUDENT
JOIN 
    GRADE ON GRADE.SID = STUDENT.STUDENTID
GROUP BY
    Student_Name, Grade_yr
HAVING
    COUNT(GRADE.SID) = 0 OR COUNT(GRADE.SID) <= 2;



--Q4: Update all student records, to increase the graduation year by 4 for all students
-- who live in Rockford.

UPDATE Student 
SET Grade_yr = Grade_yr + 4
WHERE Address LIKE '%Rockford%';



--Q5: Modify the course table to add a Chair column that can be up to 32 characters
-- (that question requires a DDL rather than a DML SQL statement)
ALTER TABLE Course
ADD Chair VARCHAR(32);


