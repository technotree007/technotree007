 /*
 --LOCK--
 --All db having two type of lock
 --1)Row level lock (RLL)
 --2)table level lock (TLL)
 
 --RLL--
 -- Whenever we are performed locks then another user query the data but they can't dml operationand also in all db
 whenever we are using commit ort rollback then locks are automatically released
 -- synx-- select*from table_name where condition for update[nowait];
  */
  select*from emp where deptno=10 for update;
  --conn test/test
  update scott.emp
  set sal=sal+10 where deptno=10; -- can't dml
  --conn scott/7204877098
  commit; -- release the lock
  /*--NoWait--
  it optional use with update clause .whenever we are using nowait automatically ontrol goes to current session if
  another not releasing lock.And oracle server return an error as--resource is busy
  
  --In All DB whenever we are using DML statement then automatically db server internally uses exclusive lock (default lock)
    */
    
    select*from emp where deptno=30 for update nowait;
    
/*--TLL--
--2 type of lock
--1)share lock (SL)-- when we are using these lock another user query the data but they can't perform DML operation
and also number of user lock the resource at the same time.
--synx-- lock table table_name in share mode;
--2)Exclusive lock (EL) -- when we are using this lock then another user query the data but they can't perform DML
operation and also at a time only one user lock the resource
--synx--lock table table_name in exclusive mode
*/

--SL--
lock table emp in share mode;
commit; --release the lock

--EL--
lock table emp in exclusive mode;
commit; -- release lock
