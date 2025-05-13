-- database\mobile_surf_database.sql

CREATE TABLE `SurfSpot`(
    `surf_spot_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `destination` VARCHAR(255) NOT NULL,
    `address` VARCHAR(255) NOT NULL,
    `state_country` VARCHAR(255) NULL,
    `difficulty_level` TINYINT NULL,
    `peak_season_begin` DATE NULL,
    `peak_season_end` DATE NULL,
    `magic_seaweed_link` VARCHAR(255) NULL,
    `created_time` DATETIME NULL,
    `geocode_raw` TEXT NULL
);
ALTER TABLE
    `SurfSpot` ADD INDEX `surfspot_peak_season_begin_index`(`peak_season_begin`);
ALTER TABLE
    `SurfSpot` ADD INDEX `surfspot_peak_season_end_index`(`peak_season_end`);
CREATE TABLE `Influencer`(
    `influencer_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `influencer_name` VARCHAR(255) NULL
);
CREATE TABLE `SurfSpot_Influencer`(
    `surf_spot_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `influencer_id` INT NOT NULL
);
CREATE TABLE `SurfBreakType`(
    `surf_break_type_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `surf_break_type_name` VARCHAR(255) NOT NULL
);
ALTER TABLE
    `SurfBreakType` ADD UNIQUE `surfbreaktype_surf_break_type_name_unique`(`surf_break_type_name`);
CREATE TABLE `SurfSpot_SurfBreakType`(
    `surf_spot_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `surf_break_type_id` INT NOT NULL
);
CREATE TABLE `Photo`(
    `photo_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `surf_spot_id` INT NOT NULL,
    `width` INT NULL,
    `height` INT NULL,
    `url` TEXT NULL,
    `filename` VARCHAR(255) NULL,
    `size_bytes` INT NULL,
    `mime_type` VARCHAR(255) NULL
);
CREATE TABLE `Thumbnail`(
    `photo_id` INT NOT NULL,
    `kind` ENUM('small', 'large', 'full') NOT NULL,
    `url` TEXT NULL,
    `width` INT NULL,
    `height` INT NULL
);
CREATE TABLE `Traveller`(
    `traveller_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `traveller_name` VARCHAR(255) NOT NULL
);
CREATE TABLE `SurfSpot_Traveller`(
    `surf_spot_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `traveller_id` INT NOT NULL
);
ALTER TABLE
    `SurfSpot_Traveller` ADD CONSTRAINT `surfspot_traveller_surf_spot_id_foreign` FOREIGN KEY(`surf_spot_id`) REFERENCES `SurfSpot`(`surf_spot_id`);
ALTER TABLE
    `Photo` ADD CONSTRAINT `photo_surf_spot_id_foreign` FOREIGN KEY(`surf_spot_id`) REFERENCES `SurfSpot`(`surf_spot_id`);
ALTER TABLE
    `SurfSpot_Influencer` ADD CONSTRAINT `surfspot_influencer_surf_spot_id_foreign` FOREIGN KEY(`surf_spot_id`) REFERENCES `SurfSpot`(`surf_spot_id`);
ALTER TABLE
    `SurfSpot_Traveller` ADD CONSTRAINT `surfspot_traveller_traveller_id_foreign` FOREIGN KEY(`traveller_id`) REFERENCES `Traveller`(`traveller_id`);
ALTER TABLE
    `SurfSpot_SurfBreakType` ADD CONSTRAINT `surfspot_surfbreaktype_surf_spot_id_foreign` FOREIGN KEY(`surf_spot_id`) REFERENCES `SurfSpot`(`surf_spot_id`);
ALTER TABLE
    `SurfSpot_SurfBreakType` ADD CONSTRAINT `surfspot_surfbreaktype_surf_break_type_id_foreign` FOREIGN KEY(`surf_break_type_id`) REFERENCES `SurfBreakType`(`surf_break_type_id`);
ALTER TABLE
    `SurfSpot_Influencer` ADD CONSTRAINT `surfspot_influencer_influencer_id_foreign` FOREIGN KEY(`influencer_id`) REFERENCES `Influencer`(`influencer_id`);
ALTER TABLE
    `Thumbnail` ADD CONSTRAINT `thumbnail_photo_id_foreign` FOREIGN KEY(`photo_id`) REFERENCES `Photo`(`photo_id`);

-- Insert influencers
INSERT INTO Influencer (influencer_id, influencer_name) VALUES
  (1, 'recD1zp1pQYc8O7l2'),
  (2, 'rec1ptbRPxhS8rRun'),
  (3, 'recSkJ4HuvzAUBrdd');

