USE lab02;


EXPLAIN SELECT
    ga.gacha_id,
    DATE_FORMAT(FROM_UNIXTIME(gd.start_date), '%Y-%m-%d') AS start_date,
    DATE_FORMAT(FROM_UNIXTIME(gd.end_date), '%Y-%m-%d') AS end_date,
    GROUP_CONCAT(td.text SEPARATOR ',') AS texts
FROM
    gacha_available AS ga
STRAIGHT_JOIN
    text_data AS td ON ga.card_id = td.`index`
STRAIGHT_JOIN
    gacha_data AS gd ON ga.gacha_id = gd.id
WHERE
    ga.is_pickup = 1 AND
    td.category = CASE ga.card_type
        WHEN 1 THEN 4
        WHEN 2 THEN 75
        ELSE -1
    END
GROUP BY
    ga.gacha_id, gd.start_date, gd.end_date
