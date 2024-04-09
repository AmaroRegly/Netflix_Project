
-- Selecione os clientes que assinam o plano Basic da Netflix a pelo menos 5 anos.

SELECT 
	user_id,
	country,
	subscription_type,
	EXTRACT(YEAR FROM join_date) as Year1,
	EXTRACT(YEAR FROM last_payment) as Year2,
    EXTRACT(YEAR FROM last_payment) - EXTRACT(YEAR FROM join_date) AS Diff
FROM
	netflix_db
WHERE
	subscription_type = 'Basic' AND (EXTRACT(YEAR FROM last_payment) - EXTRACT(YEAR FROM join_date)) > 5
ORDER BY
	Diff desc;

-- Separe os clientes homens acima de 20 anos que assinaram a Netflix nos Estados Unidos.

SELECT
	user_id,
    Country,
    Gender,
	Age
FROM
	netflix_db
WHERE
	country = "United States" AND Gender = "Male" AND Age > 30
ORDER BY
	3 desc;

-- Quantas assinaturas a Netflix teve por device em 2022?

SELECT
	EXTRACT(YEAR FROM join_date) AS Year_join,
    COUNT(join_date) AS Qtd_join,
    device
FROM
	netflix_db
WHERE
	EXTRACT(YEAR FROM join_date) = 2022
GROUP BY
	device,
    EXTRACT(YEAR FROM join_date);

-- Qual a média de idade dos homens mexicanos que assinaram o plano Standard da Netflix entre 2020 e 2022?

SELECT
    Country,
    avg(age) AS idade
FROM
	netflix_db
WHERE
	EXTRACT(YEAR FROM join_date) BETWEEN 2020 AND 2022 AND
    gender = 'Male' AND
    subscription_type = 'Standard' AND
    country = 'Mexico'
ORDER BY
	idade desc;

-- Classifique como "lucrativo" ou "não lucrativo" quando os números de assinaturas da Netflix forem acima de 70 por ano durante todo período.

SELECT
	EXTRACT(YEAR FROM join_date) AS Year1,
    COUNT(join_date) AS no_join,
	CASE
		WHEN COUNT(join_date) > 70 THEN 'Profit'
        WHEN COUNT(join_date) < 70 THEN 'NoProfit'
	End AS Status
FROM
	netflix_db
GROUP BY
	EXTRACT(YEAR FROM join_date)
ORDER BY
	Year1;

-- Qual o país que mais vendeu assinaturas da Netflix?

SELECT
	country,
    count(*) AS Qtd_join
FROM
	netflix_db
GROUP BY
	Country
ORDER BY
	Qtd_join desc;

-- Durante o período de 2020 e 2022 quem assinou mais planos da Netflix, homens ou mulheres?

SELECT
	COUNT(*),
    gender
FROM
	netflix_db
WHERE
	EXTRACT(Year FROM join_date) BETWEEN '2020' AND '2022'
GROUP BY
	gender;

-- Durante o período de 2020 a 2022, qual o total de assinaturas juntando homens e mulheres?

WITH sum_join AS (
	SELECT
		COUNT(*) AS Qtd_join,
        gender
	FROM
		netflix_db
	WHERE
		EXTRACT(Year FROM join_date) BETWEEN '2020' AND '2022'
	GROUP BY
		gender
)
SELECT
	SUM(Qtd_join) AS Total_join
FROM
	sum_join;

-- Entre  2017 e 2020, qual foi a quantidade de assinaturas da Netflix em cada plano?

SELECT
	subscription_type,
    COUNT(*)
FROM
	netflix_db
WHERE
	EXTRACT(Year FROM join_date) BETWEEN '2017' AND '2020'
GROUP BY
	subscription_type;


-- Qual a média de idade por país de quem assinou a Netflix em 2018?

SELECT
	country,
    ROUND(AVG(age), 0) AS Avg_Age
FROM
	netflix_db
WHERE
	EXTRACT(Year FROM join_date) = '2018'
GROUP BY
	Country;