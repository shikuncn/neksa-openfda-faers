--  import pt_soc_name





-- -----------
    select
        d2.drugname,
        count(distinct d2.caseid) as concomitant_medications_cnt
    from faers.faers_drug d1
    join faers.faers_drug d2
    on d1.caseid = d2.caseid
       and d1.primaryid = d2.primaryid
       and lower(d1.drugname) like 'ribociclib%'
       and lower(d2.drugname) not like '%ribociclib%'
       and lower(d1.role_cod) = '0'
       and lower(d2.role_cod) = '2'
    group by
        d2.drugname
    order by
        count(distinct d2.caseid) desc
    ;

DROP TABLE  if exists faers.ribo_drug_usage;
CREATE TABLE faers.ribo_drug_usage as
select primaryid, caseid
from faers.faers_drug d1
where (lower(d1.drugname) like 'ribociclib%'
        OR lower(d1.drugname) like '%kisqali%'
        OR lower(d1.prod_ai) like '%ribociclib%'
        OR lower(d1.prod_ai) like '%kisqali%'
    )
    and lower(d1.role_cod) = 'ps'
group by primaryid, caseid
;


select caseid, count(distinct primaryid) from faers.ribo_drug_usage
group by caseid having count(distinct primaryid) > 2

DROP TABLE  if exists faers.ribo_drug_usage;
CREATE TABLE faers.ribo_drug_usage as
select *
from faers.faers_drug d1
where (lower(d1.drugname) like 'ribociclib%'
        OR lower(d1.drugname) like '%kisqali%'
        OR lower(d1.prod_ai) like '%ribociclib%'
        OR lower(d1.prod_ai) like '%kisqali%'
    ) and lower(d1.role_cod) = 'ps';


DROP TABLE  if exists faers.ribo_drug_usage_non_ps;
CREATE TABLE faers.ribo_drug_usage_non_ps as
select *
from faers.faers_drug d1
where (lower(d1.drugname) like 'ribociclib%'
        OR lower(d1.drugname) like '%kisqali%'
        OR lower(d1.prod_ai) like '%ribociclib%'
        OR lower(d1.prod_ai) like '%kisqali%'
    ) and lower(d1.role_cod) != 'ps';



select count(1),count(distinct primaryid),count(distinct caseid) from faers.ribo_drug_usage;

-- --------------------
DROP TABLE if exists faers.abe_caseid_tb;
CREATE TABLE faers.abe_caseid_tb as
select primaryid, caseid
from faers.faers_drug d1
where (
    lower(d1.drugname) like '%abemaciclib%'
    OR lower(d1.prod_ai) like '%abemaciclib%'
    )
    and lower(d1.role_cod) = 'ps'
group by primaryid, caseid;

select count(1),count(distinct primaryid),count(distinct caseid) from faers.abe_caseid_tb;



-- -- Table 1 相关药品的 性别分布情况 ----
select count(1),count(distinct primaryid),count(distinct caseid) from faers.faers_demo;
select * from faers.faers_demo limit 5;
select count(distinct caseid) from faers._caseid_tb;     -- 9777 caseid

SELECT  sex, COUNT(distinct tb1.caseid) AS caseid_count
FROM
(   select  caseid, max(sex) as sex
    from faers.faers_demo
    group by caseid
) tb1
join (
        select distinct caseid
        from faers.ribo_drug_usage
) tb2
on tb1.caseid = tb2.caseid
group by sex order by sex;

-- -- 查找在drug 但是不在demo 表中的情况
SELECT *
FROM faers.abe_caseid_tb
where caseid not in那个疯子疯子一样
(   select distinct caseid
    from faers.faers_demo
)
limit 100;

select *
from faers.faers_demo
where caseid = 14166422


-------

select
    case
            when age = '无' then 'Unknown'
            when cast(age as signed) >= 0  and cast(age as signed) < 18 then '＜18'
            when cast(age as signed) >= 18 and cast(age as signed) < 29 then '18-29'
            when cast(age as signed) >= 30 and cast(age as signed) < 49 then '30-49'
            when cast(age as signed) >= 50 and cast(age as signed) < 64 then '50-64'
            when cast(age as signed) >= 65 and cast(age as signed) < 74 then '65-74'
            when cast(age as signed) > 75  and cast(age as signed) < 84 then '75-84'
            when cast(age as signed) > 75  and cast(age as signed) < 84 then '75-84'
            else age
    end as 'age',
    COUNT(distinct tb1.caseid) AS caseid_count
FROM
(
    select caseid, max(age) as age
    from faers.faers_demo
    group by caseid
) tb1
join (
        select distinct caseid
        from faers.ribo_drug_usage
) tb2
on tb1.caseid = tb2.caseid
group by 1
;



    select caseid, group_concat(age) as age
    from faers.faers_demo
    where caseid in  (
        select distinct caseid
        from faers.ribo_drug_usage
        )
    group by caseid
;
