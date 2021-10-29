WITH RECURSIVE fli(src, dst, dir) AS (
	SELECT src, dst, concat(dst) FROM pa3.amap
	UNION ALL
	Select fli.src, ori_fli.dst, concat(fli.dir, ',', ori_fli.dst)
    from ( SELECT * FROM pa3.amap) ori_fli, fli 
    where fli.dst = ori_fli.src and not find_in_set(ori_fli.dst, fli.dir)
)
SELECT  src, dst from fli 
group by src, dst
order by src, dst;