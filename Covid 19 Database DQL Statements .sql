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

/*Testing query with sample code*/
USE COVID19_DB

SELECT
V.Name,
VI.Ingredient 
FROM
Vaccine V INNER JOIN VaccineIngredient VI
ON 
V.VaccineID = VI.VaccineID
WHERE 
V.Name = 'Janssen';

/*Listing active ingredients for each Vaccine in alphabetical order*/
USE COVID19_DB

SELECT 
V.Name,
VI.Ingredient
FROM 
Vaccine V INNER JOIN VaccineIngredient VI 
ON 
V.VaccineID = VI.VaccineID
WHERE
IngredientType = 'ACTIVE'
ORDER BY 
V.Name;

/*Lists States that reported COVID deaths on 10/31/2020 that exceeded 10,000,000 p2*/
USE COVID19_DB

SELECT 
Jurisdiction.Name,
ReportedCovidDeaths
FROM
CovidDeaths 
INNER JOIN Jurisdiction 
ON 
CovidDeaths.JurisdictionID = Jurisdiction.JurisdictionID
WHERE 
CalendarDate = '2020-10-31' AND Jurisdiction.Population > 10000000
ORDER BY
Jurisdiction.Name;

/*States that reported 1 or more coivd cases on February 29th 2020. Show full names and be in alphabetical order*/
USE COVID19_DB;

SELECT 
	Jurisdiction.Name,
	CovidCases.ReportedCovidCases 
FROM 
	CovidCases
	JOIN Jurisdiction 
ON
	CovidCases.JurisdictionID = Jurisdiction.JurisdictionID
WHERE 
	CovidCases.CalendarDate = '2020-02-29' AND CovidCases.ReportedCovidCases > 0
ORDER BY 
	Jurisdiction.Name ASC;

/*Show dates and reported deaths from covid for the month of March 2020 in New York and California*/
USE COVID19_DB

SELECT 
    CovidDeaths.CalendarDate,  
	Jurisdiction.Name, 
    CovidDeaths.ReportedCovidDeaths
FROM 
    CovidDeaths 
    JOIN Jurisdiction 
	ON 
	CovidDeaths.JurisdictionId = Jurisdiction.JurisdictionId
WHERE 
    CovidDeaths.CalendarDate BETWEEN '2020-03-01' AND '2020-03-31'
    AND CovidDeaths.ReportedCovidDeaths > 100
    AND Jurisdiction.Name IN ('New York', 'California')
ORDER BY 
    CovidDeaths.CalendarDate

/*Listing Average daily reported Covid Cases values in GA, FL, AL from DEC 1, 2020 - DEC 31, 2020*/
USE COVID19_DB;

SELECT 
	Jurisdiction.Name, 
	AVG(ReportedCovidCases) AS 'AVG Daily COVID-19 Cases - DEC 2020'
FROM CovidCases
	JOIN Jurisdiction 
ON 
	CovidCases.JurisdictionID =Jurisdiction.JurisdictionID
WHERE
	Jurisdiction.Name IN ('Georgia', 'Florida', 'Alabama')
	AND CovidCases.CalendarDate BETWEEN '2020-12-01' AND '2020-12-31'
GROUP BY
	Jurisdiction.Name
ORDER BY
	Jurisdiction.Name;

/*Listing Full Vaccine and state for vaccines administered on DEC 30 2020*/
USE COVID19_DB

SELECT 
	Vaccine.Name, 
	Jurisdiction.Name, 
	ReportedDosesAdministered 
FROM 
	Vaccine
	INNER JOIN VaccineAdministration
ON 
	VaccineAdministration.VaccineID = Vaccine.VaccineID 
	INNER JOIN Jurisdiction
ON 
	VaccineAdministration.JurisdictionID = Jurisdiction.JurisdictionID
WHERE 
	AdministrationDate = '2020-12-30'
ORDER BY 
	Vaccine.Name, 
	Jurisdiction.Name;

/* Total COVID-19 cases that exceed 2,000,000 per state in 2021.P7*/
USE COVID19_DB;

SELECT 
	Jurisdiction.Name, 
	SUM(ReportedCovidCases) AS 'Total COVID-19 Cases'
FROM 
	CovidCases
	JOIN Jurisdiction
ON 
	CovidCases.JurisdictionID = Jurisdiction.JurisdictionID
WHERE 
	YEAR(CalendarDate) = 2021
GROUP BY 
	Jurisdiction.Name
HAVING
	SUM(ReportedCovidCases) > 2000000
ORDER BY 
	Jurisdiction.Name;

/*Showing full vaccine names and dose volumes of second dosages*/
USE COVID19_DB

SELECT 
	Vaccine.Name,
	MinimumAge,
	DoseVolume
FROM 
	Vaccine
	JOIN VaccineDosage
ON
	Vaccine.VaccineID = VaccineDosage.VaccineID
WHERE
	AdultDose = 'TRUE' AND SeriesDose = 'Second'
ORDER BY 
	Vaccine.Name;

/* Number of reported COVID 19 cases per 1000 people in 2021 in FL, NY, CA, TX, MI P.10*/
USE COVID19_DB

SELECT
	Jurisdiction.Name,
	SUM(ReportedCovidCases*1000/Population) AS '2021 COVID-19 Cases/1,000 people'
FROM
	CovidCases
	JOIN Jurisdiction
ON 
	CovidCases.JurisdictionID = Jurisdiction.JurisdictionID
WHERE
	YEAR(CalendarDate) = 2021
	AND Jurisdiction.Name IN ('Florida', 'New York', 'California', 'Texas', 'Michigan')
GROUP BY
	Jurisdiction.Name
ORDER BY
	Jurisdiction.Name ASC;

	/* Testing Query before starting assignment */
	SELECT
	Name 
	FROM
	Jurisdiction
	WHERE 
	JurisdictionID IN 
	(SELECT JurisdictionID
		FROM	
		CovidDeaths
		WHERE  
		CalendarDate = '03/11/2020');

	/* CumulativeCovidCases_VW*/
	CREATE VIEW
	CumulativeCovidCases_VW AS
	SELECT 
	Name, 
	SUM(ReportedCovidCases) AS CumulativeCovidCases
	FROM
	CovidCases
	JOIN Jurisdiction ON CovidCases.JurisdictionID = Jurisdiction.JurisdictionID
	GROUP BY
	Name;
	GO 

	SELECT * FROM CumulativeCovidCases_VW;

	/*DROP VIEW CumulativeCovidCases_VW;*/

	/* CumulativeCovidCases_VW*/
CREATE VIEW 
	CumulativeDoseAllocation_VW AS
	SELECT
		Vaccine.Name AS Vaccine,
		Jurisdiction.Name AS JurisdictionName,
		SUM(VaccineDistribution.DoseAllocation) AS CumulativeDoseAllocation
	FROM
		VaccineDistribution
		INNER JOIN Vaccine ON Vaccine.VaccineID = VaccineDistribution.VaccineID
		INNER JOIN Jurisdiction ON Jurisdiction.JurisdictionID = VaccineDistribution.JurisdictionID
	GROUP BY 
		Jurisdiction.Name, Vaccine.Name;

	SELECT * FROM CumulativeDoseAllocation_VW;
	/*DROP VIEW CumulativeDoseAllocation_VW;*/