TRIGGERS
->DML statements
before		after
-insert			instead of
-update	->statement level
-delete ->for each row

tables			views

create or replace trigger check_hour
  before update or insert or delete on orders
begin
  if to_char(sysdate, 'hh24:mi')>='17:00' then
    raise_application_error(-200001, 'No modifications are permitted after 5pm');
  end if;
end;

create or replace trigger check_hour
  after update or insert or delete on orders
declare
  x char(1);
begin
  if to_char(sysdate, 'hh24:mi')>='17:00' then
    raise_application_error(-200001, 'No modifications are permitted after 5pm');
    rollback;
  end if;
  
  x:=case when INSERTING then 'I' when UPDATING then 'U' else 'D' end; 
  insert into log_modification values
    (log_modifications_id_s.nextval,x,user,sysdate);

end;


///////

create table log_modification(
log_id number primary key,
mod_type char(1),
log_user varchar2(100),
log_date date);

create sequence log_modifications_id_s start with 1 increment by 1 nocache;

/////////

create or replace trigger check_salary
  before insert or update or delete
  of salary on employees for each row
  when(new.salary>old.salary*1.1) /** we can drop the if statement if we are using when**/
begin
  /**if :new.salary>:old.salary*1.1 then**/
    /**raise_application_error(-20002,'Exotic salary raise');**/
  /**end if;**/
  :new.salary:=:old.salary*0.9;
end;

update employees set salary=50000 where employee_id=120;