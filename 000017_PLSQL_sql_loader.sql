/*
SQL loader is a utility program which is used to transfer data from flat file to oracle database.
SQL loader tool also called as bulk loader
SQL loader always execute control file and this file extension is .ctl
during this process SQL loader automatically create log file same name as control file.
due to some reason some data are ejected are store in bad file.
Discard file stores rejected record based on when condition within control file


--FLAT FILE--
--Flat file is a structrued file which having any extension with no of record. Oracle having 2 type of flat file
1) Variable length record flat file
--A flat file which having a delimiters is called variable length record flat file eg:- abinash,1991,03-07-2020
2) fixed length record flat file
--A flat file which does not have delimiter is called fixed length record flat file. 101abc1991

--CONTROL FILE--
Always sqlldr execute controlfile based on type of flat file then we are creating control and then submit this control file to oracle server.
then only sqlldr transfer data from flatfile to oracle database.

Syntax:-
start->run->cmd->c:\
c:\>sqlldr userid=scott/tiger
control=path of ctrl file;


***Creating control file execution start with load data clause.After load data clause. We must file path of
flat file by using  "infile" clause.

syntax:-
load data
infile.'path of flat file'

We can also specify flat file data within control file itself in this case we must use '*'in place of path of flat file.
within infile clause and also use "begin data" clause in the above flat file data within control file itself.

eg:-
load data
infile *
....
....
begindata
101,abc,2021
102,xyz,2022

then we are specifying into table name
synx:- insert/truncate/append/replace into table table_name

after this we are using following clause
1)Field termineted by delimitername
2)Optionally enclosed by delimetername
3)trailing null cols

file1.txt
101,20021,abc
102,20222,xyz

->Control file
load data
infile 'c:\file1.txt'

insert into table target
fields termited by ','
(empno,sal,ename)

--save abc.ctl
->execution
c:\>sqlldr userid=scott/tiger
control=c:\abc.ctl

-------
load data
infile *
insert into table target
fields terminated by ','
(empno,ename,sal)
101,abc,2021
102,xyz,2022
*/

/*
--constant filler clause are used in control file
--If you want to store default values in oracle database then we must use constant clause within control file
--Whenever flat file having less number of column and target table require more number of column then we are using constant clause
--synx--columnname constant 'default value'

--If we want to skip column from flat file then we are using filler clause
--synx--columnname filler

--CONTROL FILE--

load data
infile 'c:\file1.txt'
insert into table target 
fields terminated by ','
(empno,ename filler,loc constant 'hyd')

--BAD FILE--
Bad file store rejected record and the file extension is .bad-- Bad file is automatically created as same name flat file.
--we can also create bad file explicitely by specifying filename within bad file clause
--Bad file store rejected record based on following reason
1)datatype mismatch
2)bussines rule violation

--datatype mismatch--
eg- file1.txt
101,abc
'102',xyz

--business rule--
create table target(empno number,ename varchar2(20),sal number check (sal>2000));

--control file--

load data
infile 'c:\file1.txt'
insert into table target 
fields terminated by ','
(empno,ename,sal)

*/

/*
--In flat file records trailing fields are null values then those record are automatically rejected and those record are store in bad file.
--if you want to store those null value also into the database then we are using "trailing nullcols" clause with in control file.

eg-file1.txt
101,abc,1000
102,xyz
103,ase
104,nnn,9000

control file:-

load data
infile 'c:\file1.txt'
insert into table target 
fileds terminated by ','
trailing nullcols
(empno,ename,sal)

*/


/*
--recnum--
whenever we are using recnum clause then oracle server automatically assign number to loaded rejected no record

eg- file1.txt
101,abc
'102',xyz

control file:-
load data
infile 'c:\file1.txt'
insert into table target
fields terminated by ','
(empno.ename,rno recnum)
*/

/*
--DISCARD FILE--
Discard file also stores rejected record based on when condition with in control file "WHEN" condition must be specified "into table tablename" clause
--discard file extension is .dsc

control file--

load data
infile 'c:\file1.txt'
discardfile 'c:\disfile.dsc'
insert into table target when deptno='10'
fields terminated by ','
(empno,ename,deptno)

--when clause value must be specified within single quote
--In when clause we are not allowed to use other then =,<>,!=
*/

/*
--Function used in control file--
--We can also use oracle predefined function within control file .In this case we must specify functions functionality with in ""and also we must use  :
--colon operator infront of the column name with in function funcunality

control file:-
load data
infile 'c:\file1.txt'
insert into table target 
fields terminated by ','
(empno,ename,gender "decode(:gender,'m','male','f','female')")

-*****Date used in control file
method1:- using date type
method2:- using to_date() function

eg:- file1.txt
101,abc,170320
102,xyz,011221

control:-
load data
infile 'c:\file1.txt'
insert into table target 
fields terminated by ','
(empno,ename,hire_date date "ddmmyy")

M-2
control
load data
infile 'c:\file1.txt'
insert into table target 
fields terminated by ','
(empno,ename,hire_date "to_date(:hire_date,'DDMMYY')")

---*** sequence used in control file

control
load data
infile 'c:\file1.txt'
insert into table target 
fields terminated by ','
(sno,"s1.nextval")

*/

/*
--creating control file for fixed length record flat file--
when flat file doesn't have delimited those flat file are called fixed length flat file
--for fixed length flat file must use position clause with in control file
--Along with position clause we must use sql loder datatype. sqlloader having 3 data type
1.integer external
2.decimal external
3. char

--when we are using fun'c then we are not allowed to use sqlloader datatype .

eg: file.txt
100abc3000
101xyz4000
102cnn5000

control:-
load data
infile 'c:\file1.txt'
insert into table target 
(empno position(01:03)integer external,
ename position(04:06)char,
sal position(07:10)integer external)

---sequence insert
load data
infile *
insert into table target
(sno "s1.nextval",value constant '50',
time "to_char(sysdate,'HH:MN:SS')", 
col1 position(01:05)":col1/100",
col2 position(06:11)"upper(:col2)",
col3 position(12:17)"to_date(:col3,'ddmmyy')"

--In oracle we are not allowed to use :colon & also we are not allowed to use :new,:old qualifier infront of sysdate,user function

--Using sql loader we can also transfer no. of flat file data into single target table by specifying no. of infile clause with in control file
--We can also transfer single flat file data into multiple table by specifing no. of into table tablename clause
*/