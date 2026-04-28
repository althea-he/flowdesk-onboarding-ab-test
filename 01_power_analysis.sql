WITH accounts AS (
  SELECT
    account_id,
    DATE(trial_start_at) AS trial_start_date
  FROM `fabriziopublic.flowdesk.dim_account`
  WHERE DATE(trial_start_at) BETWEEN '2025-09-01' AND '2025-09-14'
),

activity AS (
  SELECT
    account_id,
    COUNT(DISTINCT active_date) AS active_days
  FROM `fabriziopublic.flowdesk.fact_activity`
  WHERE active_date BETWEEN '2025-09-01' AND '2025-09-28'
  GROUP BY account_id
),

account_metrics AS (
  SELECT
    a.account_id,
    COALESCE(act.active_days, 0) AS active_days
  FROM accounts a
  LEFT JOIN activity act
    ON a.account_id = act.account_id
)

SELECT
  COUNT(*) AS n_accounts,
  AVG(active_days) AS baseline_mean_active_days,
  STDDEV_SAMP(active_days) AS sd_active_days,
  0.22 * AVG(active_days) AS minimum_detectable_effect,
  2 * POWER(
    STDDEV_SAMP(active_days) * (1.96 + 0.84) / (0.22 * AVG(active_days)),
    2
  ) AS required_n_per_group
FROM account_metrics;