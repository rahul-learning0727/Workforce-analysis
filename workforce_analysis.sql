use sql_practice;
show tables;

CREATE TABLE EmployeeDetail (
EmployeeID INT NOT NULL PRIMARY KEY,
FIRSTNAME varchar (25),
LASTNAME varchar (25),
SALARY INT,
JOININGDATE DATETIME,
DEPARTMENT varchar (25),
Gender  varchar(20)
); 

desc employeedetail;
describe employeedetail;

INSERT INTO EmployeeDetail
(EmployeeID, FIRSTNAME, LASTNAME, SALARY, JOININGDATE, DEPARTMENT, Gender  ) 
VALUES
(1, 'Vikas', 'Ahlawat', 600000, '2013-02-15 11:16:28.290', 'IT','Male'),
(2, 'nikita', 'Jain', 530000, '2014-01-09 17:31:07.793', 'HR', 'Female'),
(3, 'Ashish', 'Kumar', 1000000, '2014-01-09 17:31:07.793', 'IT','Male'),
(4, 'Nikhil', 'Sharma', 480000, '2014-01-09 17:31:07.793', 'HR','Male'),
(5, 'Anish', 'Kardian', 500000, '2014-01-09 17:31:07.793', 'Payroll','Male'),
(6, 'Vipul', 'Diwan', 200000, '2014-01-09 17:31:07.793', 'Account','Male'),
(7, 'Satish', 'Kumar', 75000, '2013-02-15 11:16:28.290', 'Account','Male'),
(8, 'Geetika', 'Chauhan', 90000, '2013-02-15 11:16:28.290', 'Admin', 'Female');

CREATE TABLE ProjectDetail (
ProjectDetailID INT NOT NULL PRIMARY KEY,
EmployeeDetailID INT NOT NULL,
ProjectName varchar(200)
);

insert into ProjectDetail values
					(1,1,'Task Track'),
                    (2,1,'CLP'),
                    (3,1,'Survey Managment'),
                    (4,2,'HR Managment'),
                    (5,3,'Task Track'),
                    (6,3,'GRS'),
                    (7,3,'DDS'),
                    (8,4,'HR Managment'),
                    (9,6,'GL Management');
select * from EmployeeDetail;
select * from ProjectDetail;

                                                             -- QUERY SET-1--
-- 1) Get all unique departments from employee table --
select distinct department from EmployeeDetail;

-- 2) Highest/lowest salary from employee table --
select max(salary) from EmployeeDetail;
select min(salary) from EmployeeDetail;

-- 3) show joining date in "dd mmm yyyy" fromat ex - "15 Feb 2013" --
select JOININGDATE from EmployeeDetail;
select JOININGDATE, date_format(JOININGDATE, "%d %b %Y") from EmployeeDetail;

-- 4) show joining date in "yyyy/mm/dd" fromat ex - "2013/02/15" --
select JOININGDATE, date_format(JOININGDATE, "%Y/%m/%d") from EmployeeDetail;

-- 5) show only time part in joining date --
select JOININGDATE, Time(JOININGDATE) from EmployeeDetail;

-- 5) show only year part in joining date --
select JOININGDATE, Year(JOININGDATE) from EmployeeDetail;

-- 5) show only month part in joining date --
select JOININGDATE, monthname(JOININGDATE) from EmployeeDetail;

-- 6) show system date --
select sysdate();

-- 6) show UTC(coordinated universal time) date --
select utc_date();

                                                 -- QUERY SET-2--
                                                 
-- 1) Get the first name, current date, joining date diff b/w current date and joining date in months -- 
 select * from EmployeeDetail;
 select firstname, utc_timestamp(), joiningdate, timestampdiff(month, joiningdate, utc_timestamp()) as difference 
 from EmployeeDetail;
 
 -- 2) Get the first name, current date, joining date diff b/w current date and joining date in days -- 
  select firstname, utc_timestamp(), joiningdate, timestampdiff(Day, joiningdate, utc_timestamp()) as difference 
 from EmployeeDetail;
 
 -- 3) get all employees details from employee table whose joining year is 2013 --
 select * from EmployeeDetail
 where year(joiningdate) = 2013;
 
 -- 4) get all employees details from employee table whose joining month is Jan --
 select * from EmployeeDetail
 where date_format(joiningdate, "%b") = "Jan";
 
