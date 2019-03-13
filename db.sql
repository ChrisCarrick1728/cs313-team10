CREATE TABLE person_table (
  person_id     serial       PRIMARY KEY,
  first_name    VARCHAR(50)  NOT NULL,
  last_name     VARCHAR(50)  NOT NULL,
  date_of_birth DATE
);

CREATE TABLE relationship_table (
  parent_id int REFERENCES person_table(person_id),
  child_id int REFERENCES person_table(person_id)
);

getPerson ->
SELECT * from person_table WHERE person_id = id;

getParents ->
SELECT parent_id FROM relationship_table WHERE child_id = id;

getChildren ->
SELECT child_id FROM relationship_table WHERE parent_id = id;

INSERT INTO person_table(first_name, last_name, date_of_birth) VALUES ('Steve', 'Rodgers', '1918-07-04');
INSERT INTO person_table(first_name, last_name, date_of_birth) VALUES ('Peter', 'Parker', '1968-07-07');
INSERT INTO person_table(first_name, last_name, date_of_birth) VALUES ('Reed', 'Richards', '1966-01-16');
INSERT INTO person_table(first_name, last_name, date_of_birth) VALUES ('Chris', 'Carrick', '1984-07-06');
INSERT INTO person_table(first_name, last_name, date_of_birth) VALUES ('Lindsay', 'Carrick', '1987-04-06');
INSERT INTO person_table(first_name, last_name, date_of_birth) VALUES ('Tyler', 'Carrick', '2007-11-19');
INSERT INTO person_table(first_name, last_name, date_of_birth) VALUES ('Joe', 'Carrick', '1966-01-16');
INSERT INTO person_table(first_name, last_name, date_of_birth) VALUES ('Debbie', 'Carrick', '1966-01-16');

INSERT INTO relationship_table VALUES (4, 6);  -- Chris to tyler
INSERT INTO relationship_table VALUES (5, 6);  -- linday to tyler
INSERT INTO relationship_table VALUES (7, 4);  -- joe to chris
INSERT INTO relationship_table VALUES (8, 4);  -- debbie to chris


SELECT person_table.first_name, person_table.last_name WHERE (SELECT relationship_table.parent_id WHERE relationship_table.child_id = childID) = 