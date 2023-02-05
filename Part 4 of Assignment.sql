/*Addidng Katalin and Hamilton's data to our VaccinceResearcher table. Part 1 of assignment*/

SET IDENTITY_INSERT VaccineResearcher ON

INSERT INTO VaccineResearcher ( ResearcherID, FirstName, LastName, Title, VaccineID) 
			Values (1, 'Katalin', 'Kariko', 'Lead Researcher', 2);
		

Select * FROM VaccineResearcher
	WHERE ResearcherID = 1;

	INSERT INTO VaccineResearcher ( ResearcherID, FirstName, LastName, Title, VaccineID) 
			Values (2, 'Hamilton', 'Bennett', 'Senior Director', 1)
		

Select * FROM VaccineResearcher
	WHERE ResearcherID = 2;

/* Updating Katalin Kariko title to Vice President after promotion. Part 2 of assignment*/

	UPDATE VaccineResearcher
SET Title = 'Vice President'
WHERE ResearcherID = 1;

SELECT * FROM VaccineResearcher
WHERE ResearcherID = 1;

/*Viewing table to comfirm accuracy in data entered*/

SELECT *FROM VaccineResearcher; 

/* Deletion of Hamilton Bennett due to retiring. Part 3 of assignment*/

DELETE FROM VaccineResearcher
WHERE ResearcherID = 2;

SELECT * FROM VaccineResearcher
WHERE ResearcherID = 2;

/*Viewing table to comfirm accuracy in data entered*/

SELECT *FROM VaccineResearcher;