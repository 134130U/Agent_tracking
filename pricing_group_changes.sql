with first_tab as (with prev as (select *
from account_pricing_groups a
where a.created_at not in(select max(created_at) from account_pricing_groups group by account_slug)
)
select gr.account_id, gr.account_slug,g.name as prev_group_name from account_pricing_groups gr,groups g
where gr.created_at in (select max(created_at) from prev group by account_slug) and g.id = gr.group_id),
last_tab as (select a.*,g.name as group_name
from account_pricing_groups a, groups g
where a.created_at in(select max(created_at) from account_pricing_groups
					  group by account_slug) and g.id = a.group_id) 
select last_tab.account_id,last_tab.account_number,last_tab.account_slug,
last_tab.created_at,last_tab.group_name,first_tab.prev_group_name,a.total_payed,a.country 
from first_tab,last_tab,account_analytics a
where first_tab.account_slug =last_tab.account_slug and last_tab.account_slug = a.slug
and last_tab.group_name !=prev_group_name
limit 100