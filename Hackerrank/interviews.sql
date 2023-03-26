SELECT c.contest_id, c.hacker_id, c.name, 
SUM(tbl_result.ts) AS ts, 
SUM(tbl_result.tas) AS tas, 
SUM(tbl_result.tv) AS tv, 
SUM(tbl_result.tuv) AS tuv 
FROM Contests c 
JOIN ( SELECT co.contest_id,ch.college_id,ch.challenge_id,
SUM(s.total_submissions) AS ts,
SUM(s.total_accepted_submissions) AS tas,tbl_vs.tv,tbl_vs.tuv 
FROM Challenges ch 
LEFT JOIN Submission_Stats s 
ON ch.challenge_id = s.challenge_id 
LEFT JOIN (SELECT ch.college_id,ch.challenge_id,
SUM(v.total_views) AS tv,
SUM(v.total_unique_views) AS tuv 
FROM Challenges ch 
LEFT JOIN View_Stats v 
ON ch.challenge_id = v.challenge_id 
GROUP BY ch.challenge_id, ch.college_id )tbl_vs 
ON ch.challenge_id = tbl_vs.challenge_id 
JOIN Colleges co
ON co.college_id = ch.college_id 
GROUP BY ch.challenge_id, ch.college_id, co.contest_id, tbl_vs.tv,tbl_vs.tuv ) tbl_result 
ON c.contest_id = tbl_result.contest_id 
GROUP BY c.contest_id, c.hacker_id, c.name