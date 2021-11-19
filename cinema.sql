-- Create database --

CREATE DATABASE cinema

-- Create tables --

CREATE TABLE administrators(
administrator_id INT PRIMARY KEY,
administrator_last_name VARCHAR(255) NOT NULL,
administrator_first_name VARCHAR(255) NOT NULL,
administrator_password VARCHAR(255) NOT NULL);

CREATE TABLE infos(
info_id INT PRIMARY KEY,
info_phone VARCHAR(20) NOT NULL,
info_address VARCHAR(255) NOT NULL,
info_postal_code INT NOT NULL,
info_city VARCHAR(255) NOT NULL);

CREATE TABLE cinemas_complex(
cinema_complex_id INT PRIMARY KEY,
cinema_complex_name VARCHAR(255) NOT NULL,
CONSTRAINT fk_info
FOREIGN KEY (info_id)
REFERENCES infos(info_id),
CONSTRAINT fk_administrator
FOREIGN KEY (administrator_id)
REFERENCES administrators(administrator_id),
info_id INT NOT NULL,
administrator_id INT NOT NULL);

CREATE TABLE movies(
movie_id INT PRIMARY KEY,
movie_name VARCHAR(255) NOT NULL,
movie_time TIMESTAMP);

CREATE TABLE movies_theaters (
movie_theater_id INT PRIMARY KEY,
movie_theater_hall_number INT NOT NULL,
movie_theater_nbr_places INT NOT NULL,
CONSTRAINT fk_cinema_complex
FOREIGN KEY(cinema_complex_id)
REFERENCES cinemas_complex(cinema_complex_id),
CONSTRAINT fk_movie
FOREIGN KEY(movie_id)
REFERENCES movies(movie_id),
cinema_complex_id INT,
movie_id INT);

CREATE TABLE sessions (
session_id INT PRIMARY KEY,
session_start_movie TIMESTAMP);

CREATE TABLE movies_theaters_sessions (
movie_theater_session_quantity INT NOT NULL,
CONSTRAINT fk_movie_theater
FOREIGN KEY(movie_theater_id)
REFERENCES movies_theaters(movie_theater_id),
CONSTRAINT fk_session
FOREIGN KEY(session_id)
REFERENCES sessions(session_id),
movie_theater_id INT,
session_id INT);

CREATE TABLE customers (
customer_id INT PRIMARY KEY,
customer_last_name VARCHAR(255) NOT NULL,
customer_first_name VARCHAR(255) NOT NULL,
customer_age INT NOT NULL,
customer_email VARCHAR(255) NOT NULL,
customer_password VARCHAR(255) NOT NULL,
CONSTRAINT fk_session
FOREIGN KEY(session_id)
REFERENCES sessions(session_id),
session_id INT);

CREATE TABLE prices_list(
price_list_id INT PRIMARY KEY,
price NUMERIC NOT NULL,
type_price VARCHAR(255) NOT NULL,
customer_id INT,
CONSTRAINT fk_customer
FOREIGN KEY(customer_id)
REFERENCES customers(customer_id));

CREATE TABLE payments(
payment_id INT PRIMARY KEY,
payment_type VARCHAR(255) NOT NULL,
customer_id INT,
CONSTRAINT fk_customer
FOREIGN KEY(customer_id)
REFERENCES customers(customer_id));

--INSERT--

