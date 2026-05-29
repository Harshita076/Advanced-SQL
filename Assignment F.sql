use aaft;

-- 1. Function to find square
DELIMITER //
CREATE FUNCTION square_num(n INT)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN n * n;
END //
DELIMITER ;

Select square_num(6);

-- 2. Function to find cube
Delimiter //
Create Function cube_num(n Int)
Returns Int
Deterministic
Begin
      Return n*n*n;
End //
Delimiter ;

Select cube_num(6);
-- 3. Function to check enven or odd
Delimiter //
Create Function even_odd(n Int)
Returns Varchar(10)
Deterministic
Begin
       Return If (n % 2 = 0, "Even","Odd");
End //
Delimiter ;

Select even_odd(7800);

-- 4. Function to Convert Uppercase
Delimiter //
Create Function upper_case(str Varchar(100))
Returns Varchar(100)
Deterministic
Begin
      Return Upper(str);
End //
Delimiter ;

Select upper_case("Harshita");

-- 5.Function to Find Length of String
Delimiter //
Create Function string_length(str Varchar(150))
Returns Int 
Deterministic
Begin
      Return Length(str);
End //
Delimiter ;

Select string_length("Nevertheless");

-- 6. Function to Reverse String
Delimiter //
Create Function reverse_str(str Varchar(100))
Returns Varchar(100)
Deterministic 
Begin
      Return Reverse(str);
End //
Delimiter ;

Select reverse_str("Monkey");

 -- 7. Function to find greatest number
 Delimiter //
 Create function greatest_number(a Int,b Int)
 Returns Int 
 Deterministic
 Begin
       return If(a>b,a,b);
ENd //
Delimiter ;
 
 Select greatest_number(78,46);
 
 -- 8. Function to add two number
 Delimiter //
 Create function add_num(a Int,b Int)
 Returns Int 
 Deterministic
 Begin 
      Return a+b;
End //
Delimiter ;
 
 Select add_num(66,72);
 
-- 9 Factorial of a Number Function
Delimiter //
create function factorial(n Int)
Returns Int
Deterministic
Begin
declare i int default 1;
declare fact int default 1;

While i<=n do
set fact=fact*i;
set i=i+1;
End while;
Return fact;
End //
Delimiter ;

Select factorial(4);

-- 10. Count Vowels in a String Function
Create Function count_vowels(str Varchar(100))
Returns Int
Deterministic
Return 
(length(lower(str)) - length(replace(lower(str),'a','')))
+
(length(lower(str)) - length(replace(lower(str),'e','')))
+
(length(lower(str)) - length(replace(lower(str),'i','')))
+
(length(lower(str)) - length(replace(lower(str),'o','')))
+
(length(lower(str)) - length(replace(lower(str),'u','')));

Select count_vowels('Command');

 
 