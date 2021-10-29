WITH RECURSIVE nei(c1, c2, distance, rel, rel_cnt) AS (
	select a1.c1 as c1, a2.c1 as c2, ROUND(ST_Distance_Sphere(a1.location, a2.location) * .000621371192, 2) as distance, 
		cast(concat(a1.c1, ',' ,a2.c1) as char(200)) as rel, 1
	from(
		SELECT c.customer_id as c1, a.location
		FROM sakila.customer c, sakila.address a
		where c.address_id = a.address_id and ST_X(a.location) > -180 and ST_X(a.location) <= 180 and ST_Y (a.location) <= 90
		) a1, (
		SELECT c.customer_id as c1, a.location
		FROM sakila.customer c, sakila.address a
		where c.address_id = a.address_id and ST_X(a.location) > -180 and ST_X(a.location) <= 180 and ST_Y (a.location) <= 90
		) a2
	where a1.c1 < a2.c1  and if(
    (ST_X(a2.location) > -180 and ST_X(a2.location) <= 180 and ST_Y (a2.location) <= 90),
    ROUND(ST_Distance_Sphere(a1.location, a2.location) * .000621371192, 2),
    0
	) > 0 and if(
    (ST_X(a2.location) > -180 and ST_X(a2.location) <= 180 and ST_Y (a2.location) <= 90),
    ROUND(ST_Distance_Sphere(a1.location, a2.location) * .000621371192, 2),
    0
	) < 20
    
	UNION ALL
    
	Select nei.c1, ori_nei.c2, nei.distance + ori_nei.distance,
		concat(nei.rel, ',', ori_nei.c2), nei.rel_cnt+1
    from ( 
		select a1.c1 as c1, a2.c1 as c2, ROUND(ST_Distance_Sphere(a1.location, a2.location) * .000621371192, 2) as distance 
		from(
			SELECT c.customer_id as c1, a.location
			FROM sakila.customer c, sakila.address a
			where c.address_id = a.address_id and ST_X(a.location) > -180 and ST_X(a.location) <= 180 and ST_Y (a.location) <= 90
			) a1, (
			SELECT c.customer_id as c1, a.location
			FROM sakila.customer c, sakila.address a
			where c.address_id = a.address_id and ST_X(a.location) > -180 and ST_X(a.location) <= 180 and ST_Y (a.location) <= 90
			) a2
		where a1.c1 <> a2.c1  and if(
		(ST_X(a2.location) > -180 and ST_X(a2.location) <= 180 and ST_Y (a2.location) <= 90),
		ROUND(ST_Distance_Sphere(a1.location, a2.location) * .000621371192, 2),
		0
		) > 0 and if(
		(ST_X(a2.location) > -180 and ST_X(a2.location) <= 180 and ST_Y (a2.location) <= 90),
		ROUND(ST_Distance_Sphere(a1.location, a2.location) * .000621371192, 2),
		0
		) < 20
	) ori_nei, nei 
    where nei.c2 = ori_nei.c1 and ori_nei.c2 > nei.c2 and not find_in_set(ori_nei.c2, nei.rel)
) 
select c1, c2 ,min(distance) as distance
from(
	select * from nei n1 where not exists (
		select * 
		from nei n2
		where find_in_set(n1.c1, n2.rel) and  find_in_set(n1.c2, n2.rel) and n1.c1 <> n2.c1
	)
) final_nei
group by c1, c2
order by c1, c2
;