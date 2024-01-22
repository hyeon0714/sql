# 함수   (숫자)
select  round(27.33,1)    # 줄바꿈을 위한 ,를 줄을 띄워서 사용할수도 있다
		,round(27.36,1)
		,round(99.01,2)
from dual;    # 일반적인 round

select  ceil(27.33)
		,ceil(27.36)
from dual;   # ceil은 정수자리에서 무조건 올림처리

select  floor(27.3)
		,floor(27.8)
from dual;   # floor은 정수자리에서 무조건 내림

select  truncate(1234.5678, 1)
		,truncate(123.456,2)
        ,truncate(9876.432,-1) #  해당위치에서 버림처리(올림이 없고, floor()와 다르게 소수점에서 버림이 가능)
from dual;

select  first_name
		,salary
        ,salary/30
        ,ceil(salary/30)
        ,truncate(salary/30, 2)   #  실제 DB에서의 함수 활용 예시
from employees
order by salary desc;

select  power(12,2),
		power(2,2),
        pow(12,2),
        pow(2,2)  # power와 pow 는 기능이 같은 함수이다 n승을 구한다
from dual;

select  sqrt(144)
		,sqrt(139)
        ,sqrt(169)  # 제곱근을 구한다
from dual;

select  sign(111)
		,sign(0)
        ,sign(-111);   # sign 양수인지 음수인지 판단한다
        
select  abs(111),
		abs(0),
        abs(-111)
from dual;     # abs는 절대값을 표시

select  greatest(3,45,101,11,102.5)
		,greatest('b', 'a', 'c')
        ,greatest('ㄷ', 'ㄹ', 'ㅎ')
from dual;   # greatest는 주어진 값중 가장 큰값을 구한다

select  least(3,45,101,11,-30,-10)
		,least('b', 'a', 'c')
        ,least('ㄷ', 'ㄹ', 'ㅎ')
from dual;    # least는 주어진 값중 가장 작은 값을 구한다

/*
select greatest(salary)
from employees;

select  greatest(employee_id, department_id)
from employees;
*/                       #  greatest와 least는 컬럼을 넣을때 해당 컬럼의 최고값을 찾는것이 아니라 컬럼 1개를 비교할 값 하나로 인식한다    // 컬럼의 비교에는 부적합

select  max(salary)
from employees;   # max는 컬럼과 사용가능

select  min(salary)
from employees;   # min은 컬럼과 사용가능



 #함수    (문자)
 
 select  concat('안녕','하세요')
 from dual;   # 문자를 합친다
 
 select  concat_ws('-','안녕','하세요', '나는')
 from dual;   # 문자를 합칠때 맨 처음의 문자를 문자들의 사이에 넣어준다
 
 select upper('upper')
		,upper('school')
        ,ucase('upper')
        ,ucase('school')
 from dual;     #  문자를 대문자로 바꾼다 upper와 ucase의 결과와 사용이 같다
 
 select lower('UPPER')
		,lower('SCHOOL')
        ,lcase('UPPER')
        ,lcase('SCHOOL')
from dual;      #  문자를 소문자로 바꾼다 lower와 lcase의 결과와 사용이 같다

select 	first_name,	
		ucase(first_name),
		upper(first_name),
		upper('ABCabc!#$%'),
		upper('가나다')
from employees;

select 	first_name,
		lcase(first_name),
		lower(first_name),
        lower('ABCabc!#$%'),
        lower('가나다')
from employees;    # upper/lower, ucase, lcase는 컬럼의 사용에도 문제가 없다

select 	first_name,
		length(first_name),
		char_length(first_name),        	
		character_length(first_name)
from employees;

select 	length('ab'), 
		char_length('ab'), 
        character_length('ab');

select 	length('가'),    #  length는 char_length(), character_length() 와 다르게 문자의 바이트를 읽는다(한글을 쓸때와 영어를 쓸때 값이 달라짐)
		char_length('가'), 
        character_length('가');  #  글자의 개수를 세는 char_length, character_length를 사용한다(두 문법은 문자의 개수를 세는게 동일하다)

select 	first_name, 
		substr(first_name,1,3), 
        substring(first_name,1,3),
        substr(first_name,-1,2),
        substring(first_name,-3,2),
        substr(first_name, 3, -2)
from employees;     #  substr, substring은 사용 방법이 똑같다
                    #  (n번) 위치에서  (n번)까지의 문자를 추출한다
                    #  (-n번) 위치는 뒤에서 부터 들어간다  두번째의 (-n번)은 역행으로 가는 것이기에 출력이 나오질 않는다

select 	concat('|',  '          안녕하세요             ',  '|' ),	
		concat('|',  trim('          안녕하세요             '),  '|' ),      # 모든 공백을 제거
		concat('|',  ltrim('          안녕하세요             '),  '|' ),                       # 문자열 왼쪽의 공백을 제거
		concat('|',  rtrim('          안녕하세요             '),  '|' );                                               # 문자열 오른쪽의 공백을 제거

