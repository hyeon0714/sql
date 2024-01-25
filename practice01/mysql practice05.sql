#담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의 
#이름, 매니저아이디, 커미션 비율, 월급 을 출력하세요.
select	*
from employees
where manager_id is not null
and commission_pct is null
and salary > 3000;

#각 부서별로 최고의 월급을 받는 사원의 직원번호(employee_id), 이름(first_name), 월급 (salary), 입사일(hire_date), 전화번호(phone_number), 부서번호(department_id) 를 조회하세요 
#-조건절비교 방법으로 작성하세요
#-월급의 내림차순으로 정렬하세요
#-입사일은 2001-01-13 토요일 형식으로 출력합니다.
#-전화번호는 515-123-4567 형식으로 출력합니다.
/*
select	max(salary)
from employees
group by department_id;
*/
select	e.employee_id 직원번호,
		e.first_name 이름,
        e.salary 월급,
        concat(
        date_format(e.hire_date,'%Y-%m-%d '),
        case when dayofweek(e.hire_date)=1 then '일요일'
        when dayofweek(e.hire_date)=2 then '월요일'
        when dayofweek(e.hire_date)=3 then '화요일'
        when dayofweek(e.hire_date)=4 then '수요일'
        when dayofweek(e.hire_date)=5 then '목요일'
        when dayofweek(e.hire_date)=6 then '금요일'
        else '토요일'
        end) 입사일,
        replace(e.phone_number,'.','-') 전화번호,
        e.department_id 부서번호
from employees e,	(select	department_id,
							max(salary) s
					from employees
					group by department_id) d
where	(e.department_id,e.salary) in (select	department_id,
										max(salary) s
										from employees
										group by department_id);

#매니저별 담당직원들의 평균월급 최소월급 최대월급을 알아보려고 한다.
#-통계대상(직원)은 2005년 이후(2005년 1월 1일 ~ 현재)의 입사자 입니다.
#-매니저별 평균월급이 5000이상만 출력합니다.
#-매니저별 평균월급의 내림차순으로 출력합니다.
#-매니저별 평균월급은 소수점 첫째자리에서 반올림 합니다.
#-출력내용은 매니저아이디, 매니저이름(first_name), 매니저별평균월급, 매니저별최소월급, 매니저별최대월급 입니다.

select	manager_id,
		round(avg(salary),1) ro,
		min(salary) mi,
		max(salary) ma  
from employees
group by manager_id
having ro>5000
and manager_id is not null;


select	m.manager_id,
		em.first_name,
        m.ro,
        m.mi,
        m.ma
from employees e, 
(select	manager_id,
		round(avg(salary),1) ro,
		min(salary) mi,
		max(salary) ma  
from employees
group by manager_id
having ro>5000
and manager_id is not null) m,
employees em
where e.manager_id=m.manager_id
and m.manager_id=em.manager_id
and e.salary=m.mi
and m.mi=em.salary
and e.hire_date>20050501
order by m.ro desc;

#각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명(department_name), 매니저(manager)의 이름(first_name)을 조회하세요.
#부서가 없는 직원(Kimberely)도 표시합니다
select	e.employee_id 사번,
		e.first_name 이름,
        d.department_name 부서명,
        m.first_name 매니저이름
from employees e, employees m, departments d
where e.manager_id=m.employee_id
and m.department_id=d.department_id;

#2005년 이후 입사한 직원중에 입사일이 11번째에서 20번째의 직원의 
#사번, 이름, 부서명, 월급, 입사일을 입사일 순서로 출력하세요
select	employee_id,
		first_name,
		d.department_name,
        salary,
        hire_date
from employees e, departments d
where e.department_id=d.department_id
and hire_date>20050101
order by hire_date limit 10,10;

#가장 늦게 입사한 직원의 이름(first_name last_name)과 월급(salary)과 근무하는 부서 이름(department_name)은?
select	hire_date
from employees
order by hire_date desc limit 1;

select	concat(first_name,' ',last_name),
		salary,
        department_name,
        hire_date
from employees e, departments d
where e.department_id=d.department_id
and e.hire_date =	(select	hire_date
					from employees
					order by hire_date desc limit 1);

#평균월급(salary)이 가장 높은 부서 직원들의 직원번호(employee_id), 이름(firt_name), 성(last_name)과  업무(job_title), 월급(salary)을 조회하시오.
/*
select	department_id,
		avg(salary) s
from employees
group by department_id
order by s desc limit 1;
*/

select	employee_id,
		first_name,
        last_name,
        job_title,
        salary,
        e.department_id
from employees e, 	
(select	department_id,
		avg(salary) s
from employees
group by department_id
order by s desc limit 1) d,
jobs j
where e.department_id=d.department_id
and e.job_id=j.job_id;

#평균 월급(salary)이 가장 높은 부서명과 월급은? (limt사용하지 말고 그룹함수 사용할 것)
select	avg(salary) s,
		first_value(avg(salary)) over(order by avg(salary) desc) fir
from employees
group by department_id;

select 	department_name,
		em.s
from departments d,
(select	avg(salary) s,
		first_value(avg(salary)) over(order by avg(salary) desc) fir, 			# first_value 사용법 숙지하기
        department_id
from employees
group by department_id) em
where d.department_id=em.department_id
and em.fir=em.s;

#평균 월급(salary)이 가장 높은 지역과 평균월급은?( limt사용하지 말고 그룹함수 사용할 것)

select	region_name,
		avg(salary)
from regions r
join countries c
on r.region_id=c.region_id
join locations l
on c.country_id=l.country_id
join departments d
on l.location_id=d.location_id
join employees e
on d.department_id=e.department_id
group by region_name
having region_name='europe'
order by avg(salary) desc;

#평균 월급(salary)이 가장 높은 업무와 평균월급은? (limt사용하지 말고 그룹함수 사용할 것)
select job_title,
		avg(salary)
from jobs j
join employees e
where j.job_id=e.job_id
group by job_title
having job_title='president'
order by avg(salary) desc;      #마지막 두문은 limit없이 어떻게 하냐