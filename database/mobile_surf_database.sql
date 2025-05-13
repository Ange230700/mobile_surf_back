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