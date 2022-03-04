 /*--VARIABLE ATTRIBUTE--
 Variable attribute are used in place of datatype in variable declaration
 whenever we are using variable attribute then oracle server automatically allocate memory for the 
 variable as same as corresponding column datatype in a table .
 This variable attribute are also called anchore notation
 
 PL/SQL having 2 type variable attribute
 1)column level attribute (CLA)-- we are define attribute for individual column
 synx:- variable_name table_name.column_name%type
 
 2)row level attribute (RLA)-- In this method single variable can represent all different datatype in a row within a table.this variable also called as record type variable
 synx:- variable_name table_name%rowtype
 */
 
 select*from emp;
 select*from dept;
 --CLA--
 declare
 v_ename emp.ename%type;
  v_sal emp.sal%type;
  begin
  select ename,sal into v_ename,v_sal from emp where empno=7782;
  dbms_output.put_line(v_ename||'  '||v_sal);
  end;
  /
  --op--CLARK  2450
  
  --RLA--
  declare
  var emp%rowtype;
  begin
  select ename,job,sal,deptno into var.ename,var.job,var.sal,var.deptno from emp where empno=7876;
  dbms_output.put_line(var.ename||' '||var.job||'   '||var.sal||'   '||var.deptno);
  end;
  /
    --ADAMS CLERK   1100   20
    
 declare
 i dept%rowtype;
 begin
 select * into i from dept where deptno=20;
 dbms_output.put_line(i.deptno||'   '||i.dname||'   '||i.loc);
 end;
 /
 --20   RESEARCH   DALLAS
 
 /*
 --PL/SQL Datatype and variable--
 1) Support all SQl data type
 2) composite datatype
 3) Ref object
 4) lobs(clob,blob,bfile)
 5) bind variable or non pl/sql variable
 
 -- BIND VARIABLE--
 -- Bind variable is a session variable created at host environment so it's also called host variable.
 --It's use in sql, pl/sql, dynamic sql so it called non-plsql variable
 --we can use this variable in plsql when sub program having out or inout parameter
 */
 
-- ex:-
variable vr1 number;
declare
vs number;
begin
select sal into vs from emp where empno=7876;
:vr1:=vs*12;
end;
/
print vr1;
--op-- 13200