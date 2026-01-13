WITH RECURSIVE Fibonacci AS (
    SELECT 0 AS n, 0 AS fib, 1 AS next_fib
    UNION ALL
    SELECT n + 1, next_fib AS fib, fib + next_fib AS next_fib
    FROM Fibonacci
    WHERE n < 9
)
SELECT n, fib
FROM Fibonacci;



output

n | fib
---+-----
 0 |   0
 1 |   1
 2 |   1
 3 |   2
 4 |   3
 5 |   5
 6 |   8
 7 |  13
 8 |  21