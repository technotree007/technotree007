 /*
 --UTL_FILE_PKG--
 --This pkg is used to write data into an OS file and also read data from OS file.
 --If we want to write data into OS file then we are using putf() method from utl_file pkg and also if we want to 
 --read data from OS file then we using get_line() method from utl_file pkg.
 --whenever we are using utl_file pkg or lobs then we must create alies directory related to physical directory using below syntax.
 --create or replace directory directory_name as 'path'
 --Before we are creating alies directory db admin give permission to create directory
 --
 */
 conn sys as sysdba;
 enter password:sys
 
 grant create any directory to scott;
 conn scott/tiger
 create or replace directory abc as 'C:\';
 
 --Before we are performing read/write operation then we hv must read write object privileges
 --synx
 --grant read,write on directory directoryname to username;
 conn sys as sysdba
 grant read,write on directory abc to scott;
 conn scott/tiger;
 
 --If You want to write data into file then we are using either putf or put_line procedure
 --also if want to read data from file then we are using get_line procedure from utl_pkg
 
 -- write data into OS file 
 --step-1 .. Before we are opening we must create file pointer variable by using file_type from utl_file pkg in
 --declare section of plsql block  --- filepointer_variablename utl_file.file_type
 --step-2--Before we are writing data into file then we must open file by usinf fopen() function .
 --This function is used in executable section of plsql block.this function accept 3 parameter and returns file_type data type.
 --filepointervariablename:=utl_file.fopen('aliesname','filename','mode') mode w-write,r-read
 --step-3--After opening file if you want to store data into file then we are using putf() procedure.
 --utl_file.putf(filepointervarname,'content');
 --step-4-- After writing data into file then we must close the file by using fclose procedure 
 --utl_file.fclose(filepointervarname);
 
 declare
 fp utl_file.file_type;
 begin
 fp:=utl_file.fopen('xyz','file1.txt','w');
 utl_file.putf(fp,'abcdef');
 utl_file.close(fp);
 end;
 /

declare
fp utl_file.file_type;
cursor c1 is select ename from emp;
begin
fp:=utl_file.fopen('xyz','file2.txt','w');
for i in c1
loop
utl_file.putf(fp,i.ename);
end loop;
utl_file.fclose(fp);
end;
/
--when using putf() to write it appear in horizontal manner. To overcome this if we want to write in our own format then 
--We must use '%s' specifier with 2nd parameter of putf procedure
--if want column data in vartical manner then '\n' new line character with %s access specifier
--utl_file.putf(filepointer var name, '%s\n',variable name);

declare
fp utl_file.file_type;
cursor c1 is select ename from emp;
begin
fp:=utl_file.fopen('xyz','file2.txt','w');
for i in c1
loop
utl_file.putf(fp,'%s\n',i.ename);
end loop;
utl_file.fclose(fp);
end;
/

--In Oracle we can also write  by using put_line()

declare
fp utl_file.file_type;
cursor c1 is select*from emp;
begin
fp:=utl_file.fopen('xyz','file4.txt','w');
for i in c1;
loop
utl_file.put_line(fp,i.ename||' '||i.sal);
end loop;
utl_file.fclose(fp);
end;
/

-------READ DATA FROM FILE------
--Read data from file then we are using get_line()

declare
fp utl_file.file_type;
z varchar2(200);
begin
fp:=utl_file.fopen('xyz','file1.txt','r');
utl_file.get_line(fp,z);
dbms_output.put_line(z);
utl_file.fclose(fp);
end;
/