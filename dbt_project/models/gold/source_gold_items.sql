with dedup_query as 
(
select 
*,
row_number() over(partition by id order by updateDate desc) as dedup_id
from
{{ source('source', 'items') }}
)

select 
id,
name,
category,
updateDate
from 
dedup_query
where 
dedup_id = 1