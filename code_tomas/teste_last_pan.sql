/*select d1.*
from wears d1
left outer join wears d2
on (d1.wears_patient = d2.wears_patient and d1.wears_end < d2.wears_end)
where d2.wears_patient is null
and d1.wears_end < CURDATE()
order by wears_patient;
*/
select * from wears
group by wears_patient
having wears_end=max(wears_end)
and wears_end < CURDATE();