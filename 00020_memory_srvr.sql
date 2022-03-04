 --Control file--
 --it control all other file in storage area
 --control files also store logically created db info
 --in oracle all control file info store in v$controlfile table
 conn sys as sysdba
 desc v$controlfile
 select*from v$controlfile;
 
 --Redlog file--
 --redlog file store commited info from redlog buffer. file extension is .log
 --relog file store in v$logfile
 desc v$logfile
 select*from v$logfile;
 
 --Instance-- when ever we are connecting to adb by using a tool then oracle server automatically create a memory area 
 --this memory area is also called as instance
 --Oracle instance consist 2 parts
 --1.SGA
 --2.Process
 
 --SGA--
 --It is also called as system global area  or shared global area .SGA memory having set of buffer these are
 --1.database buffer cache
 --2.shared pool
 --3.java pool
 --4.large pool
 --5.redlog buffer
 --when ever submitting sql/plsql code then that code is stored in library cache with in shared pool.
 
 --UNDO--
 --In oracle when ever we are performing DML transaction then new value for the transaction stored in dirty buffer and old value
 -- is stored in undo area within database buffer cache
 
 --Flashback query--
 --using by dba, flashback query retrive accidental data with reference to aspecific point of time by using as of clause.
 -- flashback query internally use undo query
 --retriving in 2 ways
 --1. using time stamp (UTS)
 --2. using scn (US)
 --synx-- select*from table_name as of timestamp(particular point of time)
 --9i synx-- systimestamp+ interval 'number' minute/hours/sec
 select*from emp as of timestamp (systimestamp -interval '1'minute);
 
 