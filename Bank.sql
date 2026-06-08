CREATE DATABASE Bank;

USE Bank;

SELECT TOP 10 *
FROM cards;

SELECT TOP 10 *
FROM users;

SELECT TOP 10 *
FROM transactions;

SELECT TOP 10 *
FROM mcc_codes;

DROP TABLE card;

-- NULL VALUES CHECKING
SELECT
	SUM(CASE WHEN card_id IS NULL THEN 1 ELSE 0 END) AS null_id,
	SUM(CASE WHEN client_id IS NULL THEN 1 ELSE 0 END) AS null_client_id,
	SUM(CASE WHEN card_brand IS NULL THEN 1 ELSE 0 END) AS null_card_brand,
	SUM(CASE WHEN card_type IS NULL THEN 1 ELSE 0 END) AS null_card_type,
	SUM(CASE WHEN card_number IS NULL THEN 1 ELSE 0 END) AS null_card_number,
	SUM(CASE WHEN expires IS NULL THEN 1 ELSE 0 END) AS null_expires,
	SUM(CASE WHEN cvv IS NULL THEN 1 ELSE 0 END) AS null_cvv,
	SUM(CASE WHEN has_chip IS NULL THEN 1 ELSE 0 END) AS null_has_chip,
	SUM(CASE WHEN num_cards_issued IS NULL THEN 1 ELSE 0 END) AS null_num_cards_issued,
	SUM(CASE WHEN credit_limit IS NULL THEN 1 ELSE 0 END) AS null_credit_limit,
	SUM(CASE WHEN acct_open_date IS NULL THEN 1 ELSE 0 END) AS null_acct_open_dt,
	SUM(CASE WHEN year_pin_last_changed IS NULL THEN 1 ELSE 0 END) AS null_pi_last_changed,
	SUM(CASE WHEN card_on_dark_web IS NULL THEN 1 ELSE 0 END) AS null_card_on_dark_web
FROM cards;

SELECT
	SUM(CASE WHEN client_id IS NULL THEN 1 ELSE 0 END) AS null_id,
	SUM(CASE WHEN current_age IS NULL THEN 1 ELSE 0 END) AS null_client_id,
	SUM(CASE WHEN retirement_age IS NULL THEN 1 ELSE 0 END) AS null_card_brand,
	SUM(CASE WHEN birth_year IS NULL THEN 1 ELSE 0 END) AS null_card_type,
	SUM(CASE WHEN birth_month IS NULL THEN 1 ELSE 0 END) AS null_card_number,
	SUM(CASE WHEN gender IS NULL THEN 1 ELSE 0 END) AS null_expires,
	SUM(CASE WHEN address IS NULL THEN 1 ELSE 0 END) AS null_cvv,
	SUM(CASE WHEN latitude IS NULL THEN 1 ELSE 0 END) AS null_has_chip,
	SUM(CASE WHEN longitude IS NULL THEN 1 ELSE 0 END) AS null_num_cards_issued,
	SUM(CASE WHEN per_capita_income IS NULL THEN 1 ELSE 0 END) AS null_credit_limit,
	SUM(CASE WHEN yearly_income IS NULL THEN 1 ELSE 0 END) AS null_acct_open_dt,
	SUM(CASE WHEN total_debt IS NULL THEN 1 ELSE 0 END) AS null_pi_last_changed,
	SUM(CASE WHEN credit_score IS NULL THEN 1 ELSE 0 END) AS null_card_on_dark_web,
	SUM(CASE WHEN num_credit_cards IS NULL THEN 1 ELSE 0 END) AS null_num_credit_cards
FROM users;

SELECT
	SUM(CASE WHEN trasaction_id IS NULL THEN 1 ELSE 0 END) AS null_id,
	SUM(CASE WHEN client_id IS NULL THEN 1 ELSE 0 END) AS null_client_id,
	SUM(CASE WHEN card_id IS NULL THEN 1 ELSE 0 END) AS null_card_id,
	SUM(CASE WHEN amount IS NULL THEN 1 ELSE 0 END) AS null_amount,
	SUM(CASE WHEN use_chip IS NULL THEN 1 ELSE 0 END) AS null_use_chip,
	SUM(CASE WHEN merchant_id IS NULL THEN 1 ELSE 0 END) AS null_merchant_id,
	SUM(CASE WHEN merchant_city IS NULL THEN 1 ELSE 0 END) AS null_merchant_city,
	SUM(CASE WHEN merchant_state IS NULL THEN 1 ELSE 0 END) AS null_merchant_state,
	SUM(CASE WHEN zip IS NULL THEN 1 ELSE 0 END) AS null_zip,
	SUM(CASE WHEN mcc IS NULL THEN 1 ELSE 0 END) AS null_mcc,
	SUM(CASE WHEN errors IS NULL THEN 1 ELSE 0 END) AS null_errors,
	SUM(CASE WHEN date IS NULL THEN 1 ELSE 0 END) AS null_date
FROM transactions;

SELECT
	SUM(CASE WHEN mcc_code IS NULL THEN 1 ELSE 0 END) AS null_mcc_code,
	SUM(CASE WHEN merchant_category IS NULL THEN 1 ELSE 0 END) AS null_merchant_category
FROM mcc_codes;

-- Duplicate Checking
SELECT client_id,COUNT(*) AS cnt
FROM users
GROUP BY client_id
HAVING COUNT(*) > 1;

SELECT card_id,COUNT(*) AS cnt
FROM cards
GROUP BY card_id
HAVING COUNT(*) > 1;

SELECT trasaction_id,COUNT(*) AS cnt
FROM transactions
GROUP BY trasaction_id
HAVING COUNT(*) > 1;

SELECT mcc_code,COUNT(*) AS cnt
FROM mcc_codes
GROUP BY mcc_code
HAVING COUNT(*) > 1;

SELECT DISTINCT c.client_id
FROM cards AS c
LEFT JOIN users AS u
ON c.client_id = u.client_id
WHERE u.client_id IS NULL;

