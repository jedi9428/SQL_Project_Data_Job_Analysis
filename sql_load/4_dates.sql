SELECT job_posted_date
FROM job_postings_fact
LIMIT 10;

SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
    EXTRACT(MONTH FROM job_posted_date) AS date_month
FROM 
    job_postings_fact
LIMIT 10;

SELECT
    COUNT(job_id) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    month
ORDER BY
    job_posted_count DESC;


-- PP1
SELECT
    job_title_short AS title,
    salary_year_avg,
    salary_hour_avg,
    job_schedule_type,
    job_posted_date,
    EXTRACT(MONTH FROM job_posted_date) AS month_posted
FROM
    job_postings_fact
WHERE
    (salary_year_avg IS NOT NULL
    OR salary_hour_avg IS NOT NULL)
    AND EXTRACT(MONTH FROM job_posted_date) >= 6
ORDER BY
    job_schedule_type DESC;


-- PP2
SELECT
    EXTRACT(MONTH FROM( job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York' )) AS month_posted,
    COUNT(*) AS job_month_count
FROM
    job_postings_fact
GROUP BY
    month_posted
ORDER BY
    month_posted DESC;

-- PP3
SELECT
    job_title_short AS title,
    EXTRACT(MONTH FROM job_posted_date) AS month_posted,
    job_posted_date,
    job_health_insurance,
    company_dim.name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim
    ON job_postings_fact.company_id = company_dim.company_id
WHERE
    EXTRACT(MONTH FROM job_posted_date) IN (4, 5, 6)
    AND job_health_insurance = 'TRUE'
LIMIT 100;