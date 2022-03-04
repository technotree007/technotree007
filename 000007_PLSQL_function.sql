/*
--FUNCTION--
--Function is a named pl/sql block and function must return a value.
--function having 2 part
--..function specification
--..function body

*/
create or replace function fun1(a varchar2)
return varchar2
is
x varchar2(2000);
begin
x:= 'Hi '||a||',Welcome to Dimano';
return x;
end;
/

declare
b varchar2(2000);
begin
b:=fun1('Abinash');
dbms_output.put_line(b);
end;
/

select fun1('Bapun') from dual;

create or replace function fun1(a number)
return varchar2
is
x varchar2(20);
begin
if mod(a,2)=0 then
x:='EVEN';
else
x:='ODD';
end if;
return x;
end;
/
select fun1(8)from dual;

declare
v varchar2(20);
begin
v:=fun1(9);
dbms_output.put_line(v);
end;
/
exec dbms_output.put_line(fun1(8));
/
-- we can also called userdefined function into insert statement
create table test(a varchar2(10));
drop table test purge;
insert into test values(fun1(9));
select*from test;

--Generally when a function having a dml stamt those function are not executed using select stmt ,but we are executing these stmt by using annonomous block
drop table test purge;
create table test as select*from emp;
select*from test;
drop function fun1;

create or replace function fun1(p_dpno number)
return number
as
s number(20);
begin
delete from test where deptno=p_dpno;
 s:=sql%rowcount;
 return s;
end;
/
declare
a number;
begin
a:=fun1(20);
dbms_output.put_line(a);
end;
/
--USING AUTONOMOUS TRANSACTION--

create or replace function fun1(p_dpno number)
return number
as
s number(20);
PRAGMA AUTONOMOUS_TRANSACTION;
begin
delete from test where deptno=p_dpno;
 s:=sql%rowcount;
 return s;
end;

/*
--In oracle we can use predefined aggrigate function and also use this user defined function in same table or different table.
*/

create or replace function fun1
return number
as
a number;
begin
select max(sal)into a from emp;
return a;
end;
/
select fun1() from dual;

--We can also use named ,mixed notation in oracle 11g, when sub-program executing select statement 

select fun1(p_no=>20,'India') from dual;

--CURSOR USED IN FUNCTION--
 create or replace function fun1
 return varchar2
 as
 x varchar2(4000);
 cursor c1 is select ename from emp;
 begin
 for i in c1
 loop
 x:=x||'    '||i.ename;
 end loop;
 return x;
 end;
 /
 
 select fun1 from dual;
 
 ---Oracle 10g introduce wm_concat() predefined aggrigate function which return multiple value group wise.
 select job,wm_concat(ename)from emp group by job;
-- all details stored in user_source, user_procedures

select*from user_procedures;
select*from user_source;

/*
--OUT MODE--
--This mode is used toreturn mode valuefrom the functions ,
--Parameter having out parameter and inout parameter , we cant execute those function in select stmt
*/

create or replace function fun1(p_empno in number,p_ename out varchar2,p_dpno out number)
return varchar2
as
begin
select ename,deptno into p_ename,p_dpno from emp where empno=p_empno;
return p_ename;
end;
/
variable a varchar2(100);
variable b varchar2(100);
variable c number;

begin
:a:=fun1(7788,:b,:c);
end;
/