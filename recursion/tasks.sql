-- task hierarchy
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


output

 id |      task_name       | parent_task_id | level
----+----------------------+----------------+-------
  1 | Project Setup        |                |     1
  2 | Requirement Analysis |              1 |     2
  3 | Design               |              1 |     2
  6 | Testing              |              1 |     2
  4 | Backend Development  |              3 |     3
  5 | Frontend Development |              3 |     3
  7 | Unit Testing         |              6 |     3
  8 | Integration Testing  |              6 |     3