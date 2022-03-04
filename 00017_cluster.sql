/*--CLUSTER--
--clusteris a database object which contain group of table of together and it will share same data block
--cluster are use in join to improve the performance
--clusetre table have same column name and also called cluster key
-- when we want to retrive the data by using joining query ,db server check cluster are available or not if available then data retrive very fastly

--1(create cluster) --create cluster cluster_name(common_column name datatype());
--2 (create cluster index)--create index index_name on cluster cluster_name;
--3 (create cluster table)-- create table table_name(col1 datatype(), col2 datatype() cluster cluster_name(common column name));
*/

create cluster ed1(a number);
create index in1 on cluster ed1;
create table e(b number,a number) cluster ed1(a);
create table d(a number,c varchar2(10)) cluster ed1(a);

drop cluster ed1 including tables;

select*from user_clusters;
