SELECT 
    company_id,
    name AS company_name
FROM company_dim
WHERE company_id IN (
    SELECT 
        company_id
    FROM 
        job_postings_fact
    WHERE 
        job_no_degree_mention = TRUE
    ORDER BY 
        company_id
)



WITH company_job_counts AS (
    SELECT 
        company_id,
        COUNT(*) AS total_jobs
    FROM
        job_postings_fact
    GROUP BY
        company_id
)

SELECT 
    company_dim.name AS company_name,
    company_job_counts.total_jobs
FROM 
    company_dim
LEFT JOIN company_job_counts ON company_job_counts.company_id = company_dim.company_id
ORDER BY 
    company_job_counts.total_jobs DESC;



--VPP
WITH remote_jobs AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM
        skills_job_dim AS skills_to_job
    INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
    WHERE
        job_postings.job_work_from_home = TRUE AND
        job_postings.job_title_short = 'Data Analyst'
    GROUP BY
        skill_id
)

SELECT 
    skills.skill_id,
    skills AS skill_name,
    skill_count
FROM remote_jobs
INNER JOIN skills_dim AS skills ON skills.skill_id = remote_jobs.skill_id
ORDER BY 
    skill_count DESC
LIMIT 5;