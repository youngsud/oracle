--to check all standard audit options enabled
Col user_name for a20
Col audit_option for a30;
SELECT user_name, audit_option AS audit_option, success, failure
FROM dba_stmt_audit_opts UNION
SELECT user_name, privilege AS audit_option, success, failure
FROM dba_priv_audit_opts UNION
SELECT owner AS user_name, object_name AS audit_option, NULL AS success, NULL AS failure
FROM dba_obj_audit_opts
WHERE owner <> 'SYS'
--Individual objects are not audited though excep 13 objects of SYS
ORDER BY 1,2;
