use aaft;
Create Table employee(
emp_id INT PRIMARY KEY Auto_Increment,
emp_name VARCHAR(50),
department VARCHAR(50),
salary DECIMAL(10,2));

Insert into employee(emp_name,department,salary)
Values
("Sonali","HR",35000),
("Priyanshi","IT",45000),
("Rahul","HR",46000),
("Rimsha","Finance",46000),
("Kaveri","Finance",60000),
("Puneet","IT",50000);

-- 1. Procedure to Show All Employee Details
Delimiter //
Create Procedure show_all_employees()
Begin
     Select * from employee;
End//
Delimiter ;

Call show_all_employees();

-- 2. Procedure to Fetch Employees from Specific Department
Delimiter //
Create Procedure get_employee_byDepartment(In dept_name Varchar(50))	
Begin 
      Select * 
      from employee 
      where department = dept_name;
End //
delimiter ;

-- Call get_employee_byDepartment("IT");

-- 3. Procedure to Increase Salary by Given Percentage for a Department

Delimiter //
Create Procedure salary_increment( In dept_name Varchar(50),IN percent_increase Decimal(5,2))
Begin
      Update employees
      Set salary= salary +(salary*percent_increase/100)
      where department = dept_name ;
End //
Delimiter ;

Call  salary_increment(2.5);

-- 4. Procedure to Return Total Salary of All Employees
Delimiter //
Create Procedure total_salary()
Begin 
      Select sum(salary) as total_salary 
      from employee;
End //
Delimiter ;

Call total_salary(); 

-- 5. Procedure to Insert New Employee
Delimiter //
Create Procedure insert_employee( IN employee_name Varchar(50),In dept Varchar(50),IN emp_salary decimal(10,2))
Begin 
      Insert into employee(emp_name,department,salary)
      Values(employee_name,dept,emp_salary);
End //
Delimiter ;
      
Call insert_employee("Harshita","HR",60000);

-- 6. Procedure to Delete Employee by ID
Delimiter //
Create Procedure delete_employee(IN e_id int)
Begin
      Delete from employee
      where emp_id = e_id;
End //
Delimiter ;

Call delete_employee(7);

-- Procedure to Return Average Salary
Delimiter //
Create Procedure Average_salary()
Begin 
      Select avg(salary) as avg_salary
      from employee;
End //
Delimiter ;

Call Average_salary();

-- 8. Procedure to Get Employees Above a Salary
Delimiter //
Create Procedure employee_aboveSalary(In min_salary Decimal(10,2))
Begin 
       Select *
       from employee
       where salary>min_salary;
End //
Delimiter ;

Call employee_aboveSalary(50000);

-- 9. Procedure to Get Highest Salary
Delimiter //
Create Procedure Highest_salary()
Begin
      Select max(salary) as Highest_Salary
      from employee;
End //
Delimiter ;

Call Highest_salary();

-- 10. Procedure to Update Employee Name
Delimiter //
Create Procedure Update_employeeName(IN e_id INt , IN new_name Varchar(50))
Begin 
      Update employee
      set emp_name = new_name
      where emp_id = e_id;
End //
Delimiter ;

Call Update_employeeName(2,"Priyanshi Verma");
 select * from employee;
