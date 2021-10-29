WITH RECURSIVE fli(src, dst, cost, dir, stop_cnt) AS (
	SELECT src, dst, cost, concat(dst), 1 FROM pa3.amap
	UNION ALL
	Select fli.src, ori_fli.dst, fli.cost+ori_fli.cost, concat(fli.dir, ',', ori_fli.dst), fli.stop_cnt+1
    from ( SELECT * FROM pa3.amap) ori_fli, fli 
    where fli.dst = ori_fli.src and not find_in_set(ori_fli.dst, fli.dir) and fli.stop_cnt < 2 and fli.src <> ori_fli.dst
)
SELECT src, dst, min(cost) as cost from fli 
group by src, dst
order by src, dst;