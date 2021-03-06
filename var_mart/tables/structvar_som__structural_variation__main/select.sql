SELECT
  sv.structural_variation_id as structural_variation_id_2072_key,
  REPLACE(sv.variation_name, ",", "") as variation_name_2072,
  sv.validation_status as validation_status_2072,
  sv.clinical_significance as clinical_significance_2072,
  a.value as value_2092,
  REPLACE(so.name, ",", "") as name_2021,
  so.description as description_2021,
  REPLACE(st.name, ",", "") as name_20100,
  st.description as description_20100,
  st.external_reference as external_reference_20100
FROM
  VAR_DB.structural_variation sv LEFT OUTER JOIN
  VAR_DB.source so ON sv.source_id = so.source_id LEFT OUTER JOIN
  VAR_DB.attrib a ON sv.class_attrib_id = a.attrib_id LEFT OUTER JOIN
  VAR_DB.study st ON sv.study_id = st.study_id
