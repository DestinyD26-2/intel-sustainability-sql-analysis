SELECT *,
       (2024 - model_year) AS device_age
FROM intel.impact_data AS impact
LEFT JOIN intel.device_data AS device
ON device.device_id = impact.device_id;
