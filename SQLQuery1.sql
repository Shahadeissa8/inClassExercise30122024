create database inClassExercise30122024
go--we wrote it to end the first line, if without itll consider the whole thing one sentance
use inClassExercise30122024 --so it under the schema cuz sometimes itll be on the master 
go
create schema Coded --can find inside security schema it is to organize tables 
					--cuz later will give permisiion based on the schemas
go					-- if database called coded you cant name objects or schema with the same name
create table Coded.Employees
(
EmployeeID int primary key identity (1,1),-- you can write not null
EmployeeName nvarchar(50) not null,--you gotta write the size if without you will run to an error
Salary decimal(18,2) not null,
City nvarchar(50),
Email nvarchar(50) not null,
Bonus money,
Promotion bit,
IsActive bit,
IsDeleted bit,
CreationDate Datetime
)
--insert data
insert into Coded.Employees--we can instead of values put (columns)
values ('Rami',1500,'Kuwait', 'Rami@gmail.com',250,1,1,0,GETDATE())
--creation date is the same date you created date

insert into Coded.Employees (EmployeeName,City,Salary,Email,Bonus)
--IsActive..etc are auto not null here bc we didnt mention them here
values ('Shahad','Hawalii',950,'shahad@gmail.com',800)

insert into Coded.Employees
--IsActive..etc are auto not null here bc we didnt mention them here
values ('Shahad',2500,'Hawalii',950,'shahad@gmail.com',0,1,1,GETDATE()),
	   ('Mohammad',500,'Salmyia',950,'mohammad@gmail.com',1,1,0 ,GETDATE()),
	   ('nawal',400,'Hawalii',950,'nawal@gmail.com',1,1,0 ,GETDATE()),
	   ('emad',400,'edalyia',950,'emad@hotmail.com',1,1,0 ,GETDATE()),
	   ('sadeq',200,'ahmadi',950,'sadeq@mew.gov.kw',1,1,0 ,GETDATE()),
	   ('neymar',100,'Hawalii',950,'neymar@gmail.com',1,1,0 ,GETDATE())
	   
	   delete from coded.Employees
	   --alt then scroll down will mean that itll highlight everything under it without the next words

select * from Coded.Employees 

select * 
from Coded.Employees
where Promotion is null

select * 
from Coded.Employees
where Promotion is not null


select * 
from Coded.Employees
where Promotion=1 and Promotion is not null 

select * 
from Coded.Employees
where Promotion=0 and Promotion is not null 

select * 
from Coded.Employees
where City = 'Hawalii' and Salary >=100

select * 
from Coded.Employees
where Salary between 1000 and 2000

select * 
from Coded.Employees
where City = 'kuwait' or City = 'ahmadi'

select * 
from Coded.Employees
where EmployeeName like 'ahmad%'

select * 
from Coded.Employees
where EmployeeName like '%ahmad%'

select * 
from Coded.Employees
where Email like '%gmail.com.com'

select * 
from Coded.Employees
where EmployeeName like '____'

select *
from Coded.Employees
where EmployeeName like 'ahmad%' or EmployeeName like 'ahmad%'

select * 
from Coded.Employees
where EmployeeName like 'ahm[a,b,c,d,e,f]d%'

select *
from Coded.Employees
where EmployeeName like 'ahm[a-f]d%' --from a to f

-- like '%a%' contains
--like 'a%' start
--like '%a' ends

select distinct City --only different cities
from Coded.Employees

select * from Coded.Employees order by Salary asc --asc is the defult from low to high
select * from Coded.Employees order by Salary desc --you gotta write it from high to low

select *
from Coded.Employees
where Salary =2500 --eg

select * 
from Coded.Employees
where Salary = (select MAX (Salary) from Coded.Employees) --best practice cuz we might have a very big table

--Alternative solution:
select top (1) *
from Coded.Employees
order by Salary desc

--top 2
select top (2) *
from Coded.Employees
order by Salary desc

--select * , N'Name:' EmployeeName, SUM (Salary + bnous) as [Total Salary]    
-- some cant be used bc it sums everything the two rows
select concat ('name: ', EmployeeName, 'Salary is: ', (Salary+ Bnous)) as 'employee information'
from Coded.Employees

--function aggregation (sum,min,max,count,avg,max) cant add two colomns
--meaning select sum(salary),name from 
select sum(Salary)
from Coded.Employees

select sum (bnous)
from Coded.Employees

select sum(Salary) + sum (bnous)
from Coded.Employees

select city, sum (salary) --sum based on city
from Coded.Employees
group by city --group them by city


--the following code is wrong it will collect all the ppl with the same name and city and sums their salaries all together
--for eg ahmad salary is now 400 instead of 200 for each
select EmployeeName, City, sum (salary) 
from Coded.Employees
group by EmployeeName, City 


select *
from Coded.Employees
where IsActive=1

--alternative sols
select * 
from Coded.VActiveEmployees
--when recieving an error check the schema name as it has not to be master but be the name of the database
--view new view, press on the table then add then tick the columns you want
--then sort them by pressing sort or by writing =1 in the feild underneeth 
--views benefits is to give the permission to people 
--they need to only see some information of the table not the whole thing

--creating view in the code
create view coded.VDeletedEmployees
as
select EmployeeName, Salary, IsDeleted
from Coded.Employees
where IsDeleted=1

drop view coded.VDeletedEmployees --is used to delete the view if you wanna change it or delete it

select *
from Coded.VDeletedEmployees

--by doing this we CAN NOT go back the data chnged forever
select *
from coded.employees --if we write it here (above) it will shoew the previous schedule before the change
update coded.employees 
set salary = Salary - 50
where salary >=400
select * -- we put it after to see the change
from coded.employees


select *
from coded.employees
update coded.employees 
set salary+=50, bnous = bnous +150
where salary >=400

delete from Coded.Employees where IsDeleted=1 --deletes for good

select *
from coded.employees