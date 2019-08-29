/** run only once
create type nt_varchar is table of varchar2(100)
/
if we are using this we no longer need the statement in declare area
**/
declare 
  type nt_varchar is table of varchar2(100);
  d nt_varchar;
  i number;
begin
/** Display the department names of departments with no employees **/
/** select t.DEPARTMENT_NAME from DEPARTMENTS t where  t.DEPARTMENT_ID not in (select DEPARTMENT_ID from EMPLOYEES where DEPARTMENT_ID is not null); **/

  dbms_output.put_line(nvl(SQL%ROWCOUNT,0)||' dep were deleted');
  delete from DEPARTMENTS t where t.DEPARTMENT_ID not in (select DEPARTMENT_ID from EMPLOYEES where DEPARTMENT_ID is not null) returning department_name bulk collect into d;
  dbms_output.put_line(SQL%ROWCOUNT||' departments were deleted');
  d.delete(1,5);/**deletes from position 1 to 5**/
  d.delete(9,11);
  i:=d.first;
  while i is not null loop
    dbms_output.put_line('At position '||i||' was deleted '||d(i));
    i:=d.next(i);
  end loop;
  rollback;
end;

///////////////////

/** Raise the salary of employees from department 80 with 10%.
    Display how many employees got a raise and their names.
**/ 
declare
  type varray_varchar is varray(40) of varchar2(100);
  d nt_varchar;
  i number;
begin
  update employees e set e.salary=e.salary*1.1 where e.department_id=80 returning e.first_name||' '||e.last_name bulk collect into d;
  dbms_output.put_line(SQL%ROWCOUNT||' employees got a raise');
  i:=d.first;
  while i is not null loop
    dbms_output.put_line('At position '||i||' got a raise '||d(i));
    i:=d.next(i);
  end loop;
  rollback;
end;

/////////////////////

/** The total order value for each category id
**/
declare
  cursor c is select t.category_id, sum(o.unit_price*o.quantity) val, count(*) no
    from product_information t join order_items o on t.product_id=o.product_id 
    group by t.category_id order by val desc;
  r c%ROWTYPE;
begin
  if not c%isopen then
    open c;
  end if;
  loop
    fetch c into r;
    exit when c%notfound or c%rowcount=11;
    dbms_output.put_line(r.category_id||' '||r.val||' '||r.no);
  end loop;
close c;
end;