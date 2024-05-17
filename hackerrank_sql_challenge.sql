--Hackerrank Solution

--Basic Select


--*Revising the select query I:* Query all columns for all American cities in the CITY table with populations larger than 100000. The CountryCode for America is USA.

--This solution uses the where clause to filter a table
SELECT 
    *
FROM
    CITY
WHERE
    COUNTRYCODE = 'USA' 
    AND POPULATION > 100000




--*Revising the select query II:* Query the NAME field for all American cities in the CITY table with populations larger than 120000. The CountryCode for America is USA.

--This solution uses the where clause to filter a table
SELECT
    NAME
FROM
    CITY
WHERE 
    COUNTRYCODE = 'USA' 
    AND POPULATION > 120000




--*Select All:* Query all columns (attributes) for every row in the CITY table.

SELECT * FROM CITY




--*Select by ID:* Query all columns for a city in CITY with the ID 1661.

--This solution uses the where clause to filter a table
SELECT * FROM CITY WHERE ID = 1661




--*Japanese Cities' Attributes:* Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.

--This solution uses the where clause to filter a table
SELECT * FROM CITY WHERE COUNTRYCODE = 'JPN'




--*Japanese Cities' Names:* Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN.

--This solution uses the where clause to filter a table
SELECT NAME FROM CITY WHERE COUNTRYCODE = 'JPN'




--*Weather Observation Station 1:* Query a list of CITY and STATE from the STATION table.

SELECT
    DISTINCT CITY,
    STATE
FROM 
    STATION




--*Weather Observation Station 3:* Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer.

--This solution utilizes the where clause to filter a table
SELECT 
    DISTINCT CITY
FROM
    STATION
WHERE ID%2 = 0




--*Weather Observation Station 4:* Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.

--This solution utilizes the aggregate function Count()
SELECT 
    COUNT(CITY) - COUNT(DISTINCT CITY)
FROM 
    STATION




--*Weather Observation Station 5:* Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name). If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.

