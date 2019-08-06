select *,case when sale = 0 then 10000 else round(sales_by_day/sale , 6) end as days_of_stock
from
(select agent as user,country,product_type,region,sum(sales) as sale,sum(stock) as stock,
round(sum(sales)/30 , 6) as sales_by_day
from
(------------- Stocks
with my_stock as (select count(serial) as stock,product_type ,agent,country,region from
(select stock_id,product_id,serial,d.name as product_type,product_type_id,a.created_at,a.etat,a.user_id,split_part(b.name,' -',1) as agent,
b.tenant_id,b.locality_id,b.stock_type,c.locality as region,c.type_locality,b.name as stock_name,
case when b.tenant_id = 1 then 'Senegal'
	when b.tenant_id = 2 then 'Mali'
    when b.tenant_id = 3 then 'Nigeria'
    When b.tenant_id = 4 then 'Burkina'
    when b.tenant_id = 5 then 'Niger'
    else  'others' end as country 
from public.stocks_products
inner join (select * from public.products where etat in('recycle','Neuf'))a on product_id = a.id
inner join (select * from public.stocks)b on stock_id = b.id 
inner join(select id as id_loc,name as locality,type_locality from public.localities)c on locality_id = c.id_loc
inner join(select * from public.product_types)d on product_type_id = d.id)t2
group by 2,3,4,5),
----ACTIVATIONS
my_sales as (select count(account_id) as sales,product_type,agent,country,region from
	(select *
from account_analytics ac
inner join (select id as id_group,invoice_model,product_type_id from groups )c on c.id_group = ac.group_id
inner join (select id as id_user,concat(first_name,' ',last_name) as agent,role_id,balance as user_balance from users)a
on a.id_user = user_id
inner join (select id as id_role,name as agent_role,machine_name from roles
          -- 	where machine_name in ('agentcommercial','agent','agentpolyvalentml','pointdepaiement')
           )b on a.role_id = b.id_role
inner join(select id as prod_id,name as product_type from product_types )d on d.prod_id = c.product_type_id)t1
where created_at >= date_trunc('month', now())-interval '1 month'
and created_at < date_trunc('month', now())
group by 2,3,4,5)
select case when my_stock.stock is not null then 0 else null end as sales,my_stock.* from my_stock
union (
	select my_sales.sales,case when my_sales.sales is not null then 0 else null end as stock,
	   product_type,agent,country,region from my_sales
)
)tab
group by 1,2,3,4)tab