select first_name, 
       lpad(first_name,10,'*'), 
       lpad(first_name,5,'*'), 
       rpad(first_name,10,'*'),
       rpad(first_name,10,'*a')
from employees;       #  문자에 ''안의 값을 넣어서 2번항목의 문자 개수를 맞춰준다   ( 문자의 맞춰줄 문자의 개수가 더 작다면 뒤의 문자를 제거한다 )

select  first_name,
		replace(first_name, 'a', '*'),
        replace(first_name, substr(first_name, 2, 3), '***'),
        replace(first_name, substr(first_name, 2, 3), '*')
from employees
where department_id =100;   #  1번의 문자열에서 2번과 동일한 값이 있다면 1번이 가진 2번의 값을 제거하고 3번으로 바꾼다



#   함수     (날짜)
select  current_date(),
		curdate();  # 현재날짜
        
select  current_time(),
		curtime();  # 현재시간

select  current_timestamp(),
		now();   #현재 시간과 날짜

select  adddate('1970#01#01',1)  # 날짜와 시간의 더하기를 만드는데 이때 날자와 시간에 구분 기호를 넣어줘야한다(구분기호는 상관없고, 19700101이런 방식은 사용이 안된다)
		,adddate('1970#01#01',2)
        ,adddate('1970#01#01 00:00:00', 120)
        ,adddate('1970%01%01 00:00:00', Interval 1 second)
        ,adddate('1970%01%01 00:00:00', Interval 1 minute)
        ,adddate('1970%01%01 00:00:00', Interval 1 hour)
        ,adddate('1970%01%01 00:00:00', Interval 1 day);   #interval은 날짜와 시간의 덧셈에 사용된다

select  adddate('1970#01#01',1)  # 
		,adddate('1970#01#01',2)
        ,adddate('1970#01#01 00:00:00', 120)
        ,adddate('1970%01%01 00:00:00', Interval -1 second)
        ,adddate('1970%01%01 00:00:00', Interval -1 minute)
        ,adddate('1970%01%01 00:00:00', Interval -1 hour)
        ,adddate('1970%01%01 00:00:00', Interval -1 day);   #interval에 는 날짜와 시간을 덧셈의 개념이라 음수를 넣어주면 빼기가 나타난다
        
select  subdate('1970/01/01',1),
		subdate('1970/01/01 00@00@00',10),
        subdate('1970',10),  # adddate(), subdate() 모두 날짜를 더하는 개념이라 년도만 표시해서는 값이 나오지 않는다
        subdate('1970/01/01',10),
        subdate('1970/01/01', interval 1 second),
        subdate('1970/01/01', interval 1 hour);  # 시간을 표시하지 않아도 시간의 덧셈 뺄셈은 가능하다
        
select  first_name
		,hire_date
		,datediff(now(), hire_date)  #현재 날짜와 입사일 사이의 날짜 차이를 계산
from employees;

select  first_name
		,hire_date
		,datediff(now(), hire_date)  
from employees
order by hire_date desc;


#함수    (변환함수)

select  now(),
		date_format(now(), '%y/%m/%d %h/%i/%s')
        ,date_format(now(), '%s')
        ,date_format(now(), '%d')
from dual;    # 주어진 날짜를 %+(y,m,d,h,i,s)라는 날짜와 시간을 나타내는 문자를 이용해서 원하는 값을 출력할수 있다

select  date_format(now(), '%Y-%m-%d(%a) %H:%i:%s %p')
		,date_format(now(), '%Y-%m-%d(%a) %H:%i:%s %p')
from dual;  #   y=연도, m=월, d=일, h=시간, i=분, s=초,    //    a=해당 달, p=am/pm


# str_to_date 함수
select datediff('2021-Jun-04', '2021-06-01');  -- 계산안됨

select str_to_date('2021-Jun-04 07:48:52', '%Y-%b-%d');
select str_to_date('2021-06-01 12:30:05', '%Y-%m-%d');

select 	datediff(str_to_date('2021-Jun-04 07:48:52', '%Y-%b-%d'),            			
		str_to_date('2021-06-01 12:30:05', '%Y-%m-%d'));
# '2021-Jun-04', '2021-06-01'는 특수문자가 들어간 문자 형식이라 날짜의 빼기가 계산이 안되지만
# str_to_date를 이용해서 문자를 숫자로 바꿔서 인식한후에 계산하면 정상적으로 나온다


select  format(1234567,0)
		,format(1234567.89,-2)
        ,format(1234.67,2)
from dual;

select  commission_pct
		,ifnull(commission_pct, 0)  # null값을 2번재 항목으로 바꾼다
from employees
order by commission_pct;