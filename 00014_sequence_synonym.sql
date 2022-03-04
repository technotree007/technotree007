 --Synonym
 --synonym is a database object which provide security ,bcz synonym hide schema,username and object name
 --synonym are alies/reference name of database object
 --1)private synonym
 --2)public synonym
 --by default synonym are private synonym
 --synx-- create public synonym synonym name for username.object name @database link
 create synonym xy for scott.emp;
 select*from xy;
 drop synonym xy;
 select*from user_synonyms;
 
 /*
 --SEQUENCE--
 --Sequence use to generate sequence number automatically
 --synx--
 create sequence sequence name
 start with n
 increment by n
 min value n
 max value n
 cycle/no cycle
 cache/no cache;
 
 --2 pseudo column
 1)currval --current sequence value
 2)nextval --next sequence number
 --synx
 1) sequencename.currval
 2) sequencename.nextval
 
 select sequencename.currval from dual;
 select sequencename.nextval from dual;
 */
create sequence s1
start with 1
increment by 2;
select s1.nextval from dual;
select s1.currval from dual;
drop sequence s1;

create sequence s1
start with 3
increment by 3
minvalue 3
maxvalue 50;

alter sequence s1 increment by -2;
alter sequence s1 start with 6; --ORA-02283: cannot alter starting sequence number

drop table test;
create table test(slno number,book varchar2(100));
create sequence s1
start with 100
increment by 1
minvalue 1
maxvalue 100
cycle
cache 4;
insert into test(slno,book)values(s1.nextval,:book);
select*from test;

/*
CACHE
Cache is a memory area which is used to free allocate set of sequence number
If we want to access sequence value very fastly then only we use cache option
--by default cache value is 20 and also cache minimum value is 2
*/
drop table test;
select*from user_synonyms;
drop synonym s1;