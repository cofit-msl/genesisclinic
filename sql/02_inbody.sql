SELECT
  member_id AS client_id,
  clients.mobile,
  measurements.date AS date_inbody,
  data->'height' AS height, 
  data->'weight' AS weight, 
  data->'bmi' AS bmi, 
  data->'body_fat_mass' AS body_fat_mass, 
  data->'body_fat_mass_percentage' AS body_fat_mass_percentage, 
  data->'weight_without_fat' AS weight_without_fat, 
  data->'muscle_mass' AS muscle_mass, 
  data->'real_muscle_mass' AS real_muscle_mass, 
  data->'vfa' AS vfa, 
  data->'vfa_level' AS vfa_level, 
  data->'waist_circumference' AS waist_circumference, 
  data->'acl' AS acl, 
  data->'cacl' AS cacl, 
  data->'total_body_water' AS total_body_water, 
  data->'protein_weight' AS protein_weight, 
  data->'mineral_weight' AS mineral_weight, 
  data->'body_cell_mass' AS body_cell_mass, 
  data->'body_mineral' AS body_mineral, 
  data->'bfmi' AS bfmi, 
  data->'bsmi' AS bsmi, 
  data->'ffmi' AS ffmi,
  blood_data.systolic_blood_pressure,
  blood_data.diastolic_blood_pressure,
  blood_data.pulse,
--  data->'systolic_blood_pressure' AS systolic_blood_pressure,
--  data->'diastolic_blood_pressure' AS diastolic_blood_pressure,
--  data->'pulse' AS pulse,
  data->'bmr' AS bmr, 
  data->'wepa50' AS wepa50, 
  data->'algle_50_left_arm' AS algle_50_left_arm, 
  data->'algle_50_left_leg' AS algle_50_left_leg, 
  data->'algle_50_right_arm' AS algle_50_right_arm, 
  data->'algle_50_right_leg' AS algle_50_right_leg, 
  data->'algle_50_trunk' AS algle_50_trunk, 
  data->'extracellular_water_ratio' AS extracellular_water_ratio, 
  data->'extracellular_water_ratio_left_arm' AS extracellular_water_ratio_left_arm, 
  data->'extracellular_water_ratio_left_leg' AS extracellular_water_ratio_left_leg, 
  data->'extracellular_water_ratio_right_arm' AS extracellular_water_ratio_right_arm, 
  data->'extracellular_water_ratio_right_leg' AS extracellular_water_ratio_right_leg, 
  data->'extracellular_water_ratio_trunk' AS extracellular_water_ratio_trunk, 
  data->'intracellular_weight' AS intracellular_weight, 
  data->'intracellular_weight_left_arm' AS intracellular_weight_left_arm, 
  data->'intracellular_weight_left_leg' AS intracellular_weight_left_leg, 
  data->'intracellular_weight_right_arm' AS intracellular_weight_right_arm, 
  data->'intracellular_weight_right_leg' AS intracellular_weight_right_leg, 
  data->'intracellular_weight_trunk' AS intracellular_weight_trunk, 
  data->'extracellular_weight' AS extracellular_weight, 
  data->'extracellular_weight_left_arm' AS extracellular_weight_left_arm, 
  data->'extracellular_weight_left_leg' AS extracellular_weight_left_leg, 
  data->'extracellular_weight_right_arm' AS extracellular_weight_right_arm, 
  data->'extracellular_weight_right_leg' AS extracellular_weight_right_leg, 
  data->'extracellular_weight_trunk' AS extracellular_weight_trunk, 
  data->'left_arm_fat' AS left_arm_fat, 
  data->'left_arm_fat_percentage' AS left_arm_fat_percentage, 
  data->'left_arm_muscle' AS left_arm_muscle, 
  data->'left_arm_muscle_percentage' AS left_arm_muscle_percentage, 
  data->'left_leg_fat' AS left_leg_fat, 
  data->'left_leg_fat_percentage' AS left_leg_fat_percentage, 
  data->'left_leg_muscle' AS left_leg_muscle, 
  data->'left_leg_muscle_percentage' AS left_leg_muscle_percentage, 
  data->'right_arm_fat' AS right_arm_fat, 
  data->'right_arm_fat_percentage' AS right_arm_fat_percentage, 
  data->'right_arm_muscle' AS right_arm_muscle, 
  data->'right_arm_muscle_percentage' AS right_arm_muscle_percentage, 
  data->'right_leg_fat' AS right_leg_fat, 
  data->'right_leg_fat_percentage' AS right_leg_fat_percentage, 
  data->'right_leg_muscle_percentage' AS right_leg_muscle_percentage, 
  data->'right_leg_muscle' AS right_leg_muscle, 
  data->'trunk_fat' AS trunk_fat, 
  data->'trunk_fat_percentage' AS trunk_fat_percentage, 
  data->'trunk_muscle' AS trunk_muscle, 
  data->'trunk_muscle_percentage' AS trunk_muscle_percentage, 
  data->'water_weight_left_arm' AS water_weight_left_arm, 
  data->'water_weight_left_leg' AS water_weight_left_leg, 
  data->'water_weight_right_arm' AS water_weight_right_arm, 
  data->'water_weight_right_leg' AS water_weight_right_leg, 
  data->'water_weight_trunk' AS water_weight_trunk, 
  data->'waist_hip_ratio' AS waist_hip_ratio, 
  data->'tbwffm' AS tbwffm, 
  data->'obesity_degree' AS obesity_degree, 
  data->'inbody_total_score' AS inbody_total_score, 
  equip_brand, 
  equip_model, 
  equip_serial, 
  member_type
FROM (
  SELECT * FROM measurements
  WHERE equip_brand = 'InBody'
) AS measurements
LEFT JOIN (
  SELECT 
  member_id AS client_id,
  date,
  data->'systolic_blood_pressure' AS systolic_blood_pressure,
  data->'diastolic_blood_pressure' AS diastolic_blood_pressure,
  data->'pulse' AS pulse
  FROM measurements
  WHERE equip_brand = 'imedtac'
) AS blood_data
  ON blood_data.client_id = measurements.member_id
  AND blood_data.date = measurements.date
INNER JOIN clients
ON clients.id = measurements.member_id
WHERE member_type = 'Client'
--  and data->>'pulse' IS NOt NULL
  

-- SELECT *, equip_brand from measurements where data->>'extracelluar_water_ratio_left_leg' is not null
