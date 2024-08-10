/*
question: What are the top paying Data Analyst remote jobs?
- Identify the top 10 highest paying Data Analyst roles that are available remotely.
- Focuses on jobs postings with specified salaries.

Result: Job seekers can identify the companies and locations that offer the most lucrative remote opportunities for Data Analysts.
*/


SELECT
    job_title,
    company.name AS company_name,
    job_posted_date,
    job_country,
    job_location,
    job_schedule_type,
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