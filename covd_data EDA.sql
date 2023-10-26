CREATE DATABASE IF NOT EXIsTS covid;

USE covid;

CREATE TABLE covid_data
(
iso_code varchar(255),
continent varchar(255),
location varchar(255),
date date,
total_cases int,
total_deaths int,
total_tests int,
total_vaccination int,
population int 
);

select * from covid_data ;

LOAD DATA INFILE 'C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\owid-covid-data - Copy.csv' INTO TABLE covid_data
FIELDS TERMINATED BY ','
IGNORE 1 LINES;  

ALTER TABLE covid_data
MODIFY COLUMN total_vaccination BIGINT,
MODIFY COLUMN total_tests BIGINT ;

-- looking at total cases vs total deaths 
select location, date, total_cases, total_deaths, population
from covid_data 
order by 3 desc 
limit 5 ; 

-- looking at total cases and total deaths and the percentage of death 
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage 
from covid_data
where location like '%Nigeria%'
order by 5 desc
limit 10; 

-- looking at the total cases vs location 
select location, date, population, total_cases,  (total_cases/population)*100 as PercentageofCases  
from covid_data
where location like '%Nigeria%'
order by 5 desc
limit 10; 

-- looking at countries with highest infection rate compared to population
select location, population, max(total_cases) as HighestInfectionCount, Max(total_cases/population)*100 as PercentPopulatioinInfected 
from covid_data 
group by location , population 
order by 4 desc; 

-- showing countries with highest death count per population 
select location, max(total_deaths) as TotalDeathCount 
from covid_data
group by location
order by TotalDeathCount desc
limit 10; 

-- showing countries with highest death count per continent 
select continent, max(total_deaths) as TotalDeathCount 
from covid_data
group by continent 
order by TotalDeathCount desc
;

select continent, location, date, population, total_vaccination 
from covid_data 
order by total_vaccination desc
limit 10;


