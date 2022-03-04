 /*
 --Oracle having 4 set operator
 1)union -- return value unique time and data sorted
 2)union all  -- unique + duplicate
 3)intersect -- it return common value
 4)minus -- value in first query not in second query
  */
  select  job from emp where deptno=20
  union
  select  job from emp where deptno=10;
  
  select  job from emp where deptno=20
  union all
  select  job from emp where deptno=10;
  
  select  job from emp where deptno=20
  intersect
  select  job from emp where deptno=10;
  
  select  job from emp where deptno=20
  minus
  select  job from emp where deptno=10;
  
  -- we can retrive 2 different datatype
  select dname dt,to_number(null)df from dept
  union
  select to_char(null)dt, deptno df from emp;
  
  /*--CONVERSION--
  --CONVERTING ONE DATA TYPE TO ANOTHER
  --oracle having 2 type of conversion
  --1)Implicit conversion (IC)-- oracle db only change utomatically one datatype to another datatype
  --2)Explicit conversion (EC)-- 
  */
  --IC
  select sal+'100'from emp;
  select length(12345)from dual;
  select last_day('12-AUG-21')from dual;
  --EC
  -- Oracle having following explicit conversion function
  --decode()
  --to_number()
  --to_char()
  --to_date()
  
  
  --DECODE()--
  --decode func is also same as if else statement
  --synx-- decode(column_name,value1,stmt1,vlu2,stm2,valu3,stm3,....,else value)
  select decode(3,1,'one',2,'two',3,'three','other') from dual; --three
  select decode(7,1,'one',2,'two',3,'three','other') from dual;  --other
  select deptno,decode(deptno,10,'Ten',20,'Twenty','Other') from dept;
  create table t1(no number,name varchar2(20));
  create sequence s2
  start with 10
  minvalue 10
  maxvalue 100
  increment by 3;
 
  drop sequence s2;
  select s1.nextval from dual;
  insert into t1 values(s2.nextval,:nm);
  SELECT*FROM T1;
  
  UPDATE T1
  SET NAME=DECODE(NAME,NULL,NULL,'XXX');
  
  select job,sum(decode(deptno,10,sal)) dept10,
  sum(decode(deptno,20,sal))dept20,
  sum(decode(deptno,30,sal))dept30
  from emp group by job;
  
  --CASE sTATEMENT--
  --CASE STATEMENT IS ALSO USED AS DECODING THE VALUE
  select deptno,case deptno
  when 10 then 'Ten'
  when 20 then 'Twenty'
  else 'other' end
  from dept;
  
  select ename, sal, case 
  when sal<=1000 then 'Low salary'
    when sal=1250 then 'spcl sal'
    when sal between 1001 and 2500 then 'midium salary'
  else 'High salary' end
  from emp;
  
  /*
  --PIVOT()--
  --pivot introduce in 11g
  --pivot performance is very high as compare to decode, use convert row to column
  synx:- select*from(select col1,col2. col3.... from table_name)
  pivot(aggregate function() for column name in (value1,value2));  
  */
  select*from(select job,sal,deptno from emp)
  pivot(sum(sal)for deptno in(10 as deptno10,20 as deptno20,30 as deptno30));
  
  select*from(select job,deptno from emp)
  pivot(count(*)for deptno in(10 as d10,20 as d20,30 as d30));
  
  --to_number()--
  select to_number('$23.45','$99.99')+10 from dual; --33.45
  --to_char()--
  --want to see julian date then using format 'j' with in to_char()
  select to_char(sysdate,'j') from dual; --2459483
  --julian date is a number since jan-1,4712 BC
  --if want to convert julian number to date
  select to_char(to_date(1234567,'J'),'DD-MON-YYYY')from dual; --23-JAN-1332
  -- given number into word
  select to_char(to_date(123,'j'),'jsp')from dual;  ---one hundred twenty-three
  
  /*
  9 -> represent a number
  g -> group separator (,)
  d -> decimal indicator (.)
  $ -> dollar indicator
  0 -> leading zero
  L -> local currency
  */
  
  select to_char(1234567,'99g999g99') from dual;  -- 12,345,67
  select to_char(1234567,'99g999g99d99')from dual;  12,345,67.00
  select to_char(123,'999d99')from dual; -- 123.00
  select to_char(1234,'99d99')from dual; --######
  select to_char(1234,'$999')from dual; --#####
   select to_char(1234,'$9999')from dual; -- $1234
   select to_char(123,'0999')from dual; -- 0123
     select to_char(123,'9990')from dual; --  123 --space displayed

--LOCAL CURRENCY--
select to_char(123,'L999')from dual; -- $123 bydefault it's dollar
-- if we want use other currency then use (nls_currency) format
select to_char(12345,'L99g999d99','nls_currency=Rs.')from dual; -- Rs.12,345.00
select ename,trim(to_char(sal,'L99999d99','nls_currency=Rs.'))from emp;

/*
--NULL Value function --
1.nvl()
2.nvl2()
3.null if()
4.coalesce()
*/

select ename,sal,comm,nvl(comm,0)from emp;
select ename,sal,comm,nvl2(comm,comm+1,2) from emp;
--nulif() -- synx nullif(exp1,exp2)
--if exp1=exp2 then it will return null other wise return exp1
select nullif(10,20)from dual; --10
select nullif(10,10) from dual; -- null
--put null whose salary greater then 2000
select ename,nullif(sal,greatest(2000,sal)) from emp;

--coalesce()--
--it's same as nvl but is a ansi standard
--synx-- coalesec(exp1,exp2,exp3..expn)

select coalesce(null,null,30,null,40,20,30,null,10)from dual; --30
select coalesce(null,46,30,67,40,20,30,null,10)from dual; --46
select ename,sal,comm,sal+coalesce(comm,0)total_sal from emp;

--nvl doing implicit conversion automatically where coalesce must have same datatype