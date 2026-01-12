CREATE TABLE IF NOT EXISTS tasks (
    id INT PRIMARY KEY,
    task_name VARCHAR(50),
    parent_task_id INT
);

INSERT INTO tasks (id, task_name, parent_task_id) VALUES
(1, 'Project Setup', NULL),
(2, 'Requirement Analysis', 1),
(3, 'Design', 1),
(4, 'Backend Development', 3),
(5, 'Frontend Development', 3),
(6, 'Testing', 1),
(7, 'Unit Testing', 6),
(8, 'Integration Testing', 6);

WITH RECURSIVE task_hierarchy AS (
    SELECT id, task_name, parent_task_id, 1 AS level
    FROM tasks
    WHERE parent_task_id IS NULL
    UNION ALL
    SELECT t.id, t.task_name, t.parent_task_id, th.level + 1
    FROM tasks t
    JOIN task_hierarchy th ON t.parent_task_id = th.id
)
SELECT * FROM task_hierarchy
ORDER BY level, parent_task_id;


CREATE TABLE IF NOT EXISTS transactions (
txn_id INT PRIMARY KEY,
txn_type VARCHAR(30),
parent_txn_id INT,
amount DECIMAL(10,2)
);


INSERT INTO transactions (txn_id, txn_type, parent_txn_id, amount) VALUES
(1001, 'PAYMENT', NULL, 500.00),
(1002, 'REFUND', 1001, -200.00),
(1003, 'REVERSAL', 1002, -100.00),
(1004, 'ADJUSTMENT', 1003, -50.00),
(1005, 'REFUND', 1001, -50.00);

WITH RECURSIVE txn_chain AS (
    SELECT
        txn_id,
        txn_type,
        parent_txn_id,
        amount,
        1 AS level
    FROM transactions
    WHERE parent_txn_id IS NULL

    UNION ALL
    SELECT
        t.txn_id,
        t.txn_type,
        t.parent_txn_id,
        t.amount,
        tc.level + 1
    FROM transactions t
    JOIN txn_chain tc
        ON t.parent_txn_id = tc.txn_id
)
SELECT * FROM txn_chain
ORDER BY level, txn_id;


-- right angle pattern using the recusion

WITH RECURSIVE pattern AS (
    SELECT 1 AS num
    UNION ALL
    SELECT num+1 FROM pattern WHERE num<5
)

SELECT REPEAT ('* ',num) AS Pattern FROM pattern;


--Fibonacci Sequence
WITH RECURSIVE FibonacciCTE AS (
    SELECT 0 AS n, 0 AS fib
    UNION ALL
    SELECT 1 AS n, 1 AS fib

    UNION ALL
    SELECT n + 1, fib + LAG(fib) OVER (ORDER BY n) 
    FROM FibonacciCTE
    WHERE n < 7
)
SELECT * FROM FibonacciCTE;
