--1
SELECT e.FirstName, e.LastName, e.isSupervisor, e.DepartmentId, d.[Name] as 'Department Name'
FROM Employee e
LEFT JOIN Department d on e.DepartmentId = d.Id
ORDER BY d.[Name], e.LastName, e.FirstName;

--2
SELECT d.[Name], d.Budget
FROM Department d
ORDER BY d.Budget DESC;

--3
SELECT d.[Name], e.FirstName, e.LastName, e.IsSupervisor,
CASE WHEN e.IsSupervisor = 1 THEN 'TRUE' ELSE 'FALSE' END as IsSupervisor
FROM Department d
LEFT JOIN Employee e on e.DepartmentId = d.Id
WHERE e.IsSupervisor = 'True';

--4
SELECT d.[Name],  COUNT(e.Id) as 'Number of Employees'
FROM Department d
LEFT JOIN Employee e on e.DepartmentId = d.Id
GROUP BY d.[Name];

--5
UPDATE Department
SET Budget = Budget * 1.2;

--6
SELECT e.FirstName, e.LastName
FROM Employee e
LEFT JOIN EmployeeTraining et on e.Id = et.EmployeeId
WHERE et.EmployeeId IS NULL;

--7
SELECT e.FirstName, e.LastName, COUNT(et.EmployeeId) as 'Number of Training Programs'
FROM Employee e
LEFT JOIN EmployeeTraining et on e.Id = et.EmployeeId
WHERE et.EmployeeId IS NOT NULL
GROUP BY e.FirstName, e.LastName, et.EmployeeId;

--8
SELECT  t.[Name], COUNT(et.TrainingProgramId) as 'Number of Attendees'
FROM EmployeeTraining et
LEFT JOIN TrainingProgram t on t.Id = et.TrainingProgramId
GROUP BY et.TrainingProgramId, t.[Name];

--9
SELECT t.[Name]
FROM TrainingProgram t
LEFT JOIN EmployeeTraining et on et.TrainingProgramId = t.Id
GROUP BY t.[Name], t.MaxAttendees
HAVING t.MaxAttendees-COUNT(et.TrainingProgramId) < 1;

--10
SELECT t.[Name], t.StartDate
FROM TrainingProgram t
WHERE t.StartDate > GETDATE();

--11
INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId) VALUES (8, 9);
INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId) VALUES (11, 9);

--12
SELECT TOP 3 t.[Name], COUNT(et.TrainingProgramId) as 'Attendees'
FROM TrainingProgram t
LEFT JOIN EmployeeTraining et on t.Id = et.TrainingProgramId
GROUP BY t.[Name], t.Id
ORDER BY [Attendees] DESC;

--13
SELECT TOP 3 t.[Name], COUNT(et.TrainingProgramId) as 'Attendees'
FROM TrainingProgram t
LEFT JOIN EmployeeTraining et on t.Id = et.TrainingProgramId
GROUP BY t.[Name]
ORDER BY [Attendees] DESC;

--14
SELECT e.Id, e.FirstName, e.LastName
FROM Employee e
LEFT JOIN ComputerEmployee ce on ce.EmployeeId = e.Id
WHERE ce.EmployeeId IS NULL;

--15
SELECT e.FirstName, e.LastName, Coalesce(c.Make + ' ' + c.Manufacturer, 'N/A') as 'Computer Info'
FROM Employee e
LEFT JOIN ComputerEmployee ce on e.Id = ce.EmployeeId
LEFT JOIN Computer c on c.Id = ce.ComputerId
WHERE ce.UnassignDate IS NULL;

--16
SELECT c.Manufacturer, c.Make, c.PurchaseDate
FROM Computer c
WHERE c.PurchaseDate < CONVERT(datetime, '2019-07-01')
AND c.DecomissionDate IS NULL;

--17
SELECT e.FirstName, e.LastName, COUNT(ce.EmployeeId) as 'Number of Computers'
FROM Employee e
LEFT JOIN ComputerEmployee ce on ce.EmployeeId = e.Id
GROUP BY ce.EmployeeId, e.FirstName, e.LastName;

--18
SELECT pt.[Name], COUNT(pt.CustomerId) as 'Number of Customers'
FROM PaymentType pt
GROUP BY pt.[Name];

--19
SELECT TOP 10 p.Title, p.Price, CONCAT(c.FirstName, ' ', c.LastName) as Seller
FROM Product p
LEFT JOIN Customer c on p.CustomerId = c.Id
ORDER BY p.Price DESC;

--20
SELECT TOP 10 p.Title, CONCAT(c.FirstName, ' ', c.LastName) as Seller, COUNT(op.ProductId) as 'Number of Products'
FROM Product p
LEFT JOIN Customer c on p.CustomerId = c.Id
LEFT JOIN OrderProduct op on p.Id = op.ProductId
GROUP BY op.ProductId, p.Title, c.FirstName, c.LastName
ORDER BY [Number of Products] DESC;

--21
SELECT TOP 1 CONCAT(c.FirstName, ' ', c.LastName) as Customer, COUNT(o.CustomerID) as 'Order Count'
FROM Customer c
LEFT JOIN [Order] o on o.CustomerId = c.Id
GROUP BY c.FirstName, c.LastName
ORDER BY [Order Count] DESC;

--22
SELECT pt.Name, COUNT(p.Id) as 'Number of Sales'
FROM ProductType pt
LEFT JOIN Product p on p.ProductTypeId = pt.Id
LEFT JOIN OrderProduct op on op.ProductId = p.Id
GROUP BY pt.Name
ORDER BY [Number of Sales] DESC;


--23
SELECT CONCAT(c.FirstName, ' ', c.LastName) as Seller, COALESCE(SUM(p.Price), 0) as 'Total Amount Sold'
FROM Customer c
LEFT JOIN Product p on p.CustomerId = c.Id
LEFT JOIN OrderProduct op on op.ProductId = p.Id
GROUP BY c.FirstName, c.LastName
ORDER BY SUM(p.Price) DESC;





