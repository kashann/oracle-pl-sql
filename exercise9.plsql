create or replace procedure "EDIT_PROJECT"
(p_project_id  NUMBER,
p_project_name  VARCHAR2,
p_doc_file_name  VARCHAR2,
p_img_file_name  VARCHAR2)
is
V_ID_PROJECT NUMBER;
BEGIN
if upper(P_DOC_FILE_NAME) not like '%.DOC' and upper(P_DOC_FILE_NAME) not like '%.DOCX' and upper(P_DOC_FILE_NAME) not like '%.PDF' then
    raise_application_error(-20001, 'The file must have one of the following extensions: .doc, .docx or .pdf');
elsif upper(P_IMG_FILE_NAME) not like '%.JPG' and upper(P_DOC_FILE_NAME) not like '%.PNG' then
    raise_application_error(-20002, 'The file must have one of the following extensions: .jpg or .png');
end if;
V_ID_PROJECT := PROJECT_ID_S.NEXTVAL;
UPDATE PROJECTS P SET P.PROJECT_NAME=P_PROJECT_NAME, P.LAST_UPDATE=SYSDATE WHERE PROJECT_ID=P_PROJECT_ID;
FOR I IN (SELECT * FROM APEX_APPLICATION_TEMP_FILES WHERE NAME= P_DOC_FILE_NAME OR NAME= P_IMG_FILE_NAME) LOOP
IF UPPER(I.FILENAME) LIKE '%.JPG' OR UPPER(I.FILENAME) LIKE '%.PNG' THEN
   UPDATE PROJECTS SET	
IMG_FILE = I.BLOB_CONTENT,
IMG_FILE_NAME = I.FILENAME,
IMG_MIME_TYPE = I.MIME_TYPE
   WHERE PROJECT_ID=V_ID_PROJECT ;
ELSE
   UPDATE PROJECTS SET	
DOC_FILE = I.BLOB_CONTENT,
DOC_FILE_NAME = I.FILENAME,
DOC_MIME_TYPE = I.MIME_TYPE
   WHERE PROJECT_ID=V_ID_PROJECT ;
END IF;
END LOOP;
END;