-- Insert traveller
INSERT INTO Traveller (traveller_id, traveller_name) VALUES
  (1, 'recWK6tW3LZH5eeWY');

-- Insert surf break types
INSERT INTO SurfBreakType (surf_break_type_id, surf_break_type_name) VALUES
  (1, 'Reef Break'),
  (2, 'Point Break'),
  (3, 'Outer Banks'),
  (4, 'Beach Break');

-- Insert surf spots
INSERT INTO SurfSpot (surf_spot_id, destination, address, state_country, difficulty_level, peak_season_begin, peak_season_end, magic_seaweed_link, created_time, geocode_raw) VALUES
  (1, 'Pipeline', 'Pipeline, Oahu, Hawaii', 'Oahu, Hawaii', 4, '2024-07-22', '2024-08-31', 'https://magicseaweed.com/Pipeline-Backdoor-Surf-Report/616/', '2018-05-31 00:16:16', 'eyJpIjoiUGlwZWxpbmUsIE9haHUsIEhhd2FhaSIsIm8iOnsic3RhdHVzIjoiT0siLCJmb3JtYXR0ZWRBZGRyZXNzIjoiRWh1a2FpIEJlYWNoIFBhcmssIEhhbGVpd2EsIEhJIDk2NzEyLCBVbml0ZWQgU3RhdGVzIiwibGF0IjoyMS42NjUwNTYyLCJsbmciOi0xNTguMDUxMjA0Njk5OTk5OTd9LCJlIjoxNTM1MzA3MDE5OTE1fQ=='),
  (2, 'Supertubes', 'Supertubes, Jeffreys Bay, South Africa', 'Jeffreys Bay, South Africa', 5, '2024-08-01', '2024-10-09', 'https://magicseaweed.com/Jeffreys-Bay-J-Bay-Surf-Report/88/', '2018-05-31 00:51:11', 'eyJpIjoiU3VwZXJ0dWJlcywgSmVmZnJleXMgQmF5LCBTb3V0aCBBZnJpY2EiLCJvIjp7InN0YXR1cyI6Ik9LIiwiZm9ybWF0dGVkQWRkcmVzcyI6IjEyIFBlcHBlciBTdCwgRmVycmVpcmEgVG93biwgSmVmZnJleXMgQmF5LCA2MzMwLCBTb3V0aCBBZnJpY2EiLCJsYXQiOi0zNC4wMzE3ODMsImxuZyI6MjQuOTMxNTk0MDAwMDAwMDJ9LCJlIjoxNTM1MzA3MDI3OTc1fQ=='),
  (3, 'Manu Bay', 'Manu Bay, Raglan, New Zealand', 'Raglan, New Zealand', 2, '2023-12-01', '2024-01-31', 'https://magicseaweed.com/Raglan-Surf-Report/91/', '2018-06-26 16:51:23', 'eyJpIjoiTWFudSBCYXksIFJhZ2xhbiwgTmV3IFplYWxhbmQiLCJvIjp7InN0YXR1cyI6Ik9LIiwiZm9ybWF0dGVkQWRkcmVzcyI6Ik1hbnUgQmF5IFJkLCBSYWdsYW4gMzI5NywgTmV3IFplYWxhbmQiLCJsYXQiOi0zNy44MjE0NTkyLCJsbmciOjE3NC44MTIyMTYxOTk5OTk5N30sImUiOjE1MzUzMDcwMjYwNTJ9'),
  (4, 'Superbank', 'Superbank, Gold Coast, Australia', 'Gold Coast, Australia', 4, '2023-11-28', '2024-02-01', 'https://magicseaweed.com/Surfers-Paradise-Gold-Coast-Surf-Report/1012/', '2018-05-31 00:16:16', 'eyJpIjoiU3VwZXJiYW5rLCBHb2xkIENvYXN0LCBBdXN0cmFsaWEiLCJvIjp7InN0YXR1cyI6Ik9LIiwiZm9ybWF0ZWRBZGRyZXNzIjoiU25hcHBlciBSb2NrcyBSZCwgQ29vbGFuZ2F0dGEgUUxEIDQyMjUsIEF1c3RyYWxpYSIsImxhdCI6LTI4LjE2MjU1NywibG5nIjoxNTMuNTUwMDI4ODAwMDAwMDZ9LCJlIjoxNTM1MzA3MDIyMDE1fQ=='),
  (5, 'Kitty Hawk', 'Kitty Hawk, Outer Banks, North Carolina', 'Outer Banks, North Carolina', 3, '2024-08-09', '2024-10-18', 'https://magicseaweed.com/North-Carolina-Outer-Banks-North-Surfing/283/', '2018-06-26 16:54:50', 'eyJpIjoiS2l0dHkgSGF3aywgT3V0ZXIgQmFua3MsIE5vcnRoIENhcm9saW5hIiwibyI6eyJzdGF0dXMiOiJPSyIsImZvcm1hdHRlZEFkZHJlc3MiOiI1MzUzIE4gVmlyZ2luaWEgRGFyZSBUcmFpbCwgS2l0dHkgSGF3aywgTkMgMjc5NDksIFVTQSIsImxhdCI6MzYuMTAwNTc3NywibG5nIjotNzUuNzExOTU1Njk5OTk5OTh9LCJlIjoxNTM1MzA3MDI3MTM5fQ=='),
  (6, 'Pasta Point', 'Pasta Point, Maldives', 'Maldives', 3, '2024-04-01', '2024-05-31', 'https://magicseaweed.com/Maldives-Surf-Forecast/56/', '2018-06-26 16:49:56', 'eyJpIjoiUGFzdGEgUG9pbnQsIE1hbGRpdmVzIiwibyI6eyJzdGF0dXMiOiJPSyIsImZvcm1hdHRlZEFkZHJlc3MiOiJNYWxlIE5vcnRoIEhhcmJvdXIsIEJvZHV0aGFrdXJ1ZmFhbnUgTWFndSwgTWFsw6ksIE1hbGRpdmVzIiwibGF0Ijo0LjMxNzg0MiwibG5nIjo3My41OTE3MzI5OTk5OTk5OH0sImUiOjE1MzUzMDcwMzA5MTJ9'),
  (7, 'Playa Chicama', 'Playa Chicama, Lima, Peru', 'Lima, Peru', 3, '2024-05-01', '2024-06-28', 'https://magicseaweed.com/Southern-Peru-Surfing/378/', '2018-06-26 16:43:44', 'eyJpIjoiUGxheWEgQ2hpY2FtYSwgTGltYSwgUGVydSIsIm8iOnsic3RhdHVzIjoiT0siLCJmb3JtYXR0ZWRBZGRyZXNzIjoiUHVlcnRvIE1hbGFicmlnbywgUGVydSIsImxhdCI6LTcuNzAwMTcyNCwibG5nIjotNzkuNDMzODE4Nzk5OTk5OTh9LCJlIjoxNTM1MzA3MDI0OTY5fQ=='),
  (8, 'Rockaway Beach', 'Rockaway Beach, Tillamook, Oregon', 'Tillamook, Oregon', 1, '2024-08-23', '2024-10-17', 'https://magicseaweed.com/Rockaway-Surf-Report/384/', '2018-06-26 16:49:46', 'eyJpIjoiUm9ja2F3YXkgQmVhY2gsIFF1ZWVucywgTmV3IFlvcmsiLCJvIjp7InN0YXR1cyI6Ik9LIiwiZm9ybWF0dGVkQWRyZXNzIjoiUm9ja2Fhd2F5IEJlYWNoLCBRdWVlbnMsIE5ZIDExNjkzLCBVU0EiLCJsYXQiOjQwLjU4NjcyNDcsImxuZyI6LTczLjgxMTQ5OTI5OTk5OTk4fSwiZSI6MTUzNTMwNzAxNjM4Mn0='),
  (9, 'Skeleton Bay', 'Skeleton Bay, Namibia', 'Namibia', 5, '2024-09-01', '2024-11-30', 'https://magicseaweed.com/Skeleton-Bay-Surf-Report/4591/', '2021-04-29 12:50:33', 'eyJpIjoiU2tlbGV0b24gQmF5LCBOYW1pYmlhIiwibyI6eyJzdGF0dXMiOiJPSyIsImZvcm1hdHRlZEFkZHJlc3MiOiJOYW1pYmlhIiwibGF0IjotMjUuOTE0NDkxOSwibG5nIjoxNC45MDY4NTk3OTIzfSwiZSI6MTUzNTMwNzAyNzk2fQ=='),
  (10, 'The Bubble', 'The Bubble, Fuerteventura, Canary Islands', 'Fuerteventura, Canary Islands', 3, '2024-06-01', '2024-09-01', 'https://magicseaweed.com/Canary-Islands-Surf-Forecast/5/', '2018-06-26 16:45:15', 'eyJpIjoiVGhlIEJ1YmJsZSwgRnVlcnRldmVudHVyYSwgQ2FuYXJ5IElzbGFuZHMiLCJvIjp7InN0YXR1cyI6Ik9LIiwiZm9ybWF0dGVkQWRyZXNzIjoiMzU2NTAgTGEgT2xpdmEsIExpbGFzIFBhbG1hcywgU3BhaW4iLCJsYXQiOjI4Ljc0NDkwOTEsImxuZyI6LTEzLjk0MjI3NzQ5OTk5OTk4OH0sImUiOjE1MzUzMDcwMjM5NDd9');

