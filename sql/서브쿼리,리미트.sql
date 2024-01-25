select	*
from employees;

select	*
from employees
where salary > (select salary
				from employees
				where first_name='den');   # 서브쿼리 하나의 질의문 속에 다른 질의문이 포함된 형태
										   # 서브쿼리 부분은 괄호로 묶기 	
                                           
select	*
from employees
where salary =	(select min(salary)
				from employees); 			# min과 같은 그룹함수도 서브쿼리를 활용해서 그룹함수 외의 컬럼도 찾을수 있다


#월급을 가장 적게 받는 사람의 이름, 월급, 사원번호는?
select	first_name,
		salary,
        employee_id
from employees
where salary =	(select	min(salary)	 # 단일행 서브쿼리/서브쿼리 결과가 1개인것
				from employees);     # 연산자가 필요하다
                
#평균 월급보다 적게 받는 사람의 이름, 월급을 출력하세요?
select	first_name,
		salary
from employees
where salary <	(select	avg(salary)
				from employees);

#부서번호가 110인 직원의 급여와 같은 월급을 받는 모든 직원의 사번, 이름, 급여를 출력하세요
select	employee_id,
		first_name,
		salary
from employees
where salary in	(select	salary
				from employees
				where department_id = 110);      # 부서번호가 110인 사람의 급여가 12008,8300 2개이므로 '='연산자로 정리가 안된다   / 다중행 서브쿼리 =>서브쿼리 결과가 2개 이상인것
                
#각 부서별로 최고급여를 받는 사원의 이름과 월급을 출력하세요
select	*
from employees
where (department_id, salary) in	(select	department_id
											,max(salary)
									from employees
                                    group by department_id);    # 그룹절을 줘서 서브쿼리 만들기

#'Den' 보다 월급을 많은 사람의 이름과 월급은?
#1번 딘의 월급
select	salary
from employees
where first_name='den';

#2번 월급이 11000(den)보다 큰 사람 출력
select	first_name,
		salary
from employees
where salary > 11000;

#3번 딘보다 많은 월급
select	first_name
		,salary
from employees
where salary > 	(select	salary
				from employees
				where first_name='den');    # sub 쿼리문을 줘서 1번에서 구한 딘의 월급을 2번에 넣어준다
 
 
#월급을 가장 적게 받는 사람의 이름, 월급, 사원번호는? 
select	min(salary)
from employees;

select 	first_name,
		salary,
        employee_id
from employees
where salary = 	(select	min(salary)
				from employees);
                
#평균 월급보다 적게 받는 사람의 이름, 월급을 출력하세요?
select	avg(salary)
from employees;

select	first_name, 
		salary
from employees
where salary < 	(select	avg(salary)
				from employees);
                

#부서번호가 110인 직원의 급여와 같은 월급을 받는 모든 직원의 사번, 이름, 급여를 출력하세요
select	salary
from employees
where department_id=110;								#다중행 서브쿼리(서브 쿼리의 실행결과가 2개 이상인경우)

/*                        
select	employee_id,
		first_name,
		salary
from employees
where salary = 	(select	salary
				from employees
				where department_id=110); 
*/              										# 조건의 결과가 2개가 나오므로 기존의 단일행 서브쿼리의 연산자로는 결과가 나오지 못한다

select	employee_id,
		first_name,
		salary
from employees
where salary in (select	salary
				from employees
				where department_id=110);  				# in 같은 내용의 결과값을 찾는다
                   

#각 부서별로 최고급여를 받는 사원의 이름과 월급을 출력하세요
select	department_id,
		max(salary)
from employees
group by department_id;

select	first_name,
		salary
from employees
where  salary in	(select	
					max(salary)
					from employees
					group by department_id);   					# 조건에 그룹을 묶었으나 그룹의 최고금액이 중복인 사람도 있어서 값이 안는다

select	first_name,
		salary,
        department_id
from employees
where (department_id, salary) 	in	(select	department_id,
											max(salary)
									from employees
									group by department_id); 	# 조건을 비교할때 부서 아이디와 급여를 같이 묶어서 비교함으로 정상값을 찾아낸다
																# 이처럼 2개의 조건을 넣어서 비교할수도 있다
                                                                # 값이 하나 빠진것은 그룹이 없는 null값의 값이 빠진것이다

select	first_name,
		salary,
        department_id
from employees
where (department_id, salary) 	in	(select	department_id,
											max(salary)
									from employees
									group by department_id)
or department_id is null and salary in (select	max(salary)
										from employees
										group by department_id);     # 억지로 null값까지 포함시켜봤다


select department_id, employee_id, first_name, salary
from employees
where (department_id, salary) in (select department_id, max(salary)
                                  from employees
                                  group by department_id);      	#서브쿼리를 활용한 결과

select e.department_id, e.employee_id, e.first_name, e.salary
from employees e, (select department_id, max(salary) salary			# max라는 그룹함수를 출력할수 있게 별명을 준다
                   from employees
                   group by department_id) s 
where e.department_id = s.department_id
and e.salary = s.salary;											#조인을 통한(교집합) 결과    // 결과는 동일


select e.department_id, e.employee_id, e.first_name, s.salary
from employees e right join (select department_id, max(salary) salary	# max라는 그룹함수를 출력할수 있게 별명을 준다
							from employees
							group by department_id) s 
on e.department_id = s.department_id	
and e.salary = s.salary;											# right join으로 null값까지 출력은 했지만 오른쪽 테이블이 그룹관계라서 그룹함수 외에는 값을 불러올수 없어서 이름의 확인이 안된다


# 월급이 11000보다 큰 직원의 이름 급여
select	*
from employees
where salary > 15000;

#부서번호가 110인 직원의 급여 보다 큰 모든 직원의 이름, 급여를 출력하세요.(or연산--> 8300보다 큰)
#1번
select	*
from employees
where department_id = 110;          # 결과값이 2개 나옴(12008,8300) 다중행 서브쿼리 필요

#2번
select	*
from employees
where salary >any (select	salary
					from employees
					where department_id = 110);		#1번의 결과가 2개이고 조건이 '같은' 이 아니고 '보다 큰'일때 or의 내용을 품은 '연산자 + any'를 사용하면 2개의 결과값을 하나라도 만족한 결과값 모두 출력한다 (8300 이상)

select	*
from employees
where salary >all	(select	salary
					from employees
                    where department_id=110);		# '>any'를 쓸때와 달리 'all'은 'and'의 개념이라 2개의 결과가 모두 만족하는 값만 출력한다(12008 이상)

select	*
from employees
where 	hire_date>20070101
and		hire_date<20071231
order by hire_date limit 2,7;		#limit는 원하는 순번의 값을 가져올수 있다 // 3번부터(시작은0) 7개의 값을 가져온다

select	*
from employees
where 	hire_date>20070101
and		hire_date<20071231
order by hire_date limit 2;			#순서대로 2개의 값을 가져온다