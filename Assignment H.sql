
Use aaft;


Create table employees(
   emp_id int primary key,
   emp_name varchar(50),
   salary decimal(10,2)
);

Create table employee_logs(
   log_id int auto_increment primary key,
   emp_id int,
   activity varchar(100),
   log_time timestamp default current_timestamp
);

Insert into employees values
(1,'Amit',50000),
(2,'Neha',62000),
(3,'Ravi',45000),
(4,'Priya',70000);

-- 1 insert log trigger
Delimiter //
Create trigger after_employee_insert
after insert on employees
for each row
begin
   Insert into employee_logs(emp_id,activity)
   values(NEW.emp_id,'New Employee Added');
end //
Delimiter ;

Insert into employees values(5,'Rahul',52000);

-- 2 delete log trigger
Delimiter //
Create trigger after_employee_delete
after delete on employees
for each row
begin
   Insert into employee_logs(emp_id,activity)
   values(OLD.emp_id,'Employee Removed');
end //
Delimiter ;

Delete from employees
where emp_id=1;

-- 3 salary update trigger
Delimiter //
Create trigger salary_update_log
after update on employees
for each row
begin
   if OLD.salary != NEW.salary then
      Insert into employee_logs(emp_id,activity)
      values(NEW.emp_id,'Salary was updated');
   end if;
end //
Delimiter ;

Update employees set salary=65000 where emp_id=2;



-- 4 prevent negative salary
Delimiter //
Create trigger check_salary
before insert on employees
for each row
begin
   if NEW.salary < 0 then
      signal sqlstate '45000'
      set message_text='Negative salary not allowed';
   end if;
end //
Delimiter ;

-- 5 add 5 percent bonus before insert
Delimiter //
Create trigger add_bonus_salary
before insert on employees
for each row
begin
   set NEW.salary = NEW.salary + (NEW.salary*0.05);
end //
Delimiter ;

Insert into employees values(6,'Karan',40000);

-- 6 store salary changes
Delimiter //
Create trigger old_new_salary
after update on employees
for each row
begin
   if OLD.salary <> NEW.salary then
      Insert into employee_logs(emp_id,activity)
      values(
         NEW.emp_id,
         concat('salary changed from ',OLD.salary,' to ',NEW.salary)
      );
   end if;
end //
Delimiter ;

-- 7 uppercase employee name
Delimiter //
Create trigger upper_name
before insert on employees
for each row
begin
   set NEW.emp_name = upper(NEW.emp_name);
end //
Delimiter ;

Insert into employees values(7,'rohit',30000);

-- 8 stop salary decrease
Delimiter //
Create trigger no_salary_reduce
before update on employees
for each row
begin
   if NEW.salary < OLD.salary then
      signal sqlstate '45000'
      set message_text='Salary cannot be reduced';
   end if;
end //
Delimiter ;

-- 9 log name update
Delimiter //
Create trigger employee_name_change
after update on employees
for each row
begin
   if OLD.emp_name <> NEW.emp_name then
      Insert into employee_logs(emp_id,activity)
      values(NEW.emp_id,'Employee name updated');
   end if;
end //
Delimiter ;

-- 10 no empty names
Delimiter //
Create trigger empty_name_check
before insert on employees
for each row
begin
   if NEW.emp_name='' then
      signal sqlstate '45000'
      set message_text='Name should not be empty';
   end if;
end //
Delimiter ;

-- 11 high salary log
Delimiter //
Create trigger high_salary_entry
after insert on employees
for each row
begin
   if NEW.salary > 85000 then
      Insert into employee_logs(emp_id,activity)
      values(NEW.emp_id,'High salary employee inserted');
   end if;
end //
Delimiter ;

-- 12 default salary trigger
Delimiter //
Create trigger default_salary
before insert on employees
for each row
begin
   if NEW.salary is null then
      set NEW.salary = 20000;
   end if;
end //
Delimiter ;

-- 13 duplicate name restriction
Delimiter //
Create trigger duplicate_employee_name
before insert on employees
for each row
begin
   if exists(
      select * from employees
      where emp_name = NEW.emp_name
   ) then
      signal sqlstate '45000'
      set message_text='Employee already exists';
   end if;
end //
Delimiter ;

-- 14 welcome message trigger
Delimiter //
Create trigger welcome_employee
after insert on employees
for each row
begin
   Insert into employee_logs(emp_id,activity)
   values(NEW.emp_id,'Welcome to company');
end //
Delimiter ;

-- 15 add extra amount during update
Delimiter //
Create trigger extra_bonus
before update on employees
for each row
begin
   if OLD.salary <> NEW.salary then
      set NEW.salary = NEW.salary + 500;
   end if;
end //
Delimiter ;