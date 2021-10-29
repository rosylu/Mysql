WITH RECURSIVE mul(m,n) AS (
  SELECT 1, 1
  UNION ALL
  SELECT if(n=9,m+1,m), if(n=9,1,n+1)
  FROM mul WHERE m <= 9 AND n <= 9
)
SELECT *, m*n from mul where m < 10;