select date_format(joiningdate, "%b") from EmployeeDetail;
select joiningdate from EmployeeDetail;

-- 5) Get all employee details from employee table whose joining date between "2013-01-01" and "2013-12-01" --
select * from EmployeeDetail
where date(JOININGDATE) between "2013-01-01" and "2013-12-01";  # it can also work without date() function

-- 6) get how many employees in employee table --
select count(*) from EmployeeDetail;

                                                           -- QUERY SET-3--
                                                           
-- 1) select top 5 records from employee table --
select * from EmployeeDetail
order by salary desc
limit 5;

-- 2) select all with first name "vikas","ashish" and "Nikhil" --
select * from EmployeeDetail
where FIRSTNAME in ("vikas","ashish", "Nikhil");

-- 2) select all without first name "vikas","ashish" and "Nikhil" --
select * from EmployeeDetail
where FIRSTNAME not in ("vikas","ashish", "Nikhil");

-- 3) select first name from employee table after removing white spaces from right/left side  --
select rtrim(firstname) from EmployeeDetail;
select ltrim(firstname) from EmployeeDetail;

-- 4) Dislpay first name and gender as M/f ( if male then M and if female then F) --
select firstname,
case when Gender = "Male" then "M"
	 when Gender = "Female" then "F"
     end as Gender
from EmployeeDetail;

-- 5) select first name from employee table prefixxed with "hello" --
select concat("Hello", " ", firstname) as greetings
from EmployeeDetail;

-- 6) Get employee detalis from employee table whose salary > 600000 --
select * from EmployeeDetail
where salary > 600000;

-- 7) Get employee detalis from employee table whose salary < 700000 --
select * from EmployeeDetail
where salary < 700000;

-- 8) Get employee detalis from employee table whose salary between 500000 and 600000--
select * from EmployeeDetail
where salary between 500000 and 600000;

-- 9) Second highest salary from employee table --
select salary from EmployeeDetail
order by salary desc;
select max(salary) from EmployeeDetail
where salary < (select max(salary) from EmployeeDetail);

-- 10) Nth highest salary from employee table --
select max(salary) from EmployeeDetail as E1
where N-1 = (select count(E2.salary) from EmployeeDetail as E2 # here "N" means no. of highest salary
			where E2.salary > E1.salary);
            
                                                    -- QUERY SET-4 (GROUP BY & HAVING)--
			
-- 1) write a query to get department wise total salary --
select department, sum(salary) as sal from EmployeeDetail
group by department
order by sal desc;

-- 2) write a query to get department , total no. of departments and total sum of salary department wise --
select department, count(department) as no_of_dept , sum(salary) as sal 
from EmployeeDetail
group by department
order by sal desc;

-- 3) write a query to get department wise avg salary and order by salary asc --
select department, round(avg(salary),0) as sal from EmployeeDetail
group by department
order by sal;

-- 4) Write a query to fetch project name assigned to more than 1 employee --
select * from ProjectDetail;
select ProjectName, count(*) as No_of_emp
from ProjectDetail
group by ProjectName
having No_of_emp > 1;

                                                 -- QUERY SET-5 (JOINS)--
                                                 
-- 1) Get emp name, project name order by first name from employee and project table for those employees which have assigned project already.
select * from EmployeeDetail;
select * from ProjectDetail;
select firstname, lastname, ProjectName
from EmployeeDetail as ED join ProjectDetail as PD
on ED.EmployeeID = PD.EmployeeDetailID
order by firstname;

-- 2) Get emp name, project name order by first name from employee and project table for all employees even they have not assigned project.
select firstname, lastname, ProjectName
from EmployeeDetail as ED left join ProjectDetail as PD
on ED.EmployeeID = PD.EmployeeDetailID
order by firstname;

-- 3) Get emp name, project name order by first name from employee and project table for all employees if project is not assigned then display --
	-- "No Project Assigned" --
select * from EmployeeDetail;
select * from ProjectDetail;

select FIRSTNAME, ifnull(ProjectName, "No Project Assigned") as Project_Name
from EmployeeDetail as ED left join ProjectDetail as PD
on ED.EmployeeID = PD.EmployeeDetailID
order by FIRSTNAME;

