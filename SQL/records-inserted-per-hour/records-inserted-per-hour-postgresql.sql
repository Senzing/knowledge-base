SELECT
  date_trunc('hour', first_seen_dt) as time,
  count(*) inserts_per_hour
FROM
  dsrc_record
GROUP BY
  time
ORDER BY
  time asc;