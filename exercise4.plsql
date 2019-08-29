begin
  execute immediate 'create table new_clients(client_id number primary key, name varchar2(100), cnp varchar2(13), enr_date date)';
  dbms_output.put_line('Table created!');
  exception
    when others then
      execute immediate 'drop table new_clients';
      dbms_output.put_line('Table dropped!');
end;


begin
  execute immediate 'create sequence client_id_s start with 1 increment by 1 nocache';
end;

/**drop sequence client_id_s;**/

select client_id_s.nextval from dual;
select client_id_s.currval from dual; /**face figuri in apex**/