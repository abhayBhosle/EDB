Employee Database System : 

Create table Department ( dname varchar(15)unique not null,dnumber int ,primary key (dnumber));
 
Insert into Department values ("Research",1);
Insert into Department values ("HR",2);
Insert into Department values ("Development",3);
Insert into Department values ("Testing",4);


Create table Employee ( ssn char(9),name varchar(15) not null, salary decimal(10,2),sex char, address varchar(30),
dno int not null,primary key(ssn), foreign key(dno) references Department(dnumber));
 
Insert into Employee values('emp001','Ram',30000,'M','RT Nagar, Blore',3);
Insert into Employee values('emp002','Sudha',75000,'F','Hebbal, Blore',2);
Insert into Employee values('emp003','Ravi',20000,'M','Hebbal, Blore',4);
Insert into Employee values('emp004','Rohan',80000,'M','RT Nagar, Mysore',1);
Insert into Employee values('emp005','Amar',35000,'M','MG Road, Mysore',3);
Insert into Employee values('emp006','Anil',45000,'M','MG Road, Noida',3);
Insert into Employee values('emp007','Tanya',35000,'F','Yelahanka, Blore',3);
Insert into Employee values('emp008','Kavita',50000,'F','Baglur, Blore',1);
Insert into Employee values('emp009','John',45000,'M','RT Nagar, Blore',4);


alter table Employee add super_ssn char(9) references Employee(ssn);
 
update Employee set super_ssn='emp006' where ssn='emp001';
update Employee set super_ssn='emp008' where ssn='emp003';
update Employee set super_ssn='emp002' where ssn='emp005';
update Employee set super_ssn='emp008' where ssn='emp006';
update Employee set super_ssn='emp008' where ssn='emp007';
update Employee set super_ssn='emp004' where ssn='emp008';
update Employee set super_ssn='emp008' where ssn='emp009';

alter table Department add mgr_ssn char(9) references Employee(ssn);
 
update Department set mgr_ssn='emp004' where dnumber=1;
update Department set mgr_ssn='emp002' where dnumber=2;
update Department set mgr_ssn='emp006' where dnumber=3;
update Department set mgr_ssn='emp009' where dnumber=4;

Create table Dept_Location ( dnumber int not null,dlocation varchar(15) not null,
primary key(dnumber, dlocation),foreign key(dnumber) references Department(dnumber) );


Create table Project ( pname varchar(15) not null, pnumber varchar(5) not null,
plocation varchar(15),dnum int not null,primary key (pnumber),unique(pname),
foreign key (dnum) references Department(dnumber));
 
Create table Workson ( essn char(9) not null,pno varchar(5) not null,
hours decimal(3,1) not null ,primary key(essn, pno),
foreign key (essn) references Employee(ssn),foreign key (pno) references project(pnumber));
 
Create table Dependent ( essn char(9) not null,dependent_name varchar(15) not null,
sex char,relationship varchar(8),primary key (essn),foreign key (essn) references Employee(ssn));
 
 
Insert into Dept_Location values(1,'Blore');
Insert into Dept_Location values(2,'Blore');
Insert into Dept_Location values(3,'Blore');
Insert into Dept_Location values(3,'Mysore');
Insert into Dept_Location values(4,'Noida');
Insert into Dept_Location values(4,'Blore');


Insert into Project values("Banking","p01","Blore",3);
Insert into Project values("Android App","p02","Mysore",3);
Insert into Project values("WSN","p03","Blore",4);
Insert into Project values("Robotics","p04","Noida",4);
Insert into Project values("Smart Vehicle","p05","Blore",3);


Insert into Workson values("emp001","p01",14);
Insert into Workson values("emp003","p01",10);
Insert into Workson values("emp001","p02",7);
Insert into Workson values("emp005","p03",18);
Insert into Workson values("emp003","p02",14);
Insert into Workson values("emp004","p05",12);
Insert into Workson values("emp007","p04",14);
Insert into Workson values("emp001","p05",12);


Insert into Dependent values("emp001","Raghu","M","son");
Insert into Dependent values("emp004","Reshma","F","wife");
Insert into Dependent values("emp007","Bindu","F","daughter");
Insert into Dependent values("emp009","Shaan","M","son");
Insert into Dependent values("emp003","Shamir","M","son");

/*2. Retrieve the names of the Employees who gets second highest salary. */
select name from Employee where salary in(select max(salary) from Employee 
where salary < (select max(salary) from Employee));

/*3. Retrieve the names of the Employees who have no dependents in alphabetical order.*/
select name from Employee e where not exists(select * from Dependent where essn = e.ssn) order by name;

/*4. List the names of all Employees who have at least two dependents*/
select name from Employee where (select count(*) from Dependent where ssn = essn)>=2;

/*5. Retrieve the number of Employees and their average salary working in each 
department. */
select dno, count(*),avg(salary) from Employee group by dno;

/*6. Retrieve the highest salary paid in each department in descending order. */
select dno, max(salary) from Employee group by dno order by max(salary) desc;

/*7. Retrieve the SSN of all Employees who work on atleast one of the project numbers 1, 2, 3
*/
select distinct(essn) from workson where pno in ('p01','p02','p03');

/*8. Retrieve the number of dependents for an Employee named RAM.*/
select count(*) from Employee e, dependent d where d.essn=e.ssn and e.name='Ram';

/*9. Retrieve the names of the managers working in location named xyz who has no 
female dependents.
*/
select distinct(name) from Employee e , Department d, Dept_location l, Dependent de
 where e.ssn= de.essn and de.sex!='F' and 
 de.essn=d.mgr_ssn and
 d.dnumber=l.dnumber and 
 l.dlocation='Blore';

/*10.  Retrieve the names of the Employees who works in the same department as that of RAM*/
select name from Employee
where dno = (select dno from Employee where name='Ram') and name!='Ram';


