CREATE TABLE [table] (
  ID int IDENTITY(1,1) PRIMARY KEY,
  Title nvarchar(20),
  Date date,
  Amount money
);
INSERT INTO [table] (Title, Date, Amount)
VALUES ('Cust A', '2021-01-01', 2.00),
       ('Cust A', '2021-01-05', 3.00),
       ('Cust A', '2021-02-01', 5.00),
        ('Cust A', '2021-02-05', 5.00),
         ('Cust A', '2021-03-01', 5.00),
        ('Cust A', '2021-03-05', 5.00);
       


-- Accepted answer that produces wrong results       
Select t.title, t.Date, 
  Sum(y.Amount) YTD,
  Sum(m.Amount) MTD
From [table] t
   join [table] y
      on y.Title = t.Title
         and datediff(year, y.Date, t.Date) = 0 
         and y.Date <= t.Date
   join [table] m
      on m.Title = t.Title
         and datediff(month, m.Date, t.Date) = 0 
         and m.Date <= t.Date
Group by t.title, t.Date;

-- Accepted answer with aggregation removed to show where it goes wrong
Select t.title, t.Date, y.Date, m.Date,
  y.Amount,
  m.Amount
From [table] t
   join [table] y
      on y.Title = t.Title
         and datediff(year, y.Date, t.Date) = 0 
         and y.Date <= t.Date
   join [table] m
      on m.Title = t.Title
         and datediff(month, m.Date, t.Date) = 0 
         and m.Date <= t.Date
Order by t.title, t.Date, y.Date, m.Date;

-- Second answer that produces wrong results
SELECT ID,
       Title,
       Date,
       Amount,
       MTD  = SUM(Amount) OVER (PARTITION BY Title, DATEADD(MONTH, DATEDIFF(MONTH, 0, [Date]), 0)),
       YTD  = SUM(Amount) OVER (PARTITION BY Title, DATEADD(YEAR, DATEDIFF(YEAR, 0, [Date]), 0))
FROM   [table];

-- Possilbe solution. produces right results
Select t.title, t.Date, 
  (Select Sum(Amount) from [table] where Title = t.Title and datediff(year, Date, t.Date) = 0 and Date <= t.Date) as YTD,
  (Select Sum(Amount) from [table] where Title = t.Title and datediff(month, Date, t.Date) = 0 and Date <= t.Date) as MTD
From [table] t;

-- Solution based on the accepted answer, produces correct results
Select a.title, a.Date, 
  Sum(Case When datediff(year, b.Date, a.Date) = 0 Then b.Amount Else 0 End) YTD,
  Sum(Case When datediff(month, b.Date, a.Date) = 0 Then b.Amount Else 0 End) MTD
From [table] a
   join [table] b
      on a.Title = b.Title
         and b.Date <= a.Date
Group by a.title, a.Date
;

-- Second version of the solution based on the accepted answer
Select t.title, t.Date, 
  Sum(y.Amount) YTD,
  Sum(Case When datediff(month, y.Date, t.Date) = 0 Then y.Amount Else 0 End) MTD
From [table] t
   join [table] y
      on t.Title = y.Title
         and datediff(year, y.Date, t.Date) = 0
         and y.Date <= t.Date
Group by t.title, t.Date
