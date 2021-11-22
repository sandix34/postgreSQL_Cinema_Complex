--- SQL requests used to test the database --

-- Table showing the cinema administrator and cinema information --

SELECT cinema_complex_name, CONCAT (administrator_first_name,' ',administrator_last_name), info_phone, info_address, info_city
FROM cinemas_complex
JOIN administrators ON cinemas_complex.administrator_id = administrators.administrator_id
JOIN infos ON cinemas_complex.info_id = infos.info_id;

--
 cinema_complex_name |       concat       |  info_phone  |     info_address      | info_city
---------------------+--------------------+--------------+-----------------------+------------
 toto                | Emlyn Warrack      | 326-183-3347 | 73 Hooker Avenue      | Koysinceq
 Yakijo              | Corbett Parks      | 326-183-3347 | 73 Hooker Avenue      | Koysinceq
 Dabfeed             | Michaeline Sellner | 646-964-8450 | 20 Southridge Place   | Mingshan
 Yambee              | Sibilla Tomashov   | 329-876-4206 | 61771 Hagan Trail     | Sungai Iyu
 Blognation          | Natty Petrollo     | 326-183-3347 | 73 Hooker Avenue      | Koysinceq
 Skibox              | Natty Petrollo     | 205-125-3577 | 71323 Steensland Hill | Birmingham
 Aibox               | Emlyn Warrack      | 611-261-7537 | 6 Knutson Terrace     | Huế
 Thoughtbeat         | Corbett Parks      | 329-876-4206 | 61771 Hagan Trail     | Sungai Iyu
 Topicblab           | Corbett Parks      | 799-355-5038 | 946 Caliangt Avenue   | Gweedore
 Livetube            | Corri Taberner     | 205-125-3577 | 71323 Steensland Hill | Birmingham
 Gigazoom            | Sibilla Tomashov   | 465-429-9641 | 64925 Prentice Drive  | Mixco
(11 lignes)
--

-- Table showing in which cinema and room number the films are shown --

SELECT movie_theater_hall_number, cinema_complex_name, movie_name
FROM movies_theaters
JOIN cinemas_complex ON movies_theaters.cinema_complex_id = cinemas_complex.cinema_complex_id
JOIN movies ON movies_theaters.movie_id = movies.movie_id;

--
 movie_theater_hall_number | cinema_complex_name |               movie_name
---------------------------+---------------------+----------------------------------------
                         4 | Blognation          | November
                         8 | Yambee              | Suspended Animation
                         2 | toto                | Marianne & Juliane (Die Bleierne Zeit)
                         6 | Thoughtbeat         | Marianne & Juliane (Die Bleierne Zeit)
                         5 | Livetube            | Marianne & Juliane (Die Bleierne Zeit)
                         2 | Blognation          | November
                         6 | Aibox               | November
                         7 | toto                | Marianne & Juliane (Die Bleierne Zeit)
                         3 | Livetube            | Once You
                         8 | Blognation          | Marianne & Juliane (Die Bleierne Zeit)
--

-- Table showing the updated schedule of a movie. --
SELECT * FROM movies;
--
 movie_id |               movie_name               | time_movie
----------+----------------------------------------+------------
        1 | November                               | 22:01:00
        2 | Marianne & Juliane (Die Bleierne Zeit) | 22:55:00
        3 | Wrestling Queens                       | 06:24:00
        4 | Once You                               | 20:01:00
        5 | Suspended Animation                    | 13:04:00
(5 lignes)

--
UPDATE movies
SET time_movie = '16:00:00'
WHERE movie_name = 'November';

SELECT * FROM movies;
--
 movie_id |               movie_name               | time_movie
----------+----------------------------------------+------------
        2 | Marianne & Juliane (Die Bleierne Zeit) | 22:55:00
        3 | Wrestling Queens                       | 06:24:00
        4 | Once You                               | 20:01:00
        5 | Suspended Animation                    | 13:04:00
        1 | November                               | 16:00:00
(5 lignes)
--