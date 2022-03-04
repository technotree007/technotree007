 /*
 --TRIGGER--
 --Trigger is also same as store procedure, It will automatically invoked whenever DML performed on table or view.
 --Having 2 type of trigger
 --a. statement level trigger --> body executed only once per DML statement
 --b. row level trigger --> Body executed for each row for DML stmt
 */
 drop table test purge;
 create table test as select*from emp;
 select*from test;
 
 create or replace trigger tr1
 after update on test
 begin
 dbms_output.put_line('HI');
 end;
 /
 
 update test
 set sal=sal+1
 where deptno=10;
 
 create or replace trigger tr2
 after update on test
 for each row
 begin
 dbms_output.put_line('HI fi');
 end;
 /
 
 /*
 --ROW LEVEL TRIGGER--
 --In row level trigger body is executed for each row dml statements , that's why we are using for each row clause in trigger specification
 --DML values stored in two rollback segments qualifier, these are old and new
 --
 */
 
 create or replace trigger tr1
 before insert on test
 for each row
 begin
 if :new.sal<5000 then
 raise_application_error(-20001,'less then 5000 not allow');
 end if;
 end;
 /
 
 insert into test(ename,sal) values('JEH',3000);
 drop trigger tr1;
  drop trigger tr2;
 
 create or replace trigger tr1
 before update on test
 for each row
 begin
 dbms_output.put_line('employee old salary='||:old.sal);
 dbms_output.put_line('employee new salary='||:new.sal);
 end;
 /
 update test
 set sal=sal+100
 where deptno=20;
 create table test_h as select*from emp where 1=2;
 create table test as select*from emp ;
 select*from test;
 select*from test_h;
 
 drop table test_h purge;
  drop table test purge;
  
 create or replace trigger tr1
 before delete on test
 for each row
 begin
 insert into test_h(empno,ename) values(:old.empno,:old.ename);
 end;
 /
 delete from test where deptno=10;
 
 create table test(add_user varchar2(200),add_date date,name varchar2(100));
 
 create or replace trigger tr1
 before insert on test
 for each row
 begin
 if :new.add_user is null then
 :new.add_user:= user;
 end if;
 if :new.add_date is null then
 :new.add_date:= sysdate;
 end if;
 end;
 /
 insert into test(name)values('Zamra');
 select*from test;
 select sysdate from dual;
 
  create table test_h as select*from dept;
 create table test as select*from emp ;
 select*from test;
 select*from test_h;
 
 drop table test_h purge;
  drop table test purge;
  
  create or replace trigger tr1
  after update or delete on test_h
  for each row
  begin
  if updating then
  if :old.deptno <> :new.deptno then
  update test
  set deptno=:new.deptno
  where deptno=:old.deptno;
  end if;
  end if;
    if deleting then
  delete from test where deptno=:old.deptno;
  end if;
  end;
  /
  update test_h
  set deptno=60
  where deptno=10;
  
  delete from test_h where deptno=30;
  drop trigger tr1;
  
  create or replace trigger tr1
  before insert on test
  for each row
  declare
  x number;
  begin
  select count(*) into x from test where empno=:new.empno;
  if x>0 then
  raise_application_error(-20001,'Duplicate not allow');
  else
  dbms_output.put_line('Record entered');
  end if;
  end;
  /
   select*from test;
 select*from test_h;
 drop table test_h;
 
 insert into test(empno)values(7122);
 drop trigger tr1;
 --AUDITING A COLUMN--&--AUTO INCREMENT COLUMN
 --Wheever we are modifying data in a column those transaction value stored in another table is called auditing a column.
 --auditing column app must be implimented using rowlevel trigger
 create sequence s1
 minvalue 1
 maxvalue 100
 increment by 1
 start with 1;
 
 create table test_2(sno number,op_type varchar2(200),op_value number);
 select*from test_2;
 
 create or replace trigger tr1
 after update or delete or insert on test
 for each row
 begin
if updating then
insert into test_2(sno,op_type,op_value)values(s1.nextval,'UPDATE',:old.sal);
end if;
 if deleting then
insert into test_2(sno,op_type,op_value)values(s1.nextval,'DELETE',:old.sal);
end if;
if inserting then
insert into test_2(sno,op_type,op_value)values(s1.nextval,'insert',:old.sal);
end if;
 end;
 /
 delete from test where empno=7782;
  delete from test where deptno=30;
  
  update test set sal=sal+100 where deptno=10;
  
  insert into test(empno) values(100);
  drop table test_2 purge;
  drop sequence s1;
  create sequence s2
 minvalue 1
 maxvalue 100
 increment by 1
 start with 1;
  
   create or replace trigger tr1
  before insert on test_2
  for each row
  declare
  a number;
  begin
  select s2.nextval into a from dual;
  :new.sno:=a;  
  end;
  /
  insert into test_2(op_value)values(348);
  
  create or replace trigger tr1
  before insert on test_2
  for each row
  begin
  :new.sno:= s1.nextval;  ---11g feature
  end;
  /
  
  /*
  --TRIGGER TIMING--
  --When we are using before timing DML transaction values are not effected directly DB .Before this process these values are effected
  --in either in trigger specification or trigger body then only those values are effected in DB.
  --That's why in oracle when ever we are modifying :new qualifier values in row level trigger then we must use before timing otherwise error came.
  --In oracle if we want to restrict invalid data entries then we are using before timing
  --When we are using after timing DML transaction values are directly affected DB then these values affected in trigger.
  
  */
  create table test as select*from emp;
  select*from test;
  
  create or replace trigger tr1
  before insert on test
  for each row
  begin
  :new.ename:=upper(:new.ename);
  end;
  /
  insert into test(ename)values('abinash');
  
  create or replace trigger tr1
  before insert or update on test
  for each row 
  begin
  if :new.hiredate >= sysdate then
  raise_application_error(-20008,'Employee not allow');
  end if;
  end;
  /
  insert into test(hiredate)values(sysdate);
  
  --TRIGGERING EVENT--
  --When we are using triggering events with a trigger body these are 1)inserting 2)updating 3)deleting clause