SELECT DISTINCT t.client_id
FROM transactions AS t
LEFT JOIN users AS u
ON t.client_id = u.client_id
WHERE u.client_id IS NULL;

SELECT DISTINCT t.card_id
FROM transactions AS t
LEFT JOIN cards AS c
ON t.card_id = c.card_id
WHERE c.card_id IS NULL;

SELECT DISTINCT t.mcc
FROM transactions AS t
LEFT JOIN mcc_codes AS m
ON t.mcc = m.mcc_code
WHERE m.mcc_code IS NULL;

ALTER TABLE users
ADD CONSTRAINT pk_users
PRIMARY KEY(client_id);

select * from transactions;
ALTER TABLE cards
ADD CONSTRAINT pk_card
PRIMARY KEY(card_id);

ALTER TABLE transactions
ADD CONSTRAINT pk_transactions
PRIMARY KEY(trasaction_id);

ALTER TABLE mcc_codes
ADD CONSTRAINT pk_mcc_codes
PRIMARY KEY(mcc_code);

select * from users;
ALTER TABLE cards
ADD CONSTRAINT fk_cards_users
FOREIGN KEY(client_id)
REFERENCES users(client_id);

ALTER TABLE transactions
ADD CONSTRAINT fk_transactions_users
FOREIGN KEY(client_id)
REFERENCES users(client_id);

ALTER TABLE transactions
ADD CONSTRAINT fk_transactions_cards
FOREIGN KEY(card_id)
REFERENCES cards(card_id);

ALTER TABLE transactions
ADD CONSTRAINT fk_transactions_mcc
FOREIGN KEY(mcc)
REFERENCES mcc_codes(mcc_code);

EXEC sp_help cards;

SELECT TOP 5 amount
FROM transactions
ORDER BY amount DESC;

ALTER TABLE cards
ADD acct_open_date_clean DATE;


ALTER TABLE cards
ADD expires_clean DATE;


UPDATE cards
SET acct_open_date_clean =
CAST('01-' + acct_open_date AS DATE);

SELECT acct_open_date_clean
FROM cards;

SELECT * FROM cards;

UPDATE cards
SET expires_clean =
CAST('01-' + expires AS DATE);

SELECT TOP 10 expires,MONTH(expires_clean)
FROM cards;

SELECT *
FROM users
WHERE current_age < 0
   OR current_age > 120;

SELECT *
FROM users
WHERE credit_score < 300
   OR credit_score > 850;

SELECT *
FROM users
WHERE yearly_income < 0
   OR per_capita_income < 0;

SELECT *
FROM users
WHERE total_debt < 0;

SELECT *
FROM cards
WHERE credit_limit < 0;

SELECT *
FROM transactions
WHERE amount <= 0;

SELECT DISTINCT merchant_state
FROM transactions
ORDER BY merchant_state;

UPDATE transactions
SET merchant_state = 'Unknown'
WHERE merchant_state IS NULL;

SELECT DISTINCT gender
FROM users;

SELECT DISTINCT card_type
FROM cards;

SELECT DISTINCT has_chip
FROM cards;

SELECT DISTINCT use_chip
FROM transactions;

SELECT DISTINCT errors
FROM transactions;


-- — CUSTOMER ANALYSIS 🔥
--Understand customer demographics, financial behavior, and risk profile.
SELECT *
FROM transactions;
--How many total customers exist?
SELECT COUNT(*) AS total_customers
FROM users;
--How many customers own multiple cards?
SELECT client_id,COUNT(*) AS total_cards
FROM cards
GROUP BY client_id
HAVING COUNT(*) > 1;

--What is the average credit score?
SELECT AVG(credit_score) AS average_credit_score
FROM users;
--Find minimum, maximum, and average yearly income.
SELECT MIN(yearly_income) AS minimum_income,MAX(yearly_income) AS maximum_income,AVG(yearly_income) AS average_income
FROM users;

--Which customers have the highest total debt?
SELECT TOP 10 WITH TIES client_id,gender,total_debt
FROM users
--GROUP BY gender
ORDER BY total_debt DESC;

--What is the average yearly income by gender?
SELECT gender,AVG(yearly_income) AS average_yearly_income
FROM users
GROUP BY gender;

--How many customers belong to each gender?
SELECT gender, COUNT(*) AS total_no_of_customers_by_gender
FROM users
GROUP BY gender;

--What is the average number of credit cards per customer?
SELECT AVG(num_credit_cards) AS average_num_of_credit_cards
FROM users;
--GROUP BY client_id

--Segment customers by credit score:

--Poor
--Fair
--Good
--Very Good
--Excellent

WITH buckets AS(
	SELECT *,NTILE(5) OVER(order by credit_score) AS bucket
	FROM users
)

SELECT *,
		CASE WHEN bucket = 1 THEN 'Poor'
			WHEN bucket = 2 THEN 'Fair'
			WHEN bucket =3 THEN 'Good'
			WHEN bucket = 4 THEN 'Very Good'
			WHEN bucket =5 THEN 'Excellent'
		END AS category_credit_score
FROM buckets

--Find customers whose debt is greater than yearly income.
SELECT client_id,yearly_income,total_debt
FROM users
WHERE total_debt > yearly_income;

--VERY important financial-risk analysis.

--Which birth year has the highest number of customers?
SELECT TOP 1 WITH TIES birth_year,COUNT(*) AS no_of_customers
FROM users
GROUP BY birth_year 
ORDER BY no_of_customers DESC;

--Find top 10 customers by yearly income.
SELECT TOP 10 WITH TIES client_id,yearly_income
FROM users 
ORDER BY yearly_income DESC;

--Which customers have highest debt-to-income ratio?
WITH debt_to_income_ratio AS (
	SELECT *,total_debt/yearly_income AS ratio
	FROM users
	--GROUP BY client_id
)

SELECT TOP 5 WITH TIES *
FROM debt_to_income_ratio
ORDER BY ratio DESC;

--Advanced risk analytics.

--SECTION 2 — CARD ANALYSIS 🔥
--Goal:

--Understand card usage and card portfolio behavior.

