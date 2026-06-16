CREATE TABLE january_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

CREATE TABLE february_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

CREATE TABLE march_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

CREATE TABLE april_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 4;

CREATE TABLE may_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 5;

CREATE TABLE june_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 6;

CREATE TABLE july_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 7;

CREATE TABLE august_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 8;

CREATE TABLE september_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 9;

CREATE TABLE october_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 10;

CREATE TABLE november_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 11;

CREATE TABLE december_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 12;

DROP TABLE january_jobs;
DROP TABLE february_jobs;
DROP TABLE march_jobs;
DROP TABLE april_jobs;
DROP TABLE may_jobs;
DROP TABLE june_jobs;
DROP TABLE july_jobs;
DROP TABLE august_jobs;
DROP TABLE september_jobs;
DROP TABLE october_jobs;
DROP TABLE november_jobs;
DROP TABLE december_jobs;

SELECT 
    COUNT(Job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY
    Location_category;


--PP1
SELECT 
    job_title_short,
    salary_year_avg,
    salary_hour_avg,
    salary_rate,

    CASE
        WHEN salary_rate = 'year' THEN (salary_year_avg/52)/40
        WHEN salary_rate = 'hour' THEN salary_hour_avg
        ELSE NULL
    END AS standardized_salary_hourly,

    CASE
        WHEN (
            CASE
                WHEN salary_rate = 'year' THEN (salary_year_avg/52)/40
                WHEN salary_rate = 'hour' THEN salary_hour_avg
                ELSE NULL
            END
            ) <= 90 THEN 'Low'
        WHEN (
            CASE
                WHEN salary_rate = 'year' THEN (salary_year_avg/52)/40
                WHEN salary_rate = 'hour' THEN salary_hour_avg
                ELSE NULL
            END
            ) >= 171 THEN 'High'
        ELSE 'Standard'
    END AS salary_bracket
FROM job_postings_fact
WHERE
    (salary_year_avg IS NOT NULL 
    OR salary_hour_avg IS NOT NULL)
    AND job_title_short = 'Data Analyst'
ORDER BY
    standardized_salary_hourly DESC;