-- Insert surf spot ↔ influencer relations
INSERT INTO SurfSpot_Influencer (surf_spot_id, influencer_id) VALUES
  (1, 1), (1, 2),
  (2, 3), (2, 2), (2, 1),
  (3, 2),
  (4, 3),
  (8, 3), (8, 2),
  (9, 1), (9, 2),
  (10, 3), (10, 1), (10, 2);

-- Insert surf spot ↔ surf break type relations
INSERT INTO SurfSpot_SurfBreakType (surf_spot_id, surf_break_type_id) VALUES
  (1, 1),
  (2, 2),
  (3, 2),
  (4, 2),
  (5, 3),
  (6, 1),
  (7, 2),
  (8, 4),
  (9, 2),
  (10, 1);

-- Insert surf spot ↔ traveller relations
INSERT INTO SurfSpot_Traveller (surf_spot_id, traveller_id) VALUES
  (6, 1);

-- Insert photos
INSERT INTO Photo (photo_id, surf_spot_id, width, height, url, filename, size_bytes, mime_type) VALUES
  (1, 1, 2233, 1536, 'https://v5.airtableusercontent.com/v3/u/41/41/1747058400000/aHkC...', 'thomas-ashlock-64485-unsplash.jpg', 688397, 'image/jpeg'),
  (2, 2, 3648, 2432, 'https://v5.airtableusercontent.com/v3/u/41/41/1747130400000/...', 'cesar-couto-477018-unsplash (1).jpg', 3066389, 'image/jpeg'),
  (3, 3, 2614, 2268, 'https://v5.airtableusercontent.com/v3/u/41/41/1747130400000/...', 'holger-link-707884-unsplash.jpg', 889937, 'image/jpeg'),
  (4, 4, 4000, 3000, 'https://v5.airtableusercontent.com/v3/u/41/41/1747130400000/...', 'jeremy-bishop-80371-unsplash.jpg', 1524876, 'image/jpeg'),
  (5, 5, 4445, 2969, 'https://v5.airtableusercontent.com/v3/u/41/41/1747130400000/...', 'jens-theess-511-unsplash.jpg', 3312476, 'image/jpeg'),
  (6, 6, 4912, 3264, 'https://v5.airtableusercontent.com/v3/u/41/41/1747130400000/...', 'aleksandar-popovski-693255-unsplash.jpg', 4449844, 'image/jpeg'),
  (7, 7, 4881, 3254, 'https://v5.airtableusercontent.com/v3/u/41/41/1747130400000/...', 'troy-williams-532798-unsplash 2.jpg', 2667269, 'image/jpeg'),
  (8, 8, 5184, 3456, 'https://v5.airtableusercontent.com/v3/u/41/41/1747130400000/...', 'dmytro-barylo-152817-unsplash.jpg', 2959901, 'image/jpeg'),
  (9, 9, 3000, 2000, 'https://v5.airtableusercontent.com/v3/u/41/41/1747130400000/...', 'YzqA020RRLaTyAZAta9g_brandon-compagne-308937-unsplash.jpg', 1494974, 'image/jpeg'),
  (10, 10, 3992, 2992, 'https://v5.airtableusercontent.com/v3/u/41/41/1747130400000/...', 'josh-withers-636290-unsplash.jpg', 5985241, 'image/jpeg');

-- Insert thumbnails
INSERT INTO Thumbnail (photo_id, kind, url, width, height) VALUES
  -- Photo 1
  (1, 'small',  'https://v5.airtableusercontent.com/v3/u/41/41/1747058400000/...', 52, 36),
  (1, 'large',  'https://v5.airtableusercontent.com/v3/u/41/41/1747130400000/...', 744, 512),
  (1, 'full',   'https://v5.airtableusercontent.com/v3/u/41/41/1747130400000/...', 2233, 1536),
  -- Photo 2
  (2, 'small',  'https://v5.airtableusercontent.com/v3/u/41/41/1747130400000/...', 54, 36),
  (2, 'large',  'https://v5.airtableusercontent.com/v3/u/41/41/1747130400000/...', 768, 512),
  (2, 'full',   'https://v5.airtableusercontent.com/v3/u/41/41/1747130400000/...', 3000, 2000),
  -- ... continue for photos 3–10
  (3, 'small',  '...', 41, 36),
  (3, 'large',  '...', 590, 512),
  (3, 'full',   '...', 2614, 2268);
-- Repeat thumbnail inserts for photos 4 through 10 in the same pattern.
