with created as (select created_at::date,country,region,count(ticket_id) as Total_tickets 
from (select tickets.id as ticket_id,assigned_to,type_ticket,tickets.status as user_action,tickets.created_at,
tickets.account_id,tickets.user_id,solved_at,b.account_number,b.status,b.group_name,b.country,b.region
from public.tickets
inner join (select accounts.id as account_id,account_number,status,user_id,group_id,d.group_name,
accounts.slug,register_by,day_disabled,written_off,written_off_at,expected_total_amount,id_client,a.id_tenant,
commune,region, case when a.id_tenant = 1 then 'Senegal'
             when a.id_tenant = 2 then 'Mali'
             when a.id_tenant = 3 then 'Nigeria'
            when a.id_tenant = 4 then 'Burkina'
            when a.id_tenant = 5 then 'Niger' end as country,
    case when status = 0 then 'Active'
        when status = 1 then 'Deactive'
        when status = 2 then 'Amorti'
        when status = 3 then 'Replaced'
        when status = 4 then 'Unlocked'
        when status = 5 then 'Detached' end as account_status
from accounts
inner join (select id as id_client,region_id,commune_id,village_id,
            id_tenant,locality_id from customers)a on customer_id = a.id_client
inner join (select * from localities
           inner join (select id as id_loc1,locality_id as loc_id1,name as commune,type_locality
                       from localities)b1
            on b1.id_loc1 = locality_id
            inner join (select id as id_loc2,locality_id as loc_id1,name as region,type_locality 
                   from localities)b2
            on b2.id_loc2 = b1.loc_id1
           )b on a.locality_id = b.id

inner join    (select id,name as group_name from groups where name not like 'TEST%'
            and name not like 'Test%')d on
            d.id=group_id where written_off is false)b on tickets.account_id= b.account_id
			where type_ticket in ('Ticket technique','Reposséder')
)tab
group by 1,2,3) , 
solved as (select solved_at::date,country,region,count(ticket_id) as solved_tickets 
from (select tickets.id as ticket_id,assigned_to,type_ticket,tickets.status as user_action,tickets.created_at,
tickets.account_id,tickets.user_id,solved_at,b.account_number,b.status,b.group_name,b.country,b.region
from public.tickets
inner join (select accounts.id as account_id,account_number,status,user_id,group_id,d.group_name,
accounts.slug,register_by,day_disabled,written_off,written_off_at,expected_total_amount,id_client,a.id_tenant,
commune,region, case when a.id_tenant = 1 then 'Senegal'
             when a.id_tenant = 2 then 'Mali'
             when a.id_tenant = 3 then 'Nigeria'
            when a.id_tenant = 4 then 'Burkina'
            when a.id_tenant = 5 then 'Niger' end as country,
    case when status = 0 then 'Active'
        when status = 1 then 'Deactive'
        when status = 2 then 'Amorti'
        when status = 3 then 'Replaced'
        when status = 4 then 'Unlocked'
        when status = 5 then 'Detached' end as account_status
from accounts
inner join (select id as id_client,region_id,commune_id,village_id,
            id_tenant,locality_id from customers)a on customer_id = a.id_client
inner join (select * from localities
           inner join (select id as id_loc1,locality_id as loc_id1,name as commune,type_locality
                       from localities)b1
            on b1.id_loc1 = locality_id
            inner join (select id as id_loc2,locality_id as loc_id1,name as region,type_locality 
                   from localities)b2
            on b2.id_loc2 = b1.loc_id1
           )b on a.locality_id = b.id

inner join    (select id,name as group_name from groups where name not like 'TEST%'
            and name not like 'Test%')d on
            d.id=group_id where written_off is false)b on tickets.account_id= b.account_id
			where type_ticket in ('Ticket technique','Reposséder') 
	  and tickets.status in ('cloturer','customer_paid','résolu')
)tab
group by 1,2,3)
select solved_at as dates,country,region,solved_tickets,
			  case when solved.solved_tickets is not null then 0 else null end as total_tickets from solved
union (select created_at,country,region,
	   case when created.total_tickets is not null then 0 else null end as solved_tickets,total_tickets from created)
