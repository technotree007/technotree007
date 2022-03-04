/* --CURSOR--
 --Cursor is a private SQL memory area which is used to process multiple records also record by record by process.
 --2type of statics cursor
 --1) Implicit cursor (IC)
 --2) Explicit cursor (EC) -- return multiple records and also record by record process
 -- EC memory area is also called as active set area
  */
   declare
   cursor c1 is select ename, sal from emp;
   vnm varchar2(100);
   vsal number;
   begin
   open c1;
   fetch c1 into vnm,vsal;
   dbms_output.put_line('1'||vnm||'  '||vsal);
   fetch c1 into vnm,vsal;
    dbms_output.put_line('2'||vnm||'  '||vsal);
    fetch c1 into vnm,vsal;
     dbms_output.put_line('3'||vnm||'  '||vsal);
     fetch c1 into vnm,vsal;
      dbms_output.put_line('4'||vnm||'  '||vsal);
      fetch c1 into vnm,vsal;
       dbms_output.put_line('5'||vnm||'  '||vsal);
       fetch c1 into vnm,vsal;
        dbms_output.put_line('6'||vnm||'  '||vsal);
        
        close c1;
        end;
        /*
1SMITH  800
2ALLEN  1600
3WARD  1250
4JONES  2975
5MARTIN  125
  */
  
  /*
  Explicit cursor having 4 attribute these are
 -- 1)%NOTFOUND
 -- 2)%FOUND
--  3)%ISOPEN
-- 4)%ROWCOUNT  
Whenever we are using this attribute the syntax is
cursor name%attribute name

%NOTFOUND --return boolen value either true or false ,return true when doesn't fetch any value
-- false when fetch value
  */
  
  declare
  cursor c1 is select*from emp;
  i emp%rowtype;
  begin
  open c1;
  loop
  fetch c1 into i;
  dbms_output.put_line(i.ename||'       '||i.sal);
  exit when c1%notfound;
  end loop;
  close c1;
  end;
  /
  
declare
cursor c1 is select ename from emp;
vnm varchar2(100);
begin
open c1;
loop
fetch c1 into vnm;
dbms_output.put_line(vnm);
exit when c1%rowcount>=5;
end loop;
close c1;
end;
/


declare
cursor c1 is select*from emp;
i emp%rowtype;
begin
open c1;
loop
fetch c1 into i;
if mod(c1%rowcount,2)=0 then
dbms_output.put_line(i.ename||'  '||i.deptno);
end if;
exit when c1%notfound;
end loop;
close c1;
end;
/

--Whenever we are creating a cursor then oracle server automatically allocate 4 memory allocation along with cursor memory area.
--Thease memory area are identified by cursor attribute these memory allocation also behave like a variable, they also store 1 value at a time.

declare
cursor c1 is select*from emp;
j emp%rowtype;
begin
open c1;
loop
fetch c1 into j;
exit when c1%notfound;
end loop;
dbms_output.put_line(c1%rowcount);
close c1;
end;
/
drop table test purge;
create table test(slno number not null,tname varchar2(20) not null,tsal number(6) not null);
select*from test;

declare
cursor c1 is select*from emp;
i emp%rowtype;
a number(10);
begin
open c1;
loop
fetch c1 into i;
a:=c1%rowcount;
exit when c1%notfound;
insert into test values(a,i.ename,i.sal);
commit;
end loop;
close c1;
end;
/
--display total salary without sum function
declare
cursor c1 is select sal from emp;
vt number(10):=0;
i emp.sal%type;
begin
open c1;
loop
fetch c1 into i;
exit when c1%notfound;
vt:=vt+nvl(i,0);
end loop;
dbms_output.put_line(vt);
close c1;
end;
/

/*
--ELIMINATE CURSOR LIFE CYCLE(or) CURSOR FOOR LOOP
--... Whenever we are using cursor for loop then no need to use open,fetch,close 
--when we use cursor for loop oracle server automatically open and fetch and close the cursor
--This is also known as shortcut method of cursor
*/

declare
cursor c1 is select*from emp;
begin
for i in c1
loop
dbms_output.put_line(i.ename||' '||i.sal);
end loop;
end;
/

--- We can also eliminate declare section of cursor by using for loop

begin
for i in (select*from dept)
loop
dbms_output.put_line(i.dname);
end loop;
end;
/

