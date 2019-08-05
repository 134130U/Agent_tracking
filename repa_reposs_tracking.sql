select country,region,solved_at,agent,written_off,account_number,user_action,
ticket_id,agent_role, product,type_ticket,commune,
case when id_tenant = 1 and tb.duree_resolution <= 3 and product = 'Pico' and type_ticket = 'Ticket technique'
					and user_action in('cloturer','résolu') then 'Pico a temps'
		when id_tenant = 1 and tb.duree_resolution > 3 and product = 'Pico' and type_ticket = 'Ticket technique'
				and user_action in('cloturer','résolu') then 'Pico retard' 
		when id_tenant = 1 and tb.duree_resolution <= 3 and product = 'TV' and type_ticket = 'Ticket technique'
				and user_action in('cloturer','résolu') then 'TV a temps'
		when id_tenant = 1 and tb.duree_resolution > 3 and product = 'TV' and type_ticket = 'Ticket technique'
				and user_action in('cloturer','résolu') then 'TV retard'
		when id_tenant in(2,3,4,5) and tb.duree_resolution <= 5 and product = 'Pico' and type_ticket = 'Ticket technique'
					and user_action in('cloturer','résolu') then 'Pico a temps'
		when id_tenant in(2,3,4,5) and tb.duree_resolution > 5 and product = 'Pico' and type_ticket = 'Ticket technique'
				and user_action in('cloturer','résolu') then 'Pico retard' 
		when id_tenant in(2,3,4,5) and tb.duree_resolution <= 5 and product = 'TV' and type_ticket = 'Ticket technique'
				and user_action in('cloturer','résolu') then 'TV a temps'
		when id_tenant in(2,3,4,5) and tb.duree_resolution > 5 and product = 'TV' and type_ticket = 'Ticket technique'
				and user_action in('cloturer','résolu') then 'TV retard'
		when tb.duree_resolution <= 5 and product = 'Pico' and type_ticket = 'Reposséder'
				and user_action in('cloturer','résolu') then 'Pico a temps'
		when tb.duree_resolution <= 5 and product = 'TV' and type_ticket = 'Reposséder'
				and user_action in('cloturer','résolu') then 'TV a temps'
		when tb.duree_resolution > 5 and product = 'Pico' and type_ticket = 'Reposséder'
				and user_action in('cloturer','résolu')  then 'Pico retard'
		when tb.duree_resolution > 5 and product = 'TV' and type_ticket = 'Reposséder'
				and user_action in('cloturer','résolu') then 'TV retard'
		when user_action='customer_paid' and product = 'Pico' then 'Pico Paye'
		when user_action='customer_paid' and product = 'TV' then 'TV Paye'
		when tb.duree_resolution isnull and product = 'TV' and user_action !='à faire' and user_action !='customer_paid' then 'TV a temps'
		when tb.duree_resolution isnull and product = 'Pico' and user_action !='à faire' and user_action !='customer_paid' then 'Pico a temps'
	end as echeance,
	case 
		when id_tenant = 1 and tb.duree_a_faire <= 3 and product = 'Pico' and type_ticket = 'Ticket technique'
				and user_action = 'à faire' then 'Pico a temps'
		when id_tenant = 1 and tb.duree_a_faire > 3 and product = 'Pico' and type_ticket = 'Ticket technique'
				and user_action = 'à faire' then 'Pico retard'
		when id_tenant = 1 and tb.duree_a_faire <= 3 and product = 'TV' and type_ticket = 'Ticket technique'
				and user_action = 'à faire' then 'TV a temps'
		when id_tenant = 1 and tb.duree_a_faire > 3 and product = 'TV'  and type_ticket = 'Ticket technique'
				and user_action = 'à faire' then 'TV retard'
		when id_tenant in(2,3,4,5) and tb.duree_a_faire <= 5 and product = 'Pico' and type_ticket = 'Ticket technique'
				and user_action = 'à faire' then 'Pico a temps'
		when id_tenant in(2,3,4,5) and tb.duree_a_faire > 5 and product = 'Pico' and type_ticket = 'Ticket technique'
				and user_action = 'à faire' then 'Pico retard' 
		when id_tenant in(2,3,4,5) and tb.duree_a_faire <= 5 and product = 'TV' and type_ticket = 'Ticket technique'
				and user_action = 'à faire' then 'TV a temps'
		when id_tenant in(2,3,4,5) and tb.duree_a_faire > 5 and product = 'TV' and type_ticket = 'Ticket technique'
				and user_action = 'à faire' then 'TV retard'
		when id_tenant in(2,3,4,5) and tb.duree_a_faire <= 5 and product = 'Pico' and type_ticket = 'Reposséder'
				and user_action = 'à faire' then 'Pico a temps'
		when id_tenant in(2,3,4,5) and tb.duree_a_faire <= 5 and product = 'TV' and type_ticket = 'Reposséder'
				and user_action = 'à faire' then 'TV a temps'
		when id_tenant in(2,3,4,5) and tb.duree_a_faire > 5 and product = 'Pico' and type_ticket = 'Reposséder'
				and user_action = 'à faire'  then 'Pico retard'
		when id_tenant in(2,3,4,5) and tb.duree_a_faire > 5 and product = 'TV' and type_ticket = 'Reposséder'
				and user_action = 'à faire' then 'TV retard'
		when id_tenant in(2,3,4,5) and user_action='customer_paid' then 'Paye'
		when id_tenant = 1 and tb.duree_a_faire <= 3 and product = 'Pico' and type_ticket = 'Reposséder'
				and user_action = 'à faire' then 'Pico a temps'
		when id_tenant = 1 and tb.duree_a_faire > 3 and product = 'Pico' and type_ticket = 'Reposséder'
				and user_action = 'à faire' then 'Pico retard'
		when id_tenant = 1 and tb.duree_a_faire <= 3 and product = 'TV' and type_ticket = 'Reposséder'
				and user_action = 'à faire' then 'TV a temps'
		when id_tenant = 1 and tb.duree_a_faire > 3 and product = 'TV'  and type_ticket = 'Reposséder'
				and user_action = 'à faire' then 'TV retard'
	end as echeance_afaire
