create table projects(
project_id number primary key,
project_name varchar2(200),
doc_file blob,
doc_file_name varchar2(200),
doc_mime_type varchar2(200),
img_file blob,
img_file_name varchar2(200),
img_mime_type varchar2(200),
last_update date);

create sequence project_id_s start with 1 increment by 1 nocache;

//////////////////////////////////

create or replace function add_project(
p_project_name varchar2,
p_doc_file_name varchar2,
p_img_file_name varchar2) return number is
v_project_id number;
begin
  v_project_id:=project_id_s.nextval;
  insert into projects(
    project_id,
    project_name,
    last_update) values (
    v_project_id,
    p_project_name,
    sysdate);

  for i in (select * from apex_application_temp_files where name=p_doc_file_name
  or name=p_img_file_name) loop
    if upper(i.filename) like '%.JPG' or upper(i.filename) like '%.JPG' then
      update projects set
        img_file = i.blob_content,
        img_file_name = i.filename,
        img_mime_type = i.mime_type
      where project_id = v_project_id;
    else
      update projects set
        doc_file = i.blob_content,
        doc_file_name = i.filename,
        doc_mime_type = i.mime_type
      where project_id = v_project_id;
    end if;
  end loop;
  return v_project_id;
end;

////////////////////////

begin
  :p8_project_id:=add_project(
    p_project_name => :p8_project_name,
    p_doc_file_name => :p8_doc_file,
    p_img_file_name => :p8_img_file);
end;