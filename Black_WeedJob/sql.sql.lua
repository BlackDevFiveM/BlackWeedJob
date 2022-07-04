-- Job By Black
-- Discord : https://discord.gg/mPqYzkem75 

INSERT INTO `addon_account` (name, label, shared) VALUES
  ('society_weedshop', 'weedshop', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
  ('society_weedshop', 'weedshop', 1),
  ('society_weedshop_fridge', 'weedshop (frigo)', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
    ('society_weedshop', 'weedshop', 1)
;

INSERT INTO `jobs` (name, label) VALUES
  ('weedshop', 'weedshop')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
  ('weedshop', 0, 'recruit', 'Équipier', 300, '{}', '{}'),
  ('weedshop', 1, 'employed', 'Formateur', 300, '{}', '{}'),
  ('weedshop', 2, 'viceboss', 'Manager', 500, '{}', '{}'),
  ('weedshop', 3, 'boss', 'Gérant', 600, '{}', '{}')
;

INSERT INTO `items` (`name`, `label`) VALUES
('weed', 'Weed'),
('weed_pooch', 'Pochon de Weed'),
('splif', 'Splif')