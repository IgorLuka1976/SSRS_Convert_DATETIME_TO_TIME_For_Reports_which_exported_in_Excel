----Important
USE AdventureWorks2019
GO

-----------SSRS case, where Secods>=86400 seconds or Hours>=24 

;WITH #time
AS
(
SELECT 
       BusinessEntityID
      ,NationalIDNumber
      ,LoginID
      ,JobTitle
      ,BirthDate
	  ,DATEDIFF(SECOND, CONVERT(date, ModifiedDate), ModifiedDate) AS Date
	  ,CONVERT(TIME(0),ModifiedDate) AS ConvertDateToTime
  FROM HumanResources.Employee
  WHERE CONVERT(TIME(0),ModifiedDate)>'00:00:00'
 )
 SELECT 
     SUM(t.Date) OVER() AS SumBySeconds
	,t.ConvertDateToTime AS SumByTime
 FROM #time t
 

