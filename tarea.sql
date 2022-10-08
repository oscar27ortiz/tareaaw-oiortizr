USE AdventureWorks2019
GO
--1) Cree una vista de las que muestre un listado de los productos descontinuados.Los productos (Production.Product) descontinuados son aquellos cuyo valor en DiscontinuedDate es distinto de NULL--

CREATE VIEW Production.ProductDiscontinued
AS
SELECT ProductID,Name
FROM Production.Product
WHERE DiscontinuedDate = NULL 
GO

SELECT *
FROM Production.ProductDiscontinued
GO

--2)Crea una vista que muestre un listado de productos (Production.Product) activos con sus respectivas categorías (Production.ProductCategory), subcategorías (Production.ProductSubcategory) y modelo (Production.ProductModel). Deben mostrarse todos los productos activos aunque no tengan modelo asociado.

CREATE VIEW Production.ProductActive
AS
SELECT p.ProductID, p.Name AS Producto, p.ProductModelID, m.Name AS Modelo, s.ProductSubcategoryID, s.Name AS Subcategoria, 
c.ProductCategoryID, c.Name AS Categoria 
FROM Production.Product p
FULL JOIN Production.ProductModel m ON p.ProductModelID = m.ProductModelID
LEFT JOIN Production.ProductSubcategory s ON s.ProductSubcategoryID = p.ProductSubcategoryID
LEFT JOIN Production.ProductCategory c ON c.ProductCategoryID = s.ProductCategoryID
GO

SELECT *
FROM Production.ProductActive
GO

--3)Crea una consulta que obtenga los datos generales de los empleados (HumanResources.Employee) del departamento (HumanResources.Department) ‘Document Control’.

SELECT p.BusinessEntityID, p.FirstName, p.LastName, h.DepartmentID, d.Name
FROM Person.Person p
INNER JOIN HumanResources.Employee e ON p.BusinessEntityID = e.BusinessEntityID
INNER JOIN HumanResources.EmployeeDepartmentHistory h ON e.BusinessEntityID = h.BusinessEntityID
INNER JOIN HumanResources.Department d ON h.DepartmentID = d.DepartmentID
Go


--4)Crea un procedimiento almacenado que obtenga los datos generales de los empleados por departamento.

CREATE PROCEDURE HumanResources.EmployeeDepartment
	@DepartmentId INT = NULL
AS
	SELECT p.BusinessEntityID AS ID, p.FirstName AS Nombre, p.LastName AS Apellido, 
	e.BirthDate, e.Gender, h.DepartmentID AS IdDepartamento, d.Name AS Departamento
	FROM Person.Person p
	INNER JOIN HumanResources.Employee e ON p.BusinessEntityID = e.BusinessEntityID
	INNER JOIN HumanResources.EmployeeDepartmentHistory h ON e.BusinessEntityID = h.BusinessEntityID
	INNER JOIN HumanResources.Department d ON h.DepartmentID = d.DepartmentID
	WHERE @DepartmentId IS NULL OR @DepartmentId = d.DepartmentID
	ORDER BY d.DepartmentID ASC
GO

EXECUTE HumanResources.EmployeeDepartment
GO

--5) Crea un procedimiento que obtenga lista de cumpleañeros del mes ordenados alfabéticamente por el primer apellido y por el nombre del departamento, si no se especifica DepartmentID entonces deberá retornar todos los datos.


--6) Crea un procedimiento que obtenga la cantidad de empleados por departamento ordenados por nombre de departamento, si no se especifica DepartmentID entonces deberá retornar todos los datos.

CREATE PROCEDURE HumanResources.NumberEmployeesDepartament

	 @DepartmentId INT = NULL

AS
	SELECT COUNT (d.DepartmentID) AS CantidadEmpleados 
	FROM Person.Person p
	INNER JOIN HumanResources.Employee e ON p.BusinessEntityID = e.BusinessEntityID
	INNER JOIN HumanResources.EmployeeDepartmentHistory h ON e.BusinessEntityID = h.BusinessEntityID
	INNER JOIN HumanResources.Department d ON h.DepartmentID = d.DepartmentID
	WHERE @DepartmentId IS NULL OR @DepartmentId = d.DepartmentID 
	
GO


EXEC HumanResources.NumberEmployeesDepartament
Go