declare
cursor c1 is select*from dept;
a number;
begin
for i in c1
loop
if c1%rowcount=2 then
a:=c1%rowcount;
dbms_output.put_line(a||' '||i.dname);
end if;
end loop;
end;
/
--%FOUND--
DECLARE
CURSOR C1 IS SELECT*FROM EMP WHERE EMPNO=74999 ;
i emp%rowtype;
begin
open c1;
loop
fetch c1 into i;
if c1%found then
dbms_output.put_line('Employee name is '||i.ename);
else
dbms_output.put_line('No employee found');
end if;
exit when c1%notfound;
end loop;
close c1;
end;
/

declare
cursor c1 is select*from emp;
i emp%rowtype;
begin
open c1;
fetch c1 into i;
while(c1%found)
loop
dbms_output.put_line(i.ename);
fetch c1 into i;
end loop;
close c1;
end;
/
-- %isopen --This attribute also return boolen result either true/false.
--This is used to ncheck wheather cursor is open or not
declare
cursor c1 is select*from dept;
i dept%rowtype;
begin
if not c1%isopen then
open c1;
loop
fetch c1 into i;
exit when c1%notfound;
dbms_output.put_line(i.dname);
end loop;
close c1;
end if;
end;
/
/*
--PARAMETERIZED CURSOR--
--In Oracle we can also pass parameter to the cursor same like as subprogram in parameter.
--In oracle whenever we are passing parameter to cursor,procedure,functionthen we are not allowed to use datatype size in formal parameter declaration.
*/
declare
cursor c1(p_deptno number) is select*from emp where deptno=p_deptno;
i emp%rowtype;
begin
open c1(10);
loop
fetch c1 into i;
exit when c1%notfound;
dbms_output.put_line(i.ename||'     '||i.deptno);
end loop;
close c1;
end;
/

declare
cursor c1(vloc varchar2)is select*from dept where loc=vloc;
i dept%rowtype;
begin
open c1('DALLAS');
loop
fetch c1 into i;
exit when c1%notfound;
dbms_output.put_line(i.dname||' '||i.loc);
end loop;
close c1;
end;
/
--Whenever we are not opening a cursor and try to perform ,then got an error invalid cursor
--MULTIPLE CURSOR WITH PARAMETERIZED CURSOR--

declare
cursor c1 is select*from dept;
cursor c2(vdpn number) is select*from emp where deptno=vdpn;
i dept%rowtype;
j emp%rowtype;
begin
for i in c1
loop
dbms_output.put_line(i.dname||' '||i.loc||' '||i.deptno);
end loop;
for j in c2(30)
loop
dbms_output.put_line(j.ename||' '||j.deptno);
end loop;
end;
/

declare
cursor c1 is select*from dept;
cursor c2(vdpn number) is select*from emp where deptno=vdpn;
i dept%rowtype;
j emp%rowtype;
begin
for i in c1
loop
dbms_output.put_line(i.dname||' '||i.loc||' '||i.deptno);
for j in c2(i.deptno)
loop
dbms_output.put_line(j.ename||' '||j.deptno);
end loop;
end loop;
end;
/

declare
cursor c1(vdeptno number) is select max(sal)a,min(sal)b,sum(sal)c from emp where deptno=vdeptno;
i emp%rowtype;
begin
for i in c1(10)
loop
dbms_output.put_line(i.a||' '||i.b||'   '||i.c);
end loop;
end;
/

/*
--Implicit cursor attribute--
--For sql statement return single record is called implicit cursor
--Implicit memory area is called as context area
--In oracle whenever select into clause or pure dml statement then oracle server inernally automatically 
allocate memory area is called as sql area/context area/implicit cursor
--In implicit cursor area four memory location area are automatically created 
--thease memory location are identify through implicit cursor , these attribute are
1) sql%notfound
2) sql%found
3)sql%isopen
4)sql%rrowcount
*/

declare
vdnm varchar2(10);
begin
select dname into vdnm from dept where deptno=40;
dbms_output.put_line(vdnm);
end;
/

declare
vdnm varchar2(10);
begin
select dname into vdnm from dept where deptno=50;
if sql%found then
dbms_output.put_line('Department found');
dbms_output.put_line(vdnm);
end if;
end;
/

drop table test purge;
create table test as select*from emp;
select*from test;

declare
vn number:=0;
begin
delete from test where deptno=60;
vn:=sql%rowcount;
if sql%found then
dbms_output.put_line('Record exists and deteted no of rows='||''||vn);
end if;
if sql%notfound then
dbms_output.put_line('Record doesn''t exists');
end if;
end;
/