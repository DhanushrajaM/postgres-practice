--BEFORE INSERT Trigger for Validation

CREATE TABLE IF NOT EXISTS students_details (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INT,
    grade CHAR(1)
);

CREATE OR REPLACE FUNCTION student_validation ()
RETURNS TRIGGER AS $$
BEGIN 
   IF NEW.age < 5 OR NEW.age > 100 THEN
      RAISE EXCEPTION 'Invalid age! Age must be between 5 and 100.';
   END IF;
   
   IF NEW.grade NOT IN ('A','B','C','D','E','F') THEN 
      RAISE EXCEPTION 'Invalid grade! Must be A, B, C, D, or F.';
   END IF;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER before_validation BEFORE INSERT ON students_details FOR EACH ROW EXECUTE FUNCTION 
student_validation();

INSERT INTO students_details(name, age, grade) VALUES ('Arun', 10, 'A');

INSERT INTO students_details(name, age, grade) VALUES ('Barath', 120, 'B');

INSERT INTO students_details(name, age, grade) VALUES ('Charlie', 15, 'G');


output

psql:Triggers/validation.sql:25: ERROR:  trigger "before_validation" for relation "students_details" already exists   
INSERT 0 1
psql:Triggers/validation.sql:29: ERROR:  Invalid age! Age must be between 5 and 100.
CONTEXT:  PL/pgSQL function student_validation() line 4 at RAISE
psql:Triggers/validation.sql:31: ERROR:  Invalid grade! Must be A, B, C, D, or F.
CONTEXT:  PL/pgSQL function student_validation() line 8 at RAISE