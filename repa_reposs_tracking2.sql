select sum(duration)as duration,state,created_at::date,country,category,call_type,agent,count(id) as appels,
sum(duree_after_call) as duree_after_call,sum(duration)+sum(duree_after_call) as duree_traitement
from(select a.*,concat(u.first_name,' ',u.last_name) as agent, 
case 
	when u.id_tenant = 1 then 'Senegal'
	when u.id_tenant = 2 then 'Mali'
	when u.id_tenant = 3 then 'Nigeria'
	when u.id_tenant = 4 then 'Burkina'
	When u.id_tenant = 5 then 'Niger'
end as country,
case when coming =  'Entrant' then 'Entrants' else 'Sortants' end as call_type,
(DATE_PART('hour', end_at::time - a.created_at::time) * 360 +
              DATE_PART('minute', end_at::time - a.created_at::time)*60
			+ DATE_PART('second', end_at::time - a.created_at::time)) as duration,
(DATE_PART('hour', after_call_end_at::time - a.end_at::time) * 360 +
              DATE_PART('minute', after_call_end_at::time - a.end_at::time)*60
			+ DATE_PART('second', after_call_end_at::time - a.end_at::time)) as duree_after_call
from calls a,users u where a.user_id = u.id and status !='canceled')a
where created_at::date = '20190804'::date
group by 2,3,4,5,6,7
