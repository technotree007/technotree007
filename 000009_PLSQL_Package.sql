 --PACKAGE--
 /*
 --Package is a DB object, which encapsulate global variable,constants,procedure,function,type,cursor into a single unit.
 --Generally pkg does't accept parameter and also can't be nested and also can't be invoked.
 --Generally pkg are used to improve performance of the application. BCZ whenever we are calling packeged sub program 1st time
 then automatically total pkg loaded into memory area(RAM).
 --Whenever we are calling subsequent subprogram then oracle server calling these subprogram from memory area.
 --Every pkg have 2 part
 a) package specification
 b) package body
 --By default pkg specification object are public ,where as pkg body object are private.
 --Generally in pkg specification we are declaring object where as pkg body we are implementing these object.
 */
 
 create or replace package pkg1
 is
 procedure pro1;
 end;
 /
 
 create or replace package body pkg1
 is
 procedure pro1
 is
 begin
 dbms_output.put_line('pkg check 1');
 end pro1;
 end;
 /
 begin
 pkg1.pro1();
 end;
 /
 drop package pkg1;
 drop table test purge;
 create  table test as select*from emp;
 select*from test;
 
 create or replace package pkg1
 is
 procedure pro1(x in number);
 function fun1(a number)return number;
 end;
 /
 
 create or replace package body pkg1
 is
 procedure pro1(x number)
 is
 q date;
 w number;
 e number;
 t number;
 y number;
 begin
 select hiredate into q from test where empno=x;
 
 select to_number(to_char(q,'J')) into w from dual;
  select to_number(to_char(sysdate,'J')) into e from dual;
  y:=e-w;
  t:=fun1(y);
  dbms_output.put_line('THE ELIGIBLE ALLOWNCE IS'||t);
 end pro1;
 function fun1(a number) 
 return number
 is
 n number;
 begin
 n:=a*10;
 return n;
 end fun1;
 end;
 /
 begin
 pkg1.pro1(7566);
 end;
 /
 
 --Calling a package function--
 --select pkg_name.function_name(actual parameter) from dual;
 declare
 x number;
 begin
 x:=pkg1.fun1(23);
 dbms_output.put_line(x);
 end;
 /
 exec pkg1.pro1;
 
 --Global Variable---
 --In oracle global variable must be specified in pkg specification only.
 create or replace package pkg1
 is
 a varchar2(200);
 procedure pro1(x varchar2);
 end;
 /
 create or replace package body pkg1
 is
 procedure pro1(x varchar2)
 is
 begin
 a:=x||' WelCome to My world';
 dbms_output.put_line(a);
 end pro1;
 end;
 /
 exec pkg1.pro1('Zahir');
 
 --Pragma Serially Reusable--
 --To maintain state of global variable or state of global cursor then we are using serially reusable pragma in package
 drop package pkg1;
 
 create or replace package pkg1
 is 
 pragma serially_reusable;
 a number(5):=100;
 end;
 /
 
 begin
 pkg1.a:=20;
 dbms_output.put_line(pkg1.a);
 end;
 /
 begin
 dbms_output.put_line(pkg1.a);
 end;
 /
 drop table test purge;
 create table test as select*from emp;
 drop package pkg1;
 
 create or replace package pkg1
 is 
 cursor c1 is select*from test;
 pragma serially_reusable;
 end;
 /
 begin
 open pkg1.c1;
 end;
 /
 
 --OVERLOADING PROCEDURE--
 --Overloading refers to same name can be used for different purpose
 --In Oracle We can also implement overloading procedure using package ,these package having same name with different type and different no of parameter.
 
 create or replace package pkg1
 is
 procedure p1(a number);
 procedure p1(x varchar2);
 end;
 /
 create or replace package body pkg1
 is
 procedure p1(a number)
 is
 begin
 dbms_output.put_line(a*a);
 end p1;
 procedure p1(x varchar2)
 is
 begin
 dbms_output.put_line('Welcome '||x);
 end p1;
 end;
 
 exec pkg1.p1(10);
 exec pkg1.p1('Abinash');
  exec pkg1.p1(a=>10);
 exec pkg1.p1(x=>'Abinash');
 
--FORWARD DECLARATION--
--declaring a procedure in package body is called forward declaration
--Generally we can also called private procedure into public procedure 
--But inthis case we must implement private procedure before calling otherwise use a forward declaration.

create or replace package pkg1
is
procedure p1;
end;
/
create or replace package body pkg1
is
procedure p2; ---forward declaration
procedure p1
is
begin
p2;
end p1;
procedure p2
is
begin
dbms_output.put_line('Forward declaration');
end p2;
end;
/
exec pkg1.p1;