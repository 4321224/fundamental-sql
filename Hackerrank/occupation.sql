/* 
The first column is an alphabetically ordered list of Doctor names.
The second column is an alphabetically ordered list of Professor names.
The third column is an alphabetically ordered list of Singer names.
The fourth column is an alphabetically ordered list of Actor names.
The empty cell data for columns with less than the maximum number of names per occupation (in this case, the Professor and Actor columns) are filled with NULL values.
 */

WITH CTE AS(
    SELECT 
     CASE WHEN OCCUPATION = 'Doctor' THEN NAME END AS DOCTOR,
     CASE WHEN OCCUPATION = 'Singer' THEN NAME END AS SINGER,
     CASE WHEN OCCUPATION = 'Actor' THEN NAME END AS ACTOR,
     CASE WHEN OCCUPATION = 'Professor' THEN NAME END AS PROFESSOR,
ROW_NUMBER() OVER(PARTITION BY OCCUPATION ORDER BY NAME) AS ROWNO
FROM OCCUPATIONS)
SELECT MAX(DOCTOR), MAX(PROFESSOR), MAX(SINGER), MAX(ACTOR)
FROM CTE
GROUP BY ROWNO;