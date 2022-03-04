 /*
 This is an user defined type which is used to represent different datatype into single unit.
 It's also same as structure of C language.
 This is a user defined type so we creating in 2 step.
 synx:-
 type typename is record (attr1 datatype (size),....);
 variablename typename;
 
 */
 declare
 type t1 is record (a number(3),b varchar2(50),c date);
 v t1;
 begin
 v.a:=100;
 v.b:='Abinash';
 v.c:=sysdate;
 DBMS_OUTPUT.PUT_LINE(v.a||'    '||v.b||'    '||v.c);
 end;
 /
 
 declare
 type t1 is record (a number(3),b varchar2(50),c date);
 v t1;
 begin
select deptno,ename,hiredate bulkcollect into v.a,v.b,v.c from emp where empno=7788;
 DBMS_OUTPUT.PUT_LINE(v.a||'    '||v.b||'    '||v.c);
 end;
 /
 
 /*
 --LOCAL SUBPROGRAM--
 Local sub program are named PL/SQL block which is used to solve particular task
 --Oracle having 2 type sub-program
 a)local procedure
 b)local function
 
 */
 declare
 procedure p1
 is 
 begin
 dbms_output.put_line('Wel come to mumbai');
 end p1;
 begin
 p1;
 end;
 /