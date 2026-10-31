
USE master;
GO

IF DB_ID(N'DEPI_DBT_HR') IS NOT NULL
BEGIN
    ALTER DATABASE DEPI_DBT_HR SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DEPI_DBT_HR;
END;
GO

CREATE DATABASE DEPI_DBT_HR;
GO

USE DEPI_DBT_HR;
GO

CREATE TABLE dbo.departments (
    department_id INT NOT NULL PRIMARY KEY,
    department_name NVARCHAR(100) NOT NULL,
    location NVARCHAR(100) NOT NULL
);

CREATE TABLE dbo.countries (
    country_id INT NOT NULL PRIMARY KEY,
    country_name NVARCHAR(100) NOT NULL,
    country_code CHAR(2) NOT NULL UNIQUE
);

CREATE TABLE dbo.genders (
    gender_id INT NOT NULL PRIMARY KEY,
    gender_name NVARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE dbo.employees (
    employee_id INT NOT NULL PRIMARY KEY,
    first_name NVARCHAR(60) NOT NULL,
    last_name NVARCHAR(60) NOT NULL,
    department_id INT NOT NULL,
    country_id INT NOT NULL,
    gender_id INT NOT NULL,
    date_of_birth DATE NOT NULL,
    hire_date DATE NOT NULL,
    salary DECIMAL(12,2) NOT NULL,
    employment_status NVARCHAR(20) NOT NULL,
    CONSTRAINT FK_employees_departments FOREIGN KEY (department_id)
        REFERENCES dbo.departments(department_id),
    CONSTRAINT FK_employees_countries FOREIGN KEY (country_id)
        REFERENCES dbo.countries(country_id),
    CONSTRAINT FK_employees_genders FOREIGN KEY (gender_id)
        REFERENCES dbo.genders(gender_id),
    CONSTRAINT CK_employees_salary_positive CHECK (salary > 0),
    CONSTRAINT CK_employees_status CHECK (employment_status IN (N'Active', N'On Leave', N'Inactive'))
);
GO

INSERT INTO dbo.departments (department_id, department_name, location) VALUES
(10, N'Data Engineering', N'Cairo'),
(20, N'Analytics', N'Giza'),
(30, N'Human Resources', N'Assiut'),
(40, N'Finance', N'Cairo'),
(50, N'Operations', N'Alexandria');

INSERT INTO dbo.countries (country_id, country_name, country_code) VALUES
(1, N'Egypt', 'EG'),
(2, N'Jordan', 'JO'),
(3, N'Saudi Arabia', 'SA'),
(4, N'United Arab Emirates', 'AE');

INSERT INTO dbo.genders (gender_id, gender_name) VALUES
(1, N'Male'),
(2, N'Female'),
(3, N'Unspecified');

INSERT INTO dbo.employees
(employee_id, first_name, last_name, department_id, country_id, gender_id, date_of_birth, hire_date, salary, employment_status)
VALUES
(1001, N'Ahmed', N'Ali',       10, 1, 1, '1998-03-12', '2022-01-10', 18500.00, N'Active'),
(1002, N'Sara',  N'Mohamed',   20, 1, 2, '1996-07-21', '2021-06-15', 22000.00, N'Active'),
(1003, N'Omar',  N'Hassan',    10, 2, 1, '1995-11-02', '2020-09-01', 24500.00, N'Active'),
(1004, N'Mariam',N'Khaled',    30, 1, 2, '1999-01-30', '2023-02-20', 14500.00, N'On Leave'),
(1005, N'Youssef',N'Adel',     40, 3, 1, '1993-05-18', '2019-04-07', 28000.00, N'Active'),
(1006, N'Nour',  N'Ibrahim',   20, 4, 2, '2000-09-14', '2024-01-11', 17000.00, N'Active'),
(1007, N'Karim', N'Samir',     50, 1, 1, '1997-12-05', '2022-08-23', 19500.00, N'Inactive'),
(1008, N'Farah', N'Tarek',     10, 2, 2, '1994-02-26', '2018-05-14', 31000.00, N'Active'),
(1009, N'Ziad',  N'Mahmoud',   40, 3, 1, '1992-08-09', '2017-10-02', 33500.00, N'Active'),
(1010, N'Jana',  N'Fathy',     30, 1, 2, '2001-04-17', '2024-07-01', 13200.00, N'Active'),
(1011, N'Adam',  N'Wael',      20, 4, 1, '1996-10-28', '2021-12-06', 23000.00, N'Active'),
(1012, N'Layla', N'Mostafa',   50, 1, 2, '1998-06-03', '2023-09-18', 16800.00, N'On Leave'),
(1013, N'Khaled',N'Emad',      10, 3, 1, '1991-01-19', '2016-03-27', 36000.00, N'Active'),
(1014, N'Dina',  N'Osman',     30, 2, 2, '1997-03-08', '2020-11-09', 20500.00, N'Active'),
(1015, N'Ramy',  N'Fouad',     40, 1, 1, '1990-07-25', '2015-02-16', 39000.00, N'Active'),
(1016, N'Noha',  N'Yasser',    20, 1, 2, '1995-12-13', '2019-08-05', 25750.00, N'Active'),
(1017, N'Bassem',N'Riad',      50, 3, 1, '1999-09-29', '2022-04-12', 18100.00, N'Active'),
(1018, N'Rana',  N'Said',      10, 4, 2, '1993-04-01', '2017-07-17', 32500.00, N'Active'),
(1019, N'Fady',  N'Nabil',     30, 1, 1, '1994-06-20', '2018-10-22', 24000.00, N'Inactive'),
(1020, N'Yara',  N'Kamel',     20, 2, 2, '2002-02-11', '2025-01-05', 12500.00, N'Active');
GO

SELECT N'Database created successfully' AS setup_status;
SELECT COUNT(*) AS employee_count FROM dbo.employees;
GO
