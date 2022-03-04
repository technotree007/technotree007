 -- Data control Language (DCL)
 --GRANT
 conn sys as sysdba;
--creating user
--synx-- create user username identified by password;
create user test identified by test;
grant connect,resource to test;
conn test/test
conn scott/7204877098
grant all on emp to test;
 conn test/test
 select*from scott.emp;
 grant create synonym to test; -- from sysdba
 create synonym employee for scott.emp;
 select*from employee;
 
 /*--PRIVILEGE--
 Database system having 2 type of user privileges
 1)system privileges (SP)
 2)object privileges (OP)
 
 */
 
 --SP-- these privileges enable user to perform database operation .It's given by DBA 
 --Oracle having more than 80 SP
 grant create procedure,create any index,create any materialized view to scott,test;
 grant create session to test;
 
 --ROLE-- role is nothing but collection of system priviliges
 -- 2type of ROLE
 --1)User defined Role (UDR)
 --2)Pre defined Role (PDR)
 
 --UDR--
 conn sys as sysdba
  grant create procedure,create trigger,create any index to r1;
  grant r1 to test;
  select *from role_sys_privs;
  
  --PDR--
  --Oracle server automatically have 3 predefined role
  --1)connect -> used by end user
  --2)resource -> developer
  --3dba ->used by dba
  grant connect,resource to test;
  
 -- Object privileges --
 -- this privileges enable users to perform some operation on table
 conn scott/7204877098
  grant update(ename)on emp to test;
  grant all on emp to r1;
  
--REVOKE-- this command is used to cancelsystem or object privileges from user
revoke all on emp from test;

--MERGE--
/* synx--
merge into target table
using source table
on (joining condition) 
when matched then
update  set column_name=value 
when not matched then
insert into (column name) values(value);
*/

drop table t1;
create table t1 as select*from dept;
create table t2 as select*from dept where deptno in(10,20);
select*from t1;
select*from t2;
update t1 set dname='SALES' where dname='EDU';

merge into t2 b
using t1 a on a.deptno=b.deptno
when matched then
update  set b.dname=a.dname,b.loc=a.loc
when not matched then
insert into (b.deptno,b.dname,b.loc) values(a.deptno,a.dname,a.loc);