INSERT INTO administrators (administrator_id, administrator_first_name, administrator_last_name, administrator_password) VALUES (1, 'Corri', 'Taberner', '173449d2ec5998419a4929e2c8a4cac396828fde85b45c53fe84017bb6fabf1c');
INSERT INTO administrators (administrator_id, administrator_first_name, administrator_last_name, administrator_password) VALUES (2, 'Wilfrid', 'Filip', 'c9e4e050e8716407aaa98dca4ef3da51205da46834b725c0ee24f0bc55f03c9a');
INSERT INTO administrators (administrator_id, administrator_first_name, administrator_last_name, administrator_password) VALUES (3, 'Julieta', 'Toynbee', '875e1409ef14e912a4256f050d6427b5e96d849b220e14372a7a5bca3fb94c6b');
INSERT INTO administrators (administrator_id, administrator_first_name, administrator_last_name, administrator_password) VALUES (4, 'Emlyn', 'Warrack', '5a05b4ea99f56a9ec825571b4237e9778a556dd4c731b8a66bec649e90ecae00');
INSERT INTO administrators (administrator_id, administrator_first_name, administrator_last_name, administrator_password) VALUES (5, 'Sibilla', 'Tomashov', '3af5ee54d26e170cd20776600ec033091e9b2ac4c79f292d0433d7ad589aebaf');
INSERT INTO administrators (administrator_id, administrator_first_name, administrator_last_name, administrator_password) VALUES (6, 'Caritta', 'Nassau', '813d23a459bdf3e28cebccb479b5e2fcdb8b2c0b93600857281d138f1773ab31');
INSERT INTO administrators (administrator_id, administrator_first_name, administrator_last_name, administrator_password) VALUES (7, 'Natty', 'Petrollo', '2cba934d32a0f72a7c8299ed1f85dd9428f3822d55419b4c203feb6856174fc0');
INSERT INTO administrators (administrator_id, administrator_first_name, administrator_last_name, administrator_password) VALUES (8, 'Angel', 'Clemitt', '220290bf7b086a62d35891be76b244d0bf7d1156240a3e0d8700a76e707f2e66');
INSERT INTO administrators (administrator_id, administrator_first_name, administrator_last_name, administrator_password) VALUES (9, 'Michaeline', 'Sellner', '449ff49b2e6b5bc6f0e89b1a497baca5daecefdabe56c6d5b0641f33afa0e4de');
INSERT INTO administrators (administrator_id, administrator_first_name, administrator_last_name, administrator_password) VALUES (10, 'Corbett', 'Parks', '29defcd4d2ce2ff93ec47299566cacf464b8c823a1bd513c22e0dc5e85febc70');

INSERT INTO infos (info_id, info_phone, info_address, info_postal_code, info_city) VALUES (1, '932-782-0987', '019 Victoria Road', '89129', 'Reggio Calabria');
INSERT INTO infos (info_id, info_phone, info_address, info_postal_code, info_city) VALUES (2, '460-567-4096', '5 Arizona Way', '3899', 'Zeewolde');
INSERT INTO infos (info_id, info_phone, info_address, info_postal_code, info_city) VALUES (3, '326-183-3347', '73 Hooker Avenue', null, 'Koysinceq');
INSERT INTO infos (info_id, info_phone, info_address, info_postal_code, info_city) VALUES (4, '611-261-7537', '6 Knutson Terrace', null, 'Huế');
INSERT INTO infos (info_id, info_phone, info_address, info_postal_code, info_city) VALUES (5, '796-412-6763', '41 Hollow Ridge Lane', null, 'Kryevidh');
INSERT INTO infos (info_id, info_phone, info_address, info_postal_code, info_city) VALUES (6, '205-125-3577', '71323 Steensland Hill', '35244', 'Birmingham');
INSERT INTO infos (info_id, info_phone, info_address, info_postal_code, info_city) VALUES (7, '329-876-4206', '61771 Hagan Trail', null, 'Sungai Iyu');
INSERT INTO infos (info_id, info_phone, info_address, info_postal_code, info_city) VALUES (8, '646-964-8450', '20 Southridge Place', null, 'Mingshan');
INSERT INTO infos (info_id, info_phone, info_address, info_postal_code, info_city) VALUES (9, '799-355-5038', '946 Caliangt Avenue', 'V31', 'Gweedore');
INSERT INTO infos (info_id, info_phone, info_address, info_postal_code, info_city) VALUES (10, '465-429-9641', '64925 Prentice Drive', '01057', 'Mixco');

