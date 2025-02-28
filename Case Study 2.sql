SELECT * FROM Employee;
SELECT * FROM Department;
SELECT * FROM Job;
SELECT * FROM Location;
SELECT FirstName, LastName, Salary, Commission FROM Employees;
SELECT EmployeeID AS "ID of the Employee", LastName AS "Name of the Employee", DepartmentID AS Dep_id FROM Employees;
SELECT CONCAT(FirstName, ' ', LastName) AS EmployeeName, Salary * 12 AS AnnualSalary FROM Employees;
-----------------------------
SELECT * FROM Employee WHERE LAST_NAME = 'Smith';
SELECT * FROM Employee WHERE DepartmentID = 20;
SELECT * FROM Employee WHERE Salary BETWEEN 2000 AND 3000;
SELECT * FROM Employee WHERE DepartmentID IN (10, 20);
SELECT * FROM Employee WHERE DepartmentID NOT IN (10, 30);
SELECT * FROM Employee WHERE FirstName LIKE 'L%';
SELECT * FROM Employee WHERE FirstName LIKE 'L%' AND LastName LIKE '%E';
SELECT * FROM Employee WHERE LENGTH(FirstName) = 4 AND FirstName LIKE 'J%';
SELECT * FROM Employee WHERE DepartmentID = 30 AND Salary > 2500;
SELECT * FROM Employee WHERE Commission IS NULL;
--------------------------------------------------
SELECT EmployeeID, LastName FROM Employees ORDER BY EmployeeID ASC;
SELECT EmployeeID, CONCAT(FirstName, ' ', LastName) AS Name FROM Employees ORDER BY Salary DESC;
SELECT * FROM Employees ORDER BY LastName ASC;
SELECT * FROM Employees ORDER BY LastName ASC, DepartmentID DESC;
-----------------------------------------------
SELECT DepartmentID, MAX(Salary) AS MaxSalary, MIN(Salary) AS MinSalary, AVG(Salary) AS AvgSalary 
FROM Employees 
GROUP BY DepartmentID;

SELECT JobID, MAX(Salary) AS MaxSalary, MIN(Salary) AS MinSalary, AVG(Salary) AS AvgSalary 
FROM Employees 
GROUP BY JobID;

SELECT MONTH(HireDate) AS Month, YEAR(HireDate) AS Year, COUNT(*) AS NumEmployees 
FROM Employees 
GROUP BY MONTH(HireDate), YEAR(HireDate) 
ORDER BY Year, Month;

SELECT MONTH(HireDate) AS Month, YEAR(HireDate) AS Year, COUNT(*) AS NumEmployees 
FROM Employees 
GROUP BY YEAR(HireDate), MONTH(HireDate) 
ORDER BY Year, Month;

SELECT DepartmentID 
FROM Employees 
GROUP BY DepartmentID 
HAVING COUNT(*) >= 4;

SELECT COUNT(*) AS NumEmployees 
FROM Employees 
WHERE MONTH(HireDate) = 2;

SELECT COUNT(*) AS NumEmployees 
FROM Employees 
WHERE MONTH(HireDate) IN (5, 6);

SELECT COUNT(*) AS NumEmployees 
FROM Employees 
WHERE YEAR(HireDate) = 1985;

SELECT MONTH(HireDate) AS Month, COUNT(*) AS NumEmployees 
FROM Employees 
WHERE YEAR(HireDate) = 1985 
GROUP BY MONTH(HireDate);

SELECT COUNT(*) AS NumEmployees 
FROM Employees 
WHERE YEAR(HireDate) = 1985 AND MONTH(HireDate) = 4;

SELECT DepartmentID 
FROM Employees 
WHERE YEAR(HireDate) = 1985 AND MONTH(HireDate) = 4 
GROUP BY DepartmentID 
HAVING COUNT(*) >= 3;

---------------------------------------------
SELECT Employee.*, Department.Name
FROM Employee
INNER JOIN Department ON Employee.DEPARTMENT_ID = Department.Department_Id;

SELECT Employees.*, Jobs.JobTitle
FROM Employees
INNER JOIN Jobs ON Employees.JobID = Jobs.JobID;

SELECT Employees.*, Departments.DepartmentName, Locations.City
FROM Employees
INNER JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID
INNER JOIN Locations ON Departments.LocationID = Locations.LocationID;

SELECT Departments.DepartmentName, COUNT(*) AS NumEmployees
FROM Employees
INNER JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID
GROUP BY Departments.DepartmentName;

SELECT COUNT(*) AS NumEmployees
FROM Employees
INNER JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID
WHERE Departments.DepartmentName = 'Sales';

SELECT Departments.DepartmentName
FROM Employees
INNER JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID
GROUP BY Departments.DepartmentName
HAVING COUNT(*) >= 3
ORDER BY Departments.DepartmentName ASC;

SELECT COUNT(*) AS NumEmployees
FROM Employees
INNER JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID
INNER JOIN Locations ON Departments.LocationID = Locations.LocationID
WHERE Locations.City = 'Dallas';

SELECT Employees.*, Departments.DepartmentName
FROM Employees
INNER JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID
WHERE Departments.DepartmentName IN ('Sales', 'Operations');
--------------------------------------------

SELECT EmployeeID, FirstName, LastName, Salary,
    CASE
        WHEN Salary < 2000 THEN 'Grade A'
        WHEN Salary >= 2000 AND Salary < 4000 THEN 'Grade B'
        WHEN Salary >= 4000 AND Salary < 6000 THEN 'Grade C'
        ELSE 'Grade D'
    END AS Grade
FROM Employees;

SELECT
    CASE
        WHEN Salary < 2000 THEN 'Grade A'
        WHEN Salary >= 2000 AND Salary < 4000 THEN 'Grade B'
        WHEN Salary >= 4000 AND Salary < 6000 THEN 'Grade C'
        ELSE 'Grade D'
    END AS Grade,
    COUNT(*) AS NumEmployees
FROM Employee
GROUP BY Grade;

SELECT
    CASE
        WHEN Salary >= 2000 AND Salary <= 5000 THEN 'Grade B'
        ELSE 'Other'
    END AS Grade,
    COUNT(*) AS NumEmployees
FROM Employee
GROUP BY Grade;
-----------------------------------
SELECT *
FROM Employees
WHERE Salary = (SELECT MAX(Salary) FROM Employees);

SELECT *
FROM Employee
WHERE DEPARTMENT_ID = (SELECT Department_Id FROM Department WHERE Name = 'Sales');

SELECT *
FROM Employees
WHERE JobID = (SELECT JobID FROM Jobs WHERE JobTitle = 'Clerk');

SELECT *
FROM Employees
WHERE LocationID = (SELECT LocationID FROM Locations WHERE City = 'Boston');

SELECT COUNT(*)
FROM Employees
WHERE DepartmentID = (SELECT DepartmentID FROM Departments WHERE DepartmentName = 'Sales');

UPDATE Employees
SET Salary = Salary * 1.10
WHERE JobID = (SELECT JobID FROM Jobs WHERE JobTitle = 'Clerk');

SELECT *
FROM Employee
WHERE Salary = (
    SELECT MAX(Salary)
    FROM Employee
    WHERE Salary < (
        SELECT MAX(Salary)
        FROM Employee
    )
);

SELECT *
FROM Employees
WHERE Salary > ALL (
    SELECT Salary
    FROM Employees
    WHERE DepartmentID = 30
);

SELECT Department_Id
FROM Department
WHERE Department_Id NOT IN (
    SELECT Department_ID
    FROM Employee
);

SELECT *
FROM Employees e
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employees
    WHERE DepartmentID = e.DepartmentID
);
