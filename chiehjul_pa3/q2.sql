WITH RECURSIVE seq(n,f, f_1) AS (
  SELECT 0, 0, 0
  UNION ALL
  SELECT n+1, if(n+1>1,if((f)%2=0,f+f_1+1,f+f_1),n+1), if(n+1>1,f,n)
  FROM seq WHERE f < 100
)
SELECT n,f as 'f(n)' from seq WHERE f < 100;