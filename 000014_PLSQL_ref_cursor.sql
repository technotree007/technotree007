/*
--ref cursor/cursor variable/Dynamic cursor
--Ref cusorn is a userdefined type which is used to process multiple record and also this is an record by record process
--Generally in statics cursor oracle server execute only one select statement at a time for a single active set area, 
--where as refcursor oracle server execute number of select stament dynamically for a single active set area , so these cursor also called dynamic cursor
--Generally We are not allowed to pass statics cursor as a parameter to sub-program,whereas we are allowed to pass ref cursor as parameter to the sub-program
--Because ref cursor are userdefined type in all database ,we can pass user defined to sub-program.
--Generally statics cursor doesn't return multiple records into client application, whereas ref cursor return multiple record into client app.
Oracle having 2 type ref cursor
1)Strong ref cursor
2)weak ref cursor
Strong ref cursor is a ref cursor having a return type whereas weak ref cursor doesn't have return type

synx:- strong
type typename is ref cursor 
return recordtype datatype;
variablename typename;

synx:- weak
type typename is ref cursors;
variablename typename;

--In ref cursor we are specifying select stmnts in executable section of pl/sql block by using open..for stmnts.
synx:-
open ref_cursor_var_name for select stmnts.
*/

declare
type t1 is ref cursor;
v t1;
i emp%rowtype;
begin
open v for select*from emp where sal>2000;
loop
fetch v into i ;
exit when v%notfound;
dbms_output.put_line(i.ename);
end loop;
close v;
end;
/

--sys ref cursor
declare
v sys_refcursor;
i emp%rowtype;
begin
open v for select*from emp where sal>2000;
loop
fetch v into i;
exit when v%notfound;
dbms_output.put_line(i.ename);
end loop;
close v;
end;
/

declare
type t1 is ref cursor;
v t1;
i emp%rowtype;
j dept%rowtype;
n number(2);
begin
n:=:deptno;
if n=10 then
open v for select*from emp where deptno=10;
loop
fetch v into i;
exit when v%notfound;
dbms_output.put_line(i.ename||' '||i.deptno);
end loop;
elsif (n=20) then
open v for select*from dept;
loop
fetch v into j;
exit when v%notfound;
dbms_output.put_line(j.dname||' '||j.deptno);
end loop;
else
dbms_output.put_line('BAD ENTRY'); 
end if;
close v;
end;
/

--Passing ref cursor as in parameter to sub program
create or replace procedure p1 (vt in sys_refcursor)
is
i emp%rowtype;
begin
loop
fetch vt into i;
exit when vt%notfound;
dbms_output.put_line(i.ename); 
end loop;
end;
/

declare 
vt sys_refcursor;
begin
open vt for select*from emp;
p1(vt);
close vt;
end;
/

--passing ref cursor as out
create or replace procedure p1(vt out sys_refcursor)
is
begin
open vt for select*from emp;
end;
/

declare
vt sys_refcursor;
i emp%rowtype;
begin
p1(vt);
loop
fetch vt into i;
exit when vt%notfound;
dbms_output.put_line(i.ename);
end loop;
close vt;
end;
/

--function
create or replace function f1
return sys_refcursor
is
v sys_refcursor;
begin
open v for select*from emp;
return v;
end;
/
select f1 from dual;

---package--
create or replace package pk1 
is
type t1 is ref cursor return emp%rowtype;
procedure p1(vt1 out t1);
type t2 is ref cursor return dept%rowtype;
procedure p2(vt2 out t2);
end;
/

create or replace package body pk1
is 
procedure p1(vt1 out t1)
is
begin
open vt1 for select*from emp;
end p1;
procedure p2(vt2 out t2)
is
begin
open vt2 for select*from dept;
end p2;
end;
/

variable a refcursor;
variable b refcursor;
exec pk1.p1(:a);
exec pk1.p2(:b);
print a b ;

--In Oracle we are not  allowed to create ref cursor variable in package.
/*
ex:- 
create or replace package pk1
is 
type t1 is ref cursor;
v t1;
end;
/
*/

show error;