--How many total cards exist?
SELECT COUNT(DISTINCT card_id) AS total_cards
FROM cards;

--Which card brand is most commonly used?
SELECT TOP 2 WITH TIES card_brand, COUNT(*) AS users
FROM cards
GROUP BY card_brand
ORDER BY users DESC;

--Which card type is most common?
SELECT TOP 2 WITH TIES card_type, COUNT(*) AS users
FROM cards
GROUP BY card_type
ORDER BY users DESC;

--What percentage of cards are chip-enabled?
WITH total_cards AS(
	SELECT COUNT(*) AS total_cards
	FROM cards
), chip_enabled AS(
	SELECT COUNT(*) AS total_no_of_enabled_cards
	FROM cards
	WHERE has_chip = 1
)

SELECT ROUND(((c.total_no_of_enabled_cards*100.0)/t.total_cards),2) AS percentage_of_chip_enabled_cards
FROM total_cards AS t
CROSS JOIN chip_enabled AS c;

--Which card type has the highest average credit limit?
SELECT TOP 1 WITH TIES card_type, AVG(credit_limit) AS highest_average_credit_limit
FROM cards
GROUP BY card_type
ORDER BY highest_average_credit_limit DESC;

SELECT TOP 1 WITH TIES card_type, AVG(credit_limit) AS lowest_average_credit_limit
FROM cards
GROUP BY card_type
ORDER BY lowest_average_credit_limit;
--How many cards are expired?
SELECT COUNT(*) AS total_expired_cards
FROM cards
WHERE expires_clean < GETDATE()


--Which customers own the most cards?
SELECT TOP 10 WITH TIES client_id, SUM(num_cards_issued) AS total_cards
FROM cards 
GROUP BY client_id
ORDER BY total_cards DESC;

--Find top 10 cards with highest credit limit.
SELECT TOP 10 WITH TIES card_id,credit_limit
FROM cards 
ORDER BY credit_limit DESC;

--What is the average credit limit by card brand?
SELECT card_brand, AVG(credit_limit) AS average_credit_limit
FROM cards
GROUP BY card_brand
ORDER BY average_credit_limit DESC;

--Which card brands have highest expired-card percentage?
WITH total_cards AS (
    SELECT card_brand,
           COUNT(*) AS total_cards
    FROM cards
    GROUP BY card_brand
),

expired_cards AS (
    SELECT card_brand,
           COUNT(*) AS expired_cards
    FROM cards
    WHERE expires_clean < GETDATE()
    GROUP BY card_brand
)

SELECT t.card_brand,
       ROUND(
           (ISNULL(e.expired_cards,0) * 100.0)
           / t.total_cards,
           2
       ) AS expired_percentage
FROM total_cards t
LEFT JOIN expired_cards e
ON t.card_brand = e.card_brand
ORDER BY expired_percentage DESC;

--How many cards were opened each year?
SELECT YEAR(acct_open_date_clean) AS year,COUNT(*) AS total_no_of_opened_cards
FROM cards
GROUP BY YEAR(acct_open_date_clean)
ORDER BY year;


--SECTION 3 — TRANSACTION ANALYSIS 🔥🔥
--Goal:

--Understand transaction behavior and spending patterns.


--How many total transactions exist?
SELECT COUNT(DISTINCT trasaction_id) AS total_transactions
FROM transactions;

--What is the total transaction amount?
SELECT SUM(ABS(amount)) AS total_transaction_amount
FROM transactions;

--What is the average transaction amount?
SELECT AVG(ABS(amount)) AS average_transaction_amount
FROM transactions;

--Find highest and lowest transaction amount.
SELECT MIN(amount) AS minimum_transaction_amount,MAX(amount) AS maximum_transaction_amount
FROM transactions;

--How many debit vs credit transactions exist?

--(using negative/positive amount logic)
WITH debit AS(
	SELECT COUNT(*) AS total_debit_transactions
	FROM transactions
	WHERE amount < 0
), credit AS(
	SELECT COUNT(*) AS total_credit_transactions
	FROM transactions 
	WHERE  amount > 0
), zero_amount AS (
	SELECT COUNT(*) AS total_zero_amount_transactions
	FROM transactions 
	WHERE  amount = 0
)

SELECT (total_debit_transactions + total_credit_transactions + total_zero_amount_transactions) AS total_transactions,
		total_debit_transactions,total_credit_transactions, total_zero_amount_transactions
FROM debit 
CROSS JOIN credit
CROSS JOIN zero_amount;



--What percentage of transactions are negative?
WITH total AS (
	SELECT COUNT(DISTINCT trasaction_id) AS total_transactions
	FROM transactions
),debit AS(
	SELECT COUNT(*) AS total_debit_transactions
	FROM transactions
	WHERE amount < 0
)

SELECT ROUND(((total_debit_transactions*100.0)/total_transactions),2) AS percentage_of_negative_transactions
FROM total 
CROSS JOIN debit;

--Which merchant categories have highest transaction volume?
SELECT TOP 10 WITH TIES m.merchant_category,COUNT(t.trasaction_id) AS no_of_transactions
FROM transactions AS t
JOIN mcc_codes AS m
ON t.mcc = m.mcc_code
GROUP BY m.merchant_category
ORDER BY no_of_transactions DESC;


--Which merchant categories generate highest transaction value?
SELECT TOP 10 WITH TIES m.merchant_category,SUM(ABS(t.amount)) AS transaction_amount
FROM transactions AS t
JOIN mcc_codes AS m
ON t.mcc = m.mcc_code
GROUP BY m.merchant_category
ORDER BY transaction_amount DESC;

--Which cities generate highest transaction value?
SELECT TOP 7 WITH TIES merchant_city,SUM(ABS(amount)) AS transaction_value
FROM transactions
GROUP BY merchant_city
ORDER BY transaction_value DESC;

--Which merchant locations have highest transaction counts?
SELECT TOP 7 WITH TIES merchant_state,COUNT(trasaction_id) AS num_of_transactions
FROM transactions
GROUP BY merchant_state
ORDER BY num_of_transactions DESC;

