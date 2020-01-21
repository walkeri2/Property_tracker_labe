DROP TABLE IF EXISTS property_tracker;

CREATE TABLE property_tracker(
  id SERIAL PRIMARY KEY,
  value INT,
  number_of_bedrooms INT,
  year_built INT,
  address VARCHAR(255)
);
