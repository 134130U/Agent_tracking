select *
from account_pricing_groups a
where a.created_at in(select min(created_at) from account_pricing_groups group by account_slug)
order by created_at asc
limit 100