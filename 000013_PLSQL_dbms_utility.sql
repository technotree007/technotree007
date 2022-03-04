 /*
 --dbms_utility--
 --dbms_utility package internally having index by table and also this pkg having following procedure
 --comma_to_table (CTT)
 --table_to_comma(TTC)
 --CTT--
 It is user to store comma separated strings into index by table , this procedure accept 3 parameter
 --TCC--
 It is used to convert index by table values to comma separated string ,This procedure also accept 3 parameter
 --Before using this procedure we must declare index by table variable in declare section
 */
 
 declare
 v dbms_utility.uncl_array;
 z BINARY_INTEGER;
 str varchar2(200);
 begin
 str:='a1,b2,c3,d4,e5';
 dbms_utility.comma_to_table(str,z,v); --(string,binary_integer var name,index by table var name)
 for i in v.first..v.last
 loop
 dbms_output.put_line(v(i));
 end loop;
 end;
 /
 
 declare
 v dbms_utility.uncl_array;
 z binary_integer;
 str varchar2(100);
 begin
  select ename Bulk collect into v from test;
  dbms_utility.table_to_comma(v,z,str); --(index by table var name,binary_integer var name,string)
  dbms_output.put_line(str);
  end;
  /