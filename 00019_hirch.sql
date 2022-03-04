 /*
 --In all relational dbwe can also store hierchical data in relational db
 --If we want to store hierchical data then relational table must contain minimum 3 column
 and also in these 3 columns 2 columns must have same datatype and also data must be related.
 --If we want to retrive hierchical data then we are using following clause
 --1)level -- level is a psuedo column which automatically assign number to each levelwith in tree structure
 --2)start with -- through start with clause we can specify searching condition with in hierchical
 --3)connect by -- through connect by clause we can specify relation between hierchical column by using prior operator
 --Prior--
 Prior is an uniary operator used in connect by clause whenever we are using prior operator infront of the child column(empno)then oracle server
 uses top to bottom search with in hierarchy where as when we are using prior operator infront of the parent column then oracvle server uses
 bottom to top search with in the hierchy
  */
  select level,sys_connect_by_path(ename,'->')
  from emp start with mgr is null connect by prior empno=mgr;
  
  