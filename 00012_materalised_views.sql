 /*
 --MATERIALIZED VIEW-- (mv)
-- GRANT CREATE ANY materialized view to scott;
 --GENERALLY VIEWS DOESN'T STORE DATA BUT MV store data
 --MV also store data same like as table but when ever we are refreshing MV it synchronised data based on base table
 --VIEW--
 --view doesn't store data
 --view purpose as security
 --if we drop base table then view can't be accessable
 --we can perform DML on views
 
 --MV--
 --MV store data
 --MV purpose is improve performance
 --if we drop base table then also MV accessable
 --We can't perform DML on MV
 */
 create table test as select*from emp where 1=1; --TEST' does not contain a primary key constraint
 select*from test;
 alter table test add primary key(empno);
 
 create materialized view mv1
 as select*from test;
 select*from user_mviews;
 select*from mv1;
 delete from test where deptno=20;
 --MV refresh--
 exec dbms_mview.refresh('MV1');
 
 drop materialized view mv1;
 --Oracle having 2 type of MV
 --1.Complete refresh MV (CRMV)
 --2.Fast refresh MV  (FRMV)
 
 --CRMV--
 --By default MV are CRMV
 --When evere we are refreshed internally rowids are re-created  also for not modified data in base table
 create materialized view mv1 refresh complete
 as select*from test ;
 select*from test;
 select*from mv1;
 delete from test where empno=7499;
 exec dbms_mview.refresh('MV1');
 
 --FRMV--
 --FRMV is also called as incremental refresh MV
 --FRMV rowids are not change even if we are refreshing MV number of time
 --before create FRMV we need to create materialized view log
 create materialized view log on test;
 
 create materialized view mv2 refresh fast
 as select*from test;
 
 select*from mv2;
 exec dbms_mview.refresh('MV2');
 
 --- refresh MV automatically by set ON DEMAND/ON COMMIT
 create materialized view mv3 refresh fast on commit
 as select*from test;
 
 create materialized view mv4 refresh fast on demand
 as select*from test;
 
 select*from mv3;
 select*from mv4;
 insert into test(empno,ename, job)values(111,'RAJZ','ACTING');
 drop materialized view mv4;