from
(select tickets.id as ticket_id,assigned_to,a.username,CONCAT(first_name,'  ', last_name) as agent,
type_ticket,tickets.status as user_action,tickets.account_id,tickets.user_id,tickets.solved_at,
b.account_number,b.status,a.id_tenant,d.name as groupes,b.country,b.region,b.commune,written_off,
 (case when tickets.assigned_at isnull then 
 extract(days from (tickets.solved_at - tickets.created_at))
	else extract(days from (tickets.solved_at - tickets.assigned_at)) end)::numeric as duree_resolution,
 (case when tickets.assigned_at isnull then
		extract(days from(now()::timestamp - tickets.created_at))
	else extract(days from(now()::timestamp - tickets.assigned_at)) end)::numeric  as duree_a_faire,
case when d.name in('WowSolar60','Sun King Home 60 Easy Buy','WowSolar100') then 'Pico'
	when d.name = 'WowSolarTV' then 'TV' end as Product,g.agent_role,g.machine_name
from public.tickets 
inner join (select * from public.users )a on assigned_to=a.id
inner join(select* from public.account_analytics)b on tickets.account_id= b.account_id
inner join(select* from public.groups where groups.name not like 'TEST%' )c on b.group_id=c.id
inner join(select* from public.product_types)d on c.product_type_id=d.id
inner join (select id,name as agent_role,machine_name from public.roles)g on a.role_id = g.id
where type_ticket in ('Ticket technique','Reposséder') 
 --and g.machine_name in ('agentcommercial','agent','agentpolyvalentml','pointdepaiement')
	and first_name  not like 'Vince%' and first_name not like 'Alint%' and tickets.deleted is false
)tb 
where user_action in('cloturer','résolu','customer_paid') 

