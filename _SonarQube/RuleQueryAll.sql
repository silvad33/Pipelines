SELECT
		rules.plugin_key,
		rules.NAME,
		CASE
		      WHEN rules.priority = 1  THEN 'Minor'
		      WHEN rules.priority = 2  THEN 'Major'
		      WHEN rules.priority = 3  THEN 'Critical'
		      WHEN rules.priority = 4  THEN 'Blocker'
		      ELSE 'Info'
		END priority_name,
		CASE
		      WHEN rules.rule_type = 1  THEN 'Code Smell'
		      WHEN rules.rule_type = 2  THEN 'Bug'
		      WHEN rules.rule_type = 3  THEN 'Vulnerability'
		      ELSE 'Security Hotspot'
		END rule_type_name,
		rules.system_tags ,
		rules.plugin_rule_key,
		rules.plugin_name,
		rule_desc_sections.content
	FROM
		rules, rule_desc_sections
	WHERE
		rules.status = 'READY'
		AND rule_desc_sections.rule_uuid = rules.uuid
	ORDER BY
		rules.plugin_key,
		rules.NAME