--Find monthly transaction trends.
SELECT YEAR(date) AS year,MONTH(date) AS month,COUNT(*) AS no_of_transactions_in_a_month
FROM transactions
GROUP BY YEAR(date),MONTH(date)
ORDER BY YEAR(date),MONTH(date);

--Find yearly transaction trends.
SELECT YEAR(date) AS year,COUNT(*) AS no_of_transactions_in_a_month
FROM transactions
GROUP BY YEAR(date)
ORDER BY YEAR(date);

--Which customers spend the most money?  i want clarification on this!! different results were coming 
SELECT TOP 20 WITH TIES u.client_id,SUM(-t.amount) AS money_spent
FROM transactions AS t
JOIN users AS u
ON u.client_id = t.client_id
WHERE t.amount < 0
GROUP BY u.client_id
ORDER BY money_spent DESC;


--Which customers perform the most transactions? -- after grouping i will analyse i will ask chatgpt whether to group it or not?
SELECT TOP 10 WITH TIES
       client_id,
       COUNT(*) AS total_transactions
FROM transactions
GROUP BY client_id
ORDER BY total_transactions DESC;

--What is the average transaction amount by card type?
SELECT c.card_type, AVG(ABS(t.amount)) AS average_transaction_amount
FROM cards AS c
JOIN transactions AS t
ON c.card_id = t.card_id
--WHERE amount > 0
GROUP BY c.card_type

--Which transactions have unusually large amounts?
SELECT t.trasaction_id,t.client_id,t.card_id,u.yearly_income,t.amount
FROM transactions AS t
JOIN users AS u 
ON u.client_id = t.client_id
WHERE ABS(t.amount) > u.yearly_income

--(anomaly-style analysis)

--SECTION 4 — ERROR & FAILURE ANALYSIS 🔥


--How many transactions contain errors?
SELECT COUNT(*) AS total_errors
FROM transactions
WHERE errors IS NOT NULL

--What percentage of transactions fail?
WITH total AS(
	SELECT COUNT(*) AS total_transactions
	FROM transactions
), failed AS (
	SELECT COUNT(*) AS total_errors
	FROM transactions
	WHERE errors IS NOT NULL
)

SELECT ROUND(((100.0*total_errors)/total_transactions),2) AS percentage_of_failed_errors
FROM total
CROSS JOIN failed;

--Which error type occurs most frequently?
SELECT TOP 3 WITH TIES errors AS error_type,COUNT(*) AS no_of_errors
FROM transactions
WHERE errors IS NOT NULL
GROUP BY errors
ORDER BY no_of_errors DESC;

--Which merchant categories experience most errors?
SELECT TOP 3 WITH TIES m.merchant_category,COUNT(*) AS no_of_errors
FROM transactions AS t
JOIN mcc_codes AS m
ON t.mcc = m.mcc_code
WHERE t.errors IS NOT NULL
GROUP BY m.merchant_category
ORDER BY no_of_errors DESC;

--Which card types experience highest transaction failures?
SELECT TOP 3 WITH TIES c.card_type,COUNT(*) AS no_of_transaction_failures
FROM cards AS c
JOIN transactions AS t
ON t.card_id = c.card_id
WHERE t.errors IS NOT NULL
GROUP BY c.card_type
ORDER BY no_of_transaction_failures DESC;

--Which customers experience highest number of failed transactions?
SELECT TOP 10 WITH TIES
       client_id,
       COUNT(*) AS total_failed_transactions
FROM transactions
WHERE errors IS NOT NULL
GROUP BY client_id
ORDER BY total_failed_transactions DESC;

--Which cities have highest failed transaction rates?
WITH total_city_transactions AS (
    SELECT merchant_city,
           COUNT(*) AS total_transactions
    FROM transactions
    GROUP BY merchant_city
),

failed_city_transactions AS (
    SELECT merchant_city,
           COUNT(*) AS failed_transactions
    FROM transactions
    WHERE errors IS NOT NULL
    GROUP BY merchant_city
)

SELECT t.merchant_city,
       ROUND(
           (100.0 * ISNULL(f.failed_transactions,0))
           / t.total_transactions,
           2
       ) AS failed_transaction_rate
FROM total_city_transactions t
LEFT JOIN failed_city_transactions f
ON t.merchant_city = f.merchant_city
ORDER BY failed_transaction_rate DESC;


--Compare average transaction amount between:

--successful transactions
--failed transactions
WITH success AS(
	SELECT AVG(amount) AS average_of_successful_transaction_amount
	FROM transactions
	WHERE errors IS NULL
), failure AS(
	SELECT AVG(amount) AS average_of_failed_transaction_amount
	FROM transactions
	WHERE errors IS NOT NULL
)

SELECT average_of_successful_transaction_amount,average_of_failed_transaction_amount,
		ABS(average_of_successful_transaction_amount - average_of_failed_transaction_amount) AS absolute_difference
FROM success
CROSS JOIN failure


--SECTION 5 — CUSTOMER BEHAVIOR ANALYSIS 🔥

--Which customers are likely dormant?
WITH latest_transactions AS(
	SELECT client_id,MAX(date) AS latest_transaction
	FROM transactions
	GROUP BY client_id
)

SELECT *,ABS(DATEDIFF(MONTH,latest_transaction,GETDATE())) AS no_of_months_from_last_transaction
FROM latest_transactions
WHERE ABS(DATEDIFF(MONTH,latest_transaction,GETDATE())) >=12

--(no transactions in long period)

--Which customers spend more than their yearly income?
WITH spent AS(
	SELECT client_id,SUM(ABS(amount)) AS total_spent
	FROM transactions
	WHERE amount < 0
	GROUP BY client_id
)

SELECT u.client_id,u.yearly_income,s.total_spent
FROM users AS u
JOIN spent AS s
ON s.client_id = u.client_id
WHERE u.yearly_income < s.total_spent 
--Which customers have unusually high transaction frequency?
SELECT TOP 10 WITH TIES
	   client_id,
	   COUNT(*) AS total_transactions
