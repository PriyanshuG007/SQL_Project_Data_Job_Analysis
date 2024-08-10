/*
Question: What are the most in demand skills for data analysts?
- Indentify the top 5 in-demand skills for a Data Analyst.
- Focus on all job postings.

Result: Retrieves the top 5 skills with the highest demand in the job market,
providing insights into the most valuable skills for job seekers.
*/

WITH skills_count AS (
    SELECT 
        job_postings_fact.*,
        skill_id
    FROM job_postings_fact
    
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    WHERE job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE
)

SELECT 
    skills,
    COUNT(skills_count.job_id) AS total_count
    
FROM skills_count
LEFT JOIN skills_dim ON skills_count.skill_id = skills_dim.skill_id
GROUP BY 
    skills
ORDER BY
    total_count DESC
LIMIT 5