create or replace trigger tr1
before insert or delete or update on test
for each row
begin
if inserting then
raise_application_error(-20007,'not allowed for insert DML');
end if;
if deleting then
raise_application_error(-20008,'not allowed for delete DML');
end if;
if updating then
raise_application_error(-20009,'not allowed for update DML');
end if;
end;
/
drop trigger tr1;
/*
--TRIGGER EXECUTION ORDER--
1. Before statement level
2. Before row level
3. After row level
4. After statement level
*/
create or replace trigger tr1
before update on test
begin
dbms_output.put_line('1-before statement level');
end;

create or replace trigger tr2
before update on test
for each row
begin
dbms_output.put_line('2-before row level');
end;

create or replace trigger tr3
after update on test
for each row
begin
dbms_output.put_line('3-after row level');
end;

create or replace trigger tr4
after update on test
begin
dbms_output.put_line('4-after statement level');
end;


/*
o/p- update test set sal=sal+1 where empno=7788;
1-before statement level
2-before row level
3-after row level
4-after statement level

1 row updated.
*/

--FOLLOWS CLAUSE I TRIGGER--
--Whenever we are using same table or same level, we don't have the control on execution
--so Oracle 11g introduce one clause named as follows

create or replace trigger tr1
before insert on test
for each row
begin
dbms_output.put_line('Trigger-1');
end;

create or replace trigger tr2
before insert on test
for each row
follows tr1
begin
dbms_output.put_line('Trigger-2');
end;
/
/*
o/p-
Trigger-1
Trigger-2
*/

--MUTATING ERROR--ME
/*
--If there a row level trigger based on a table then trigger body can't read data from same table also it can't perform DML operation on same table.
--If we are trying this then oracle server Return an error , 
--This error is called mutating error and table is called mutating table and this trigger is caller mutating trigger
-- ME is a run time error occured in row level trigger
--This is not occured in statement level trigger
--When we use statement level trigger transaction are automatically commited so ME not happen.
--In Row level trigger transaction are not auto commited so ME happen.
--To overcome this problem we are using autonomous transaction.But autonomous transaction always return privious result.
*/
select*from test;

create or replace trigger tr1
after delete on test
for each row
declare
a number;
begin
select count(*)into a from test;
dbms_output.put_line(a);
end;
/
/*
delete from test where deptno=10;
ERROR at line 1:
ORA-04091: table SCOTT.TEST is mutating, trigger/function may not see it
ORA-06512: at "SCOTT.TR1", line 4
ORA-04088: error during execution of trigger 'SCOTT.TR1'

*/
create or replace trigger tr1
after delete on test
for each row
declare
a number;
pragma autonomous_transaction;
begin
select count(*)into a from test;
dbms_output.put_line(a);
end;
/

--WHEN CLAUSE--
--We can also specify condition using when clause
--when clause is not allow to use in statement level trigger
--In when clause we not allow to use collon(:) infront of the qualifier (new,old)
--when condition must be a sql expression
--when condition always return a value either true or false
--when when clause return true then only trigger body executed

create or replace trigger tr1
after insert on test
for each row 
when (new.deptno=10)
begin
dbms_output.put_line('Your departmrnt is allow to execute trigger');
end;
/
insert into test(ename,deptno)values('JAK',10);

--CALLING A PROCEDURE INTO TRIGGER --
Create or replace procedure p1
as
begin
dbms_output.put_line('Calling a procedure in trigger');
end;
/

create or replace trigger tr1
after insert on test
for each row
call p1
/

/*
--DDL Trigger or System trigger--
--In DB we can also create triggers of DDL event . These type of trigger is called as DDL trigger or system trigger
--In Oracle DBA created these trigger either in DB level or schema level
synx-
create or replace trigger trigger_name
before/after create/alter/drop//truncate/rename/ on database/username schema
declare
.
.
begin
.
.
end;

*/

create or replace tr1
after create on database
begin
dbms_output.put_line('DDL trigger');
end;

/
create or replace trigger tr1
before drop on scott.schema
begin
if ora_dict_obj_name='EMP' and ora_dict_obj_type='TABLE' then
raise_application_error(-20034,'EMP table drop not allow');
end;
/

--we can alter trigger and enable or disable
--synx -- alter trigger trigger_name enable/disable
alter trigger tr1 enable;

--Oracle having 12 type of triggerbased on statement level, row level, before, after, insert,update,delete
--Oracle also support trigger on views through instate of trigger
--All trigger information store under user_triggers data dictionary
desc user_triggers;
select*from user_triggers;

--drop trigger trigger_name