-- 4) Get all project name even they have  not matching any employee id in left table, order by first name 
select FIRSTNAME, ProjectName from EmployeeDetail as ED right join ProjectDetail as PD
on ED.EmployeeID = PD.EmployeeDetailID
order by FIRSTNAME;

-- 5) get complete record emp name and project name
select FIRSTNAME, ProjectName from EmployeeDetail as ED left join ProjectDetail as PD
on ED.EmployeeID = PD.EmployeeDetailID
union all
select FIRSTNAME, ProjectName from EmployeeDetail as ED right join ProjectDetail as PD
on ED.EmployeeID = PD.EmployeeDetailID
order by FIRSTNAME;

-- 6) get complete record emp name and project name if not record matching found the show NULL
select FIRSTNAME, ProjectName from EmployeeDetail as ED left join ProjectDetail as PD
on ED.EmployeeID = PD.EmployeeDetailID
union all
select FIRSTNAME, ProjectName from EmployeeDetail as ED right join ProjectDetail as PD
on ED.EmployeeID = PD.EmployeeDetailID
where isnull(ProjectName) = True
order by FIRSTNAME;

-- 7) write a query to find out the project names which is not assigned to any employee --
select distinct ProjectName, ifnull(FIRSTNAME, "Not Assigned") from EmployeeDetail as ED right join ProjectDetail as PD
on ED.EmployeeID = PD.EmployeeDetailID
where FIRSTNAME = "Not Assigned";

-- 8) write query to fetch emp name and project who has assigned more than 1 project --
select * from ProjectDetail;
select EmployeeID, FIRSTNAME, ProjectName from EmployeeDetail as ED join ProjectDetail as PD
on ED.EmployeeID = PD.EmployeeDetailID
where EmployeeDetailID in (select EmployeeDetailID from ProjectDetail
							group by EmployeeDetailID having count(*) >1);

select EmployeeDetailID, count(*) from ProjectDetail   # subquery
group by EmployeeDetailID
having count(*) > 1;

-- 9) write down the query to fetch project name on which more than one employee are working along with employee name
select ProjectName, EmployeeID from EmployeeDetail as ED join ProjectDetail as PD
on ED.EmployeeID = PD.EmployeeDetailID
where PD.ProjectName in (select ProjectName from ProjectDetail
							group by ProjectName having count(*) >1);	
                            
                            
                                -- QUERY SET-6 (IMPORTANT QUESTIONS)--
/* 
1) FIND Nth HIGHEST SALARY
2) SQL QUERY TO GET ORGANIZATION HIERARCHY
3) DELET DUPLICATE ROWS IN SQL
4) FIND EMPLOYEES HIRED IN LAST N M0NTHS
5) TRANSFORM ROWS INTO COLUMN
6) QUERY TO FIND ROWS THAT CONTAIN ONLY NUMERICAL DATA
7) QUERY TO FIND DEPARTMENT WITH HIGHEST NUMBER OF EMPLOYEES 
8) DIFFERENCE BETWEEN INNER AND LEFT JOIN
9) JOIN 3 TABLES IN SQL
*/

Create table Employees
(
     ID int primary key auto_increment,
     FirstName varchar(50),
     LastName varchar(50),
     Gender varchar(50),
     Salary int
);
Insert into Employees values (1,'Ben', 'Hoskins', 'Male', 70000),
							 (2,'Mark', 'Hastings', 'Male', 60000),
                             (3,'Steve', 'Pound', 'Male', 45000),
                             (4,'Ben', 'Hoskins', 'Male', 70000),
                             (5,'Philip', 'Hastings', 'Male', 45000),
                             (6,'Mary', 'Lambeth', 'Female', 30000),
                             (7,'Valarie', 'Vikings', 'Female', 35000),
                             (8,'John', 'Stanmore', 'Male', 80000);
select * from employees;
-- 1) FIND Nth HIGHEST SALARY --
select ID, max(distinct salary) from employees e1
where N-1 = ( select count(distinct e2.salary) from employees as e2
			where e2.salary > e1.salary);
            
select ID, max(distinct salary) as sal from employees e1
where 3-1 = ( select count(distinct e2.salary) from employees as e2
			where e2.salary > e1.salary);