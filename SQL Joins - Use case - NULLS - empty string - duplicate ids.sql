create TABLE TableA
(id INTEGER,
value1 varchar(50)
);



create TABLE TableB
(id INTEGER,
value2 varchar(50)
);

# Look at the data carefully we have NULL in Id column which we will be using in join
#also we have empty string in the id column which is also being used in the join condition 

insert into TableA(id,value1) values(NULL,1);
insert into TableB(id,value2) values('',2);
insert into TableB(id,value2) values('',55);
insert into TableB(id,value2) values(1,1);
insert into TableB(id,value2) values(1,3);
insert into TableB(id,value2) values(2,4);
insert into TableB(id,value2) values(2,6);
insert into TableB(id,value2) values(3,5);
insert into TableB(id,value2) values(4,5);


insert into TableB(id,value2) values(NULL,1);
insert into TableA(id,value1) values('',2);
insert into TableA(id,value1) values(1,1);
insert into TableA(id,value1) values(1,10);
insert into TableA(id,value1) values(2,3);
insert into TableA(id,value1) values(3,4);
insert into TableA(id,value1) values(4,5);

#INNER JOIN
#------------------------------------------------------------------------------------------------------------#

# we are making an inner join. So, lets see the join behaviour.
# There will be a cartesian product if we have two macthing id in the right TableA



# Things  to observer once you exexute the above query
# 1. NULLS are not joined in the inner join so its result is not displayed
# 2. '' (empty strings) are also joined with the right table. 
#   If we have more empty string in the right table then it will be cartesian product 1*2 = 2 (result rows)
# 3. In the same way lets say we have two 1's in the left table in the id and also two 1's in the right table in the id
#    so the result will be the cartesian product 2*2 = 4 (result rows)
#------------------------------------------------------------------------------------------------------------#

select TableA.id, TableB.value2
from TableA inner join TableB
on TableA.id = TableB.id;

#LEFT JOIN
#------------------------------------------------------------------------------------------------------------#

select TableA.id, TableB.value2
from TableA right join TableB
on TableA.id = TableB.id;

#left join displays all the values from the left table and then displays all the values from the right table.
# notice the behaviour it joins the '' empty strings if it is in join condition
# Also it joins the nulls but it does not display the value associated with nulls in the 