FROM transactions
GROUP BY client_id
ORDER BY total_transactions DESC;
--Find customers with highest average transaction size.
SELECT TOP 10 WITH TIES
	   client_id,
	   AVG(ABS(amount)) AS avg_transaction_size
FROM transactions
GROUP BY client_id
ORDER BY avg_transaction_size DESC;

--Which customers frequently use chip-enabled transactions?
SELECT TOP 10 WITH TIES
	   client_id,
	   COUNT(*) AS chip_transactions
FROM transactions
WHERE use_chip = 1
GROUP BY client_id
ORDER BY chip_transactions DESC;
--Which age groups spend the most money?
WITH age_groups AS(
	SELECT client_id,
		   current_age,

		   CASE
			   WHEN current_age BETWEEN 18 AND 25 THEN '18-25'
			   WHEN current_age BETWEEN 26 AND 35 THEN '26-35'
			   WHEN current_age BETWEEN 36 AND 50 THEN '36-50'
			   ELSE '50+'
		   END AS age_group
	FROM users
)

SELECT a.age_group,
	   SUM(ABS(t.amount)) AS total_spending
FROM age_groups a
JOIN transactions t
ON a.client_id = t.client_id
WHERE t.amount < 0
GROUP BY a.age_group
ORDER BY total_spending DESC;
--Find relationship between credit score and spending.
SELECT u.credit_score,
	   AVG(ABS(t.amount)) AS avg_spending
FROM users u
JOIN transactions t
ON u.client_id = t.client_id
WHERE t.amount < 0
GROUP BY u.credit_score
ORDER BY u.credit_score;

--Which customers use multiple card brands?
SELECT client_id,
	   COUNT(DISTINCT card_brand) AS no_of_card_brands
FROM cards
GROUP BY client_id
HAVING COUNT(DISTINCT card_brand) > 1
ORDER BY no_of_card_brands DESC;

--SECTION 6 — ADVANCED ANALYTICS 🔥🔥

--Find rolling monthly transaction totals.
WITH monthly_transactions AS(
	SELECT YEAR(date) AS year,
		   MONTH(date) AS month,
		   SUM(ABS(amount)) AS monthly_total
	FROM transactions
	GROUP BY YEAR(date), MONTH(date)
)

SELECT *,
	   SUM(monthly_total)
	   OVER(
			ORDER BY year, month
	   ) AS rolling_total
FROM monthly_transactions;
--(Window functions)

--Rank customers by spending.
WITH customer_spending AS(
	SELECT client_id,
		   SUM(ABS(amount)) AS total_spending
	FROM transactions
	WHERE amount < 0
	GROUP BY client_id
)

SELECT *,
	   RANK() OVER(
			ORDER BY total_spending DESC
	   ) AS spending_rank
FROM customer_spending;

--Find top 3 customers in each merchant category.
WITH category_spending AS(
	SELECT m.merchant_category,
		   t.client_id,
		   SUM(ABS(t.amount)) AS total_spending
	FROM transactions t
	JOIN mcc_codes m
	ON t.mcc = m.mcc_code
	WHERE t.amount < 0
	GROUP BY m.merchant_category,
			 t.client_id
)

SELECT *
FROM(
	SELECT *,
		   RANK() OVER(
				PARTITION BY merchant_category
				ORDER BY total_spending DESC
		   ) AS ranking
	FROM category_spending
) x
WHERE ranking <= 3;

--Find month-over-month transaction growth.


--Find cumulative transaction totals over time.
SELECT date,
	   amount,
	   SUM(ABS(amount))
	   OVER(
			ORDER BY date
	   ) AS cumulative_total
FROM transactions;
--Detect rapid repeated transactions.


--Find customers whose spending suddenly spikes.
WITH customer_monthly_spending AS(
	SELECT client_id,
		   YEAR(date) AS year,
		   MONTH(date) AS month,
		   SUM(ABS(amount)) AS monthly_spending
	FROM transactions
	WHERE amount < 0
	GROUP BY client_id,
			 YEAR(date),
			 MONTH(date)
)

SELECT *,
	   LAG(monthly_spending)
	   OVER(
			PARTITION BY client_id
			ORDER BY year, month
	   ) AS previous_spending
FROM customer_monthly_spending;
--(LAG/LEAD)

--Segment customers into:

--low value
--medium value
--high value

--(using NTILE)

WITH customer_spending AS(
	SELECT client_id,
		   SUM(ABS(amount)) AS total_spending
	FROM transactions
	WHERE amount < 0
	GROUP BY client_id
)

SELECT *,

	   CASE
		   WHEN bucket = 1 THEN 'Low Value'
		   WHEN bucket = 2 THEN 'Medium Value'
		   WHEN bucket = 3 THEN 'High Value'
	   END AS customer_segment

FROM(
	SELECT *,
		   NTILE(3)
		   OVER(
				ORDER BY total_spending
		   ) AS bucket
	FROM customer_spending
) x;

--Find moving average transaction amounts.
WITH monthly_transactions AS(
	SELECT YEAR(date) AS year,
		   MONTH(date) AS month,
		   AVG(ABS(amount)) AS avg_amount
	FROM transactions
	GROUP BY YEAR(date),
			 MONTH(date)
)

SELECT *,

	   AVG(avg_amount)
	   OVER(
			ORDER BY year, month
			ROWS BETWEEN 2 PRECEDING
			AND CURRENT ROW
	   ) AS moving_average

FROM monthly_transactions;

--Rank merchant categories by yearly revenue.
WITH yearly_revenue AS(
	SELECT YEAR(t.date) AS year,
		   m.merchant_category,
		   SUM(ABS(t.amount)) AS revenue
	FROM transactions t
	JOIN mcc_codes m
	ON t.mcc = m.mcc_code
	GROUP BY YEAR(t.date),
			 m.merchant_category
)

SELECT *,

	   RANK() OVER(
			PARTITION BY year
			ORDER BY revenue DESC
	   ) AS revenue_rank

FROM yearly_revenue;


CREATE VIEW vw_customer_summary AS

