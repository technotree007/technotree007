 /*
 --BULKBIND--
 --When a pl/sql block contain more number of sql,procedure statement then all procedure statement are executed in
 procedure statement executorwith in pl/sql engine and also all sql statement are executedwith in sql engine.
 These type of execution method are also called as context switching execution method.
 
 --context switching method degrade performance of the application,To improve oracle introduce bulk bind process using collection
 
 --In this process we can execute all values in a collection at a time using forall clause ,In bulk bind process we are using bulk update,bulk delete,bulk insert.
 synx:-
 forall indexvariable_name collectionvariable_name.first..collectionvariable_name.last
 dml statement where column_name=collectionvariable_name(indexvariable_name);
 */
 select*from test;
 
 declare
 type t1 is varray(10)of number(4);
 v t1:=t1(10,30,40);
 begin
 forall i in v.first..v.last
 update test
 set sal=sal+1
 where deptno=v(i);
 end;
 
 declare
 type t1 is varray(20)of number(10);
 v t1:=t1();
 begin
 select empno bulk collect into v from test where comm is null;
 forall i in v.first..v.last
 update test
 set comm=1
 where empno=v(i);
 end;
 
 /*
 --whenever index by table or nested table having gap then we can't use bulk bind .To overcome this issue we are using varray, we can store upto 2gb data
 --to overcome all these problem oracle 10g introduce "indicies of" clause in bulkbind process, this clause used in forall statement
 syntax: forall indexvariable_name in indices of collection variable name
 */
 
 declare
 type t1 is table of number(10)
 index by binary_integer;
 v t1;
 begin
 select empno bulk collect into v from test;
 v.delete(3);
 forall i in indices of v
 update test
 set sal=10000
 where empno=v(i);
 end;
 /
 
 --SQL%bulk_rowcount--
 --In bulkbind process if you want to return affected number of rows within each process then for count we are using this
 --SQL%bulk_rowcount(i)
 
 declare
 type t1 is varray(30) of number(3);
  v t1:=t1(10,20,30);
 begin
 forall i in v.first..v.last
 update test
 set sal=sal+1
 where deptno=v(i);
 
 for i in v.first..v.last
 loop
 dbms_output.put_line('deptno-'||v(i)||' affected rows are '||sql%bulk_rowcount(i));
 end loop;
 end;
 /
 
 --BULK DELETE--
 declare
 type t1 is varray(20) of number;
 v t1:=t1(10,20,30);
 begin
 forall i in v.first..v.last
 delete from test where deptno=v(i);
 end;
 
 --BULK INSERT--
 create table test5(s_name varchar2(20));
 select*from test5;
 drop table test3 purge;
 
 declare
 type t1 is varray(20) of varchar2(20);
 v t1:=t1();
 begin
 select ename bulk collect into v from test;
 forall i in v.first..v.last
 insert into test5 values(v(i));
 commit;
 end;
 /
 
 declare
 type t1 is varray(20) of varchar2(20);
 v t1:=t1();
 begin
 select ename bulk collect into v from test;
 v(2):='ABINASH';
 v(14):='BAPUN';
 forall i in v.first..v.last
 insert into test5 values(v(i));
 end;
 /
 
/*
 --FORALL and DML Error/Bulk Exception--
 --In Oracle Forallstatement typically execute multiple DML statement , whenever an exception occure in one of those DML stmts then default behaviour is
 --that stamt is rollback and forall stop
 --all(previous) successful stmts are not rollbacked 
 --If we want to continue forall processing after an error occure then add "save exception" clause in bulk bind process
 --save exception tells oracle save exception and continue processing all DML stmts
 --Whenever we are using save exception clause for each exception rised oracle automatically populate sql%bulk_exception psuedo collection .
 --This collection having only collection method count.
 --In Bulk bind process whenever exception raised sql%bulk_exception index by table .
 --This index by table having 2 fields these are error_index,error_code.
 error_index:- error_index stores index no of error
 error_code:- It store error number (only positive) of error occured in bulk bind process.
 
 --If we want to handle bulk exception then we must follow 2 step
 1: store number of exception in a variable by using count collection method sql%bulk_exception index by table
 2:     Before we are using this process we must use save exception clause in forall stmts.
 */
 
 drop table test5 purge;
 create table test5(sname varchar2(20) not null);
 alter table test5 modify(sname number);
 select*from test5;
 
 declare
 type t1 is table of number(10);
 v t1:=t1(10,20,30,40,50);
 z number(20);
 begin
 v(3):=null;
 v(4):=null;
   forall i in v.first..v.last save exceptions 
 insert into test5 values(v(i));
 commit;
 exception
 when others then 
 z:=sql%bulk_exceptions.count ;
 dbms_output.put_line(z);
 
 for j in 1..z
 loop
 dbms_output.put_line('error index is '||sql%bulk_exceptions(j).error_index||' error code is '|| sql%bulk_exceptions(j).error_code);
 end loop;
 end;
 /