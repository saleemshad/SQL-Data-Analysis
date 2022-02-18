CREATE TABLE employee ( 
  id int, 
 name varchar(20),
 department varchar(20),
 location varchar(20),
 salary float,
 star_date DATE, 
 end_date DATE
)




INSERT INTO employee (id, name,department, location, salary, star_date, end_date) VALUES(1, 'Shad', 'Finance', 'Hyderabad',50000,
to_date('2021-01-01','yyyy-MM-dd'), to_date('2021-02-01','yyyy-MM-dd'));

INSERT INTO employee (id, name,department, location, salary, star_date, end_date) VALUES(1, 'Shad', 'Finance', 'Hyderabad',60000,
to_date('2021-03-01','yyyy-MM-dd'), to_date('2021-04-01','yyyy-MM-dd'));


INSERT INTO employee (id, name,department, location, salary, star_date, end_date) VALUES(1, 'Shad', 'Finance', 'Hyderabad',60000,
to_date('2021-03-01','yyyy-MM-dd'), to_date('2021-04-01','yyyy-MM-dd'));

INSERT INTO employee (id, name,department, location, salary, star_date, end_date) VALUES(1, 'Shad', 'IT', 'Banglore',80000,
to_date('2021-06-01','yyyy-MM-dd'), to_date('2021-07-01','yyyy-MM-dd'));


INSERT INTO employee (id, name,department, location, salary, star_date, end_date) VALUES(1, 'Shad', 'Hosting', 'Hyderabad',90000,
to_date('2021-07-01','yyyy-MM-dd'), NULL);




--- getting current and current-1 (prebous one) record of an employee from the scd_type_2 table
with employee_rank as (
select id, name, location, salary, star_date, end_date,
dense_rank() over(partition by id order by end_date desc) as rnk
from employee)
select id, name, location, salary, star_date, end_date from employee_rank
where rnk <=2