WITH per_device AS ( 
  SELECT 
    region, 
    impact.device_id, 
    device.device_type, 
    AVG(impact.energy_savings_yr) AS 
avg_energy_savings_per_device, 
    SUM(impact.co2_saved_kg_yr) AS 
total_co2_saved_per_device, 
    2024 - device.model_year AS device_age_2024 
  FROM 
    intel.impact_data AS impact 
    JOIN intel.device_data AS device ON 
device.device_id = impact.device_id 
  GROUP BY 
    region, 
    impact.device_id, 
    device.device_type, 
    device.model_year 
) 
SELECT 
  region, 
  COUNT(*) AS total_devices_repurposed, 
  AVG(avg_energy_savings_per_device) AS 
avg_energy_savings_kwh_per_device, 
  SUM(total_co2_saved_per_device) / 1000.0 AS 
total_co2_saved_tons 
FROM 
  per_device 
GROUP BY 
  region 
ORDER BY 
  region 
