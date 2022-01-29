##Understanding Window functions
## Use case : Find Average Salary of each Department


#create table
create TABLE employees
(id INTEGER,
name varchar(50),
Age	INTEGER,
Department varchar(50),	
Salary INTEGER
);

# insert data
insert into employees(id,name,Age, Department,Salary) values(1,'Ramesh'	,20,'Finance',50000);
insert into employees(id,name,Age, Department,Salary) values(2, 'Deep',25, 'Sales',30000);
insert into employees(id,name,Age, Department,Salary) values(3,'Suresh',22,'Finance',50000);
insert into employees(id,name,Age, Department,Salary) values(4,'Ram',28,'Finance',20000);
insert into employees(id,name,Age, Department,Salary) values(5,'Pradeep',22,'Sales',20000);

# select data
select * from employees;


## Overall average salary of all employees using calculation
select SUM(Salary)/COUNT(id) as "calculation" from employees;

## Overall average salary of all employees using AVG function
select avg(Salary) as "avg_function" from employees;

## Avg salary of Department using aggregate function AVG
select Department,avg(Salary) from employees
group by Department;

## I want to see the AVG salary of Department along with other columns like Name, Age, Dept , Salary
## but with  this method of aggreagtion like just using AVG will not work here so I the below query will not give me proper result
select Name,Age,Department,Salary, avg(Salary) from employees
group by Name,Age,Department,Salary;



#I need to  use winodw function to do that so this is how we can display the proper result 
select Name, Age, Department , Salary,
AVG(Salary) OVER(PARTITION BY Department)
from employees;

