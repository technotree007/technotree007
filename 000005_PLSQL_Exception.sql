/*
--Exception is an error at runtime.
ORACLE having 3 type of exception
1) Predefined exception (PE)
2) userdefined exception (USREX)
3) unmamed exception (UNMEX)

--PE--
--Oracle provide 20 PE -- when a run time error happened use a appropriate PE
1- no_data_found
2- too_many_rows
3- zero_divide
4- invalid_cursor
5- cursor_already_open
6- invalid_number
7- value_error
*/
--no_data_found
--when ever plsql block carrying select into clause if data not available then return this error
select*from emp;
declare
vnm varchar2(100);
begin
select ename into vnm from emp where empno=7369;
dbms_output.put_line(vnm);
exception
when no_data_found then
dbms_output.put_line('employee not exists');
end;
/

--too_many_rows
declare
vnm varchar2(200);
begin
select ename into vnm from emp;
dbms_output.put_line(vnm);
exception
when too_many_rows then
dbms_output.put_line('Not more then one fetch');
end;
/

--zero_devide
begin
dbms_output.put_line(8/0);
exception
when zero_divide then
dbms_output.put_line('zero divide not allow');
end;
/

--invalid_cursor
--when not opening the cursor but try to run
declare
vnm varchar2(100);
cursor c1 is select ename from emp;
begin
fetch c1 into vnm;
dbms_output.put_line(vnm);
close c1;
exception
when invalid_cursor then
dbms_output.put_line('cursor is not open');
end;
/
--cursor_already_open
--before reopening the cursor we must close it
declare
vnm varchar2(100);
cursor c1 is select ename from emp;
begin
open c1;
fetch c1 into vnm;
dbms_output.put_line(vnm);
close c1;
open c1;
fetch c1 into vnm;
dbms_output.put_line(vnm);
open c1;
exception
when cursor_already_open then
dbms_output.put_line('close the cursor');
end;
/

--value_error
-- Plsql block contain procedure statement those statement trying to convert string type to number
declare
vnm number;
begin
vnm :='abc';
dbms_output.put_line(vnm);
exception
when value_error then
dbms_output.put_line('enter proper value');
end;
/
-- when store more then the size
declare
vnm number(3);
begin
vnm :=1234;
dbms_output.put_line(vnm);
exception
when value_error then
dbms_output.put_line('size exceed');
end;
/

--invalid_number
--plsql block contain sql statement try to convert string type to number type
begin
insert into emp(ename,sal)values('ABC','GHY');
exception
when invalid_number then
dbms_output.put_line('Put valid number');
end;
/

/*
--EXCEPTION PROPAGATION--
Exception also rise in declare section, executable section,exception section
--when reise in executable section handle in inner block or outer block;
--when rise in declare section those exception must handle in outer block this is called exception propagation
*/
begin
declare
a number(2):=786;
begin
dbms_output.put_line(a);
end;
exception
when value_error then
dbms_output.put_line('enter proper size');
end;
/

/*
--USERDEFINED EXCEPTION--
--In oracle we can create our on exception and rise whenever necessary.This is called userdefined exception
--1.declare
--2.rise
--3.handling exception
*/

declare
a exception;
b number:=70;
c number:=30;
begin
if b>c then
raise a;
else
dbms_output.put_line(c);
end if;
exception 
when a then
dbms_output.put_line('Userdefined exception rise');
end;
/

declare
x exception;
begin
if to_char(sysdate,'DY')='THU' then
raise x;
end if;
exception
when x then
dbms_output.put_line('USER DEFINED EXP');
end;
/

declare
x exception;
vnm varchar2(100);
cursor c1 is select ename from emp where deptno=40;
begin
open c1;
loop
fetch c1 into vnm;
if c1%rowcount=0 then
raise x;
else
exit when c1%notfound;
dbms_output.put_line(vnm);
end if;
end loop;
close c1;
exception
when x then
dbms_output.put_line('department not found');
end;
/

--NESTED EXCEPTION--
declare
x exception;
xx exception;
begin
begin
raise x;
exception
when x then
dbms_output.put_line('Exception X handle');
raise xx;
end;
exception
when xx then
dbms_output.put_line('Exception XX handle');
end;
/

---UNNAMED EXCEPTION---
--In oracle if we want to handle other then oracle 20 exception then we are using unnamed exception
--This method we are creating our own exception name with appropriate error number using exception_init()

declare
x exception;
pragma exception_init(x,-1400);
begin
insert into emp(empno,ename)values(null,'ABC');
exception
when x then
dbms_output.put_line('Can''t insert null need value');
end;
/

declare
x exception;
pragma exception_init(x,-2292);
begin
delete from dept where deptno=10;
exception
when x then
dbms_output.put_line('Can''t delete primary value');
end;
/

--ERROR TRAPPING FUNCTIONS--
--iN ORACLE if we want to catch error no with error message then we are using 2 error trapping function

/*--sqlcode -- it return number , see below number and explanation
0 --> No oracle error
-ve --> oracle error
100 --> no_data_found
1 --> user defined exception
--sqlerrm  ---it return error number with error message
*/
drop table test purge;
create table test(a number,b varchar2(100));
select*from test;

declare
vnm varchar2(100);
vcd number;
vmsg varchar2(100);
begin
select ename into vnm from emp where empno=1111;
exception
when others then
vcd:=sqlcode;
vmsg:=sqlerrm;
dbms_output.put_line(vcd);
dbms_output.put_line(vmsg);
end;
/

begin
delete from dept where deptno=10;
exception
when others then
if sqlcode=-2292 then
dbms_output.put_line('Not allowed to delete master data');
end if;
end;
/

--RAISE APPLICATION ERROR--
/*
--iF YOU WANT TO DISPLAY UNDEFINED EXCEPTION IN MORE DESCRITIVE FORM USE raise_application_error()
--when we use this oracle server automatically display user defined exception in oracle error format
-- number should be -20000 to -20999 ans message should be 512 character
--This function also used in trigger because it can stop invalid data entry
*/

declare
x exception;
begin
if 10>5 then
raise x;
end if;
exception
when others then
raise_application_error(-20001,'10 is grater than 5');
end;
/