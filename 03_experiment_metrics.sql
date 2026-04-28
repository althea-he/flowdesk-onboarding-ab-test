WITH xp AS (
  SELECT
    unit_id AS account_id,
    `group`
  FROM `fabriziopublic.flowdesk.experiment_groups`
  WHERE experiment_name = 'onboarding_email_v1'
),

accounts AS (
  SELECT
    account_id,
    converted_at,
    churned_at
  FROM `fabriziopublic.flowdesk.dim_account`
  WHERE DATE(trial_start_at) BETWEEN '2025-09-15' AND '2025-09-28'
),

activity AS (
  SELECT
    account_id,
    COUNT(DISTINCT active_date) AS active_days,
    SUM(n_features) AS total_features
  FROM `fabriziopublic.flowdesk.fact_activity`
  WHERE active_date BETWEEN '2025-09-15' AND '2025-09-28'
  GROUP BY account_id
),

account_metrics AS (
  SELECT
    xp.`group`,
    xp.account_id,
    COALESCE(act.active_days, 0) AS active_days,
    COALESCE(act.total_features, 0) AS total_features,
    CASE WHEN COALESCE(act.active_days, 0) > 0 THEN 1 ELSE 0 END AS activated,
    CASE WHEN DATE(a.converted_at) BETWEEN '2025-09-15' AND '2025-09-28' THEN 1 ELSE 0 END AS converted,
    CASE WHEN DATE(a.churned_at) BETWEEN '2025-09-15' AND '2025-09-28' THEN 1 ELSE 0 END AS churned
  FROM xp
  JOIN accounts a
    ON xp.account_id = a.account_id
  LEFT JOIN activity act
    ON xp.account_id = act.account_id
)

SELECT
  `group`,
  COUNT(*) AS n_accounts,

  AVG(active_days) AS avg_active_days,
  STDDEV_SAMP(active_days) AS sd_active_days,

  AVG(activated) AS activation_rate,
  STDDEV_SAMP(activated) AS sd_activation,

  AVG(converted) AS conversion_rate,
  STDDEV_SAMP(converted) AS sd_conversion,

  AVG(churned) AS churn_rate_account_level,
  STDDEV_SAMP(churned) AS sd_churn_account_level,

  SUM(total_features) / NULLIF(SUM(active_days), 0) AS feature_intensity_per_active_day,
  AVG(total_features) AS avg_total_features,
  AVG(active_days) AS avg_active_days_for_ratio,
  VAR_SAMP(total_features) AS var_total_features,
  VAR_SAMP(active_days) AS var_active_days_ratio,
  COVAR_SAMP(total_features, active_days) AS cov_features_active_days

FROM account_metrics
GROUP BY `group`
ORDER BY `group`;