INSERT INTO cinemas_complex (cinema_complex_id, cinema_complex_name, info_id, administrator_id) VALUES (1, 'Yakijo', 3, 10);
INSERT INTO cinemas_complex (cinema_complex_id, cinema_complex_name, info_id, administrator_id) VALUES (2, 'Dabfeed', 8, 9);
INSERT INTO cinemas_complex (cinema_complex_id, cinema_complex_name, info_id, administrator_id) VALUES (3, 'Yambee', 7, 5);
INSERT INTO cinemas_complex (cinema_complex_id, cinema_complex_name, info_id, administrator_id) VALUES (4, 'Blognation', 3, 7);
INSERT INTO cinemas_complex (cinema_complex_id, cinema_complex_name, info_id, administrator_id) VALUES (5, 'Skibox', 6, 7);
INSERT INTO cinemas_complex (cinema_complex_id, cinema_complex_name, info_id, administrator_id) VALUES (6, 'Aibox', 4, 4);
INSERT INTO cinemas_complex (cinema_complex_id, cinema_complex_name, info_id, administrator_id) VALUES (7, 'Thoughtbeat', 7, 10);
INSERT INTO cinemas_complex (cinema_complex_id, cinema_complex_name, info_id, administrator_id) VALUES (8, 'Topicblab', 9, 10);
INSERT INTO cinemas_complex (cinema_complex_id, cinema_complex_name, info_id, administrator_id) VALUES (9, 'Livetube', 6, 1);
INSERT INTO cinemas_complex (cinema_complex_id, cinema_complex_name, info_id, administrator_id) VALUES (10, 'Gigazoom', 10, 5);

INSERT INTO movies (movie_id, movie_name, movie_time) VALUES (1, 'November', '10:01 PM');
INSERT INTO movies (movie_id, movie_name, movie_time) VALUES (2, 'Marianne & Juliane (Die Bleierne Zeit)', '10:55 PM');
INSERT INTO movies (movie_id, movie_name, movie_time) VALUES (3, 'Wrestling Queens', '6:24 AM');
INSERT INTO movies (movie_id, movie_name, movie_time) VALUES (4, 'Once You''re Born You Can No Longer Hide (Quando sei nato non puoi più nasconderti)', '8:01 PM');
INSERT INTO movies (movie_id, movie_name, movie_time) VALUES (5, 'Suspended Animation', '1:04 PM');


INSERT INTO movies_theaters (movie_theater_id, movie_theater_hall_number, movie_theater_nbr_places, cinema_complex_id, movie_id) VALUES (1, 4, 1, 4, 1);
INSERT INTO movies_theaters (movie_theater_id, movie_theater_hall_number, movie_theater_nbr_places, cinema_complex_id, movie_id) VALUES (2, 8, 5, 3, 5);
INSERT INTO movies_theaters (movie_theater_id, movie_theater_hall_number, movie_theater_nbr_places, cinema_complex_id, movie_id) VALUES (3, 2, 4, 1, 2);
INSERT INTO movies_theaters (movie_theater_id, movie_theater_hall_number, movie_theater_nbr_places, cinema_complex_id, movie_id) VALUES (4, 6, 7, 7, 2);
INSERT INTO movies_theaters (movie_theater_id, movie_theater_hall_number, movie_theater_nbr_places, cinema_complex_id, movie_id) VALUES (5, 5, 4, 9, 2);
INSERT INTO movies_theaters (movie_theater_id, movie_theater_hall_number, movie_theater_nbr_places, cinema_complex_id, movie_id) VALUES (6, 2, 6, 4, 1);
INSERT INTO movies_theaters (movie_theater_id, movie_theater_hall_number, movie_theater_nbr_places, cinema_complex_id, movie_id) VALUES (7, 6, 10, 6, 1);
INSERT INTO movies_theaters (movie_theater_id, movie_theater_hall_number, movie_theater_nbr_places, cinema_complex_id, movie_id) VALUES (8, 7, 4, 1, 2);
INSERT INTO movies_theaters (movie_theater_id, movie_theater_hall_number, movie_theater_nbr_places, cinema_complex_id, movie_id) VALUES (9, 3, 2, 9, 4);
INSERT INTO movies_theaters (movie_theater_id, movie_theater_hall_number, movie_theater_nbr_places, cinema_complex_id, movie_id) VALUES (10, 8, 6, 4, 2);

INSERT INTO sessions (session_id, session_start_movie) VALUES (1, '9:48 AM');
INSERT INTO sessions (session_id, session_start_movie) VALUES (2, '3:49 AM');
INSERT INTO sessions (session_id, session_start_movie) VALUES (3, '6:02 PM');
INSERT INTO sessions (session_id, session_start_movie) VALUES (4, '9:56 AM');