SELECT
	u.client_id,
	u.gender,
	u.credit_score,
	u.yearly_income,

	COUNT(DISTINCT c.card_id) AS total_cards,

	COUNT(t.trasaction_id) AS total_transactions,

	SUM(
		CASE
			WHEN t.amount < 0
			THEN ABS(t.amount)
			ELSE 0
		END
	) AS total_spending

FROM users u
LEFT JOIN cards c
ON u.client_id = c.client_id

LEFT JOIN transactions t
ON u.client_id = t.client_id

GROUP BY
	u.client_id,
	u.gender,
	u.credit_score,
	u.yearly_income;

CREATE VIEW vw_transaction_summary AS

SELECT
    t.trasaction_id AS transaction_id,
    t.client_id,
    t.card_id,
    t.amount,
    ABS(t.amount) AS absolute_transaction_amount,
    t.use_chip,
    t.merchant_city,
    t.merchant_state,
    t.errors,
    t.date,

    CASE
        WHEN t.amount < 0 THEN 'Debit'
        WHEN t.amount > 0 THEN 'Credit'
        ELSE 'Zero Amount'
    END AS transaction_type,

    CASE
        WHEN t.errors IS NULL THEN 'Successful'
        ELSE 'Failed'
    END AS transaction_status,

    m.merchant_category

FROM transactions t
LEFT JOIN mcc_codes m
ON t.mcc = m.mcc_code;

CREATE VIEW vw_spending_behavior AS

SELECT
    t.client_id,

    COUNT(*) AS total_transactions,

    SUM(
        CASE
            WHEN t.amount < 0
            THEN ABS(t.amount)
            ELSE 0
        END
    ) AS total_spending,

    AVG(
        CASE
            WHEN t.amount < 0
            THEN ABS(t.amount)
        END
    ) AS avg_spending,

    MAX(
        CASE
            WHEN t.amount < 0
            THEN ABS(t.amount)
        END
    ) AS highest_transaction,

    MIN(
        CASE
            WHEN t.amount < 0
            THEN ABS(t.amount)
			END
    ) AS lowest_transaction,

    MAX(t.date) AS latest_transaction_date

FROM transactions t
GROUP BY t.client_id;

CREATE VIEW vw_failure_analysis AS

SELECT
    t.trasaction_id AS transaction_id,
    t.client_id,
    t.card_id,
    c.card_type,
    c.card_brand,
    t.amount,
    t.errors,
    t.merchant_city,
    t.merchant_state,
    m.merchant_category,
    t.date

FROM transactions t
LEFT JOIN cards c
ON t.card_id = c.card_id

LEFT JOIN mcc_codes m
ON t.mcc = m.mcc_code

WHERE t.errors IS NOT NULL;

SELECT * FROM vw_failure_analysis;

CREATE VIEW vw_monthly_trends AS

SELECT
    YEAR(date) AS year,
    MONTH(date) AS month,

    COUNT(*) AS total_transactions,

    SUM(ABS(amount)) AS total_transaction_amount,

    AVG(ABS(amount)) AS average_transaction_amount,

    SUM(
        CASE
            WHEN errors IS NOT NULL
            THEN 1
            ELSE 0
        END
    ) AS failed_transactions

FROM transactions
GROUP BY YEAR(date), MONTH(date);

SELECT * FROM vw_monthly_trends;


CREATE VIEW vw_customer_segments AS
WITH customer_spending AS(
    SELECT
        client_id,
        SUM(
            CASE
                WHEN amount < 0
                THEN ABS(amount)
                ELSE 0
            END
        ) AS total_spending

    FROM transactions
    GROUP BY client_id
)

SELECT *,

    CASE
        WHEN spending_bucket = 1 THEN 'Low Value'
        WHEN spending_bucket = 2 THEN 'Medium Value'
        WHEN spending_bucket = 3 THEN 'High Value'
    END AS customer_segment

FROM(

    SELECT *,

        NTILE(3)
        OVER(
            ORDER BY total_spending
        ) AS spending_bucket

    FROM customer_spending

) x;

SELECT * FROM vw_customer_segments;


CREATE PROCEDURE sp_top_spending_customers
    @top_n INT
AS
BEGIN

    SELECT TOP(@top_n)
           client_id,
           SUM(ABS(amount)) AS total_spending

    FROM transactions
    WHERE amount < 0

    GROUP BY client_id
    ORDER BY total_spending DESC;

END;

CREATE PROCEDURE sp_monthly_transaction_report
    @year INT,
    @month INT
AS
BEGIN

    SELECT
        COUNT(*) AS total_transactions,

        SUM(ABS(amount)) AS total_transaction_amount,

        AVG(ABS(amount)) AS average_transaction_amount,

        SUM(
            CASE
                WHEN errors IS NOT NULL
                THEN 1
                ELSE 0
            END
        ) AS failed_transactions

    FROM transactions

    WHERE YEAR(date) = @year
      AND MONTH(date) = @month;

END;

CREATE PROCEDURE sp_failed_transactions
AS
BEGIN

    SELECT
        t.trasaction_id AS transaction_id,
        t.client_id,
        t.card_id,
        t.amount,
        t.errors,
        t.date,
        m.merchant_category

    FROM transactions t
    LEFT JOIN mcc_codes m
    ON t.mcc = m.mcc_code

    WHERE t.errors IS NOT NULL;

END;

CREATE PROCEDURE sp_customer_transaction_history
    @client_id INT
AS
BEGIN

    SELECT
        trasaction_id AS transaction_id,
        amount,
        use_chip,
        merchant_city,
        merchant_state,
        errors,
        date

    FROM transactions
    WHERE client_id = @client_id

    ORDER BY date DESC;

END;

CREATE PROCEDURE sp_merchant_category_analysis
AS
BEGIN

    SELECT
        m.merchant_category,

        COUNT(*) AS total_transactions,

        SUM(ABS(t.amount)) AS total_transaction_amount,

        AVG(ABS(t.amount)) AS average_transaction_amount,

        SUM(
            CASE
                WHEN t.errors IS NOT NULL
                THEN 1
                ELSE 0
            END
        ) AS failed_transactions

    FROM transactions t
    LEFT JOIN mcc_codes m
    ON t.mcc = m.mcc_code

    GROUP BY m.merchant_category

    ORDER BY total_transaction_amount DESC;

