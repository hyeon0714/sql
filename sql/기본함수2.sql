select  avg(salary),
		avg(commission_pct)
from employees;

select  sum(salary)
from employees;

select  count(first_name)
from employees;

select  count(*)
from employees;

select  count(commission_pct)
from employees;   # null값은 자동으로 제외

select  count(salary)
		,sum(salary)
        ,avg(salary)
        ,(691416/107)
from employees;

select  count(*)
from employees
where salary>16000;

select  count(salary)
		,max(salary)
        ,min(salary)
from employees;

select department_id, job_id, count(*), sum(salary)
from employees
group by department_id, job_id;         # group by는 뒤에온 그룹을 기준으로 잡는다

select  *
from employees
order by first_name, last_name;         # order by는 먼저 쓴 그룹을 기준으로 잡는다

#월급(salary)의 합계가 20000 이상인 부서의 부서 번호와 , 인원수, 월급합계를 출력하세요
select  department_id
		,count(*)
        ,sum(salary)
from employees
#where sum(salary)>=20000
where salary>=10000         # group by절에는 where절을 같이 쓸수 없다(++정확하게는 sum 함수를 사용할수 없다//그룹함수 사용이 안됨)
group by department_id;      #   -->> 급여가 10000이상 개인을 부서 아이디 그룹들중 인원수와 급여합계

select  department_id
		,count(*)
        ,sum(salary)
from employees
group by department_id
having sum(salary)>=20000;    # group by 절에는 where절 대신에 having 절을 써서 일을 대신할수 있다
							  # having은 그룹 함수와 그룹 절만 쓸수 있다
                              
select  department_id
		,count(*)
        ,if(sum(salary)>=20000,sum(salary),0) 급여
from employees
group by department_id;


select  first_name
		,salary
        ,commission_pct
        ,if(commission_pct is null,0,1)
        ,if(ifnull(commission_pct,0)=0,0,1)    # 같은 결과값이다  null은 문자이니 is null로 비교를 하고 ifnull로 null값을 0으로 바꾸고 =0으로 비교를 했다
from employees;

/*
직원아이디, 월급, 업무아이디, 실제월급(realSalary)을 출력하세요.
 실제월급은 job_id 가 'AC_ACCOUNT' 면 월급+월급*0.1,                             
 'SA_REP' 월급+월급*0.2,                            
 'ST_CLERL' 면 월급+월급*0.3                            
 그외에는 월급으로              
 계산하세요
*/

select  employee_id
		,salary
        ,job_id
		,case when job_id='AC_ACCOUNT' then salary+salary*0.1
        when job_id='SA_REP' then salary+salary*0.2
        when job_id='ST_CLERL' then salary+salary*0.3
        else salary
        end 실급여
from employees;

select  employee_id
		,salary
        ,job_id
		,if( job_id='AC_ACCOUNT' , salary+salary*0.1,
        if( job_id='SA_REP' , salary+salary*0.2,
        if( job_id='ST_CLERL' , salary+salary*0.3,
         salary))) 실급여
from employees;

/*
직원의 이름, 부서번호, 팀을 출력하세요팀은 코드로 결정하며 부서코드가     
10~50 이면 'A-TEAM'    
60~100이면 'B-TEAM'      
110~150이면 'C-TEAM'     
나머지는 '팀없음' 으로 
    출력하세요.
*/
select  first_name
		,department_id
        ,case when 10<=department_id and department_id<=50 then 'A-TEAM'
        when 60<=department_id and department_id<=100 then 'B-TEAM'
        when 110<=department_id and department_id<=150 then 'C-TEAM'
        else '팀없음'
        end 팀
from employees
order by department_id;

select  first_name
		,department_id
        ,if(10<=department_id and department_id<=50, 'A-TEAM',
        if(60<=department_id and department_id<=100, 'B-TEAM',
        if(110<=department_id and department_id<=150, 'C-TEAM',
        '팀없음'))) 팀
from employees
order by department_id;

select  first_name
		,department_name
from employees, departments;

select  *
from employees inner join departments
on employees.department_id = departments.department_id;   # departments의 null값은 제외한다

select  *
from employees inner join jobs
on employees.job_id = jobs.job_id;

#모든 직원이름, 부서이름, 업무명 을 출력하세요   *3개의 테이블
select  first_name
		,department_name
        ,job_title
        ,employees.department_id
from 	employees join departments join jobs       # inner는 생략 가능 ++ join 대신에도 ,로 대체가능
where 	employees.department_id=departments.department_id     # on이 아니고 where로 사용 가능(where의 가장 많이 사용하는 형태)
and		employees.job_id=jobs.job_id;	

select  first_name
		,department_name
        ,job_title
        ,e.department_id
from 	employees e, departments d, jobs j       # 테이블 별명까지 추가 가능
where 	e.department_id=d.department_id       # 테이블 별명을 만들면 테이블 별명으로 지정해야한다
and		e.job_id=j.job_id;

select	*
from employees e
inner join departments d
    on e.department_id = d.department_id
inner join jobs j                               # 테이블 연결을 하나씩 하는법 => 이때 where을 쓸수 없고 on으로만 연결이 가능하다
    on e.job_id = j.job_id;                   

select	*
from employees left outer join departments
on employees.department_id=departments.department_id;      # left outer join => 왼쪽의 employees를 기준으로 집합시킴으로 employees.department_id의 null값을 포함한 값을 출력
														
select	*
from employees left join departments
on employees.department_id=departments.department_id;      # left outer join에서 outer는 생략이 가능하나 outer join은 where가 들어올수 없고 on만 가능하다

select	*
from employees e
left join departments d
on		e.department_id=d.department_id
left join jobs j
on		e.job_id=j.job_id;                   # outer join의 3개이상 테이블 연결하는법

