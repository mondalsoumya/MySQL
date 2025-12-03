USE world;
SHOW TABLES;
DESCRIBE country;
DESCRIBE city;
DESCRIBE countrylanguage;

SELECT DISTINCT IsOfficial FROM countrylanguage;


#Aggregation in SQL Assignment

#Question 1 : Count how many cities are there in each country?

SELECT co.Name AS country,
       COUNT(ci.ID) AS city_count
FROM country co
LEFT JOIN city ci ON co.Code = ci.CountryCode
GROUP BY co.Name
ORDER BY city_count DESC;

#Question 2 : Display all continents having more than 30 countries.

SELECT Continent,
       COUNT(*) AS country_count
FROM country
GROUP BY Continent
HAVING COUNT(*) > 30;

#Question 3 : List regions whose total population exceeds 200 million.

SELECT Region,
       SUM(Population) AS total_population
FROM country
GROUP BY Region
HAVING SUM(Population) > 200000000
ORDER BY total_population DESC;

#Question 4 : Find the top 5 continents by average GNP per country

SELECT Continent,
       AVG(CAST(GNP AS DECIMAL(18,2))) AS avg_gnp
FROM country
WHERE GNP IS NOT NULL
GROUP BY Continent
ORDER BY avg_gnp DESC
LIMIT 5;

#Question 5 : Find the total number of official languages spoken in each continent.

SELECT c.Continent,
       COUNT(DISTINCT cl.Language) AS official_language_count
FROM country c
JOIN countrylanguage cl ON c.Code = cl.CountryCode
-- adjust depending on actual values from DESCRIBE; this covers common variants:
WHERE cl.IsOfficial IN ('T','t','Y','y','Yes','YES','1','TRUE','true')
GROUP BY c.Continent
ORDER BY official_language_count DESC;

#Question 6 : Find the maximum and minimum GNP for each continent.

SELECT Continent,
       MAX(GNP) AS max_gnp,
       MIN(GNP) AS min_gnp
FROM country
GROUP BY Continent;

#Question 7 : Find the country with the highest average city population.

SELECT c.Name AS country,
       AVG(ci.Population) AS avg_city_population
FROM country c
JOIN city ci ON c.Code = ci.CountryCode
GROUP BY c.Code, c.Name
HAVING COUNT(ci.ID) > 0
ORDER BY avg_city_population DESC
LIMIT 1;

#Question 8 : List continents where the average city population is greater than 200,000.

SELECT c.Continent,
       AVG(ci.Population) AS avg_city_population
FROM country c
JOIN city ci ON c.Code = ci.CountryCode
GROUP BY c.Continent
HAVING AVG(ci.Population) > 200000;

#Question 9 : Find the total population and average life expectancy for each continent, ordered by average life expectancy descending.

SELECT Continent,
       SUM(Population) AS total_population,
       AVG(LifeExpectancy) AS avg_life_expectancy
FROM country
GROUP BY Continent
ORDER BY avg_life_expectancy DESC;

#Question 10 : Find the top 3 continents with the highest average life expectancy, but only include those where total population is over 200 million.

SELECT Continent,
       SUM(Population) AS total_population,
       AVG(LifeExpectancy) AS avg_life_expectancy
FROM country
GROUP BY Continent
HAVING SUM(Population) > 200000000
ORDER BY avg_life_expectancy DESC
LIMIT 3;