END;

CREATE PROCEDURE sp_dormant_customers
    @inactive_months INT
AS
BEGIN

    WITH latest_transactions AS(

        SELECT
            client_id,
            MAX(date) AS latest_transaction

        FROM transactions
        GROUP BY client_id
    )

    SELECT
        client_id,
        latest_transaction,

        DATEDIFF(
            MONTH,
            latest_transaction,
            GETDATE()
        ) AS inactive_months

    FROM latest_transactions

    WHERE DATEDIFF(
            MONTH,
            latest_transaction,
            GETDATE()) >= @inactive_months;

END;

CREATE PROCEDURE sp_top_merchant_cities
    @top_n INT
AS
BEGIN

    SELECT TOP(@top_n)
           merchant_city,
           SUM(ABS(amount)) AS total_transaction_amount

    FROM transactions

    GROUP BY merchant_city

    ORDER BY total_transaction_amount DESC;

END;

EXEC sp_top_spending_customers 10;

EXEC sp_monthly_transaction_report 2019, 5;

EXEC sp_customer_transaction_history 825;

EXEC sp_dormant_customers 12;

EXEC sp_top_merchant_cities 5;




DROP TABLE IF EXISTS fact_transactions;
DROP TABLE IF EXISTS dim_customers;
DROP TABLE IF EXISTS dim_cards;
DROP TABLE IF EXISTS dim_merchants;
DROP TABLE IF EXISTS dim_dates;




CREATE TABLE dim_customers (

    client_id               INT,
    current_age             INT,
    retirement_age          INT,
    birth_year              INT,
    birth_month             INT,
    gender                  VARCHAR(20),
    address                 VARCHAR(255),
    latitude                FLOAT,
    longitude               FLOAT,
    per_capita_income       FLOAT,
    yearly_income           FLOAT,
    total_debt              FLOAT,
    credit_score            INT,
    num_credit_cards        INT

);



INSERT INTO dim_customers

SELECT DISTINCT
    client_id,
    current_age,
    retirement_age,
    birth_year,
    birth_month,
    gender,
    address,
    latitude,
    longitude,
    per_capita_income,
    yearly_income,
    total_debt,
    credit_score,
    num_credit_cards

FROM users;





CREATE TABLE dim_cards (

    card_id                     INT,
    client_id                   INT,
    card_brand                  VARCHAR(50),
    card_type                   VARCHAR(50),
    card_number                 VARCHAR(50),
    expires                     VARCHAR(20),
    expires_clean               DATE,
    cvv                         VARCHAR(10),
    has_chip                    VARCHAR(20),
    num_cards_issued            INT,
    credit_limit                FLOAT,
    acct_open_date              VARCHAR(20),
    acct_open_date_clean        DATE,
    year_pin_last_changed       INT,
    card_on_dark_web            VARCHAR(20)

);



INSERT INTO dim_cards

SELECT DISTINCT
    card_id,
    client_id,
    card_brand,
    card_type,
    card_number,
    expires,
    expires_clean,
    cvv,
    has_chip,
    num_cards_issued,
    credit_limit,
    acct_open_date,
    acct_open_date_clean,
    year_pin_last_changed,
    card_on_dark_web

FROM cards;







CREATE TABLE dim_merchants (

    mcc_code                INT,
    merchant_category       VARCHAR(255)

);




INSERT INTO dim_merchants

SELECT DISTINCT
    mcc_code,
    merchant_category

FROM mcc_codes;





CREATE TABLE dim_dates (

    full_date           DATE,
    year                INT,
    quarter_no          INT,
    month_no            INT,
    month_name          VARCHAR(20),
    week_no             INT,
    day_no              INT,
    weekday_name        VARCHAR(20)

);




INSERT INTO dim_dates

SELECT DISTINCT

    CAST(date AS DATE) AS full_date,

    YEAR(date) AS year,

    DATEPART(QUARTER, date) AS quarter_no,

    MONTH(date) AS month_no,

    DATENAME(MONTH, date) AS month_name,

    DATEPART(WEEK, date) AS week_no,

    DAY(date) AS day_no,

    DATENAME(WEEKDAY, date) AS weekday_name

FROM transactions;






CREATE TABLE fact_transactions (

    transaction_id            INT,
    client_id                 INT,
    card_id                   INT,
    transaction_date          DATE,
    mcc_code                  INT,

    amount                    FLOAT,
    absolute_amount           FLOAT,

    transaction_type          VARCHAR(20),
    transaction_status        VARCHAR(20),

    use_chip                  VARCHAR(20),

    merchant_city             VARCHAR(100),
    merchant_state            VARCHAR(100),

    zip                       VARCHAR(20),

    errors                    VARCHAR(255)

);


INSERT INTO fact_transactions

SELECT

    trasaction_id AS transaction_id,

    client_id,

    card_id,

    CAST(date AS DATE) AS transaction_date,

    mcc AS mcc_code,

    amount,

    ABS(amount) AS absolute_amount,

    CASE
        WHEN amount < 0 THEN 'Debit'
        WHEN amount > 0 THEN 'Credit'
        ELSE 'Zero Amount'
    END AS transaction_type,

    CASE
        WHEN errors IS NULL THEN 'Successful'
        ELSE 'Failed'
    END AS transaction_status,

    use_chip,

    merchant_city,

    merchant_state,

    zip,

    errors

FROM transactions;



/* =========================================================
                SAMPLE STAR SCHEMA VALIDATION
========================================================= */


/* TOTAL CUSTOMERS */

SELECT COUNT(*)
FROM dim_customers;


/* TOTAL CARDS */

SELECT COUNT(*)
FROM dim_cards;


/* TOTAL MERCHANTS */

SELECT COUNT(*)
FROM dim_merchants;


/* TOTAL DATES */

