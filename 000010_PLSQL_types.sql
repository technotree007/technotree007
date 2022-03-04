 /*
 --Types used in package--
 --In oracle we can create our own user defined datatype using type keyword
 --In PL/SQL userdefined types are created in 2 step
 -->1st we are creating type using after/print syntax
 -->Then only we are creating variable of datatype
 
 --PL/SQL having following types
 --** PL/SQL record
 --** index by table/ PLSQL table/ Associative array
 --** Nested table
 --** Varray
 --** Ref cursor
 
--1. --PLSQL Record--
 --This is a user defined type which is used to represent different datatype into single unit
 -- It is also same as structure in C language
 --This is defined in 2 step
 ---->1. synx:- type typename is record(attribute1 datatype size,...)
 ---->2. synx:- variable_name type_name
 */
 
 declare
 type t1 is record(a1 number,a2 varchar2(200),a3 date);
 vt1 t1;
 begin
 vt1.a1:=208;
 vt1.a2:='First Try';
 vt1.a3:=sysdate;
 dbms_output.put_line(vt1.a1);
  dbms_output.put_line(vt1.a2);
   dbms_output.put_line(vt1.a3);
   end;
   
   select*from test;
   
   create or replace package pk1
   is
   type t1 is record(a1 number,a2 varchar2(100));
   procedure p1(x number);
   end;
   
   create or replace package body pk1
   is
   procedure p1(x number)
   is 
   vt1 t1;
   begin
   select sal,ename into vt1.a1,vt1.a2  from test where empno=x;
     dbms_output.put_line(vt1.a1);
       dbms_output.put_line(vt1.a2);
       end p1;
       end;
       /
       
       exec pk1.p1(7698);
       
 /*
 ---- INDEX BY TABLE/PLSQL TABLE/ASSOCIATIVE ARRAY--   
 --This is an userdefined type which is used to stored no of data item in a single unit.
 --Basically this is an unbound table
 --Basically index by table having key-value pair i.e here value field stored actual data and key field stored indexes
 --These indexs are either number/character, +ve/-ve nos.
 --This key internally behaves like primary key
 --for improving performance of thr app oracle provide binary_integer data for key field
 --If we want to operate index by table then we are using following collection method these are 
 1)exists
 2)first
 3)last
 4)prior
 5)next
 6)count
 7)delete (index)
 8)delete (index1,index2...n)
 9)delete
 
 --This is a userdefined type so we create 2 setup process.
 synx1--type typename is table of datatype(size)
         index by binary_integer;
synx2:-- variable_name typename;
 */
 
 declare
 type t1 is table of number(20)
 index by binary_integer;
 vt t1;
 begin
 vt(1):=10;
  vt(2):=20;
   vt(3):=30;
    vt(4):=40;
     vt(5):=50;
dbms_output.put_line(vt(3));
dbms_output.put_line('first '||vt.first);
dbms_output.put_line('last '||vt.last);
dbms_output.put_line('prior '||vt.prior(4));
dbms_output.put_line('count '||vt.count);
dbms_output.put_line('next '||vt.next(2));
vt.delete(1);
end;
/
select*from test;

declare
type t1 is table of varchar2(20)
index by binary_integer;
v t1;
x number;
cursor c1 is select ename from test;
begin
x:=1;
open c1;
loop
exit when c1%notfound;
fetch c1 into v(x);
x:=x+1;
end loop;
close c1;
 for i in v.first..v.last
 loop
 dbms_output.put_line(v(i));
 end loop;
 end;
/

/*
--BULK COLLECT--
--Whenever resource table having large amount of data and also if we are transfering data using cursor then automatically oracle server degrade the
--performance of the application. Bcz cursor internally uses record by record process.
--if we want to improve the performance of the application oracle 8i introduce bulk collect concept.
--synx-- select* bulk collect into collection variable_name from table_name where condition
--whenever we are using bulk collect clause in oracle server select column at a time and stored data into
--collection, This process automatically improves performance of the application
*/

declare
type t1 is table of varchar2(20)
index by binary_integer;
v t1;
begin
select ename bulk collect into v from test;
for i in v.first..v.last
loop
dbms_output.put_line(v(i));
end loop;
end;
/

declare
type t1 is table of date
index by binary_integer;
v t1;
begin
select hiredate bulk collect into v from test;
for i in v.first..v.last
loop
dbms_output.put_line(v(i));
end loop;
end;
/

declare
type t1 is table of varchar2(100)
index by varchar2(100);
v t1;
x varchar2(200);
begin
v('a'):='Abinash';
v('b'):='Bapun';
v('c'):='Champaion';
x:='a';
dbms_output.put_line(v('b'));
dbms_output.put_line(v(x));
end;
/

declare
type t1 is table of emp%rowtype
index by binary_integer;
v t1;
begin
select* bulk collect into v from emp;
for i in v.first..v.last
loop
dbms_output.put_line(v(i).empno||'      '||v(i).ename||'        '||v(i).deptno);
end loop;
end;
/

/*
--Return result set--
--If want to return large amount of datafrom db server to client application then we are using following method
--using index by table
--using ref cursor

*/
select*from test;

create or replace package pkg1
is 
type t1 is table of test%rowtype
index by binary_integer;
function f1 return t1;
end;
/

create or replace package body pkg1
is
function f1 return t1
is
vt t1;
begin
select * bulk collect into vt from test;
return vt;
end f1;
end;
/

declare
x pkg1.t1;
begin
x:=pkg1.f1;
for i in x.first..x.last
loop
dbms_output.put_line(x(i).ename||'  '||x(i).sal);
end loop;
end;
/

--EXISTS COLLECTION METHOD--
--Exists collection method used in index by tables,nested table,varray
--Exists collection always return boolean value either true or false
--This collection method is used to test wheather requested data available in collection or not.

declare
type t1 is table of varchar2(200)
index by binary_integer;
v t1;
begin
select ename bulk collect into v from test;
for i in v.first..v.last
loop
dbms_output.put_line(v(i));
end loop;
end;
/

declare
type t1 is table of varchar2(200)
index by binary_integer;
v t1;
begin
select ename bulk collect into v from test;
 v.delete(3);
for i in v.first..v.last
loop
dbms_output.put_line(v(i));
end loop;
end;
/

declare
type t1 is table of varchar2(200)
index by binary_integer;
v t1;
x boolean;
begin
select ename bulk collect into v from test;
 v.delete(3);
for i in v.first..v.last
loop
 x:=v.exists(i);
if x=true then
dbms_output.put_line(v(i));
end if;
end loop;
end;
/

declare
type t1 is table of varchar2(200)
index by binary_integer;
v t1;
begin
select ename bulk collect into v from test;
 v.delete(3);
for i in v.first..v.last
loop
 if v.exists(i) then
dbms_output.put_line(v(i));
end if;
end loop;
end;
/