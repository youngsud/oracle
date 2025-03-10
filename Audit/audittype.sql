--to check  if standard/fga/unified/mixed mode auditing

SELECT 'Standard Auditing' AS AUDIT_TYPE, (CASE WHEN (UPPER(value) IN ('DB', 'XML', 'OS', 'DB_EXTENDED', 'XML_EXTENDED')) THEN 'Enabled' ELSE 'Disabled' END) AS STATUS
FROM v$parameter
WHERE name = 'audit_trail' UNION ALL
SELECT 'Fine-Grained Auditing (FGA)' AS AUDIT_TYPE, (CASE WHEN EXISTS
(SELECT 1
FROM dba_audit_policies) THEN 'Enabled' ELSE 'Disabled' END) AS STATUS
FROM dual UNION ALL
SELECT 'Unified Auditing' AS AUDIT_TYPE, (CASE WHEN
(SELECT value
FROM v$option
WHERE parameter = 'Unified Auditing') = 'TRUE' THEN 'Enabled' ELSE 'Disabled' END) AS STATUS
FROM dual UNION ALL
SELECT 'Mixed Mode Auditing' AS AUDIT_TYPE, (CASE WHEN EXISTS
(SELECT 1
FROM audit_unified_enabled_policies) THEN 'Enabled' ELSE 'Disabled' END) AS STATUS
FROM dual;
