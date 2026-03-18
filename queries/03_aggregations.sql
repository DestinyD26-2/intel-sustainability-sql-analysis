WITH per_device AS ( 
SELECT 
device_id, 
AVG(energy_savings_yr) AS 
avg_energy_savings_per_device, 
SUM(co2_saved_kg_yr) AS total_co2_saved_per_device 
FROM 
intel.impact_data 
GROUP BY 
device_id  
) 
SELECT 
  model_year, 
  COUNT(*) AS total_devices_repurposed, 
  AVG(2024 - device.model_year) AS avg_device_age_2024, 
  SUM(per_device.avg_energy_savings_per_device) AS 
avg_energy_savings_kwh_per_year, 
   
  SUM(per_device.total_co2_saved_per_device) / 1000.0 
AS total_co2_saved_tons 
FROM 
  per_device 
  LEFT JOIN intel.device_data as device ON 
device.device_id = per_device.device_id 
GROUP BY 
  model_year 
