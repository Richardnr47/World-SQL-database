# query to choose database.
USE world;

# query for answering question: How many inhabitants are there in Stockholm?
SELECT 
    Name, Population
FROM
    city
WHERE
    Name = 'Stockholm';

# query for answering the question: How many countries are there with "stan" in the country-name?
SELECT 
    COUNT(Name) AS Count
FROM
    country
WHERE
    Name LIKE '%stan%';


# query for answering the question: Which different government forms are there and how many times have they occured?
SELECT 
    GovernmentForm AS Government_form, COUNT(GovernmentForm) AS Count
FROM
    country
GROUP BY 
	GovernmentForm
ORDER BY 
	COUNT(GovernmentForm) DESC;


# query for answering the question: Which 10 cities have the highest population and in which country are these located?
SELECT
	city.Name as City, city.Population, country.Name as Country
FROM
	city
INNER JOIN
	country ON city.CountryCode=country.Code
ORDER BY
	Population DESC
LIMIT
	10;

# Question to answer:
# Select the continents that have got the letter 'S' in its name and is having more than two companies on the top 10 of the worlds largest companies.

# Creating a new table top_companies with its columns.
CREATE TABLE IF NOT EXISTS top_companies(
    Company VARCHAR(50),
	CountryCode CHAR(3),
    Revenue DECIMAL(10, 1),
    StockExchange VARCHAR(50),
    PRIMARY KEY(Company),
    FOREIGN KEY(CountryCode) 
		REFERENCES country(Code)
);


# Creating company data in table top_companies.
INSERT INTO top_companies (Company, CountryCode, Revenue, StockExchange)
	VALUES('Walmart Inc', 'USA', 542.0, 'New York Stock Exchange'),
	('China Petroleum & Chemical Corp.','CHN', 355.8, 'New York Stock Exchange'),
    ('Amazon Inc', 'USA', 321.8, 'NASDAQ'),
    ('PetroChina Co', 'CHN', 320.0, 'New York Stock Exchange'),
    ('Apple', 'USA', 273.9, 'NASDAQ'),
    ('CVS Health Corp.', 'USA', 264.0, 'New York Stock Exchange'),
    ('Royal Dutch Shell', 'NLD', 263.1, 'New York Stock Exchange'),
    ('Berkshire Hathaway', 'USA', 260.5, 'New York Stock Exchange'),
    ('Toyota Motor', 'JPN', 248.6, 'New York Stock Exchange'),
    ('Volkswagen', 'DEU', 247.4, 'OTC');
    

/*JOIN-function that creates a tavle qith column 'Continent' from country-table and number of companies from top_companies table.
Aggregate-function, counts number of companies in each continent. */
SELECT
	c.Continent, COUNT(c.Continent) AS Count_Companies
FROM
	top_companies AS tp
JOIN country AS c
	ON tp.CountryCode = c.Code

# Wildcard, sorting all continents that have the letter 'S' in its name.
	 c.Continent LIKE '%S%'
GROUP BY 
	c.Continent    
# Comparison operator, sorting all continents that is having more than two companies in the list.
HAVING
	COUNT(c.Continent) > 2
# Sorting number of companies in descending order if there would be several companies in the list.
ORDER BY 
	COUNT(c.Continent) DESC;
