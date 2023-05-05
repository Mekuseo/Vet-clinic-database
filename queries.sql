/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
select species FROM animals
COMMIT;
SELECT species FROM animals;

BEGIN;
DELETE FROM animals Where;
SELECT COUNT(*) FROM animals;
ROLLBACK;
SELECT COUNT(*) FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT my_savepoint;
UPDATE animals SET weight_kg = weight_kg * (-1);
ROLLBACK TO my_savepoint;
UPDATE animals SET weight_kg = weight_kg * (-1) WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;

SELECT neutered, SUM(escape_attempts) as total_escapes
FROM animals
GROUP BY neutered
ORDER BY total_escapes DESC
LIMIT 1;

SELECT species, MIN(weight_kg), MAX(weight_kg)
FROM animals
GROUP BY species;

SELECT species, AVG(escape_attempts) as avg_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

//--------------------------------------------------------------------

SELECT * FROM animals 
INNER JOIN owners ON animals.owner_id = owners.id 
WHERE owners.full_name = 'Melody Pond';

SELECT animals.name FROM animals 
INNER JOIN species ON animals.species_id = species.id 
WHERE species.name = 'Pokemon';

SELECT owners.full_name, animals.name 
FROM owners 
LEFT JOIN animals ON owners.id = animals.owner_id;

SELECT species.name, COUNT(*) as count 
FROM animals 
INNER JOIN species ON animals.species_id = species.id 
GROUP BY species.name;

SELECT animals.name FROM animals 
INNER JOIN species ON animals.species_id = species.id 
INNER JOIN owners ON animals.owner_id = owners.id 
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

SELECT animals.name FROM animals 
INNER JOIN owners ON animals.owner_id = owners.id 
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

SELECT owners.full_name, COUNT(*) as count 
FROM animals 
INNER JOIN owners ON animals.owner_id = owners.id 
GROUP BY owners.full_name 
ORDER BY count DESC 
LIMIT 1;

SELECT animals.name
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.visit_date DESC
LIMIT 1;

SELECT COUNT(DISTINCT visits.animal_id)
FROM visits
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez';

SELECT vets.name, specializations.species_id
FROM vets
LEFT JOIN specializations ON vets.id = specializations.vet_id
LEFT JOIN species ON specializations.species_id = specializations.id;

SELECT animals.name
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez'
AND visits.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

SELECT animals.name, COUNT(*) AS num_visits
FROM animals
JOIN visits ON animals.id = visits.animal_id
GROUP BY animals.name
ORDER BY num_visits DESC
LIMIT 1;

SELECT vets.name
FROM vets
JOIN visits ON vets.id = visits.vet_id
JOIN animals ON visits.animal_id = animals.id
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Maisy Smith'
ORDER BY visits.visit_date ASC
LIMIT 1;

SELECT animals.name AS animal_name, vets.name AS vet_name, visits.visit_date
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
ORDER BY visits.visit_date DESC
LIMIT 1;

SELECT COUNT(*)
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
LEFT JOIN specializations ON (vets.id = specializations.vet_id AND animals.species_id = specializations.species_id)
WHERE specializations.id IS NULL;

SELECT specializations.species_id
FROM specializations
JOIN (SELECT animals.species_id, COUNT(*) AS num_visits
      FROM animals
      JOIN visits ON animals.id = visits.animal_id
      WHERE animals.owner_id = (SELECT id FROM owners WHERE name = 'Maisy Smith')
      GROUP BY animals.species_id
      ORDER BY num_visits DESC
      LIMIT 1) AS most_visited_species ON specializations.id = most_visited_species.species_id;
