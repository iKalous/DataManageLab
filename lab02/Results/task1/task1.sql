USE lab02;

# Task1

SELECT
    login_bonus_data.id AS lbd_id,
    SUM(
        IF(login_bonus_detail.item_id = 43, login_bonus_detail.item_num, 0) +
        IF(login_bonus_detail.item_id_2 = 43, login_bonus_detail.item_num, 0) +
        IF(login_bonus_detail.item_id_3 = 43, login_bonus_detail.item_num, 0) +
        IF(login_bonus_detail.item_id_4 = 43, login_bonus_detail.item_num, 0) +
        IF(login_bonus_detail.item_id_5 = 43, login_bonus_detail.item_num, 0)
    ) AS total_diamod
FROM login_bonus_data
JOIN login_bonus_detail ON login_bonus_data.id = login_bonus_detail.login_bonus_id
GROUP BY login_bonus_data.id
ORDER BY total_diamod DESC;



CREATE TABLE login_bonus_detail_new (
    id INT AUTO_INCREMENT PRIMARY KEY,
    login_bonus_id INT NOT NULL COMMENT '关联活动ID',
    count INT NOT NULL COMMENT '第几次奖励',
    item_id INT NOT NULL COMMENT '奖励物品ID',
    item_num INT NOT NULL COMMENT '奖励物品数量',
    reward_order INT NOT NULL COMMENT '奖励顺序（同一count内的排序）',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (login_bonus_id) REFERENCES login_bonus_data(id)
) COMMENT '优化后的登录活动详情表';

CREATE INDEX idx_bonus_count ON login_bonus_detail_new(login_bonus_id, count);
CREATE INDEX idx_item_id ON login_bonus_detail_new(item_id);

# 数据迁移
INSERT INTO login_bonus_detail_new (login_bonus_id, count, item_id, item_num, reward_order)
SELECT
    login_bonus_id,
    count,
    item_id,
    item_num,
    1 AS reward_order
FROM login_bonus_detail
WHERE item_id IS NOT NULL AND item_num > 0

UNION ALL

SELECT
    login_bonus_id,
    count,
    item_id_2,
    item_num_2,
    2 AS reward_order
FROM login_bonus_detail
WHERE item_id_2 IS NOT NULL AND item_num_2 > 0

UNION ALL

SELECT
    login_bonus_id,
    count,
    item_id_3,
    item_num_3,
    3 AS reward_order
FROM login_bonus_detail
WHERE item_id_3 IS NOT NULL AND item_num_3 > 0

UNION ALL

SELECT
    login_bonus_id,
    count,
    item_id_4,
    item_num_4,
    4 AS reward_order
FROM login_bonus_detail
WHERE item_id_4 IS NOT NULL AND item_num_4 > 0

UNION ALL

SELECT
    login_bonus_id,
    count,
    item_id_5,
    item_num_5,
    5 AS reward_order
FROM login_bonus_detail
WHERE item_id_5 IS NOT NULL AND item_num_5 > 0;

# 查询
SELECT
    lbd.id AS login_bonus_id,
    SUM(lbd_new.item_num) AS total_diamond
FROM
    login_bonus_data lbd
JOIN
    login_bonus_detail_new lbd_new ON lbd.id = lbd_new.login_bonus_id
WHERE
    lbd_new.item_id = 43  -- 钻石的物品ID
GROUP BY
    lbd.id
ORDER BY
    total_diamond DESC;










