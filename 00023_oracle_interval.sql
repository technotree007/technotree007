
/*
Oracle INTERVAL
provides the INTERVAL data type that allows you to store periods of time.

--There are two types of INTERVAL:

--INTERVAL YEAR TO MONTH – stores intervals using of year and month.
--INTERVAL DAY TO SECOND – stores intervals using days, hours, minutes, and seconds including fractional seconds.
*/
CREATE TABLE candidates (
    candidate_id NUMBER,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    job_title VARCHAR2(255) NOT NULL,
    year_of_experience INTERVAL YEAR TO MONTH,
    PRIMARY KEY (candidate_id)
);

INSERT INTO candidates (candidate_id,
    first_name,
    last_name,
    job_title,
    year_of_experience
    )
VALUES (101,
    'Camila',
    'Kramer',
    'SCM Manager',
    INTERVAL '10-2' YEAR TO MONTH
    );
    
    INSERT INTO candidates (candidate_id,
    first_name,
    last_name,
    job_title,
    year_of_experience
    )
VALUES (102,
    'Keila',
    'Doyle',
    'SCM Staff',
    INTERVAL '9' MONTH
    );
    
    SELECT * FROM candidates;