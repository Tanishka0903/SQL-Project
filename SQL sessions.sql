show databases;
create database excelr;
use excelr;
create table students(S_ID int, S_Name char(50), Age int, Course char(20));
insert into students values (1,"Riya",25,"My Sql");
insert into students values (2,"Rohit",22,"My Sql");
select * from students;
desc students;
-- creating a table
create table patients (P_ID int,P_Name varchar(50),DOB date,TOA datetime);
insert into patients values(1,"xyz","1995-09-07","2023-09-11 18:46:10");
insert into patients values(2,"abc","1995-11-15",now());
select * from patients;
alter table students add column marks int;
alter table students drop column Age;
alter table students change column S_ID Std_ID int;
alter table students modify column S_Name varchar(50);
rename table Students to MyClass;
select*from myclass;
use excelr;
create table Randtable (id int, Name varchar(50));
select * from randtable;
insert into randtable values(54,"suman");
rename table randtable to randomtable;
drop table randomtable;
insert into myclass (std_id ,s_name , marks)values (3,"riya","70");
insert into myclass (std_id ,s_name , marks)values (4,"rohit","85");
insert into myclass (std_id ,s_name , marks)values (5,"siya","79"),
(6,"suman", 88),(7,"omkar",90),(8,"amruta",89);
select * from myclass;
set sql_safe_updates=0;
select 2+3 as sum;
select 15*35 result;
select 3=4 as result;
select 3<4 as result;
select 3>4 as result;
select 2 is null as result;
select 2 is not null as result;
select * from myclass;
update myclass set marks=0 where marks is null;
update myclass set course="my sql" where course is null;
delete from myclass duplicate;rollback;
rollback ;
insert into myclass (std_id ,s_name , marks)values (3,"riya","70"), (4,"rohit",85),(5,"siya","79"),
(6,"suman", 88),(7,"omkar",90),(8,"amruta",89);
insert into myclass values (1,"Riya","My Sql",0);
delete from myclass where marks=0;

select*from myemp limit 10;
use excelr;
select emp_id , salary from myemp;
select emp_id , salary from myemp where salary>10000 and salary<12000;
select emp_id , first_name,job_id from myemp where job_id="it_prog" or job_id="fi_account";
select emp_id , salary from myemp where salary between 10000 and 12000;
select * from myemp limit 50;
select*from myemp order by salary desc;
select distinct job_id from myemp ;
select * from myemp where job_id like "f%";
select * from myemp where first_name like "s%";
select * from myemp where last_name like "%s";
select * from myemp where first_name like "%an%";
select * from myemp where first_name like "l__";
select * from myemp where last_name like "_he_";
select * from myemp where job_id like "%vp%";
select * from myemp where job_id in ("it_prog","fi_account","pu_clerk");
select * from myemp where job_id not in ("it_prog","fi_account","pu_clerk");
select * from myemp where first_name like "s%" and salary>10000 and dep_id in (90,100,30) and commission_pct=0;