SELECT COUNT(*)
FROM dim_dates;


/* TOTAL FACT RECORDS */

SELECT COUNT(*)
FROM fact_transactions;




/* MONTHLY TRANSACTION TREND */

SELECT
    d.year,
    d.month_name,
    SUM(f.absolute_amount) AS total_transaction_amount

FROM fact_transactions f

JOIN dim_dates d
ON f.transaction_date = d.full_date

GROUP BY
    d.year,
    d.month_name,
    d.month_no

ORDER BY
    d.year,
    d.month_no;



/* TOP SPENDING CUSTOMERS */

SELECT TOP 10
    c.client_id,
    c.gender,
    c.credit_score,

    SUM(f.absolute_amount) AS total_spending

FROM fact_transactions f

JOIN dim_customers c
ON f.client_id = c.client_id

WHERE f.transaction_type = 'Debit'

GROUP BY
    c.client_id,
    c.gender,
    c.credit_score

ORDER BY total_spending DESC;



/* FAILURE RATE ANALYSIS */

SELECT
    transaction_status,
    COUNT(*) AS total_transactions

FROM fact_transactions

GROUP BY transaction_status;



/* TOP MERCHANT CATEGORIES */

SELECT TOP 10

    m.merchant_category,

    SUM(f.absolute_amount) AS transaction_amount

FROM fact_transactions f

JOIN dim_merchants m
ON f.mcc_code = m.mcc_code

GROUP BY m.merchant_category

ORDER BY transaction_amount DESC;



/* CUSTOMER SEGMENTATION */

WITH customer_spending AS(

    SELECT
        client_id,
        SUM(absolute_amount) AS total_spending

    FROM fact_transactions

    WHERE transaction_type = 'Debit'

    GROUP BY client_id
)

SELECT *,

    NTILE(3)
    OVER(
        ORDER BY total_spending
    ) AS spending_segment

FROM customer_spending;

SELECT COUNT(*)
FROM transactions;

SELECT COUNT(*)
FROM fact_transactions;

SELECT COUNT(DISTINCT client_id)
FROM users;

SELECT COUNT(DISTINCT client_id)
FROM dim_customers;

SELECT COUNT(DISTINCT card_id)
FROM cards;

SELECT COUNT(DISTINCT card_id)
FROM dim_cards;

SELECT COUNT(DISTINCT mcc_code)
FROM mcc_codes;

SELECT COUNT(DISTINCT mcc_code)
FROM dim_merchants;

SELECT SUM(amount)
FROM transactions;

SELECT SUM(amount)
FROM fact_transactions;

SELECT SUM(
CASE WHEN amount < 0
THEN ABS(amount)
ELSE 0
END)
FROM transactions;

SELECT SUM(
CASE WHEN transaction_type='Debit'
THEN absolute_amount
ELSE 0
END)
FROM fact_transactions;

ALTER TABLE fact_transactions
ADD spending_amount FLOAT,
    deposit_amount FLOAT,
    net_amount FLOAT;

UPDATE fact_transactions
SET
    spending_amount =
        CASE
            WHEN amount < 0 THEN ABS(amount)
            ELSE 0
        END,

    deposit_amount =
        CASE
            WHEN amount > 0 THEN amount
            ELSE 0
        END,

    net_amount = amount;

ALTER TABLE dim_dates
ADD quarter_name VARCHAR(10),
    month_year VARCHAR(20),
    is_weekend VARCHAR(10);

UPDATE dim_dates
SET
    quarter_name =
        CONCAT('Q', quarter_no),

    month_year =
        CONCAT(
            LEFT(month_name,3),
            '-',
            year
        ),

    is_weekend =
        CASE
            WHEN weekday_name IN ('Saturday','Sunday')
            THEN 'Yes'
            ELSE 'No'
        END;

select * from dim_dates;

ALTER TABLE dim_customers
ADD credit_score_band VARCHAR(20);

UPDATE dim_customers
SET credit_score_band =
CASE
    WHEN credit_score < 580 THEN 'Poor'
    WHEN credit_score < 670 THEN 'Fair'
    WHEN credit_score < 740 THEN 'Good'
    WHEN credit_score < 800 THEN 'Very Good'
    ELSE 'Excellent'
END;

ALTER TABLE dim_customers
ADD age_group VARCHAR(20);

UPDATE dim_customers
SET age_group =
CASE
    WHEN current_age BETWEEN 18 AND 25 THEN '18-25'
    WHEN current_age BETWEEN 26 AND 35 THEN '26-35'
    WHEN current_age BETWEEN 36 AND 50 THEN '36-50'
    ELSE '50+'
END;

ALTER TABLE dim_cards
ADD card_status VARCHAR(20);

UPDATE dim_cards
SET card_status =
CASE
    WHEN expires_clean < GETDATE()
    THEN 'Expired'
    ELSE 'Active'
END;

ALTER TABLE dim_customers
ADD debt_to_income_ratio FLOAT;

UPDATE dim_customers
SET debt_to_income_ratio =
CASE
    WHEN yearly_income = 0 THEN NULL
    ELSE total_debt / yearly_income
END;

USE Bank;

SELECT * FROM fact_transactions;

SELECT * FROM dim_customers;

SELECT * FROM dim_cards;

SELECT * FROM dim_merchants;

SELECT * FROM dim_dates;

ALTER TABLE dim_customers
ADD customer_segment VARCHAR(20);

WITH customer_spending AS
(
    SELECT
        client_id,
        SUM(spending_amount) AS total_spending,

        NTILE(3) OVER
        (
            ORDER BY SUM(spending_amount)
        ) AS bucket
    FROM fact_transactions
    GROUP BY client_id
)

UPDATE dc
SET customer_segment =
    CASE
        WHEN cs.bucket = 1 THEN 'Low Value'
        WHEN cs.bucket = 2 THEN 'Medium Value'
        WHEN cs.bucket = 3 THEN 'High Value'
    END
FROM dim_customers dc
JOIN customer_spending cs
ON dc.client_id = cs.client_id;

select * from dim_customers;