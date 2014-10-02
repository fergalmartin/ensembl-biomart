SELECT
  v.variation_id as variation_id_2025_key,
  vs.name as name_2030,
  s.source_id as source_id_2021,
  s.name as name_2021,
  s.description as description_2021
FROM
  VAR_DB.variation_synonym vs INNER JOIN
  VAR_DB.source s ON vs.source_id = s.source_id RIGHT OUTER JOIN
  VAR_DB.variation v ON vs.variation_id = v.variation_id
