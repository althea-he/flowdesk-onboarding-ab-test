SELECT
  `group`,
  COUNT(*) AS n_accounts
FROM `fabriziopublic.flowdesk.experiment_groups`
WHERE experiment_name = 'onboarding_email_v1'
GROUP BY `group`
ORDER BY `group`;