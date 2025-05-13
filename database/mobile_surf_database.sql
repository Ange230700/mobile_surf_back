-- database\mobile_surf_database.sql
CREATE TABLE
    `SurfSpot` (
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

ALTER TABLE `SurfSpot` ADD INDEX `surfspot_peak_season_begin_index` (`peak_season_begin`);

ALTER TABLE `SurfSpot` ADD INDEX `surfspot_peak_season_end_index` (`peak_season_end`);

CREATE TABLE
    `Influencer` (
        `influencer_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `influencer_name` VARCHAR(255) NULL
    );

CREATE TABLE
    `SurfSpot_Influencer` (
        `surf_spot_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
        `influencer_id` INT NOT NULL
    );

CREATE TABLE
    `SurfBreakType` (
        `surf_break_type_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `surf_break_type_name` VARCHAR(255) NOT NULL
    );

ALTER TABLE `SurfBreakType` ADD UNIQUE `surfbreaktype_surf_break_type_name_unique` (`surf_break_type_name`);

CREATE TABLE
    `SurfSpot_SurfBreakType` (
        `surf_spot_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
        `surf_break_type_id` INT NOT NULL
    );

CREATE TABLE
    `Photo` (
        `photo_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `surf_spot_id` INT NOT NULL,
        `width` INT NULL,
        `height` INT NULL,
        `url` TEXT NULL,
        `filename` VARCHAR(255) NULL,
        `size_bytes` INT NULL,
        `mime_type` VARCHAR(255) NULL
    );

CREATE TABLE
    `Thumbnail` (
        `photo_id` INT NOT NULL,
        `kind` ENUM ('small', 'large', 'full') NOT NULL,
        `url` TEXT NULL,
        `width` INT NULL,
        `height` INT NULL
    );

CREATE TABLE
    `Traveller` (
        `traveller_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
        `traveller_name` VARCHAR(255) NOT NULL
    );

CREATE TABLE
    `SurfSpot_Traveller` (
        `surf_spot_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
        `traveller_id` INT NOT NULL
    );

ALTER TABLE `SurfSpot_Traveller` ADD CONSTRAINT `surfspot_traveller_surf_spot_id_foreign` FOREIGN KEY (`surf_spot_id`) REFERENCES `SurfSpot` (`surf_spot_id`);

ALTER TABLE `Photo` ADD CONSTRAINT `photo_surf_spot_id_foreign` FOREIGN KEY (`surf_spot_id`) REFERENCES `SurfSpot` (`surf_spot_id`);

ALTER TABLE `SurfSpot_Influencer` ADD CONSTRAINT `surfspot_influencer_surf_spot_id_foreign` FOREIGN KEY (`surf_spot_id`) REFERENCES `SurfSpot` (`surf_spot_id`);

ALTER TABLE `SurfSpot_Traveller` ADD CONSTRAINT `surfspot_traveller_traveller_id_foreign` FOREIGN KEY (`traveller_id`) REFERENCES `Traveller` (`traveller_id`);

ALTER TABLE `SurfSpot_SurfBreakType` ADD CONSTRAINT `surfspot_surfbreaktype_surf_spot_id_foreign` FOREIGN KEY (`surf_spot_id`) REFERENCES `SurfSpot` (`surf_spot_id`);

ALTER TABLE `SurfSpot_SurfBreakType` ADD CONSTRAINT `surfspot_surfbreaktype_surf_break_type_id_foreign` FOREIGN KEY (`surf_break_type_id`) REFERENCES `SurfBreakType` (`surf_break_type_id`);

ALTER TABLE `SurfSpot_Influencer` ADD CONSTRAINT `surfspot_influencer_influencer_id_foreign` FOREIGN KEY (`influencer_id`) REFERENCES `Influencer` (`influencer_id`);

ALTER TABLE `Thumbnail` ADD CONSTRAINT `thumbnail_photo_id_foreign` FOREIGN KEY (`photo_id`) REFERENCES `Photo` (`photo_id`);

-- Insert influencers
INSERT INTO
    `Influencer` (`influencer_id`, `influencer_name`)
VALUES
    (1, 'recD1zp1pQYc8O7l2'),
    (2, 'rec1ptbRPxhS8rRun'),
    (3, 'recSkJ4HuvzAUBrdd');

-- Insert traveller
INSERT INTO
    `Traveller` (`traveller_id`, `traveller_name`)
VALUES
    (1, 'recWK6tW3LZH5eeWY');

-- Insert surf break types
INSERT INTO
    `SurfBreakType` (`surf_break_type_id`, `surf_break_type_name`)
VALUES
    (1, 'Reef Break'),
    (2, 'Point Break'),
    (3, 'Outer Banks'),
    (4, 'Beach Break');

-- Insert surf spots
INSERT INTO
    `SurfSpot` (
        `surf_spot_id`,
        `destination`,
        `address`,
        `state_country`,
        `difficulty_level`,
        `peak_season_begin`,
        `peak_season_end`,
        `magic_seaweed_link`,
        `created_time`,
        `geocode_raw`
    )
VALUES
    (
        1,
        'Pipeline',
        'Pipeline, Oahu, Hawaii',
        'Oahu, Hawaii',
        4,
        '2024-07-22',
        '2024-08-31',
        'https://magicseaweed.com/Pipeline-Backdoor-Surf-Report/616/',
        '2018-05-31 00:16:16',
        'eyJpIjoiUGlwZWxpbmUsIE9haHUsIEhhd2FhaSIsIm8iOnsic3RhdHVzIjoiT0siLCJmb3JtYXR0ZWRBZGRyZXNzIjoiRWh1a2FpIEJlYWNoIFBhcmssIEhhbGVpd2EsIEhJIDk2NzEyLCBVbml0ZWQgU3RhdGVzIiwibGF0IjoyMS42NjUwNTYyLCJsbmciOi0xNTguMDUxMjA0Njk5OTk5OTd9LCJlIjoxNTM1MzA3MDE5OTE1fQ=='
    ),
    (
        2,
        'Supertubes',
        'Supertubes, Jeffreys Bay, South Africa',
        'Jeffreys Bay, South Africa',
        5,
        '2024-08-01',
        '2024-10-09',
        'https://magicseaweed.com/Jeffreys-Bay-J-Bay-Surf-Report/88/',
        '2018-05-31 00:51:11',
        'eyJpIjoiU3VwZXJ0dWJlcywgSmVmZnJleXMgQmF5LCBTb3V0aCBBZnJpY2EiLCJvIjp7InN0YXR1cyI6Ik9LIiwiZm9ybWF0dGVkQWRkcmVzcyI6IjEyIFBlcHBlciBTdCwgRmVycmVpcmEgVG93biwgSmVmZnJleXMgQmF5LCA2MzMwLCBTb3V0aCBBZnJpY2EiLCJsYXQiOi0zNC4wMzE3ODMsImxuZyI6MjQuOTMxNTk0MDAwMDAwMDJ9LCJlIjoxNTM1MzA3MDI3OTc1fQ=='
    ),
    (
        3,
        'Manu Bay',
        'Manu Bay, Raglan, New Zealand',
        'Raglan, New Zealand',
        2,
        '2023-12-01',
        '2024-01-31',
        'https://magicseaweed.com/Raglan-Surf-Report/91/',
        '2018-06-26 16:51:23',
        'eyJpIjoiTWFudSBCYXksIFJhZ2xhbiwgTmV3IFplYWxhbmQiLCJvIjp7InN0YXR1cyI6Ik9LIiwiZm9ybWF0dGVkQWRkcmVzcyI6Ik1hbnUgQmF5IFJkLCBSYWdsYW4gMzI5NywgTmV3IFplYWxhbmQiLCJsYXQiOi0zNy44MjE0NTkyLCJsbmciOjE3NC44MTIyMTYxOTk5OTk5N30sImUiOjE1MzUzMDcwMjYwNTJ9'
    ),
    (
        4,
        'Superbank',
        'Superbank, Gold Coast, Australia',
        'Gold Coast, Australia',
        4,
        '2023-11-28',
        '2024-02-01',
        'https://magicseaweed.com/Surfers-Paradise-Gold-Coast-Surf-Report/1012/',
        '2018-05-31 00:16:16',
        'eyJpIjoiU3VwZXJiYW5rLCBHb2xkIENvYXN0LCBBdXN0cmFsaWEiLCJvIjp7InN0YXR1cyI6Ik9LIiwiZm9ybWF0ZWRBZGRyZXNzIjoiU25hcHBlciBSb2NrcyBSZCwgQ29vbGFuZ2F0dGEgUUxEIDQyMjUsIEF1c3RyYWxpYSIsImxhdCI6LTI4LjE2MjU1NywibG5nIjoxNTMuNTUwMDI4ODAwMDAwMDZ9LCJlIjoxNTM1MzA3MDIyMDE1fQ=='
    ),
    (
        5,
        'Kitty Hawk',
        'Kitty Hawk, Outer Banks, North Carolina',
        'Outer Banks, North Carolina',
        3,
        '2024-08-09',
        '2024-10-18',
        'https://magicseaweed.com/North-Carolina-Outer-Banks-North-Surfing/283/',
        '2018-06-26 16:54:50',
        'eyJpIjoiS2l0dHkgSGF3aywgT3V0ZXIgQmFua3MsIE5vcnRoIENhcm9saW5hIiwibyI6eyJzdGF0dXMiOiJPSyIsImZvcm1hdHRlZEFkZHJlc3MiOiI1MzUzIE4gVmlyZ2luaWEgRGFyZSBUcmFpbCwgS2l0dHkgSGF3aywgTkMgMjc5NDksIFVTQSIsImxhdCI6MzYuMTAwNTc3NywibG5nIjotNzUuNzExOTU1Njk5OTk5OTh9LCJlIjoxNTM1MzA3MDI3MTM5fQ=='
    ),
    (
        6,
        'Pasta Point',
        'Pasta Point, Maldives',
        'Maldives',
        3,
        '2024-04-01',
        '2024-05-31',
        'https://magicseaweed.com/Maldives-Surf-Forecast/56/',
        '2018-06-26 16:49:56',
        'eyJpIjoiUGFzdGEgUG9pbnQsIE1hbGRpdmVzIiwibyI6eyJzdGF0dXMiOiJPSyIsImZvcm1hdHRlZEFkZHJlc3MiOiJNYWxlIE5vcnRoIEhhcmJvdXIsIEJvZHV0aGFrdXJ1ZmFhbnUgTWFndSwgTWFsw6ksIE1hbGRpdmVzIiwibGF0Ijo0LjMxNzg0MiwibG5nIjo3My41OTE3MzI5OTk5OTk5OH0sImUiOjE1MzUzMDcwMzA5MTJ9'
    ),
    (
        7,
        'Playa Chicama',
        'Playa Chicama, Lima, Peru',
        'Lima, Peru',
        3,
        '2024-05-01',
        '2024-06-28',
        'https://magicseaweed.com/Southern-Peru-Surfing/378/',
        '2018-06-26 16:43:44',
        'eyJpIjoiUGxheWEgQ2hpY2FtYSwgTGltYSwgUGVydSIsIm8iOnsic3RhdHVzIjoiT0siLCJmb3JtYXR0ZWRBZGRyZXNzIjoiUHVlcnRvIE1hbGFicmlnbywgUGVydSIsImxhdCI6LTcuNzAwMTcyNCwibG5nIjotNzkuNDMzODE4Nzk5OTk5OTh9LCJlIjoxNTM1MzA3MDI0OTY5fQ=='
    ),
    (
        8,
        'Rockaway Beach',
        'Rockaway Beach, Tillamook, Oregon',
        'Tillamook, Oregon',
        1,
        '2024-08-23',
        '2024-10-17',
        'https://magicseaweed.com/Rockaway-Surf-Report/384/',
        '2018-06-26 16:49:46',
        'eyJpIjoiUm9ja2F3YXkgQmVhY2gsIFF1ZWVucywgTmV3IFlvcmsiLCJvIjp7InN0YXR1cyI6Ik9LIiwiZm9ybWF0dGVkQWRyZXNzIjoiUm9ja2Fhd2F5IEJlYWNoLCBRdWVlbnMsIE5ZIDExNjkzLCBVU0EiLCJsYXQiOjQwLjU4NjcyNDcsImxuZyI6LTczLjgxMTQ5OTI5OTk5OTk4fSwiZSI6MTUzNTMwNzAxNjM4Mn0='
    ),
    (
        9,
        'Skeleton Bay',
        'Skeleton Bay, Namibia',
        'Namibia',
        5,
        '2024-09-01',
        '2024-11-30',
        'https://magicseaweed.com/Skeleton-Bay-Surf-Report/4591/',
        '2021-04-29 12:50:33',
        'eyJpIjoiU2tlbGV0b24gQmF5LCBOYW1pYmlhIiwibyI6eyJzdGF0dXMiOiJPSyIsImZvcm1hdHRlZEFkZHJlc3MiOiJOYW1pYmlhIiwibGF0IjotMjUuOTE0NDkxOSwibG5nIjoxNC45MDY4NTk3OTIzfSwiZSI6MTUzNTMwNzAyNzk2fQ=='
    ),
    (
        10,
        'The Bubble',
        'The Bubble, Fuerteventura, Canary Islands',
        'Fuerteventura, Canary Islands',
        3,
        '2024-06-01',
        '2024-09-01',
        'https://magicseaweed.com/Canary-Islands-Surf-Forecast/5/',
        '2018-06-26 16:45:15',
        'eyJpIjoiVGhlIEJ1YmJsZSwgRnVlcnRldmVudHVyYSwgQ2FuYXJ5IElzbGFuZHMiLCJvIjp7InN0YXR1cyI6Ik9LIiwiZm9ybWF0dGVkQWRyZXNzIjoiMzU2NTAgTGEgT2xpdmEsIExpbGFzIFBhbG1hcywgU3BhaW4iLCJsYXQiOjI4Ljc0NDkwOTEsImxuZyI6LTEzLjk0MjI3NzQ5OTk5OTk4OH0sImUiOjE1MzUzMDcwMjM5NDd9'
    );

-- Insert surf spot ↔ influencer relations
INSERT INTO
    `SurfSpot_Influencer` (`surf_spot_id`, `influencer_id`)
VALUES
    (1, 1),
    (1, 2),
    (2, 3),
    (2, 2),
    (2, 1),
    (3, 2),
    (4, 3),
    (8, 3),
    (8, 2),
    (9, 1),
    (9, 2),
    (10, 3),
    (10, 1),
    (10, 2);

-- Insert surf spot ↔ surf break type relations
INSERT INTO
    `SurfSpot_SurfBreakType` (`surf_spot_id`, `surf_break_type_id`)
VALUES
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
INSERT INTO
    `SurfSpot_Traveller` (`surf_spot_id`, `traveller_id`)
VALUES
    (6, 1);

-- Insert photos
INSERT INTO
    `Photo` (
        `photo_id`,
        `surf_spot_id`,
        `width`,
        `height`,
        `url`,
        `filename`,
        `size_bytes`,
        `mime_type`
    )
VALUES
    (
        1,
        1,
        2233,
        1536,
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/rZ_71tYUjyOKQwo4M33b-g/FK3qH1JPXkXALrUDMdTSPxRlhZnyHxbM1QC_HuY7mQsdtSyFCkgU67-3W_WpzSKooseiLd0i9XRc9ssgEijfgXZxOCfrIAyWvSX3G7qTX0ur-JyW8QvoqoXM4hrYrgcB/91owc-Dwe9h2r18ecJYu8gQPYO4NMOGcQNC3tV9OQFI',
        'thomas-ashlock-64485-unsplash.jpg',
        688397,
        'image/jpeg'
    ),
    (
        2,
        2,
        3648,
        2432,
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/nhnXyxRoBOlaAbEfXIQ91A/7lkCryCINZq_v-yTYVCXVKc6OAUMVaTbCVVF7qUX0C26hwNGYQFL9D51qrDXvMZuBmATP7XM0DPRiLJIweuyJc9MYQlXLbgixxdppxUB6g5i70RAUnSSeLCQF21sxwey/JP6WzW4lYf02k-Y3zAvWaf--9c1hnWYshAU7LAn6_x0',
        'cesar-couto-477018-unsplash (1).jpg',
        3066389,
        'image/jpeg'
    ),
    (
        3,
        3,
        2614,
        2268,
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/ZLyKT91-EZaj5WupLKlikQ/6gJOQxYSE_1_T0V6FCcQvpHi5ZL_5SvZzVo_ZU0iOyt82WgghEP3JH0qn3O8vvmliDV7jZB6v7FQK84ER2AAep-2uC-3E9cyQ4xKNzdiemRDlc9wgLCt-CxJVBGabypi/cVGDZOAqaTSsE6khFjx3E3fFjhpa4rdu1EHedZemQD8',
        'holger-link-707884-unsplash.jpg',
        889937,
        'image/jpeg'
    ),
    (
        4,
        4,
        4000,
        3000,
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/e16Dmbyp7ziIxNxb_EpORA/rge5rVAbOor17uMH0axajIMAguO_Rv1Y-fQ8sPC37sw9ivUUSoVTMIA0LfuG8pjGJq3tSAfmxFAZTam2pNAhxuShs4Gys32WQiIpUvxU9j6zz93w_oOYSIQ30D7cQaMy/H1aH3mOU3HHD7UEJ9c9gAmb3UKZF91sLrKIwxSDtJmY',
        'jeremy-bishop-80371-unsplash.jpg',
        1524876,
        'image/jpeg'
    ),
    (
        5,
        5,
        4445,
        2969,
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/2xduLyk2SXEzBz0QURKiJA/DU6_BNOlZjNO3KkF4cRWH05otZCwN6u4zsEb3kQ74gm00gG79dUmJNA0k-ug7Nuaz4ta4m5rjwiNtcudV02EMsyD3Jw1bw-JDDdE6LdDykeGBvloIJOOpbVqoAYiHb-p/c18-kj6xMGH8F2fwWlXXzCcmY2CGdAH8nwwzcVwd0Kk',
        'jens-theess-511-unsplash.jpg',
        3312476,
        'image/jpeg'
    ),
    (
        6,
        6,
        4912,
        3264,
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/boT_97uEd0UKKhbmyweBQA/T42WGjXVA11TyIQiWMj-LGzlWHlsQKfA4ja2o5ffqQTl7nK5oEr79_EZoZ_wWVgZMMmEq-OXcbTI-TITvC8NV-36kD0OU_RSCufd6AzEyljhvKU82nFXFXg5hFuEAh_iKSk0x95NuMz2rhVBdWwfAQ/jOqjNpEqmX0G1QxD9Vs21dwwEhGTHAK0ctF1TMEHzCo',
        'aleksandar-popovski-693255-unsplash.jpg',
        4449844,
        'image/jpeg'
    ),
    (
        7,
        7,
        4881,
        3254,
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/rQtUYTRty45RqtAminzo3g/SdhCODfyimwoi7N42faFDX4GsLlUzS5caxM-PKlOFW_rjiyTZyf3GrPzVyNOCL34E8QbadkcZTQ8x4CvxH17A9dyESdicpklSj3X9Z2vwkx58GYrFVbYUhnmieWpp4Ib/ETI50H0wnWRaXbggZ22Jrgty2raZjf6LnrRdHkAAXl0',
        'troy-williams-532798-unsplash 2.jpg',
        2667269,
        'image/jpeg'
    ),
    (
        8,
        8,
        5184,
        3456,
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/fe-CjdewYg7eSAr6CTA3dg/frd5wcrFhxlK7YfV7GPKvAsFBTzZB2Nf9ug8uf_kFSb8raCxxrvgnD-dRddFeeOs2Izm0cL1qSGN0hX-zOak2kByy4dT_vKg3XYWRdyNcQgmYe4q4ejBcNg0m6AaSsu-/tZBrEDTMm5ISKSQYzuBFweYxbRGpryYQsWmWxk9IeRY',
        'dmytro-barylo-152817-unsplash.jpg',
        2959901,
        'image/jpeg'
    ),
    (
        9,
        9,
        3000,
        2000,
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/9YwXvxjB4ZN3hSj5jZCejA/14GyYI2ibLlEyvjM1hjgYvNUi4IlKOcA45CAn2TRkmlL6blNhiLuTraUO8JgCQL2Dsy3iK94dZfPq0TFvIwRyy3OoijHql1gdImATRNFGnfpfGRog5qV4GKwRivV--issGxGIYP_VW18LkSaTAVDsVrBHKpw9dhghPYQPEfFbUK4TsiX6wkstCtgSWSi8MkoKlMGHoZkVvB8hJcSy_23JQ/WbLZKJSCKM-QNrDwkV0Vc1iLEgw8J0j39EkosXKT0x0',
        'YzqA020RRLaTyAZAta9g_brandon-compagne-308937-unsplash.jpg',
        1494974,
        'image/jpeg'
    ),
    (
        10,
        10,
        3992,
        2992,
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/zigzW4EOPTeZKtlaVMggJg/V9Yas9_SygCirug_fTtM-xyK7kBH4K4Y5pZaJO9eq8J3zW-neuPlrPvQd5tWI3DzGLfAl-JOBMRk6Nt6TnywzasvL6pu6N02W8yzJ3T7hblqgIwFkkdELSJySQEcqmbO/LYLTJqZZZb6Dtpuv4fs9sV45W7HHvdtY6ys0NUHq264',
        'josh-withers-636290-unsplash.jpg',
        5985241,
        'image/jpeg'
    );

-- Insert thumbnails
INSERT INTO
    `Thumbnail` (`photo_id`, `kind`, `url`, `width`, `height`)
VALUES
    (
        1,
        'small',
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/QmCv0Sd7J-FksfD4H7WTsg/NZAE1iJJBMCPzz78xY5_x0N5Dl0aWTDYaNvmBlZdyi7lAM9uXPWhBiwGOiWPAw1gRF5qNpgxLwm_UxFKlJ7lRoIOKfCOMHln7e7Zb5W0uOlkmQSTGUSlFZ7QSG4v9yfpyE7-XTiDZ6skoSsAi5SRjw/Ibw8P3nVNvs0pMB87JhnMWQEAsvGtdOybDSGUwXOA5E',
        52,
        36
    ),
    (
        1,
        'large',
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/d3xYpwyTqqKqOL_7vhQZsA/Tgw__SdKJ9zL3-cVy-T7SbGxwrxFrV_sYzAmj_f3KF2rb2ZuODa_dESNHjSJRvuFVVtrpcYuLTa5oUeqm5E1Hblfz1bnQJSp5xtpErwdiL9XMqjszRq0WKhY4jONRmCHCwOq8KcO2YTvUbjCy1xfiQ/W6Bo8-PhdAchm4bTHpOlO5VMgYWXXvRmNqVJVyotomQ',
        744,
        512
    ),
    (
        1,
        'full',
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/_1Mi5Dp3l7S20NnGRBI3Bg/YGNe0IeME6GwUIgyOdfN5xbtOk2IGoSCvA9YmgoLa7hoLH_Qld8hyZsFJ5Q6tog4hYpaJBj-jcOE1X30XLP3yJzcjPW5BMy1D-Wu0CTxpthXGtKSF4K4XRIpV-wS43wo/9Dt8JQZLG3oNZVpZUEOcOzZMtkXNXRDwTTOVh1G8f1c',
        2233,
        1536
    ),
    (
        2,
        'small',
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/Uw_SqrSv5LiP2yOb_Kr4dw/ku1miAcOztuBYeqrKr0MLO1OwOm1EHvKG8wbL_KGtUsGH_DsE4aaMt-1vqQ_y8rRQmt4z764nnGDuZJkge6QMknGea7QUDcSrJYoMl0q-YGP3lC0Jf-i5nbhF7dnzUSN0StowC1QKrB1VMJSKGGhKw/-97ohOJDtbL5qCAFx2wg0wco2s3W2ajOxPynVuZiH0I',
        54,
        36
    ),
    (
        2,
        'large',
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/anWEzUwUfGNkc5wuoVA_NQ/WDZn-VnnXCRM3G7tDUqvSUkdoQQLw3WBz9zifbuYLUozW_013yZaaqMRRg6MFq3AWsf7j31K9UPu7Y-J9yhP0xT1NrOy3xiOdmIHT1NiwUYqIlfwjhdYe1GWd3j_8K43T_w_BNBS3VmADTYc0-w6rg/91EHDJfvrgh10zaEmVtRwxXDPxEDnv99uYU9lgvOY7A',
        768,
        512
    ),
    (
        2,
        'full',
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/PxHFXIS1GV-0RBDw8Z2puQ/THSpErPX3aWDGPIsc4446W8VDpffQtQ1kMnAAxDyaGhsd7tOhrVyFshIie2hGo7-FXNNvHd5T_TJTHQ7W8pvHyOSFw9WAZeZVe1WfiXP06F_GWbTL3e3y3vZ1k5ruTWKpHMpqS6wSoTyenP4Pk3YRg/sngHeYuLnk2831NeFmEHi5lYUcrzOLuxPCmNQnMMwvQ',
        3000,
        2000
    ),
    (
        3,
        'small',
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/acSCJ0eQ4mj_CLVfqXzyCQ/1Z2svWNRrziHyh8uLPR_IZeWaU6zswjCNtMfE1T_8lQc2pFvOFzd9oAslmCRlkP84Jx0yRu9LpVn45niTUwbxOHF8WXD3An_Hmd2r81baqbeV9o0rdjRXFx-wKntxNPS/ahYMI9W6YGu7hciWMnXBqp40xC5aT0S1AVs3oARglVM',
        41,
        36
    ),
    (
        3,
        'large',
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/PTiJvrVerTcJ_oznzMjP2A/vHomrArElS3FUWi1CNYaXileUPTcCOKpro-M80N92K9izi4qdoBSdlH_02EXkmanb7pUBBEk8bNIBmx62MJjE6ZiV1R3Ds6kJnwgjQaWcwQjii-UiHSalv4NiWhXKbJk/WUdiTKp8GPv2COtEuxw_Wn3jmX9D8UKhKeSdKrFiu6g',
        590,
        512
    ),
    (
        3,
        'full',
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/NOZd-dU0C302qqIDcDlVRw/3XxuHt2Jwklg0ItZ08_Y3MDOM3cdj0RlGVO7fdrH0NE0Nq_NbAcLkNfb40eDGcR5MHOj3zqS6dk6Q6LXkidqXcyMrMKFcOxCku5W2sZ76KLNJybapCXjJ2p5gF498g9K/hojVDEErZWv1zM88TodyGHdyzHi4ItgeBGCbgRtIpWA',
        2614,
        2268
    ),
    (
        4,
        'small',
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/iNOyPDwX3DeV4xsIuCJ0Gg/THL4QYfT1Rx9VoKJEMIcUcUxs2KsCBxwSLvnPN2Xm-p4ockYlx_EfJhaFm7EvJS2JLi3Ck8HiXV0sUJkZ6VFE0WMNMT8wYurWM9tYvnPCcUqvJein7IQgAufa9_ftH5J/0u-Irp8VPQz8MLWTwHj3kLk-PmhUdcC2xdLL4vms_ws',
        48,
        36
    ),
    (
        4,
        'large',
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/EVH96aI7-wcS77tTjugoLQ/Et_9NJFcN6btKr9xiyI0xLY247Wz4W69MAgLRS3a2y7RdwNhC-XXwhTo68K5xB-ULrXRWTxFnjrfWPHLfFt_y3s2LRAo_OIVjY9jlIh1ZStFRq7Duhjy-nh1pWGAdxI9/UGCzh92asmQV3xUdj0GDVnXqZxhZAC_GG98UKVNZm-M',
        683,
        512
    ),
    (
        4,
        'full',
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/KmGb3TKNcOoI4uM93qCY1A/JivlxkGD6kB7WApgzCi1XP3gB62E_BxLBvylFJKp7Mg16aDXs9qHrdxOJPLtUCB6vy7X3pAxzRodD2M0HbxXVNVnHsMr5QK4gdKKG3NyzkRuup_2BuGPsLYAmlSupAU_/Dasmde4pRTmtAlOc5BA_NzOu4RBWiEzvOiXO6YE8UYU',
        3000,
        2250
    ),
    (
        5,
        'small',
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/EkNvwpsGmxBPkD74hu_ANA/UvBbaCxfRcGjSv0TIEIsEktr0B-nRbku4YcxNxCp2Tuk1e74NKwQZcbcf9RW9S1WlSServbBCOzDRG-IqV-9KWPABvjD8WgKjag2Sw0DuHrP1-BIJG0pJXxWT1SMYDyC/Wy-DCP6pmAiX-6x0VyjB3JOujjzXxE8P0NwIcswbM2A',
        54,
        36
    ),
    (
        5,
        'large',
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/n5FVIcxJFG7TZ82D7g7MYA/Q2IGELtQTcSwqBCtocGuQ9YvKHbtX6WXtByf-9HX3p9tiJtOxVL4kob6X9sdrlWbyFFGlgnQ3ETqFo_UObaZgHwqa6_s0jMwFTC4fJFqdus9LCGENQnD5FzTy3Q_0rxC/upNFD-OqAAaw4NMqn2wDYh6sujfk8KnzgF67rJo15sA',
        766,
        512
    ),
    (
        5,
        'full',
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/tHyfmOd7H9JHHL3AzCM0sA/MzpUtIrROoiuNHa1ANwJihU2GCfSr4fAp83TlDqLU2gQyRFKCrC0B9GpTWwS5y1XR4FqvOy2KWzlYwOQiSikTuMCymh6NTOzXrQ6Yxht1-MfUZMhhJ8a7aT6F57inb8X/w8Oygn7R7bSzetHbWOTyPmuQj5DDkJTbkyEivdnN-Oc',
        3000,
        2004
    ),
    (
        6,
        'small',
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/8nEjNDN7v3JW43nQsKQ51w/MYshan5v2CB2pSwUTboFg6sQkJENykxZ2WNOJSM2C7eOpix6WpmNwcDJtGX5T2fP17QCroen5DFoZJacrtGU1z14q5zI-pV-rd5ueWmbNWwuGW5qSQbAGu33GPlZCenhy4_DZWUPJ6yRlBE0kpMhWg/rS4q-nMVDl6kst50JSvdJlQ9jv2Jbev-LdmOyNI7yig',
        54,
        36
    ),
    (
        6,
        'large',
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/bAg7JvoKEXeeUvapRWyXDg/jbUbcRQeLRMt9uynvo1KxSMUUX2N9UhaqdWunqq-cHYHRsvYCS-Qw4tWQE8hj33ZMvvfjhqI4MTjMiyz_RoVGq1c5iBXDdqNw_xdzuS86RA_9BjYJRVe93Rg0VYu_Jf-LKULPSoFoEmSnBabxA7TFQ/acSuqrHpr0fj-IqzaVdnhD3yk_9lQlhkGGjez8ZyVm8',
        770,
        512
    ),
    (
        6,
        'full',
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/k3auF3hggyxFNfCLYDgkGA/if2nhdqIzv4Ys5U22Ayv1G3jLVwBEo3nua5Y1ZH_IswqcPflImo1qNpM5bhdd56IhWh6Xx0LmoQHk7crCyZ8_rGsEbT1xoH4CbEmIJ3vICT3xEty6LpwiF3ipLaMq1kXQ0wp0HqGWCQBRaG3Dag9qA/GXVNkldrMZUUIGnt1rhhYXi2ypk1isOfOhTWepEI4yU',
        3000,
        1994
    ),
    (
        7,
        'small',
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/Ag7-lGJ3p-5VPsQx14Q6DQ/eQ3HpjCFhKsg9vE7NTSxcs4M9TPkBP3hS_KR2TUU3OGr8hh85vwQ_y2KCRRvH5KHfQ3cIDIen6foKu5WzJ_CRSRxBoxg7MrBsgeYRmp5McEucE_CeWMOoNYaw9KNUgtCLffsPqqummQlTAx_zoRB5Q/7enfsV2a6O-c6sGYNAX_zRtZp2R_1iwbuELp-gckh74',
        54,
        36
    ),
    (
        7,
        'large',
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/dMnY_dwn73cnzr3AJzhvag/7cIyQ5v9mtwrL1U9wn_5WOxjUKIDMpto_0dfXAvZn-NWF70a-dXyLX7Bi3QiqwNGImiqPfJsGzvRpe5CX-x-GpSRF61HLFjBZQsc3eE57O5e8XexhQLQL4HqwRMdAl1gy-rtdG9ckLHigpmM0K984Q/wbVZWasLmV6avLrm-7FIkd4E8bCtTcMiJ10v4l83VLA',
        768,
        512
    ),
    (
        7,
        'full',
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/gXEZ0IInbtcZTjnzKt1xVA/ptqgxMlV6BxOLYGAXK6YRmen4pKOeeiGqNYkAf4vG67vir2xCSL02fnObUWCYMxCFOdt8jKZgSD8S5SgwNB8UcOXe4Hfkd2R5uKg1KqGrKANXDWuZ_ycK7_q1ze8qivOAtdfG6IicPtp6IUQT9JxiQ/m6YZ8ych9nMDFpSQcN7xVuxj_XbMJQbaGF_XFTyZOhI',
        3000,
        2000
    ),
    (
        8,
        'small',
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/dKDobq5s3JgQ1xlW0LivcA/B_aSK2SIxlEeKCuesCeFaXkgqLgCKJ_5UGH5NcqnzCbkVg7NvSzNsuzL4yAesqm_g7GoXCLtoytH7PwWB9XIS_6JI1CNNZQ3En_VochwqBwsGvD5ZkU5iY7Sosct8bcBs2EqchfhW_YuMr8URFwjFg/ay_-PltDUvMa8qn2Buss_KSYeJ8PydLWHfg4HPprek4',
        54,
        36
    ),
    (
        8,
        'large',
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/Dw0NToJX39S6oMSbH-zJZQ/S5cL4h_G19zuUMJcxgDF4XJnGEwckJoktcPvipp73hVptvt4U9Quw4vuhTUEUAESsOV3Y8mOtvGutcbEahY3I3wr1-6LxHf0ywJJk8DEE8fseqJOu4-mGnkysvpjja5UjkppH3JMq2HKN4sFwyDXHg/mKBEg8LqAKtXfsyX8x4IuOzyT62oN8AwEKjoapRaP0c',
        768,
        512
    ),
    (
        8,
        'full',
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/fLdEur5ScQ3OHp362giFiA/vD5cBe3hirpKL27T5WjxLHMFaN4Wf9NkKsjlCdpzpGBnen-SMGMl210n1eR3fRQD2lLssB0U7OZm88LbUgx0xe_xoPPQ37XmSgWXV3lHETnBdY737pM7v2DJMsvnaMkC/AX2H7MevNCasqpQ80CcLWiTRXyQ2BjQ68KlJJSmDNC8',
        3000,
        2000
    ),
    (
        9,
        'small',
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/0x6lxceaiCzOu7RK_wsnSQ/HsXMPp2Bx4mkkIzy7W0fPSX-9tvrfLWB6SAXzNju_GlsoHG43ZZBIYTjFayfCafyOC-xqihDedY1KhUuvyiYKJ17ZV2-em2C5GGEepH0CL6ovspNV07e1AfObGlbqq-iDBa-0cC51cSDzMYA0AO73A/QGbLjeFwl1ruGAxKOJZkHgBMO_JA-oC-kbmqxeQr4HM',
        54,
        36
    ),
    (
        9,
        'large',
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/ip6hpaiu5qfXczMOvuWJEA/ZDKCoX24svD-ZDnuMGEpah1BHTsSCGCfHClINkGb3eSf3pDnTnUNrCEGYiVjEJl4xzlyQXDB8hvoMvtoXT0wl5zErbOtRJZTSxtcA2ldXddpNl_TSTS5G_fcwkWKTgivQg44_xbzpAKu8AkK1G3QKw/ZlmThgkGstWu8qinYH5lzPVHzZGv2WiNwpzHKCLRLcM',
        768,
        512
    ),
    (
        9,
        'full',
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/NumANOAN6PEl-IPDKqtaeQ/NkR3o5TZT1oYasaP_6g5ev4IBQTbEBv16q_5577BegHxzAj2W0QvlpKC7YnDPv-lwSf6vBmXKJMhdeajE29o-Vrkq0-7yfUKRwrmH0IreS9y0ggRWh59FXVMiqmun7aizrQSXKukDCySqt3mF-EFSg/bkSAXMSN2IfgJg0ruvilUkCjnaULmd1KcSFAIswSBE4',
        3000,
        3000
    ),
    (
        10,
        'small',
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/JielXP-b_IzPUZcJfVjB4A/94ZQ4R8l8ePaLAgapBUiEJ9sV9kUbfyg8HGHKzlTCXP0hlhi9cpANU_1cFCv7BIkBRXyfoVLt-mD2XKUMjzOzjlmD9bbZPIBTjJr0-RkB-tdNmX-L5DecE1EOA9UuW5E/bxfg4C9PGj7XxeNMZRyMWEfcu-gAetbx8DLwITAigmc',
        48,
        36
    ),
    (
        10,
        'large',
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/qpQiYKv6JrMAtUks3VZqhw/XRzrdb5Oy7EPXlEON1c-aGE7OAxt1dLVsWU3g6Cc_nDhBTLxHamAK-Q6esbwTXz5JtzkF2tODY_TtSrr4p-KJ2jrTc16f8KXlvf0_RkMfy5D_0_RcXQhKAwPs2Ccats2/w9dLEIEQZvb8yglGD2yEzWpNPlJTskEmV7pOw1GsyoY',
        683,
        512
    ),
    (
        10,
        'full',
        'https://v5.airtableusercontent.com/v3/u/41/41/1747137600000/KaNkMBBtSVuVJoFWDHm5PQ/QLrZtShELa89-QSReY1emYicQMhZJ0rEP7gPnhVlBXqrm3uYEEGRdM2FE8roNBFcwnM-hLjdWoT2Jtz0AaSWZehQUZ8yikk132y0sXfq9IKOuW3F2yAd0ydnz6JmUsVp/s_ZaPwYTx-Q_9D5lK2xBTHjFEigHsNimBF7DhcSbBjw',
        3000,
        2249
    );