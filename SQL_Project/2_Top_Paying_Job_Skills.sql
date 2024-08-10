/*
Question: What skills are required for the top paying Data Analyst jobs?
- Use the top 10 highest paying Data Analyst  jobs from first query.
- Add the specific skills required for these roles.

Result: It provides a detailed look at which high paying jobs demand certain skills, helping job seekers understand which skills to develop that align with top salaries.
*/

WITH top_paying_skills AS(
    WITH top_paying_jobs AS(

    SELECT
    job_id,
    job_title,
    company.name AS company_name,
    job_posted_date,
    job_country,
    salary_year_avg

    FROM 
        job_postings_fact

    LEFT JOIN company_dim AS company ON job_postings_fact.company_id = company.company_id

    WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL

    ORDER BY
        salary_year_avg DESC

    LIMIT 10

    )

    SELECT 
        top_paying_jobs.*,
        skill_id
    FROM top_paying_jobs
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = top_paying_jobs.job_id

)

SELECT 
    top_paying_skills.*,
    skills
FROM top_paying_skills
LEFT JOIN skills_dim ON top_paying_skills.skill_id = skills_dim.skill_id