/*
Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.


Write a query to find the difference between the total number of cities and the unique number of cities in the table STATION.
*/



SELECT COUNT(CITY)-COUNT(DISTINCT(CITY))
FROM STATION
