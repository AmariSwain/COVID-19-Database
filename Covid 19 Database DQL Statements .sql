/*Displaying Covid 19 Vaccines */
USE COVID19_DB;

SELECT * FROM Vaccine;

/*Displaying Covid 19 Vaccines alphabetical order */
USE COVID19_DB

SELECT
NAME
FROM
Vaccine
ORDER BY
Name;

/* Displaying Vaccines that are suitable for children */
USE COVID19_DB

SELECT
Name	
FROM
Vaccine	
WHERE
MinimumAge < 18;

/* Displaying States/Jurisdictions with a population of 10M - 20M also put them in alphabetical order */ 
 USE Jurisdiction_DB

 SELECT
 Name,
 Population
 FROM
 Jurisdiction
 WHERE 
 Population BETWEEN 10000000 AND 20000000
 ORDER BY
 NAME;

 /*  Displaying States/Jurisdictions with names with "M", show Name, Population, and capital. Also make it alphabetical order */
USE Jurisdiction_DB

 SELECT
 Name,
 Capital,
 Population
 FROM
 Jurisdiction
 WHERE
 Name LIKE 'M%'
 ORDER BY
 NAME;

 /* Displaying Pennsylvania, Iowa, Rhode Island, Maine, and Alabama with area. Also making them in decending order by area*/
 
USE Jurisdiction_DB

 SELECT 
 Name,
 Area
 FROM 
 Jurisdiction
 WHERE 
 Name LIKE '%Pennsylvania%' OR
 Name LIKE '%Iowa%' OR 
 Name LIKE '%Rhode Island%' OR 
 Name LIKE '%Maine%' OR 
 Name LIKE '%Alabama%'
 ORDER BY
 Area DESC;

 /* Displaying COVID 19 vaccine distribution dates and allocations > 600k for any vaccine. Must be in chronological order.*/
 USE COVID19_DB
 
 SELECT
 DistributionDate,
 DoseAllocation
 FROM
 VaccineDistribution 
 WHERE
 DoseAllocation > 600000
 ORDER BY
 DistributionDate;

 /* Displaying 1st & 2nd COVID 19 vac dose series volumes for children. Show dose series and volume*/
 USE COVID19_DB
 
 SELECT
 SeriesDose,
 DoseVolume
 FROM
 VaccineDosage 
 WHERE
 ChildDose = 'TRUE'
 ORDER BY
 SeriesDose;

 /* Displaying dates the reported cases > 75k for any state. Must be in Chronological order.*/
 USE COVID19_DB

 SELECT
 CalendarDate,ReportedCovidCases 
 FROM 
 CovidCases
  WHERE 
  ReportedCovidCases > 75000
  ORDER BY
  ReportedCovidCases DESC;

   /* Displaying Covid 19 vaccine ingredients tht are in both children and adult vaccines. Show in Alphabetical order*/
   USE COVID19_DB

   SELECT
   Ingredient
   FROM
   VaccineIngredient
   WHERE
   ChildFormulation = 'TRUE' AND AdultFormulation = 'TRUE'
   ORDER BY
   Ingredient;

/*Testing Query for results comparison*/
SELECT
SUM(Population) AS 'US Population'
FROM
Jurisdiction;

/* Displaying Highest 1st dose volume*/
USE COVID19_DB
 
 SELECT
 Max(DoseVolume) AS 'Highest Dose Volume'
 From 
 VaccineDosage;

 /* Displaying Lowest dose volume*/
USE COVID19_DB
 
 SELECT
 Min(DoseVolume) AS 'Lowest Dose Volume'
 From
 VaccineDosage;

 /* Displaying Lowest, Highest , and average for covid cases on Nov 30th 2020*/
USE COVID19_DB;

SELECT
MIN(ReportedCovidCases) AS 'Lowest Reported Cases',
MAX(ReportedCovidCases) AS 'Highest Reported Cases',
AVG(ReportedCovidCases) AS 'Average Reported Cases'
FROM
CovidCases
WHERE
CalendarDate = '2020-11-30';

/* Population densities in alphabetical order*/
USE Jurisdiction_DB;

SELECT
Name, 
Sum(Population / Area) AS 'Population Density '
FROM
Jurisdiction
WHERE
Name  LIKE '%Wisconsin%' OR Name LIKE '%Alaska%' OR Name LIKE '%New Jersey%'
Group By
Name
ORDER BY
Name ASC;

/* Average reported covid deaths for the week of Sept 19th-25th, 2021*/
USE COVID19_DB

SELECT CalendarDate,
AVG(ReportedCovidDeaths) AS 'Average State COVID-19 Fatalities'
FROM
CovidDeaths
WHERE
CalendarDate >= '2021-09-19' AND CalendarDate <= '2021-09-25'
GROUP BY
CalendarDate
ORDER BY
CalendarDate;

/*Calendar Dates and total deaths for days that exceed 3750. Show date and order query results in descending order*/
USE COVID19_DB

SELECT
CalendarDate,
SUM(ReportedCovidDeaths) AS 'Total COVID-19 Fatalities'
FROM
CovidDeaths
GROUP BY
CalendarDate
HAVING
SUM(ReportedCovidDeaths ) > 3750 
ORDER BY
SUM(ReportedCovidDeaths) DESC;

/*Number of  Covid- 19 Vaccine ingredients in child vaccine formula. */
USE COVID19_DB

SELECT
COUNT(Ingredient) AS 'Number of Ingredients'
FROM
VaccineIngredient
WHERE
ChildFormulation = 'TRUE';

/*Difference between Max and Min daily reported cases for August 1-7th 2021, Group and order results by date in chronological order*/ 
USE COVID19_DB

SELECT
CalendarDate,
Max(ReportedCovidCases) - Min(ReportedCovidCases) AS 'Covid-19 Case Difference'
FROM
CovidCases
WHERE
CalendarDate BETWEEN '2021-08-01' AND '2021-08-07'
GROUP BY
CalendarDate
ORDER BY
CalendarDate ASC;

/* Cumulative Covid-19 vaccine dose distribution per dose series */
USE COVID19_DB;

SELECT 
  SeriesDose, 
  SUM(ReportedDosesAdministered) AS 'Cumulative Dose Allocation'
FROM 
  VaccineAdministration,
  VaccineDosage
GROUP BY 
SeriesDose
ORDER BY 
SeriesDose;

/* Present total number of administered doses for each year*/
USE COVID19_DB

SELECT
YEAR(AdministrationDate),
SUM(ReportedDosesAdministered) AS 'Total Doses Administered'
FROM
VaccineAdministration
GROUP BY
YEAR(AdministrationDate)
ORDER BY
YEAR(AdministrationDate);
