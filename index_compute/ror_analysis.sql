--  PT 分析 --
--  step1: 对所有 报告版本(primaryid) 标记 THIS_DRUG/OTHER_DRUG
DROP table faers.ror_pt_a_b;
CREATE TABLE faers.ror_pt_a_b as
select
       if(t2.primaryid is not null, 'THIS_DRUG', 'OTHER_DRUG') as drug_name
       ,replace(t1.pt,'\\r', '') as pt
       ,count(distinct t1.primaryid) as primaryid_cnt
from faers.faers_reac t1
left join faers.ribo_drug_usage t2
on t1.primaryid = t2.primaryid
group by 1,2
;
-- ALTER table rename faers.ror_pt_a_b faers.ror_pt_DE_dE;
-- ALTER table faers.ror_pt_DE_dE  modify drug varchar(255) character set utf8mb3 collate utf8mb3_bin;
-- D： DE+De;  d: dE+dE
DROP table faers.ror_pt_D_d;
CREATE TABLE faers.ror_pt_D_d as
select
       if(t2.primaryid is not null, 'THIS_DRUG', 'OTHER_DRUG') as drug_name
       ,count(distinct t1.primaryid) as primaryid_cnt
from faers.faers_reac t1
left join faers.ribo_drug_usage t2
on t1.primaryid = t2.primaryid
group by 1
;

--
DROP TABLE  if exists faers.drug_pt_stats;
CREATE TABLE faers.drug_pt_stats as
select
     t1.drug_name, t1.pt,
     t1.primaryid_cnt as drug_event_cnt,
     coalesce(t2.primaryid_cnt,0) - t1.primaryid_cnt as drug_otherevent_cnt
from faers.ror_pt_a_b t1
left join faers.ror_pt_D_d t2
on t1.drug_name = t2.drug_name
;

DROP TABLE  if exists faers.ror_pt_abcd;
CREATE TABLE faers.ror_pt_abcd as
select pt,
       sum(if(drug_name = 'THIS_DRUG',drug_event_cnt, 0)) as a,
       sum(if(drug_name = 'THIS_DRUG',0, drug_event_cnt)) as b,
       sum(if(drug_name = 'THIS_DRUG',drug_otherevent_cnt, 0)) as c,
       sum(if(drug_name = 'THIS_DRUG',0, drug_otherevent_cnt)) as d
from faers.drug_pt_stats
group by 1
;