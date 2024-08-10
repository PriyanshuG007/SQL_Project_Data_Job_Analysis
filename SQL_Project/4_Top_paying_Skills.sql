/*
Question: What are the top skills based on salary?
- Look at the average salary associated with each skill for data Analyst positions.
- Focuses on roles with specified salries, regardless of location.

Result: It revelas how different skills impact salary levels for data Analysts and helps identify the most financially rewarding skills to acquire or improve.
*/

WITH jobs_to_skills AS(

    WITH jobs_table AS (
    SELECT 
        job_id,
        company_id,
        job_title,
        job_location,
        job_posted_date,
        salary_year_avg

    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL AND
        job_title_short = 'Data Analyst' AND
        job_work_from_home = TRUE

    )

    SELECT 
        jobs_table.*,
        skill_id
    FROM jobs_table
    INNER JOIN skills_job_dim ON jobs_table.job_id = skills_job_dim.job_id

)

SELECT  
    skills,
    ROUND(AVG(salary_year_avg), 0) AS average_year_salary
FROM jobs_to_skills
LEFT JOIN skills_dim ON jobs_to_skills.skill_id = skills_dim.skill_id
GROUP BY
    skills
ORDER BY average_year_salary DESC
LIMIT 20