WITH RECURSIVE fac(n,d,q) AS (
  SELECT 999, 1, cast(999 as decimal(7,4))
  UNION ALL
  SELECT n, d+1, cast((n/(d+1)) as decimal(7,4))
  FROM fac 
  WHERE q > 1
)
SELECT n,d,q 
from fac
where q = round(q);