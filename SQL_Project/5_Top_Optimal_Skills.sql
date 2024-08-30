/*
Question: What are the most optimal skills to learn (aka its in high demand and a high paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles.
 Concentrates on remote positions with specified salaries.

 Results: Targets skills that offers job security(high demand) and financial benefits(high salaries).
*/

WITH top_paying_skills AS (

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

), top_demanded_skills AS (

    WITH skills_count AS (
    SELECT 
        job_postings_fact.*,
        skill_id
    FROM job_postings_fact
    
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    WHERE job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE AND
    salary_year_avg IS NOT NULL
    )

    SELECT 
        skills,
        COUNT(skills_count.job_id) AS total_count
        
    FROM skills_count
    LEFT JOIN skills_dim ON skills_count.skill_id = skills_dim.skill_id
    GROUP BY 
        skills
)

SELECT 
    top_demanded_skills.*,
    average_year_salary
FROM top_demanded_skills
INNER JOIN top_paying_skills ON top_demanded_skills.skills = top_paying_skills.skills
ORDER BY 
    total_count DESC,
    average_year_salary DESC
LIMIT 10