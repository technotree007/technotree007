/*
--Views is a database object used to provide authority lavel security
-- Views are created from table, views doesn't store data also called virtual table
--when we want to restrict column as per user then only we creating views
VIEWS are 2 types
1)Simple view
2)complex view or join view

SIMPLE VIEW (DML Operatio)
--We can't perform DML opration if the view have group by ,rownum,set operator,join distinct
--We must add base table not null able column to perform insertion
*/
select*from emp;
select*from dept;
create or replace view v1 as select*from emp where deptno=10;
select*from v1;
drop view v1;
create table test as select*from emp;
select*from test;
drop table test purge;
create or replace view v1 as select empno,ename from test where deptno=10;
select*from v1;
insert into v1 values(1000,'ABINASH');
-- when a view contain function or expression then plz create a allies name for those function and expression
--Complex view
create or replace view v1 as
select deptno, max(sal)mx from test group by deptno;
delete from v1 where empno=7782;
delete from v1 where deptno is null; --data manipulation operation not legal on this view

/*Trigger
1)Statement lavel trigger (it's executed only once)
2)row level trigger (executed for each row for dml statement)

--syntax---
create or replace trigger trigger_name
before/after insert/update/delete on table_name
[for each row] --for row level trigger
begin
---
---
end;
*/
drop table test purge;
create table test(a date);
select*from test;
--statement level--
--GRANT CREATE ANY TRIGGER TO SCOTT;
create or replace trigger vt1
after update on emp
begin
insert into test values(sysdate);
end;

drop trigger vt1;
update emp
set sal=sal-1 where deptno=10;
SELECT*FROM TEST;
SELECT*FROM EMP;

--ROW LEVEL--
create or replace trigger vt1
after update on emp for each row
begin
insert into test values(sysdate);
end;

update emp set sal=sal-1
where deptno=10;

select*from emp;
create table test as select*from emp where 1=1;
create table test1 as select*from emp where 1=1;
truncate table test1;

create or replace trigger tv1
after delete on test for each row
begin
insert into test1 values(:old.empno,:old.ename,:old.job,:old.mgr,:old.hiredate,:old.sal,:old.comm,:old.deptno);
end;

select*from test;
select*from test1;
drop table test purge;
drop table test1 purge;

delete from test where deptno=10;
drop view v1;

--instead of trigger--
--By default instead of trigger are row level trigger and also this instead of trigger are created on view
select*from test;
create or replace view v1
as select*from test;

create or replace trigger vt3
instead of update on v1 for each row
begin
update test1 set
ename=:new.ename
where ename=:old:ename;
end;
/
select*from user_updatable_columns;
--with check option
-- if you want to put constraint type mechanish then put check option
drop table test purge;
create table test as select*from emp where deptno=10 and 1=1;
create or replace view v1
as select*from test where deptno=10 with check option;
insert into v1(ename)values('ABI');  ---view WITH CHECK OPTION where-clause violation

--with read only--
create or replace view v2
as select*from test with read only;
delete from v2;

--force view--
--We can also create a view without having base table, these type of views are called as force view
create or replace force view v3
as select*from test1;
create table test1 as select*from emp where deptno=20;
alter view v3 compile;