INSERT INTO movies_theaters_sessions (movie_theater_session_quantity, movie_theater_id, session_id) VALUES (8, 10, 2);
INSERT INTO movies_theaters_sessions (movie_theater_session_quantity, movie_theater_id, session_id) VALUES (2, 10, 4);
INSERT INTO movies_theaters_sessions (movie_theater_session_quantity, movie_theater_id, session_id) VALUES (19, 6, 2);
INSERT INTO movies_theaters_sessions (movie_theater_session_quantity, movie_theater_id, session_id) VALUES (10, 5, 3);
INSERT INTO movies_theaters_sessions (movie_theater_session_quantity, movie_theater_id, session_id) VALUES (22, 10, 1);
INSERT INTO movies_theaters_sessions (movie_theater_session_quantity, movie_theater_id, session_id) VALUES (19, 10, 3);

INSERT INTO customers (customer_id, customer_first_name, customer_last_name, customer_email, customer_age, customer_password, session_id) VALUES (1, 'Betteann', 'Bloy', 'bbloy0@imdb.com', 94, '35a3ae9e671134c659e0c1d56a748582ae410bf0889c18862090ffbc3eefe351', 1);
INSERT INTO customers (customer_id, customer_first_name, customer_last_name, customer_email, customer_age, customer_password, session_id) VALUES (2, 'Sonya', 'Reast', 'sreast1@exblog.jp', 33, 'c4a95b8803a93892ed7631c35e32caa75b86cc8932d727c751468d8efa8a1743', 3);
INSERT INTO customers (customer_id, customer_first_name, customer_last_name, customer_email, customer_age, customer_password, session_id) VALUES (3, 'Penelope', 'Walisiak', 'pwalisiak2@live.com', 34, 'd646c01c9b3c7a4daf508423675268d83bd46f22b80e848b5f97f0887e5583eb', 2);
INSERT INTO customers (customer_id, customer_first_name, customer_last_name, customer_email, customer_age, customer_password, session_id) VALUES (4, 'Katherina', 'Jahndel', 'kjahndel3@cocolog-nifty.com', 85, 'be9b2930184e5191dc044e2b4e4120840026e221af20a139ad633fc32f80267f', 4);
INSERT INTO customers (customer_id, customer_first_name, customer_last_name, customer_email, customer_age, customer_password, session_id) VALUES (5, 'Kirby', 'Lilloe', 'klilloe4@merriam-webster.com', 35, '83df0311440b35ff7e5bb3b1c5fb54ce871c73c9193b80cebc84ec9acb879794', 1);
INSERT INTO customers (customer_id, customer_first_name, customer_last_name, customer_email, customer_age, customer_password, session_id) VALUES (6, 'Gasparo', 'Budgen', 'gbudgen5@ovh.net', 88, '0536cfad36d834d99addfc670b28a7a1c5fdcb119b144c10f90f54a243b80c46', 3);

INSERT INTO prices_list (price_list_id, price, type_price, customer_id) VALUES (1, '€9,44', 'rutrum neque', 1);
INSERT INTO prices_list (price_list_id, price, type_price, customer_id) VALUES (2, '€8,80', 'arcu sed', 3);
INSERT INTO prices_list (price_list_id, price, type_price, customer_id) VALUES (3, '€0,14', 'orci pede', 2);
INSERT INTO prices_list (price_list_id, price, type_price, customer_id) VALUES (4, '€4,24', 'id justo', 6);
INSERT INTO prices_list (price_list_id, price, type_price, customer_id) VALUES (5, '€5,88', 'sed sagittis', 5);
INSERT INTO prices_list (price_list_id, price, type_price, customer_id) VALUES (6, '€6,89', 'laoreet ut', 3);
INSERT INTO prices_list (price_list_id, price, type_price, customer_id) VALUES (7, '€9,03', 'vestibulum ante', 5);
INSERT INTO prices_list (price_list_id, price, type_price, customer_id) VALUES (8, '€8,03', 'pulvinar sed', 6);
INSERT INTO prices_list (price_list_id, price, type_price, customer_id) VALUES (9, '€9,94', 'ipsum primis', 2);
INSERT INTO prices_list (price_list_id, price, type_price, customer_id) VALUES (10, '€6,68', 'magnis dis', 2);

INSERT INTO payments (payment_id, payment_type, customer_id) VALUES (1, 'volutpat', 2);
INSERT INTO payments (payment_id, payment_type, customer_id) VALUES (2, 'sit', 3);
INSERT INTO payments (payment_id, payment_type, customer_id) VALUES (3, 'massa', 4);