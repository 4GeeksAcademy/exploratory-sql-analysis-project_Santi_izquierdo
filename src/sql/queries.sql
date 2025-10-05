SELECT * FROM regions; 
SELECT * FROM species;
SELECT * FROM climate;
SELECT * FROM observations;

--¿Cuáles son las primeras 10 observaciones registradas?
SELECT * FROM observations
LIMIT 10;

--¿Qué identificadores de región (region_id) aparecen en los datos?
SELECT DISTINCT region_id FROM observations; 

--¿Cuántas especies distintas (species_id) se han observado?
SELECT COUNT(DISTINCT species_id) AS total_species FROM observations;

--¿Cuántas observaciones hay para la región con region_id = 2?
SELECT * FROM observations
WHERE region_id = 2;

--¿Cuántas observaciones se registraron el día 1998-08-08?
SELECT * FROM observations
WHERE observation_date = '1998-08-08';

--Nivel 2 – Agregación y ordenamiento (GROUP BY, COUNT, ORDER BY, HAVING sin JOIN)

--¿Cuál es el region_id con más observaciones?
SELECT region_id, COUNT(*) AS total_observations
FROM observations
GROUP BY region_id
ORDER BY total_observations DESC;

--¿Cuáles son los 5 species_id más frecuentes?
SELECT species_id, COUNT(*) AS total_records
FROM observations
GROUP BY species_id
ORDER BY total_records DESC
LIMIT 5;

--¿Qué especies (species_id) tienen menos de 5 registros?
SELECT species_id, COUNT(*) AS observation_count
FROM observations
GROUP BY species_id
HAVING observation_count < 5
ORDER BY observation_count ASC;

--¿Qué observadores (observer) registraron más observaciones?
SELECT observer, COUNT(*) AS total
FROM observations
GROUP BY observer
ORDER BY total DESC;

--Nivel 3 – Relaciones entre tablas (JOIN)

--Muestra el nombre de la región (regions.name) para cada observación.
SELECT observations.id, regions.name AS region_name, observations.observation_date
FROM observations
JOIN regions ON observations.region_id = regions.id

--Muestra el nombre científico de cada especie registrada (species.scientific_name).
SELECT observations.id, species.scientific_name
FROM observations
JOIN species ON observations.species_id = species.id;

--¿Cuál es la especie más observada por cada región?
SELECT regions.name AS region, species.scientific_name, COUNT(*) AS total
FROM observations
JOIN species ON observations.species_id = species.id
JOIN regions ON observations.region_id = regions.id
GROUP BY region, species.scientific_name
ORDER BY region, total DESC;
