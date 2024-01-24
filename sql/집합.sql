# 이름, 부서번호, 부서명, 업무아이디, 업무명, 도시아이디, 도시명
select	first_name,
		e.department_id,
        department_name,
        e.job_id,
        job_title,
        d.location_id,
        city
from employees e join departments d join jobs j join locations l
on 	e.department_id=d.department_id
and d.location_id=l.location_id
and e.job_id=j.job_id;                         # 4개의 테이블 join

select	first_name,
		e.department_id,
        department_name,
        e.job_id,
        job_title,
        d.location_id,
        city
from employees e, departments d, jobs j, locations l
where 	e.department_id=d.department_id
and 	d.location_id=l.location_id
and		e.job_id=j.job_id                          # 4개의 테이블 where 사용
and e.department_id>50;                            # 조건도 추가해봄

select	first_name,
		e.department_id,
        department_name,
		e.job_id,
        job_title,
        l.location_id,
		city
from employees e left join departments d 
on e.department_id=d.department_id
left join jobs j
on e.job_id=j.job_id
left join locations l
on d.location_id=l.location_id;     #outer join으로 null값까지 표시
#where e.department_id>50;         #having으로 조건추가 가능

select	department_name
from employees right join departments
on employees.department_id=departments.department_id;  # 오른쪽 테이블을 기준으로 생성


select  e.employee_id
 from employees e left join departments d  
 on e.department_id = d.department_id 

union
select 	e.employee_id
 from employees e right join departments d 
 on e.department_id = d.department_id;     # union으로 2개의 쿼리문에서 중복되는 값을 1개만 가져옴    # left_ 107 + right_ 122 합계 123개

select	*
from employees e join employees m
on e.employee_id=m.manager_id;        # self join 임의의 테이블 2개를 inner join으로 교집합(내부에 한사람이 2개의 중복되는 2개의 매니저 아이디를 가질수도 있고 매니저 아이디가 없는 사람은 제외)

select	*
from employees e left join employees m
on e.employee_id=m.manager_id;  

select	*
from employees e right join employees m
on e.employee_id=m.manager_id;  


select	*
from employees e left join employees m
on e.employee_id=m.manager_id
union
select	*
from employees e right join employees m
on e.employee_id=m.manager_id;             # left_195 + right_107 - inner_106 총 196개 출력

