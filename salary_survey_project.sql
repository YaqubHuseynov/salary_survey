CREATE DATABASE salary_survey1;
USE salary_survey1;

SELECT *
FROM survey_data;

-- Identifying duplicate rows in data

WITH duplicate_cte AS (SELECT *, ROW_NUMBER() OVER(PARTITION BY `Timestamp`, Age, Industry, Job_title, Additional_context_job, `Annual_salary?`, additional_monetary_compensation, Currency, Other_currency, Additional_context_income, 
Country, State, City, professional_work_experience_overall, professional_work_experience_field, education_level, Gender, Race) AS num
FROM survey_data)

SELECT *
FROM duplicate_cte
WHERE num > 1
ORDER BY Industry, Job_title;

-- Creating a new table with the specified columns and inserting unique rows from the original table into the new table

CREATE TABLE `survey_data1` (
  `Timestamp` text,
  `Age` text,
  `Industry` text,
  `Job_title` text,
  `Additional_context_job` text,
  `Annual_salary` text,
  `additional_monetary_compensation` text,
  `Currency` text,
  `Other_currency` text,
  `Additional_context_income` text,
  `Country` text,
  `State` text,
  `City` text,
  `professional_work_experience_overall` text,
  `professional_work_experience_field` text,
  `education_level` text,
  `Gender` text,
  `Race` text,
  `Row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO survey_data1
WITH duplicate_cte AS (SELECT *, ROW_NUMBER() OVER(PARTITION BY `Timestamp`, Age, Industry, Job_title, Additional_context_job, `Annual_salary?`, additional_monetary_compensation, Currency, Other_currency, Additional_context_income, 
Country, State, City, professional_work_experience_overall, professional_work_experience_field, education_level, Gender, Race) AS num
FROM survey_data)

SELECT *
FROM duplicate_cte
WHERE num = 1;

ALTER TABLE survey_data1
DROP COLUMN Row_num;

-- Looking for unique values

SELECT *
FROM survey_data1;

SELECT DISTINCT `Timestamp`
FROM survey_data1;

SELECT DISTINCT `Timestamp`
FROM survey_data1
WHERE `Timestamp` LIKE '%2024%';

SELECT DISTINCT Age
FROM survey_data1;

SELECT DISTINCT Industry
FROM survey_data1
ORDER BY Industry;

SELECT DISTINCT Job_title
FROM survey_data1
ORDER BY Job_title;

SELECT DISTINCT Additional_context_job
FROM survey_data1
ORDER BY Additional_context_job;

-- SELECT Annual_salary?
SELECT DISTINCT Annual_salary
FROM survey_data1
ORDER BY Annual_salary;

SELECT DISTINCT additional_monetary_compensation
FROM survey_data1
ORDER BY additional_monetary_compensation;

SELECT DISTINCT Currency
FROM survey_data1
ORDER BY Currency;

SELECT DISTINCT Other_currency
FROM survey_data1
ORDER BY Other_currency;

SELECT DISTINCT Additional_context_income
FROM survey_data1
ORDER BY Additional_context_income;

SELECT DISTINCT Country
FROM survey_data1
ORDER BY Country; 

SELECT DISTINCT State
FROM survey_data1
ORDER BY State;

SELECT DISTINCT City
FROM survey_data1
ORDER BY City; 

SELECT DISTINCT professional_work_experience_overall
FROM survey_data1
ORDER BY professional_work_experience_overall;

SELECT DISTINCT professional_work_experience_field
FROM survey_data1
ORDER BY professional_work_experience_field;

SELECT DISTINCT education_level
FROM survey_data1
ORDER BY education_level;

SELECT DISTINCT Gender
FROM survey_data1
ORDER BY Gender;

SELECT DISTINCT Race
FROM survey_data1
ORDER BY Race;

-- Adding a new column for categorized industry groups and updating the new column with industry categories based on matching patterns

ALTER TABLE survey_data1
ADD COLUMN grouped_industry VARCHAR(75);

UPDATE survey_data1
SET grouped_industry =
    CASE
        WHEN Industry LIKE 'Academia%' THEN 'Academia'
        WHEN Industry LIKE '%research%' THEN 'Research'
        WHEN Industry LIKE '%educational technology%' THEN 'Educational technology'
        WHEN Industry LIKE '%librar%' THEN 'Library'
        WHEN Industry LIKE 'Pharma%' THEN 'Pharmaceuticals'
        WHEN Industry LIKE '%law%' THEN 'Law'
        WHEN Industry LIKE '%admin%' THEN 'Administration'
        WHEN Industry LIKE '%aerospace%' THEN 'Aerospace'
        WHEN Industry LIKE '%agriculture%' THEN 'Agriculture'
        WHEN Industry LIKE 'bio%' AND Industry LIKE '%tech%' THEN 'Biotech'
        WHEN Industry LIKE 'archive%' THEN 'Archives'
        WHEN Industry LIKE 'museum%' THEN 'Museums'
        WHEN Industry LIKE 'edu%' THEN 'Education'
        WHEN Industry LIKE 'techno%' THEN 'Technology'
        WHEN Industry LIKE '%health%' AND Industry LIKE '%care%' THEN 'Healthcare'
        WHEN Industry LIKE 'art%' THEN 'Art'
        WHEN Industry LIKE '%non%' AND Industry LIKE '%profit%' THEN 'Nonprofits'
        WHEN Industry LIKE 'business%' THEN 'Business'
        WHEN Industry LIKE 'media%' THEN 'Media'
        WHEN Industry LIKE 'envir%' THEN 'Environmental'
        WHEN Industry LIKE '%vet%' THEN 'Veterinary'
        WHEN Industry LIKE 'publish%' THEN 'Publishing'
        WHEN Industry LIKE 'retail%' THEN 'Retail'
        WHEN Industry LIKE 'whole%' THEN 'Wholesale'
        WHEN Industry LIKE '%automotive%' THEN 'Automotive'
        WHEN Industry LIKE '%insurance%' THEN 'Insurance'
        WHEN Industry LIKE 'engineer%' THEN 'Engineering'
        WHEN Industry LIKE '%architect%' THEN 'Architect'
        WHEN Industry LIKE '%fashion%' THEN 'Fashion'
        WHEN Industry LIKE '%property%' THEN 'Property'
        WHEN Industry LIKE '%sales%' THEN 'Sales'
        WHEN Industry LIKE '%military%' THEN 'Military'
        WHEN Industry LIKE '%avia%' THEN 'Aviation'
        WHEN Industry LIKE 'science%' THEN 'Science'
        WHEN Industry LIKE '%energy%' THEN 'Energy'
        WHEN Industry LIKE 'real%' THEN 'Real Estate'
        WHEN Industry LIKE '%accou%' THEN 'Accounting'
        WHEN Industry LIKE 'medic%' THEN 'Medical'
        WHEN Industry LIKE '%music%' THEN 'Music'
        WHEN Industry LIKE '%transp%' THEN 'Transportation'
        WHEN Industry LIKE '%stude%' THEN 'Student'
        WHEN Industry LIKE '%contract%' THEN 'Contracting'
        WHEN Industry LIKE '%food%' THEN 'Food'
        WHEN Industry LIKE '%oil%' THEN 'Energy'
        WHEN Industry LIKE '%information t%' THEN 'IT'
        WHEN Industry LIKE '%beauty%' THEN 'Beauty'
        WHEN Industry LIKE '%communic%' THEN 'Communication'
        WHEN Industry LIKE '%estate%' THEN 'Real Estate'
        WHEN Industry LIKE '%market%' THEN 'Marketing'
        WHEN Industry LIKE '%const%' THEN 'Construction'
        WHEN Industry LIKE '%childcare%' THEN 'Childcare'
        WHEN Industry LIKE '%educ%' THEN 'Education'
        WHEN Industry LIKE 'it%' THEN 'IT'
        WHEN Industry LIKE '%trade%' THEN 'Trade Association'
        WHEN Industry LIKE '%travel%' THEN 'Travel'
        WHEN Industry LIKE '%polit%' THEN 'Politics'
        WHEN Industry LIKE '%game%' THEN 'Game'
        WHEN Industry LIKE '%mining%' THEN 'Mining'
        WHEN (Industry LIKE '%chur%' OR Industry LIKE '%relig%') THEN 'Religion'
        WHEN Industry LIKE '%restaurant%' THEN 'Food'
        WHEN Industry LIKE 'space%' THEN 'Aerospace'
        WHEN Industry LIKE '%human res%' THEN 'HR'
        WHEN Industry LIKE '%hr%' THEN 'HR'
        WHEN Industry LIKE '%fitness%' THEN 'Fitness'
        WHEN Industry LIKE 'secur%' THEN 'Security'
        WHEN Industry LIKE '%manuf%' THEN 'Manufacturing'
        WHEN Industry LIKE '%finance%' THEN 'Finance'
        WHEN Industry LIKE '%bever%' THEN 'Food'
        WHEN Industry LIKE '%archa%' THEN 'Archaeology'
        WHEN Industry LIKE '%customer%' THEN 'Customer service'
        WHEN Industry LIKE '%consulting%' THEN 'Consulting'
        WHEN Industry LIKE '%cultur%' THEN 'Culture'
        WHEN Industry LIKE '%publish%' THEN 'Publishing'
        WHEN Industry LIKE '%wine%' THEN 'Food'
        WHEN Industry LIKE '%tour%' THEN 'Tourism'
        WHEN Industry LIKE '%animal%' THEN 'Animal Health'
        WHEN Industry LIKE '%commerce%' THEN 'E-commerce'
        WHEN Industry LIKE '%wareh%' THEN 'Warehouse'
        WHEN Industry LIKE '%waste%' THEN 'Waste Management'
        WHEN Industry LIKE '%ware%' THEN 'Software'
        WHEN Industry LIKE '%comput%' THEN 'Computing'
        WHEN Industry LIKE '%social work%' THEN 'Social Work'
        WHEN Industry LIKE '%event%' THEN 'Events'
        ELSE 'Other'
    END;
    
SELECT DISTINCT grouped_industry 
FROM survey_data1
ORDER BY grouped_industry;

-- Removing leading and trailing spaces from the Additional_context_job column

UPDATE survey_data1
SET Additional_context_job = TRIM(Additional_context_job);

-- Adjusting and cleaning the Annual_salary column, including renaming, removing invalid values, and converting to a proper numeric format

ALTER TABLE survey_data1
CHANGE COLUMN `Annual_salary?` `Annual_salary` TEXT NULL DEFAULT NULL ;

WITH count_cte AS (SELECT *, TRIM(Annual_salary) sal
FROM survey_data1
WHERE CountLetters(TRIM(Annual_salary)) > 0)

UPDATE survey_data1
SET Annual_salary = NULL
WHERE TRIM(Annual_salary) IN (SELECT sal FROM count_cte);

UPDATE survey_data1
SET Annual_salary = NULL
WHERE Annual_salary IN ('0', '000"', '1', '500"');

UPDATE survey_data1
SET Annual_salary = CAST(REPLACE(Annual_salary, ',', '') AS UNSIGNED);

ALTER TABLE survey_data1
MODIFY COLUMN Annual_salary BIGINT;

UPDATE survey_data1
SET Annual_salary = 65000
WHERE Annual_salary = '6000070000';

-- Cleaning, removing invalid values, and converting the additional_monetary_compensation column to a numeric format

UPDATE survey_data1
SET additional_monetary_compensation = TRIM(additional_monetary_compensation);

UPDATE survey_data1
SET additional_monetary_compensation = NULL
WHERE CountLetters(additional_monetary_compensation) > 0;

UPDATE survey_data1
SET additional_monetary_compensation = NULL
WHERE additional_monetary_compensation IN ('', 0);

UPDATE survey_data1
SET additional_monetary_compensation = CAST(REPLACE(additional_monetary_compensation, ',', '') AS UNSIGNED);

ALTER TABLE survey_data1
MODIFY COLUMN additional_monetary_compensation BIGINT;

-- Standardizing and cleaning Currency and Other_currency columns by setting specific values and converting various representations to standardized currency codes

UPDATE survey_data1
SET Currency = 'Other'
WHERE Currency IN ('', ' admin stuff', ' but don''t have a MLIS"', ' create test plans', ' like me', ' testing', '0', '125,000', '18500', '300', '400', '56,000', '7500');

UPDATE survey_data1
SET Other_currency = ''
WHERE Currency != 'Other'; 

UPDATE survey_data1
SET Other_currency = 'N/A'
WHERE Other_currency IN ('Equity', ' and pick up whatever balls are getting dropped everywhere else."', ' and run some smaller QA projects outright"', ' are in product or support; I write support content (that you''d find in a company''s Help Center) for an enterprise software company."',
' event planning', '-', '0', '1', '25000', '29,250', 'Occasionally (once a year or so) I qualify for a $100 bonus given out once a quarter to great employees. I also tend to accumulate a decent amount of overtime because I can?? always leave the sales floor the minute my shift ends');

UPDATE survey_data1
SET Currency = 
	CASE
		WHEN Other_currency IN ('AUD/NZD', 'AUD', 'AUD Australian ', 'Australian Dollars ', 'NZD') THEN 'AUD/NZD'
        WHEN Other_currency = 'CAD' THEN 'CAD'
        WHEN Other_currency = 'CHF' THEN 'CHF'
        WHEN Other_currency IN ('EUR', 'Euro') THEN 'EUR'
        WHEN Other_currency = 'GBP' THEN 'GBP'
        WHEN Other_currency = 'HKD' THEN 'HKD'
        WHEN Other_currency = 'JPY' THEN 'JPY'
        WHEN Other_currency = 'SEK' THEN 'SEK'
        WHEN Other_currency IN ('USD', 'American Dollars', 'US Dollar') Then 'USD'
        WHEN Other_currency = 'ZAR' THEN 'ZAR'
        ELSE Currency
	END;

UPDATE survey_data1
SET Other_currency = 
	CASE
		WHEN Other_currency IN ('Argentine Peso', 'Argentinian peso (ARS)', 'ARS', 'Peso Argentino') THEN 'ARS'
        WHEN Other_currency = 'Bdt' THEN 'BDT'
        WHEN Other_currency IN ('BR$', 'BRL', 'BRL (R$)') THEN 'BRL'
        WHEN Other_currency IN ('China RMB', 'CNY', 'RM', 'RMB (chinese yuan)') THEN 'CNY'
        WHEN Other_currency = 'croatian kuna' THEN 'HRK'
        WHEN Other_currency IN ('czech crowns', 'CZK') THEN 'CZK'
        WHEN Other_currency IN ('Danish Kroner', 'Dkk', 'DKK ') THEN 'DKK'
        WHEN Other_currency IN ('IDR', 'IDR ') THEN 'IDR'
        WHEN Other_currency IN ('ILS', 'ILS (Shekel)', 'ILS/NIS', 'Israeli Shekels', 'NIS (new Israeli shekel)') THEN 'ILS/NIS'
        WHEN Other_currency IN ('Indian rupees', 'INR', 'INR (Indian Rupee)', 'Rupees') THEN 'INR'
        WHEN Other_currency IN ('Korean Won ', 'KRW', 'KRW (Korean Won)') THEN 'KRW'
        WHEN Other_currency IN ('Mexican pesos', 'MXN') THEN 'MXN'
        WHEN Other_currency IN ('NOK', 'Norwegian kroner (NOK)') THEN 'NOK'
        WHEN Other_currency IN ('Philippine Peso', 'Philippine peso (PHP)', 'Philippine Pesos', 'Php', 'PhP (Philippine Peso)') THEN 'PHP'
        WHEN Other_currency IN ('PLN', 'PLN (Polish zloty)', 'PLN (Zwoty)', 'Polish Z?oty') THEN 'PLN'
        WHEN Other_currency IN ('SGD', 'SGD ', 'Singapore Dollara') THEN 'SGD'
        WHEN Other_currency = 'Taiwanese dollars' THEN 'TWD'
        WHEN Other_currency IN ('THAI  BAHT', 'Thai Baht ', 'THB') THEN 'THB'
        ELSE Other_currency
	END;
    
-- Removing leading and trailing spaces from Additional_context_income
    
UPDATE survey_data1
SET Additional_context_income = TRIM(Additional_context_income);

-- Cleaning and standardizing the Country column by setting specific values and trimming excess spaces

UPDATE survey_data1
SET Country = ''
WHERE Country IN (' a public US government document. However', ' and', ' and fluctuates a lot. This is a successful company I joined slightly pre-IPO."', ' and it almost never happens. While we are entitled to overtime', 
' and some months i don''t work at all', ' as well as a holiday bonus."', ' but for all intents and purposes', ' but I can fund up to 12 months on external grant dollars."', ' but I make sure to record any time that I spend on this outside of my regular hours."', 
' but I''m unsure of what it is."', ' but it varies quite a bit and I can never really count on timeline. On average probably about $25k per year"', ' but it''s never happened before and I''m not sure it''ll happen again."', 
' but that is the standard full-time librarian contract at my university"', ' but the overtime rate doesn''t kick in until 48 hrs/wk"', ' but they are basically guaranteed (to get one', 
' but this year''s may be different."', ' even though it is 10 months wages', ' follow up calls', ' fully remote"', ' I am not sure how to translate that into English (and do not know anything comparable in US or UK culture)', 
' I guessed an average."', ' I''m afraid. "', ' in that I run a major coalition/program that is housed at our non-profit', ' it makes up over half my pay. "', ' not 40', 
' or at least that''s what I''m paid for and we no longer qualify for overtime. That was slashed during COVID. "', ' practically it all goes in to the pension as they''re not pension matching."', 
' so value can vary significantly."', ' so will have a real-salary decrease', ' things related to mental health like fidget toys or ""happy"" lights) also have stocks but i can not touch them until ive been employed a year', 
' which is difficult or impossible to sell today but will probably be worth more by the time it''s possible to sell it. (Or it could go to zero - always a possibility.)"', 
' which means that our contract year has three months ""off"" - which is when we have to do most of our research."', '???? ', '$2,175.84/year is deducted for benefits', '000 for someone at my level)"',
'1000', '12700', 'Additional compensation in form of RSUs', 'Also stock options, but I''m treating that as fake money for now', 'bonus based on meeting yearly goals set w/ my supervisor', 
'I earn commission on sales. If I meet quota, I''m guaranteed another 16k min. Last year i earned an additional 27k. It''s not uncommon for people in my space to earn 100k+ after commission. ', 
'I was brought in on this salary to help with the EHR and very quickly was promoted to current position but compensation was not altered. ', 'No benefits included since I''m paid as a consultant', 
'Rec''d one bonus this yr., divided by yrs. at job. Part-time @ $25/hr.', 'that''s 4000 before taxes, so it''s actually a good bit less than that', 'We don''t get raises, we get quarterly bonuses, but they periodically asses income in the area you work, so I got a raise because a 3rd party assessment showed I was paid too little for the area we were located',
'Contracts', 'Currently finance', 'ff', 'dbfemf', 'europe', 'Global', 'LOUTRELAND', 'na', 'n/a (remote from wherever I want)', 'Y', 'Remote', 'Policy', 'International', 'ss');

UPDATE survey_data1
SET Country = TRIM(Country);

UPDATE survey_data1
SET Country = 
	CASE
		WHEN Country LIKE 'U. S%' OR Country LIKE 'us%' OR Country LIKE 'u.s%' OR Country LIKE '%state%' OR Country LIKE '%united s%' OR Country LIKE '% us' OR Country IN (' U.S.', 'America', 'California', 'Hartford', 'I.S.', 'ISA', 'IS', 'I work for a UAE-based organization, though I am personally in the US.', 'Montana', 'New Jersey', 'New York', 'U.A.', 'UA', 'Worldwide (based in US but short term trips aroudn the world)', 'Virginia', 'United y') THEN 'US'
        WHEN Country LIKE 'can%' OR Country = 'Csnada' THEN 'Canada'
        WHEN Country != 'Ukraine ' AND (Country LIKE '%u.k%' OR Country LIKE '%brita%' OR Country LIKE '%eng%' OR Country LIKE '%king%' OR Country LIKE '%uk%' OR Country IN ('Bermuda', 'Cayman Islands', 'Isle of Man', 'London')) THEN 'UK'
        WHEN Country LIKE '%zeal%' OR Country LIKE 'nz%' THEN 'New Zealand'
        WHEN Country LIKE '%jap%' THEN 'Japan'
        WHEN Country LIKE '%tral%' THEN 'Australia'
        WHEN Country LIKE '%bra%' THEN 'Brazil'
        WHEN Country LIKE '%cze%' THEN 'Czechia'
        WHEN Country LIKE '%hong%' THEN 'Hong Kong'
        WHEN Country LIKE '%germ%' THEN 'Germany'
        WHEN Country LIKE '%net%' OR Country IN ('Nederland', 'NL') THEN 'Netherlands'
        WHEN Country LIKE 'fin%' THEN 'Finland'
        WHEN Country LIKE '%swe%' THEN 'Sweden'
        WHEN Country LIKE '%swi%' THEN 'Switzerland'
        WHEN Country LIKE 'ire%' THEN 'Ireland'
        WHEN Country LIKE '%arg%' THEN 'Argentina'
        WHEN Country LIKE '%ban%' THEN 'Bangladesh'
        WHEN Country LIKE '%bel%' THEN 'Belgium'
        WHEN Country LIKE '%mark%' THEN 'Denmark'
        WHEN Country IN ('ibdia', 'INDIA') THEN 'India'
        WHEN Country LIKE '%ita%' THEN 'Italy'
        WHEN Country LIKE '%xico%' THEN 'Mexico'
        WHEN Country LIKE '%lux%' THEN 'Luxembourg'
        WHEN Country LIKE '%chin%' THEN 'China'
        WHEN Country LIKE '%stria%' THEN 'Austria'
        WHEN Country LIKE '%roma%' THEN 'Romania'
        WHEN Country LIKE '%phi%' THEN 'Philippines'
        WHEN Country = 'Panam?' THEN 'Panama'
        ELSE Country
	END;
    
-- Setting State to empty for non-state values and specific entries

UPDATE survey_data1
SET State = ''
WHERE State IN (' and then they vest over 3 years."', ' as well as serve in the director role for the organization"', ' but sometimes directors will give key people (including actors) gifts as a thank you', 
' but the 40 hour comp is the same."', ' I am hourly. "', ' in a pinch', ' living overseas', ' marketing', ' not nec. the amount) barring some sort of extreme fiscal emergency within the company."', 
' so i really make about $14', ' so the base income is halved', ' we never get it-- we get flex time instead. "', ' which I am paid over 12 chunks. This is the total I am paid',
'U.K', 'U.S.', 'UK', 'United States', 'US', 'USA', 'USD');

-- Cleaning and standardizing city names by removing non-city values and correcting misspellings

UPDATE survey_data1
SET City = TRIM(City);

UPDATE survey_data1
SET City = ''
WHERE City IN (NULL, '-', '--', '---', '-----', '.', '..', '(Anonymous)', '**Too small a sample size, can''t share', '0', '/', '000 a year on average."', 
 '12043', '46901', '11 - 20 years', '21 - 30 years', '8 - 10 years', 'A city in the UK', 'A city small enough to not answer this question', '??arge??Canadian prairie city.',
 '(Rural)', 'Africa', 'I don?? live in a city; I am VERY rural', 'Normal I??l', 'Don?? want to answer', 'N/A', 'No', 'none', 'na', 'GTA', 'xxx', 'G', 'City', 'Many', 'O', 'NOPE'
 'Xx', 'Free', 'Skip', 'cody', 'N\A', 'Xxxx', 's', 'ff', 'test', 'Remote--don''t work in same state as my employer is located', 'Remote', 'Remote Worker', 'Small city, remote, national company'
 'I work remotely', 'Remote/ home', 'Rural area, remote worker', 'NA (remote)', 'Remote work', 'I work remotely from a different location.', 'Remote Office', 'Remotely', 'Remote many cities'
 'Fully Remote', 'Not Applicable (Remote work)', 'Remote -', 'n/a (remote from wherever I want)', 'N/A - remote work', 'Remote Based', 'N/A-Remote', 'N/A - Remote', 'IT support. "', 'I get additional pay for things like ""hardship',
 'as well as to increase chances of working together in the future. "');

UPDATE survey_data1
SET City = 
	CASE
		WHEN City = '?rhus' THEN 'Arhus'
        WHEN City = '?stanbul' THEN 'Istanbul'
        WHEN City = 'D?sseldorf' THEN 'Düsseldorf'
        WHEN City = 'G?ttingen' THEN 'Göttingen'
        WHEN City = 'Orl?ans' THEN 'Orléans'
        WHEN City = 'N?rnberg' THEN 'Nürnberg'
        WHEN City = 'V?ster?s' THEN 'Västerås'
        WHEN City = 'St. John??' THEN "St John's"
        WHEN City = 'Montr?al' THEN 'Montreal'
        WHEN City = 'M?laga' THEN 'Málaga'
        WHEN City = 'H?ttigweiler' THEN 'Hüttigweiler'
        WHEN City = 'A Coru?a' THEN 'A Coruña'
        WHEN City = 'Z?rich' THEN 'Zürich'
        WHEN City = 'Malm?' THEN 'Malmö'
        WHEN City = 'M?nster' THEN 'Münster'
        WHEN City = 'Krak?w' THEN 'Kraków'
		WHEN City = 'Mayag?ez' THEN 'Mayagüez'
		WHEN City = 'S?o Paulo' THEN 'São Paulo'
		WHEN City = 'St John??' THEN "St John's"
		WHEN City = 'Ciudad de Panam?' THEN 'Ciudad de Panamá'
	    WHEN City = 'F?rth' THEN 'Fürth'
		WHEN City = 'San Nicol?s de los Arroyos' THEN 'San Nicolás de los Arroyos'
        WHEN City = 'Oaxaca de Juarez (home). Company I work for is based in Los ?ngeles' THEN 'Oaxaca de Juarez (home). Company I work for is based in Los Angeles'
        WHEN City = 'K?ln' THEN 'Köln'
        WHEN City = 'W?rzburg' THEN 'Würzburg'
        WHEN City = 'Saarbr?cken' THEN '"Saarbrücken'
        WHEN City = 'Baden-W?rttemberg' THEN 'Baden-Württemberg'
        WHEN City = 'Coeur d??lene' THEN "Coeur d'Alene"
        WHEN City = 'Bah?a Blanca, Buenos Aires, province Argentina' THEN 'Bahía Blanca'
        WHEN City = 'Qu?bec' THEN 'Québec'
        WHEN City = 'Espa?ola' THEN 'Española'
        WHEN City = 'Pozna?' THEN 'Poznań'
        WHEN City = 'Gda?sk' THEN 'Gdańsk'
        WHEN City = 'Bogot?' THEN 'Bogotá'
        ELSE City 
	END;
    
-- Defining a function to count the number of alphabetic characters in a text

DELIMITER $$

CREATE FUNCTION CountLetters(input_text TEXT) RETURNS INT
DETERMINISTIC 
NO SQL
BEGIN
    DECLARE letter_count INT DEFAULT 0;
    DECLARE i INT DEFAULT 1;
    DECLARE char_at CHAR(1);

    WHILE i <= LENGTH(input_text) DO
        SET char_at = SUBSTRING(input_text, i, 1);
        
        IF char_at REGEXP '[a-zA-Z]' THEN
            SET letter_count = letter_count + 1;
        END IF;
        
        SET i = i + 1;
    END WHILE;

    RETURN letter_count;
END $$

DELIMITER ;

SELECT DISTINCT(City)
FROM survey_data1
WHERE CountLetters(City) > 70;

-- Trimming and standardize the 'professional_work_experience_overall' column values

UPDATE survey_data1
SET professional_work_experience_overall = TRIM(professional_work_experience_overall);

UPDATE survey_data1
SET professional_work_experience_overall = ''
WHERE professional_work_experience_overall NOT IN ('1 year or less', '11 - 20 years', '2 - 4 years', '21 - 30 years', '31 - 40 years', '41 years or more', '5-7 years', '8 - 10 years'
);

-- Trimming and standardizing 'professional_work_experience_field' column values

UPDATE survey_data1
SET professional_work_experience_field = TRIM(professional_work_experience_field);

UPDATE survey_data1
SET professional_work_experience_field = ''
WHERE professional_work_experience_field NOT IN ('1 year or less', '11 - 20 years', '2 - 4 years', '21 - 30 years', '31 - 40 years', '41 years or more', '5-7 years', 
'8 - 10 years');

-- Standardizing 'education_level' column by clearing values not in the defined list

SELECT education_level, COUNT(*) num
FROM survey_data1
GROUP BY education_level
ORDER BY num DESC;

UPDATE survey_data1
SET education_level = ''
WHERE education_level NOT IN ('College degree', 'Master''s degree', 'Some college', 'PhD', 'Professional degree (MD, JD, etc.)', 'High School');

-- Standardizing 'Gender' values and set undefined or ambiguous values to empty

SELECT Gender, COUNT(*) num
FROM survey_data1
GROUP BY Gender
ORDER BY num DESC;

UPDATE survey_data1
SET Gender = 'Other or prefer not to answer'
WHERE Gender IN ('Prefer not to answer', 'Prefer not to say');

UPDATE survey_data1
SET Gender = ''
WHERE Gender NOT IN ('Woman', 'Man', 'Non-binary', 'Other or prefer not to answer');

SELECT Race, COUNT(*) num
FROM survey_data1
GROUP BY Race
ORDER BY num DESC;

-- Cleaning 'Race' column by removing irrelevant values and standardizing 'Other or prefer not to answer'

UPDATE survey_data1
SET Race = ''
WHERE Race IN ('Woman', '8 - 10 years', 'Master''s degree', 'Man', 'College degree', 'Non-binary', '2 - 4 years', '5-7 years', 'Rockport', 'I''m contracted for 195 days'
);

UPDATE survey_data1
SET Race = 'Another option not listed here or prefer not to answer'
WHERE Race = 'Other or prefer not to answer';

-- Survey questions

SELECT *
FROM survey_data1;

SELECT Age, COUNT(*) num
FROM survey_data1
GROUP BY Age
ORDER BY num DESC;

SELECT grouped_industry, COUNT(*) num
FROM survey_data1
GROUP BY grouped_industry
ORDER BY num DESC;

SELECT currency, COUNT(*) num
FROM survey_data1
GROUP BY currency
ORDER BY num DESC;

SELECT Other_currency, COUNT(*) num
FROM survey_data1
GROUP BY Other_currency
ORDER BY num DESC;

SELECT Country, COUNT(*) num
FROM survey_data1
GROUP BY Country
ORDER BY num DESC;

SELECT professional_work_experience_overall, COUNT(*) num
FROM survey_data1
GROUP BY professional_work_experience_overall
ORDER BY num DESC;

SELECT professional_work_experience_field, COUNT(*) num
FROM survey_data1
GROUP BY professional_work_experience_field
ORDER BY num DESC;

SELECT education_level, COUNT(*) num
FROM survey_data1
GROUP BY education_level
ORDER BY num DESC;

SELECT Gender, COUNT(*) num
FROM survey_data1
GROUP BY Gender
ORDER BY num DESC;

SELECT Race, COUNT(*) num
FROM survey_data1
GROUP BY Race
ORDER BY num DESC;