--This solution utilizes aggregate functions Min() and Max(), Union() Functions, Length() functions, limit() function to truncate table and Where() clause to filter
(SELECT 
    CITY, 
    LENGTH(CITY) 
FROM 
    STATION 
WHERE 
    LENGTH(CITY) = (SELECT MIN(LENGTH(CITY)) FROM STATION)
ORDER BY 
    CITY
LIMIT 1) 
UNION
(SELECT 
    CITY, 
    LENGTH(CITY) 
FROM 
    STATION 
WHERE 
    LENGTH(CITY) = (SELECT MAX(LENGTH(CITY)) FROM STATION)




--*Weather Observation Station 6:* Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.

--This solution utilizes Regular Expressions
SELECT 
   DISTINCT CITY
FROM 
    STATION
WHERE 
    CITY REGEXP '^[AEIOU]'





--*Weather Observation Station 7:* Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.

--This solution utilizes Regular Expressions
SELECT 
   DISTINCT CITY
FROM 
    STATION
WHERE 
    CITY REGEXP '[AEIOU]$'





--*Weather Observation Station 8:* Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.

--This solution utilizes Regular Expressions
SELECT
   DISTINCT CITY
FROM
    STATION
WHERE
    CITY REGEXP '^[AEIOU]'
    AND CITY REGEXP '[AEIOU]$'




--*Weather Observation Station 9:* Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.

--This solution utilizes the negated Regular Expressions
SELECT
   DISTINCT CITY
FROM
    STATION
WHERE
    CITY NOT REGEXP '^[AEIOU]'




--*Weather Observation Station 10:* Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.

--This solution utilizes the negated Regular Expressions
SELECT
    DISTINCT CITY
FROM
    STATION
WHERE
    CITY NOT REGEXP '[AEIOU]$'




--*Weather Observation Station 11:* Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.

--This solution utilizes the negated Regular Expressions
SELECT
    DISTINCT CITY
FROM
    STATION
WHERE
    CITY NOT REGEXP '^[AEIOU]'
    OR CITY NOT REGEXP '[AEIOU]$'




--*Weather Observation Station 12:* Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. Your result cannot contain duplicates.

--This solution utilizes the negated Regular Expressions
SELECT
    DISTINCT CITY
FROM
    STATION
WHERE
    CITY NOT REGEXP '[AEIOU]$'
    AND CITY NOT REGEXP '^[AEIOU]'


--*Higher Than 75 Marks:* Query the Name of any student in STUDENTS who scored higher than 75  Marks. Order your output by the last three characters of each name. If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID.











--Basic Join



--You are given two tables: Students and Grades. Students contains three columns ID, Name and Marks.

--Ketty gives Eve a task to generate a report containing three columns: Name, Grade and Mark. 
--Ketty doesn't want the NAMES of those students who received a grade lower than 8. The report must be in descending order by grade -- i.e. higher grades are entered first. 
--If there is more than one student with the same grade (8-10) assigned to them, order those particular students by their name alphabetically. 
--Finally, if the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order. 
--If there is more than one student with the same grade (1-7) assigned to them, order those particular students by their marks in ascending order.
--Write a query to help Eve.
SELECT
    CASE
        WHEN g.Grade < 8 THEN NULL
        ELSE s.Name
    END AS name,
    g.Grade,
    s.Marks
FROM
    Students s
JOIN
    Grades g
ON
    s.Marks BETWEEN g.Min_Mark AND g.Max_Mark
ORDER BY
    g.Grade DESC,
    s.Name 













--Advanced Join



--*15 Days of learning SQL:* Write a query to print total number of unique hackers who made at least  submission each day (starting on the first day of the contest), and find the hacker_id and name of the hacker who made maximum number of submissions each day. If more than one such hacker has a maximum number of submissions, print the lowest hacker_id. The query should print this information for each day of the contest, sorted by the date.

--declaring table variables
DECLARE @consistent_hackers TABLE
(
    hacker_id int,
    submission_date date
)
;

DECLARE @count_hackers TABLE
(
    hacker_id int,
    submission_date date
)
;

--declaring the variables
DECLARE @subdate date;
DECLARE @remainingdate date;

--inserting into table for first date
INSERT INTO @consistent_hackers
    SELECT
        hacker_id,
        submission_date
    FROM    submissions
    WHERE   submission_date LIKE '2016-03-01'
;


--initializing the variables
SET @subdate = '2016-03-01';
SET @remainingdate = '2016-03-01';

--looping
WHILE @subdate < '2016-03-15'
BEGIN

    SET @subdate = DATEADD(day,1,@subdate);

    INSERT INTO @consistent_hackers
    SELECT
        s.hacker_id,
        s.submission_date
    FROM    
        submissions s
    JOIN    
        @consistent_hackers ch 
    ON 
        ch.hacker_id = s.hacker_id 
        AND
        ch.submission_date = @remainingdate
    WHERE   
        s.submission_date = @subdate;

    SET @remainingdate = DATEADD(day,1,@remainingdate);

END;

INSERT INTO @count_hackers
   SELECT
      COUNT(DISTINCT hacker_id),
      submission_date
    FROM
        @consistent_hackers
    GROUP BY 
       submission_date;
       
WITH 
    a1 AS (
    SELECT
        DISTINCT submission_date AS dates,
        COUNT(DISTINCT hacker_id) AS numberOfHackers
    FROM
        submissions
    GROUP BY
        submission_date
    ),

    base AS (
    SELECT
        h.name AS nameHackerMaxSubmissions,
        submission_date AS dates,
        s.hacker_id AS idHackerMaxSubmissions,
        COUNT(s.hacker_id) as cunt,
        ROW_NUMBER() OVER (PARTITION BY submission_date ORDER BY COUNT(s.hacker_id) DESC, s.hacker_id ASC) AS rownum
    FROM
        submissions s
    JOIN
        hackers h
    ON
        s.hacker_id  = h.hacker_id
    GROUP BY
        submission_date, s.hacker_id, h.name
    ),

    a2 AS (
    SELECT
        base.dates AS dates,
        base.idHackerMaxSubmissions AS idHackerMaxSubmissions,
        base.nameHackerMaxSubmissions AS nameHackerMaxSubmissions
    FROM    
        base
    WHERE
        base.rownum = 1
    )

SELECT  
    a1.dates,
    ch.hacker_id,
    a2.idHackerMaxSubmissions,
    a2.nameHackerMaxSubmissions
FROM
    a1
JOIN    
    a2
ON
    a1.dates = a2.dates
JOIN
    @count_hackers ch
ON
  a1.dates = ch.submission_date
