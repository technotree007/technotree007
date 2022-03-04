/*
--SUBPROGRAM--
--Sub-program are named plsql block
--2 type of sub-program 
(a).Procedure --may or mat not return a value 
(b).Function -- must return a value

--PROCEDURE--
--procedure is a named pl/sql block, which is used to slove particular task
--when we are using create or replace keyword, those procedure are permanately store in DB, that's why procedure are also called stored procedure.
--Generally procedure are used to improve the performance of the application, bcoz procedure having one time compilation
--PROCEDURE HAVING 2 PART
--a) procedure specification
--b) procedure module
*/
show error; --- to view error

create or replace procedure pro1
as
a number:=20;
b number:=30;
begin
dbms_output.put_line(a+b);
end;
/
exec pro1;

begin
pro1();
end;
/
-----------------------------
drop procedure pro1;

create or replace procedure pro1(age number,name varchar2)
is
begin
dbms_output.put_line('Hi Mr.'||name||' Welcome to ROYAL-CRUSE. As per your data you are '||age||' years old.');
end;
/
exec pro1(31,'ABINASH SAHOO');

select*from emp;

create or replace procedure pro1(p_empno number) as
i emp%rowtype;
cursor c1 is select*from emp where empno=p_empno;
begin
for i in c1
loop
dbms_output.put_line(i.ename||' '||i.sal);
end loop;
end;
/

exec pro1(7788);


/*
--PROCEDURE PARAMETER--
--Parameter is a name which is used to pass value from procedure
--procedure having 2 type of parameter
**Formal Parameter
**Actual parameter

--FORMAL PARAMETER-- (FP)
--FP must be specified in procedure specification
--FP specifies name of the parameter,type of the parameter
--In oracle we are not allowed to use datatype size in FP declaration

--MODE--
--Oracle FP having 3 type of mode
(a). IN Mode
(b). OUT Mode
(c). IN OUT Mode
*/

--IN--
drop table test purge;
create table test(id number,name varchar2(200),phn number);
select*from test;

create or replace procedure pro1(id in number,name in varchar2,phn in number) as
begin
insert into test values(id,name,phn);
commit;
end;

exec pro1(101,'ABINASH SAHOO',7204877098);

--OUT--
create or replace procedure pro1(ai in number,bo out number) as
begin
bo:=ai*ai;
end;
/

variable x number;
exec pro1(5,:x);
print x;

declare
x number(10);
begin
pro1(6,x);
dbms_output.put_line(x);
end;
/
/*
 --PASS BY VALUE & PASS BY REFRENCE--
 --Whenever we are using modular programing all language supports two types of passing parameter mechanism
 1> pass by value
 2> pass by refrence
 
 --In Pass by value method actual value doesn't change in main program ,when we are using subprogram parameter
 --In oracle bydefault all in parameter internally uses pass by reference method.
 --Where as bydefault all out parameter internally use pass by value method
 --In Oracle when ever we returning large amount of data using out parameter internally copies of value
created bcoz out parameter internaly using pass by value method.
--This process automatically degrade the performance of the procedure.
--To overcome this problem oracle introduce nocopy hint in out parameter 
*/

create or replace procedure pro1(p_no in number,p_name out nocopy varchar2)as 
begin
select ename into p_name from emp where empno=p_no;
end;
/

declare
a varchar2(200);
begin
pro1(7788,a);
dbms_output.put_line(a);
end;
/

--INOUT--
create or replace procedure pro1(a in out number) as
begin
a:=a*a;
end;
/

variable x number;
exec :x:=10;
exec pro1(:x);
print x;
/

declare
x number:=11;
begin
pro1(x);
dbms_output.put_line(x);
end;
/

/*
--AUTONOMOUS TRANSACTION/CONCEPT-- (AT)
--AT are independent transactionused in procedure and trigger
--Whenever we are calling autonomous procedure in PL/SQL block and also when we are using rollback in pl/sql block then autonomous procedure never affect
--we are using pragma autonomous_transaction ; in declare section
*/

drop table test purge;
create table test(name varchar2(10));
select*from test;

create or replace procedure pro1 as
pragma autonomous_transaction;
begin
insert into test values('INDIA');
commit;
end;

begin
insert into test values('USA');
pro1;
rollback;
end;
-- op/- INDIA

create or replace procedure pro1 as
begin
insert into test values('INDIA');
commit;
end;
/
begin
insert into test values('USA');
pro1;
rollback;
end;
--o/p-- USA, INDIA
/*
--Authid current user--
--When procedure having authoid current user clause then then that procedure not executed by another user if privilage also given
--Generally when we reading data from tables perform dml , on data security point of view we are using this clause
--This is use in specification of the procedure
*/
create or replace procedure pro1(p_no in number) 
authid current_user
as
begin
update emp
set sal=sal+nvl(comm,0)
where empno=p_no;
commit;
end;
/

-- Handle or unhandle exception in procedure
--whenever we are calling inner procedure into outer procedure then we must implement inner procedure exception
--otherwise oracle server execute outer procedure exception
create or replace procedure pro1(a number,b number) as
c number(10);
begin
c:= a/b;
dbms_output.put_line('The result is = '||c);
exception
when zero_divide then
dbms_output.put_line('Zero not divided');
end;
/

create or replace procedure pro2 as
begin
pro1(10,0);
exception
when others then
dbms_output.put_line('PL/SQL error');
end;
/
 
 --EXECUTION METHOD--
 --Procedure IN parameter having 3 type of execution method
 --position notation
 exec pro1(12,'ABC',89);
 --named notation
 exec pro1(p_no -> 12,p_name -> 'ABC',p_sal -> 89);
 --Mixed notation -- it is combination of position and named notation
 exec pro1(12,p_name -> 'ABC',89);
 