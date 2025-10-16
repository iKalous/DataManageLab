USE lab02;

SELECT DISTINCT
    a1.id AS activity_1_id,
    a2.id AS activity_2_id,
    DATE_FORMAT(a1.start_date, '%Y-%m') AS month_1,
    DATE_FORMAT(a2.start_date, '%Y-%m') AS month_2
FROM
    login_bonus_data AS a1
JOIN login_bonus_data AS a2 ON a1.id <> a2.id
WHERE
    DATEDIFF(a1.end_date,a1.start_date) <= 31 AND
    DATEDIFF(a2.end_date,a2.start_date) <= 31 AND
    DATE_FORMAT(DATE_ADD(a1.start_date, INTERVAL 1 MONTH), '%Y-%m') = DATE_FORMAT(a2.start_date, '%Y-%m');
