/* **********************************

COVID-19 DATABASE CREATION SCRIPT
HI-520 - DATABASE DESIGN & SQL

********************************** */

SET NOCOUNT ON
GO

USE master;
GO

IF EXISTS 
(
	SELECT * 
	FROM sysdatabases 
	WHERE name='COVID19_DB'
)
BEGIN
	ALTER DATABASE COVID19_DB 
		SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE COVID19_DB;
END;
GO

CREATE DATABASE COVID19_DB;
GO

USE COVID19_DB;
GO

/* Definition for the "Jurisdiction" Table */

CREATE TABLE Jurisdiction (
	JurisdictionID				VARCHAR (5) NOT NULL,
	Name						VARCHAR (50) NOT NULL,
	Capital						VARCHAR (50) NULL, 
	Population					INT NOT NULL,
	Area						FLOAT (1) NOT NULL,
	CONSTRAINT PK_Jurisdiction PRIMARY KEY (JurisdictionID)
);
GO	

/* Definition for the "CovidCases" Table */

CREATE TABLE CovidCases (
	CalendarDate				DATE NOT NULL,
	JurisdictionID				VARCHAR (5) NOT NULL,
	ReportedCovidCases			INT NOT NULL,
	CONSTRAINT PK_CovidCases PRIMARY KEY (CalendarDate)
);
GO

/* Definition for the "CovidDeaths" Table */

CREATE TABLE CovidDeaths (
	CalendarDate				DATE NOT NULL,
	JurisdictionID				VARCHAR (5) NOT NULL,
	ReportedCovidCases			INT NOT NULL,
	CONSTRAINT PK_CovidDeaths PRIMARY KEY (CalendarDate)
);
GO

/* Definition for the "Vaccine" Table */

CREATE TABLE Vaccine (
	VaccineID					INT NOT NULL,
	Name						VARCHAR(30) NOT NULL,
	Provider					VARCHAR(50) NOT NULL,
	MinimumAge					INT	NOT NULL,
	CONSTRAINT PK_Vaccine PRIMARY KEY (VaccineID)
);
GO

/* Definition for the "VaccineResearcher" Table */

CREATE TABLE VaccineResearcher (
	ResearcherID				INT IDENTITY(1,1) NOT NULL,
	FirstName					VARCHAR(50) NOT NULL,
	LastName					VARCHAR(50) NOT NULL,
	Title						VARCHAR(50) NOT NULL,
	VaccineID					INT	NOT NULL,
	CONSTRAINT PK_VaccineResearcher PRIMARY KEY (ResearcherID)
);
GO

/* Definition for the "VaccineIngredient" Table */

CREATE TABLE VaccineIngredient (
	VaccineIngredientID			INT IDENTITY(1,1) NOT NULL,
	VaccineID					INT NOT NULL,
	IngredientType				VARCHAR(20) NOT NULL,
	Ingredient					VARCHAR(200) NOT NULL,
	ChildFormulation			BIT NOT NULL, 
	AdultFormulation			BIT NOT NULL,
	CONSTRAINT PK_VaccineIngredient PRIMARY KEY (VaccineIngredientID)
);
GO	

/* Definition for the "VaccineDosage" Table */

CREATE TABLE VaccineDosage (
	VaccineDosageID				INT IDENTITY(1,1) NOT NULL,
	VaccineID					INT NOT NULL,
	SeriesDose					VARCHAR(20) NOT NULL,
	DoseVolume					FLOAT(2) NOT NULL,
	ChildDose					BIT NOT NULL,
	AdultDose					BIT NOT NULL,
	DaysAfterPriorDose			INT,
	CONSTRAINT PK_VaccineDosage PRIMARY KEY (VaccineDosageID)
);
GO

/* Definition for the "VaccineAdministration" Table */

CREATE TABLE VaccineAdministration (
	VaccineAdministrationID		INT IDENTITY(1,1) NOT NULL,	
	AdministrationDate			DATE NOT NULL,
	JurisdictionID				VARCHAR(5) NOT NULL,
	VaccineID					INT NOT NULL,
	ReportedDosesAdministered	INT NOT NULL,
	CONSTRAINT PK_VaccineAdministration PRIMARY KEY (VaccineAdministrationID)
);
GO	

/* Definition for the "VaccineDistribution" Table */

CREATE TABLE VaccineDistribution (
	VaccineDistributionID		INT IDENTITY(1,1) NOT NULL,	
	DistributionDate			DATE NOT NULL,
	JurisdictionID				VARCHAR(5) NOT NULL,
	VaccineID					INT NOT NULL,
	SeriesDose					VARCHAR(20) NOT NULL,	
	DoseAllocation				INT NOT NULL,
	CONSTRAINT PK_VaccineDistribution PRIMARY KEY (VaccineDistributionID)
);
GO	

/* Generation of Database Referential Integrity Constraints */	

ALTER TABLE VaccineResearcher
ADD CONSTRAINT FK_VaccineResearcher_Vaccine
FOREIGN KEY (VaccineID) REFERENCES Vaccine(VaccineID);

ALTER TABLE VaccineAdministration
ADD CONSTRAINT FK_VaccineAdministration_Vaccine
FOREIGN KEY (VaccineID) REFERENCES Vaccine(VaccineID);

ALTER TABLE VaccineAdministration
ADD CONSTRAINT FK_VaccineAdministration_Jurisdiction
FOREIGN KEY (JurisdictionID) REFERENCES Jurisdiction(JurisdictionID);

ALTER TABLE VaccineDistribution
ADD CONSTRAINT FK_VaccineDistribution_Vaccine
FOREIGN KEY (VaccineID) REFERENCES Vaccine(VaccineID);

ALTER TABLE VaccineDistribution
ADD CONSTRAINT FK_VaccineDistribution_Jurisdiction
FOREIGN KEY (JurisdictionID) REFERENCES Jurisdiction(JurisdictionID);

ALTER TABLE VaccineDosage
ADD CONSTRAINT FK_VaccineDosage_Vaccine
FOREIGN KEY (VaccineID) REFERENCES Vaccine(VaccineID);

ALTER TABLE VaccineIngredient
ADD CONSTRAINT FK_VaccineIngredient_Vaccine
FOREIGN KEY (VaccineID) REFERENCES Vaccine(VaccineID);

ALTER TABLE CovidCases
ADD CONSTRAINT FK_CovidCases_Jurisdiction
FOREIGN KEY (JurisdictionID) REFERENCES Jurisdiction(JurisdictionID);

ALTER TABLE CovidDeaths
ADD CONSTRAINT FK_CovidDeaths_Jurisdiction
FOREIGN KEY (JurisdictionID) REFERENCES Jurisdiction(JurisdictionID);