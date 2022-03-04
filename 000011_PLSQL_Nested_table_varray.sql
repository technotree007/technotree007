/*
--NESTED TABLE, VARRAY--
--Oracle8.0 introduce nested table ,varray.
--Thease are also user-defined datatype which is used to store number of data items in a single unit.
--Before we are storing data into these collection we must use constroctor
--Here constroctor name is same as typename

--NESTED TABLE--
--This is an user-defined which is used to store number of data item in a single unit.
--This is also unconstraint table same like index by table ,But this table doesn't have key value pair.
--In this collection index always start with 1 and also index as conjucative.
--Generally index by table are not stored permanately into DB and also we can't add or remove index.
--To overcome this problem Oracle 8 introduce extension of index by table called nested table ,which is used to store permanately to DB
--using sql and also we can add,remove index using extend,trim collection method
synx:-
type typename is table of datatype(size)
variablename typename :=typename(); ---- typename()->constroctor
*/
declare
type t1 is table of number(10)  ---index by table
index by binary_integer;
v t1;
begin
v(500):=300;
dbms_output.put_line(v(500));
end;
/
declare
type t1 is table of number(10);
v t1:=t1();
begin
v(300):=200;
dbms_output.put_line(v(300));
end;
/
---error --ORA-06533: Subscript beyond count

declare
type t1 is table of number(10);
v t1:=t1();
begin
v.extend(500);
v(300):=200;
dbms_output.put_line(v(300));
end;
/

declare
type t1 is table of number;
v t1:=t1(10,20,30,40,50);
begin
for i in v.first..v.last
loop
dbms_output.put_line(v(i));
end loop;
end;
/

declare
type t1 is table of number;
v t1:=t1();
begin
v.extend(5);
v(1):=100;
v(2):=200;
v(4):=400;
v(5):=500;
for i in v.first..v.last
loop
dbms_output.put_line(v(i));
end loop;
end;
/
--Cursor using--
--NEW CONCEPT--

declare
type t1 is table of test%rowtype;
v t1:=t1();
begin
select *bulk collect into v from test;
for i in v.first..v.last
loop
dbms_output.put_line(v(i).ename);
end loop;
end;

--OLD CONCEPT--

declare
type t1 is table of varchar2(10);
v t1:=t1();
cursor c1 is select ename from test;
x number:=1;
begin
for i in c1
loop
v.extend;
v(x):=i.ename;
x:=x+1;
end loop;

for i in v.first..v.last
loop
dbms_output.put_line(v(i));
end loop;
end;
/

/*
--VARRAY--
--Varray is an userdefined type. Which is used to store similar data itemin a single unit.
--Varray store upto 2GB data. Here by default indexes are also start with 1.
--Before we are storing data into varray , we use constrant of this is an user-defined type So we are creating 2 step process.
--1st we are creating type then only we are creating a variable of datatype.
synx:-
1.
type typename is varray(maxsize)of datatype(size);
2.
variable typename :=typename()
*/

declare
type t1 is varray(6)of number(10);
v t1:=t1(10,20,30,40,50,60);
begin
for i in v.first..v.last
loop
dbms_output.put_line(v(i));
end loop;
end;
/

declare
type t1 is varray(10)of number(5);
v t1:=t1(1000,2000,3000,4000,5000,6000);
begin
dbms_output.put_line(v.limit);
dbms_output.put_line(v.count);
v.extend(4,2);
v.trim(2);
dbms_output.put_line(v.count);

for i in v.first..v.last
loop
dbms_output.put_line(v(i));
end loop;
v.delete;
dbms_output.put_line(v.count);
end;
/

--In varray we are not allowed to delete particular element or or using delete collection method 
-- But we can delete all the element by using delete collection method

declare 
type t1 is varray(20)of test%rowtype;
v t1:=t1();
begin
select*bulk collect into v from test;
for i in v.first..v.last
loop
dbms_output.put_line(v(i).ename||'  '||v(i).sal);
end loop;
end;
/

--DIFFERENCE BETWEEN INDEX BY TABLE, NESTED TABLE, VARRAY
--INDEXBY TABLE--
--This is an unbound table and also having key value pair
--We can't storeindex by table permanately into DB
--we can't add remove index
--index values are either number or character or are +ve or -ve
--Index by table having exists,first,last,prior,next,count,delete(index),delete(index,index),delete collection method

--NESTED TABLE--
--This is an unbound table
--We can't store nested table permanately into DB
--We can add remove indexes using extend,trim collection method
--By default index start with 1
--Index by table having extend,trim,exists,first,last,prior,next,count,delete(index),delete(index,index),delete collection method

--VARRAY--
--This is an bound table which store up to 2gb data
--We can store varray permanately into DB using sql.
--We can add remove indexes using extend,trim collection method
--By default index start with 1
--Index by table having extend,trim,exists,first,last,prior,next,count,delete(index),delete(index,index),delete collection method
