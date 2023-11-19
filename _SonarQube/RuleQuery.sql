(

/*CS*/

(SELECT LANGUAGE, NAME,
'https://sonarqube.presidio.com/coding_rules?open='||plugin_name||':'||plugin_rule_key||'&rule_key='||plugin_name||':'||plugin_rule_key link,
CASE
      WHEN priority = 1  THEN 'Minor'
      WHEN priority = 2  THEN 'Major'
      WHEN priority = 3  THEN 'Critical'
      WHEN priority = 4  THEN 'Blocker'
      ELSE 'Info'
END priority_name,
CASE
      WHEN rule_type = 1  THEN 'Code Smell'
      WHEN rule_type = 2  THEN 'Bug'
      WHEN rule_type = 3  THEN 'Vulnerability'
      ELSE 'Security Hotspot'
END rule_type_name,
system_tags,
'FALSE' active
from rules where uuid NOT IN (SELECT rule_uuid from active_rules where profile_uuid = 'AYbgj3Semxn4zL3aqO0d') and language = 'cs' and status != 'DEPRECATED')

UNION

(SELECT LANGUAGE, NAME,
'https://sonarqube.presidio.com/coding_rules?open='||plugin_name||':'||plugin_rule_key||'&rule_key='||plugin_name||':'||plugin_rule_key link,
CASE
      WHEN priority = 1  THEN 'Minor'
      WHEN priority = 2  THEN 'Major'
      WHEN priority = 3  THEN 'Critical'
      WHEN priority = 4  THEN 'Blocker'
      ELSE 'Info'
END priority_name,
CASE
      WHEN rule_type = 1  THEN 'Code Smell'
      WHEN rule_type = 2  THEN 'Bug'
      WHEN rule_type = 3  THEN 'Vulnerability'
      ELSE 'Security Hotspot'
END rule_type_name,
system_tags,
'TRUE' active
from rules where uuid IN (SELECT rule_uuid from active_rules where profile_uuid = 'AYbgj3Semxn4zL3aqO0d') and status != 'DEPRECATED')

UNION

/*JavaScript*/

(SELECT LANGUAGE, NAME,
'https://sonarqube.presidio.com/coding_rules?open='||plugin_name||':'||plugin_rule_key||'&rule_key='||plugin_name||':'||plugin_rule_key link,
CASE
      WHEN priority = 1  THEN 'Minor'
      WHEN priority = 2  THEN 'Major'
      WHEN priority = 3  THEN 'Critical'
      WHEN priority = 4  THEN 'Blocker'
      ELSE 'Info'
END priority_name,
CASE
      WHEN rule_type = 1  THEN 'Code Smell'
      WHEN rule_type = 2  THEN 'Bug'
      WHEN rule_type = 3  THEN 'Vulnerability'
      ELSE 'Security Hotspot'
END rule_type_name,
system_tags,
'FALSE' active
from rules where uuid NOT IN (SELECT rule_uuid from active_rules where profile_uuid = 'AYbh5T6Pmxn4zL3aqPXU') and language = 'js' and plugin_rule_key like 'S%' and status != 'DEPRECATED')

UNION

(SELECT LANGUAGE, NAME,
'https://sonarqube.presidio.com/coding_rules?open='||plugin_name||':'||plugin_rule_key||'&rule_key='||plugin_name||':'||plugin_rule_key link,
CASE
      WHEN priority = 1  THEN 'Minor'
      WHEN priority = 2  THEN 'Major'
      WHEN priority = 3  THEN 'Critical'
      WHEN priority = 4  THEN 'Blocker'
      ELSE 'Info'
END priority_name,
CASE
      WHEN rule_type = 1  THEN 'Code Smell'
      WHEN rule_type = 2  THEN 'Bug'
      WHEN rule_type = 3  THEN 'Vulnerability'
      ELSE 'Security Hotspot'
END rule_type_name,
system_tags,
'TRUE' active
from rules where uuid IN (SELECT rule_uuid from active_rules where profile_uuid = 'AYbh5T6Pmxn4zL3aqPXU') and status != 'DEPRECATED')

UNION

/*CSS*/

(SELECT LANGUAGE, NAME,
'https://sonarqube.presidio.com/coding_rules?open='||plugin_name||':'||plugin_rule_key||'&rule_key='||plugin_name||':'||plugin_rule_key link,
CASE
      WHEN priority = 1  THEN 'Minor'
      WHEN priority = 2  THEN 'Major'
      WHEN priority = 3  THEN 'Critical'
      WHEN priority = 4  THEN 'Blocker'
      ELSE 'Info'
END priority_name,
CASE
      WHEN rule_type = 1  THEN 'Code Smell'
      WHEN rule_type = 2  THEN 'Bug'
      WHEN rule_type = 3  THEN 'Vulnerability'
      ELSE 'Security Hotspot'
END rule_type_name,
system_tags,
'FALSE' active
from rules where uuid NOT IN (SELECT rule_uuid from active_rules where profile_uuid = 'AYbh1NuKmxn4zL3aqPRB') and language = 'css' and plugin_rule_key like 'S%' and status != 'DEPRECATED')

UNION

(SELECT LANGUAGE, NAME,
'https://sonarqube.presidio.com/coding_rules?open='||plugin_name||':'||plugin_rule_key||'&rule_key='||plugin_name||':'||plugin_rule_key link,
CASE
      WHEN priority = 1  THEN 'Minor'
      WHEN priority = 2  THEN 'Major'
      WHEN priority = 3  THEN 'Critical'
      WHEN priority = 4  THEN 'Blocker'
      ELSE 'Info'
END priority_name,
CASE
      WHEN rule_type = 1  THEN 'Code Smell'
      WHEN rule_type = 2  THEN 'Bug'
      WHEN rule_type = 3  THEN 'Vulnerability'
      ELSE 'Security Hotspot'
END rule_type_name,
system_tags,
'TRUE' active
from rules where uuid IN (SELECT rule_uuid from active_rules where profile_uuid = 'AYbh1NuKmxn4zL3aqPRB') and status != 'DEPRECATED')

UNION

/*T-SQL*/

(SELECT LANGUAGE, NAME,
'https://sonarqube.presidio.com/coding_rules?open='||plugin_name||':'||plugin_rule_key||'&rule_key='||plugin_name||':'||plugin_rule_key link,
CASE
      WHEN priority = 1  THEN 'Minor'
      WHEN priority = 2  THEN 'Major'
      WHEN priority = 3  THEN 'Critical'
      WHEN priority = 4  THEN 'Blocker'
      ELSE 'Info'
END priority_name,
CASE
      WHEN rule_type = 1  THEN 'Code Smell'
      WHEN rule_type = 2  THEN 'Bug'
      WHEN rule_type = 3  THEN 'Vulnerability'
      ELSE 'Security Hotspot'
END rule_type_name,
system_tags,
'FALSE' active
from rules where uuid NOT IN (SELECT rule_uuid from active_rules where profile_uuid = 'AYbh-lYimxn4zL3aqPv-') and language = 'ts' and plugin_rule_key like 'S%' and status != 'DEPRECATED')

UNION

(SELECT LANGUAGE, NAME,
'https://sonarqube.presidio.com/coding_rules?open='||plugin_name||':'||plugin_rule_key||'&rule_key='||plugin_name||':'||plugin_rule_key link,
CASE
      WHEN priority = 1  THEN 'Minor'
      WHEN priority = 2  THEN 'Major'
      WHEN priority = 3  THEN 'Critical'
      WHEN priority = 4  THEN 'Blocker'
      ELSE 'Info'
END priority_name,
CASE
      WHEN rule_type = 1  THEN 'Code Smell'
      WHEN rule_type = 2  THEN 'Bug'
      WHEN rule_type = 3  THEN 'Vulnerability'
      ELSE 'Security Hotspot'
END rule_type_name,
system_tags,
'TRUE' active
from rules where uuid IN (SELECT rule_uuid from active_rules where profile_uuid = 'AYbh-lYimxn4zL3aqPv-') and status != 'DEPRECATED')

UNION

/*Web*/

(SELECT LANGUAGE, NAME,
'https://sonarqube.presidio.com/coding_rules?open='||plugin_name||':'||plugin_rule_key||'&rule_key='||plugin_name||':'||plugin_rule_key link,
CASE
      WHEN priority = 1  THEN 'Minor'
      WHEN priority = 2  THEN 'Major'
      WHEN priority = 3  THEN 'Critical'
      WHEN priority = 4  THEN 'Blocker'
      ELSE 'Info'
END priority_name,
CASE
      WHEN rule_type = 1  THEN 'Code Smell'
      WHEN rule_type = 2  THEN 'Bug'
      WHEN rule_type = 3  THEN 'Vulnerability'
      ELSE 'Security Hotspot'
END rule_type_name,
system_tags,
'FALSE' active
from rules where uuid NOT IN (SELECT rule_uuid from active_rules where profile_uuid = 'AYbh2nawmxn4zL3aqPUX') and language = 'web' and status != 'DEPRECATED')

UNION

(SELECT LANGUAGE, NAME,
'https://sonarqube.presidio.com/coding_rules?open='||plugin_name||':'||plugin_rule_key||'&rule_key='||plugin_name||':'||plugin_rule_key link,
CASE
      WHEN priority = 1  THEN 'Minor'
      WHEN priority = 2  THEN 'Major'
      WHEN priority = 3  THEN 'Critical'
      WHEN priority = 4  THEN 'Blocker'
      ELSE 'Info'
END priority_name,
CASE
      WHEN rule_type = 1  THEN 'Code Smell'
      WHEN rule_type = 2  THEN 'Bug'
      WHEN rule_type = 3  THEN 'Vulnerability'
      ELSE 'Security Hotspot'
END rule_type_name,
system_tags,
'TRUE' active
from rules where uuid IN (SELECT rule_uuid from active_rules where profile_uuid = 'AYbh2nawmxn4zL3aqPUX') and status != 'DEPRECATED')

UNION

/*T-SQL*/

(SELECT LANGUAGE, NAME,
'https://sonarqube.presidio.com/coding_rules?open='||plugin_name||':'||plugin_rule_key||'&rule_key='||plugin_name||':'||plugin_rule_key link,
CASE
      WHEN priority = 1  THEN 'Minor'
      WHEN priority = 2  THEN 'Major'
      WHEN priority = 3  THEN 'Critical'
      WHEN priority = 4  THEN 'Blocker'
      ELSE 'Info'
END priority_name,
CASE
      WHEN rule_type = 1  THEN 'Code Smell'
      WHEN rule_type = 2  THEN 'Bug'
      WHEN rule_type = 3  THEN 'Vulnerability'
      ELSE 'Security Hotspot'
END rule_type_name,
system_tags,
'FALSE' active
from rules where uuid NOT IN (SELECT rule_uuid from active_rules where profile_uuid = 'AYbgz73Zmxn4zL3aqPKe') and language = 'tsql' and status != 'DEPRECATED')

UNION

(SELECT LANGUAGE, NAME,
'https://sonarqube.presidio.com/coding_rules?open='||plugin_name||':'||plugin_rule_key||'&rule_key='||plugin_name||':'||plugin_rule_key link,
CASE
      WHEN priority = 1  THEN 'Minor'
      WHEN priority = 2  THEN 'Major'
      WHEN priority = 3  THEN 'Critical'
      WHEN priority = 4  THEN 'Blocker'
      ELSE 'Info'
END priority_name,
CASE
      WHEN rule_type = 1  THEN 'Code Smell'
      WHEN rule_type = 2  THEN 'Bug'
      WHEN rule_type = 3  THEN 'Vulnerability'
      ELSE 'Security Hotspot'
END rule_type_name,
system_tags,
'TRUE' active
from rules where uuid IN (SELECT rule_uuid from active_rules where profile_uuid = 'AYbgz73Zmxn4zL3aqPKe') and status != 'DEPRECATED')

)