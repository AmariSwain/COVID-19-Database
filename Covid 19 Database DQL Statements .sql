/*Displaying Covid 19 Vaccines */
USE COVID19_DB;

SELECT * FROM Vaccine;

/*Displaying Covid 19 Vaccines alphabetical order */
USE COVID19_DB

SELECT NAME

FROM Vaccine

ORDER BY Name;

/* Displaying Vaccines that are suitable for children */
USE COVID19_DB

SELECT Name
	
FROM Vaccine
	
WHERE MinimumAge < 18;

/* Displaying States/Jurisdictions with a population of 10M - 20M also put them in alphabetical order */ 
 USE Jurisdiction_DB

 SELECT Name, Population

 FROM Jurisdiction

 WHERE Population BETWEEN 10000000 AND 20000000

 ORDER BY NAME;

 /*  Displaying States/Jurisdictions with names with "M", show Name, Population, and capital. Also make it alphabetical order */
USE Jurisdiction_DB

 SELECT Name, Capital, Population

 FROM Jurisdiction

 WHERE Name LIKE 'M%'

 ORDER BY NAME;

 /* Displaying Pennsylvania, Iowa, Rhode Island, Maine, and Alabama with area. Also making them in decending order by area*/
 
USE Jurisdiction_DB

 SELECT Name, Area

 FROM Jurisdiction

 WHERE Name LIKE '%Pennsylvania%' OR Name LIKE '%Iowa%' OR Name LIKE '%Rhode Island%' OR Name LIKE '%Maine%' OR Name LIKE '%Alabama%'

 ORDER BY Area DESC;

 /* Displaying COVID 19 vaccine distribution dates and allocations > 600k for any vaccine. Must be in chronological order.*/
 USE COVID19_DB
 
 SELECT DistributionDate, DoseAllocation

 FROM VaccineDistribution 

 WHERE DoseAllocation > 600000

 ORDER BY DistributionDate;

 /* Displaying 1st & 2nd COVID 19 vac dose series volumes for children. Show dose series and volume*/
 USE COVID19_DB
 
 SELECT SeriesDose, DoseVolume

 From VaccineDosage 

 WHERE ChildDose = 'TRUE'
 
 ORDER BY SeriesDose;

 /* Displaying dates the reported cases > 75k for any state. Must be in Chronological order.*/
 USE COVID19_DB

 SELECT CalendarDate,ReportedCovidCases
 
  
 FROM CovidCases

  WHERE ReportedCovidCases > 75000

  ORDER BY ReportedCovidCases DESC;


   /* Displaying Covid 19 vaccine ingredients tht are in both children and adult vaccines. Show in Alphabetical order*/
   USE COVID19_DB

   SELECT Ingredient

   FROM VaccineIngredient

   WHERE ChildFormulation = 'TRUE' AND AdultFormulation = 'TRUE'

   ORDER BY Ingredient;