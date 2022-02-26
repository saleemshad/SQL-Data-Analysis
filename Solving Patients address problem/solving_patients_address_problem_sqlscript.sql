-- Create Table

create TABLE patients  
(patient_id INTEGER,  
address varchar(50),  
state varchar(50),  
city  varchar(50),  
zip  varchar(50) ,
last_updated date
);
-- Inserting records
insert into patients(patient_id,address,state,city,zip,last_updated) values(1,'Tolichowki','Telangana','Hyderabad',NULL, to_date('2021-01-01','yyyy-MM-dd'));

insert into patients(patient_id,address,state,city,zip,last_updated) values(1,NULL,'Telangana',NULL,NULL, to_date('2021-01-02','yyyy-MM-dd'));

insert into patients(patient_id,address,state,city,zip,last_updated) values(2,'Mehdipatnam',NULL,NULL,NULL,to_date('2021-01-03','yyyy-MM-dd'));

insert into patients(patient_id,address,state,city,zip,last_updated) values(2,'Mehdipatnam','Telangana',NULL,NULL,to_date('2021-01-04','yyyy-MM-dd'));

insert into patients(patient_id,address,state,city,zip,last_updated) values(3,'Mehdipatnam1',NULL,NULL,NULL,to_date('2021-02-01','yyyy-MM-dd'));

insert into patients(patient_id,address,state,city,zip,last_updated) values(3,'Mehdipatnam','Telangana','Hyderabad','500001',to_date('2021-02-02','yyyy-MM-dd'));

insert into patients(patient_id,address,state,city,zip,last_updated) values(3,'Mehdipatnam','Telangana','Hyderabad','500001',to_date('2021-02-03','yyyy-MM-dd'))


insert into patients(patient_id,address,state,city,zip,last_updated) values(1,'Tolichowki','Telangana','Hyderabad','500002', to_date('2021-01-03','yyyy-MM-dd'))


--- quqrying the data
with patients_address as(

select PATIENT_ID,ADDRESS,state,city,zip,last_updated,
(case when ADDRESS is null then 0 else 1 end) +
(case when state is null then 0 else 1 end) +
(case when city is null then 0 else 1 end) +
(case when zip is null then 0 else 1 end)  as Sum_addrcols_foreach_patient,

max((case when ADDRESS is null then 0 else 1 end) + 
(case when state is null then 0 else 1 end) + (case when city is null then 0 else 1 end) + 
(case when zip is null then 0 else 1 end) ) over(partition by PATIENT_ID) as max_of_summary
from patients
)
,

most_no_of_addr_cols_filled as (

select PATIENT_ID,ADDRESS,state,city,zip,last_updated, Sum_addrcols_foreach_patient, max_of_summary,
dense_rank() over(partition by patient_id order by last_updated desc) as ranking_addr_cols_filled
from patients_address
where Sum_addrcols_foreach_patient = max_of_summary
)

select PATIENT_ID,ADDRESS,state,city,zip,last_updated from most_no_of_addr_cols_filled where ranking_addr_cols_filled=1


