/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    date_of_birth DATE,
    escape_attempts INTEGER,
    neutered BOOLEAN,
    weight_kg DECIMAL(10, 2)
);

ALTER TABLE animals ADD COLUMN species VARCHAR(255);

CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(255),
    age INTEGER
);

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE vets (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  age INTEGER NOT NULL,
  date_of_graduation DATE NOT NULL
);

CREATE TABLE specializations (
  id SERIAL PRIMARY KEY,
  vet_id INTEGER REFERENCES vets(id),
  species_id INTEGER REFERENCES species(id),
  UNIQUE (vet_id, species_id)
);

CREATE TABLE visits (
  id SERIAL PRIMARY KEY,
  animal_id INTEGER REFERENCES animals(id),
  vet_id INTEGER REFERENCES vets(id),
  visit_date DATE
);
