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
cinema(# session_id INT);

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

insert into administrators (administrator_id, administrator_first_name, administrator_last_name, administrator_password) values (1, 'Corri', 'Taberner', '173449d2ec5998419a4929e2c8a4cac396828fde85b45c53fe84017bb6fabf1c');
insert into administrators (administrator_id, administrator_first_name, administrator_last_name, administrator_password) values (2, 'Wilfrid', 'Filip', 'c9e4e050e8716407aaa98dca4ef3da51205da46834b725c0ee24f0bc55f03c9a');
insert into administrators (administrator_id, administrator_first_name, administrator_last_name, administrator_password) values (3, 'Julieta', 'Toynbee', '875e1409ef14e912a4256f050d6427b5e96d849b220e14372a7a5bca3fb94c6b');
insert into administrators (administrator_id, administrator_first_name, administrator_last_name, administrator_password) values (4, 'Emlyn', 'Warrack', '5a05b4ea99f56a9ec825571b4237e9778a556dd4c731b8a66bec649e90ecae00');
insert into administrators (administrator_id, administrator_first_name, administrator_last_name, administrator_password) values (5, 'Sibilla', 'Tomashov', '3af5ee54d26e170cd20776600ec033091e9b2ac4c79f292d0433d7ad589aebaf');
insert into administrators (administrator_id, administrator_first_name, administrator_last_name, administrator_password) values (6, 'Caritta', 'Nassau', '813d23a459bdf3e28cebccb479b5e2fcdb8b2c0b93600857281d138f1773ab31');
insert into administrators (administrator_id, administrator_first_name, administrator_last_name, administrator_password) values (7, 'Natty', 'Petrollo', '2cba934d32a0f72a7c8299ed1f85dd9428f3822d55419b4c203feb6856174fc0');
insert into administrators (administrator_id, administrator_first_name, administrator_last_name, administrator_password) values (8, 'Angel', 'Clemitt', '220290bf7b086a62d35891be76b244d0bf7d1156240a3e0d8700a76e707f2e66');
insert into administrators (administrator_id, administrator_first_name, administrator_last_name, administrator_password) values (9, 'Michaeline', 'Sellner', '449ff49b2e6b5bc6f0e89b1a497baca5daecefdabe56c6d5b0641f33afa0e4de');
insert into administrators (administrator_id, administrator_first_name, administrator_last_name, administrator_password) values (10, 'Corbett', 'Parks', '29defcd4d2ce2ff93ec47299566cacf464b8c823a1bd513c22e0dc5e85febc70');

insert into infos (info_id, info_phone, info_address, info_postal_code, info_city) values (1, '932-782-0987', '019 Victoria Road', '89129', 'Reggio Calabria');
insert into infos (info_id, info_phone, info_address, info_postal_code, info_city) values (2, '460-567-4096', '5 Arizona Way', '3899', 'Zeewolde');
insert into infos (info_id, info_phone, info_address, info_postal_code, info_city) values (3, '326-183-3347', '73 Hooker Avenue', null, 'Koysinceq');
insert into infos (info_id, info_phone, info_address, info_postal_code, info_city) values (4, '611-261-7537', '6 Knutson Terrace', null, 'Huế');
insert into infos (info_id, info_phone, info_address, info_postal_code, info_city) values (5, '796-412-6763', '41 Hollow Ridge Lane', null, 'Kryevidh');
insert into infos (info_id, info_phone, info_address, info_postal_code, info_city) values (6, '205-125-3577', '71323 Steensland Hill', '35244', 'Birmingham');
insert into infos (info_id, info_phone, info_address, info_postal_code, info_city) values (7, '329-876-4206', '61771 Hagan Trail', null, 'Sungai Iyu');
insert into infos (info_id, info_phone, info_address, info_postal_code, info_city) values (8, '646-964-8450', '20 Southridge Place', null, 'Mingshan');
insert into infos (info_id, info_phone, info_address, info_postal_code, info_city) values (9, '799-355-5038', '946 Caliangt Avenue', 'V31', 'Gweedore');
insert into infos (info_id, info_phone, info_address, info_postal_code, info_city) values (10, '465-429-9641', '64925 Prentice Drive', '01057', 'Mixco');

insert into cinemas_complex (cinema_complex_id, cinema_complex_name) values (1, 'Moore and Sons');
insert into cinemas_complex (cinema_complex_id, cinema_complex_name) values (2, 'Pfeffer LLC');
insert into cinemas_complex (cinema_complex_id, cinema_complex_name) values (3, 'Weber-Mayer');
insert into cinemas_complex (cinema_complex_id, cinema_complex_name) values (4, 'Jast Group');
insert into cinemas_complex (cinema_complex_id, cinema_complex_name) values (5, 'Crona-Cummerata');
insert into cinemas_complex (cinema_complex_id, cinema_complex_name) values (6, 'Ferry-O''Kon');
insert into cinemas_complex (cinema_complex_id, cinema_complex_name) values (7, 'Douglas Inc');
insert into cinemas_complex (cinema_complex_id, cinema_complex_name) values (8, 'Zieme, Kassulke and Fritsch');
insert into cinemas_complex (cinema_complex_id, cinema_complex_name) values (9, 'Fahey, Nienow and Sipes');
insert into cinemas_complex (cinema_complex_id, cinema_complex_name) values (10, 'Wilkinson and Sons');

insert into movies (movie_id, movie_name, movie_time) values (1, 'November', '10:01 PM');
insert into movies (movie_id, movie_name, movie_time) values (2, 'Marianne & Juliane (Die Bleierne Zeit)', '10:55 PM');
insert into movies (movie_id, movie_name, movie_time) values (3, 'Wrestling Queens', '6:24 AM');
insert into movies (movie_id, movie_name, movie_time) values (4, 'Once You''re Born You Can No Longer Hide (Quando sei nato non puoi più nasconderti)', '8:01 PM');
insert into movies (movie_id, movie_name, movie_time) values (5, 'Suspended Animation', '1:04 PM');
insert into movies (movie_id, movie_name, movie_time) values (6, 'Silent House', '4:45 PM');
insert into movies (movie_id, movie_name, movie_time) values (7, 'Finances of the Grand Duke, The (Die Finanzen des Großherzogs)', '2:18 AM');
insert into movies (movie_id, movie_name, movie_time) values (8, 'Power of Nightmares, The: The Rise of the Politics of Fear', '4:23 PM');
insert into movies (movie_id, movie_name, movie_time) values (9, 'The Salt of the Earth', '9:09 AM');
insert into movies (movie_id, movie_name, movie_time) values (10, 'Fighting', '7:12 AM');
insert into movies (movie_id, movie_name, movie_time) values (11, 'Under the Flag of the Rising Sun', '11:19 PM');
insert into movies (movie_id, movie_name, movie_time) values (12, 'The Wind in the Willows', '9:52 PM');
insert into movies (movie_id, movie_name, movie_time) values (13, 'Lucky Texan, The', '2:15 PM');
insert into movies (movie_id, movie_name, movie_time) values (14, 'Candidate, The (Kandidaten)', '1:13 PM');
insert into movies (movie_id, movie_name, movie_time) values (15, 'The DUFF', '10:56 PM');


insert into movies_theaters (movie_theater_id, movie_theater_hall_number, movie_theater_nbr_places) values (1, 2, 215);
insert into movies_theaters (movie_theater_id, movie_theater_hall_number, movie_theater_nbr_places) values (2, 1, 138);
insert into movies_theaters (movie_theater_id, movie_theater_hall_number, movie_theater_nbr_places) values (3, 8, 17);
insert into movies_theaters (movie_theater_id, movie_theater_hall_number, movie_theater_nbr_places) values (4, 10, 289);
insert into movies_theaters (movie_theater_id, movie_theater_hall_number, movie_theater_nbr_places) values (5, 3, 48);
insert into movies_theaters (movie_theater_id, movie_theater_hall_number, movie_theater_nbr_places) values (6, 6, 180);
insert into movies_theaters (movie_theater_id, movie_theater_hall_number, movie_theater_nbr_places) values (7, 5, 1);
insert into movies_theaters (movie_theater_id, movie_theater_hall_number, movie_theater_nbr_places) values (8, 15, 68);
insert into movies_theaters (movie_theater_id, movie_theater_hall_number, movie_theater_nbr_places) values (9, 14, 108);
insert into movies_theaters (movie_theater_id, movie_theater_hall_number, movie_theater_nbr_places) values (10, 11, 273);
insert into movies_theaters (movie_theater_id, movie_theater_hall_number, movie_theater_nbr_places) values (11, 9, 22);
insert into movies_theaters (movie_theater_id, movie_theater_hall_number, movie_theater_nbr_places) values (12, 14, 23);
insert into movies_theaters (movie_theater_id, movie_theater_hall_number, movie_theater_nbr_places) values (13, 14, 153);
insert into movies_theaters (movie_theater_id, movie_theater_hall_number, movie_theater_nbr_places) values (14, 15, 179);
insert into movies_theaters (movie_theater_id, movie_theater_hall_number, movie_theater_nbr_places) values (15, 8, 168);

insert into sessions (session_id, session_start_movie) values (1, '9:48 AM');
insert into sessions (session_id, session_start_movie) values (2, '3:49 AM');
insert into sessions (session_id, session_start_movie) values (3, '6:02 PM');
insert into sessions (session_id, session_start_movie) values (4, '9:56 AM');
insert into sessions (session_id, session_start_movie) values (5, '10:32 AM');
insert into sessions (session_id, session_start_movie) values (6, '8:04 PM');
insert into sessions (session_id, session_start_movie) values (7, '12:12 AM');
insert into sessions (session_id, session_start_movie) values (8, '9:11 PM');
insert into sessions (session_id, session_start_movie) values (9, '10:52 AM');
insert into sessions (session_id, session_start_movie) values (10, '5:38 PM');

insert into movies_theaters_sessions (movie_theater_session_quantity) values (6);
insert into movies_theaters_sessions (movie_theater_session_quantity) values (5);
insert into movies_theaters_sessions (movie_theater_session_quantity) values (4);
insert into movies_theaters_sessions (movie_theater_session_quantity) values (4);
insert into movies_theaters_sessions (movie_theater_session_quantity) values (6);
insert into movies_theaters_sessions (movie_theater_session_quantity) values (5);
insert into movies_theaters_sessions (movie_theater_session_quantity) values (5);
insert into movies_theaters_sessions (movie_theater_session_quantity) values (6);
insert into movies_theaters_sessions (movie_theater_session_quantity) values (6);
insert into movies_theaters_sessions (movie_theater_session_quantity) values (6);

insert into customers (customer_id, customer_first_name, customer_last_name, customer_email, customer_age, customer_password) values (1, 'Betteann', 'Bloy', 'bbloy0@imdb.com', 94, '35a3ae9e671134c659e0c1d56a748582ae410bf0889c18862090ffbc3eefe351');
insert into customers (customer_id, customer_first_name, customer_last_name, customer_email, customer_age, customer_password) values (2, 'Sonya', 'Reast', 'sreast1@exblog.jp', 33, 'c4a95b8803a93892ed7631c35e32caa75b86cc8932d727c751468d8efa8a1743');
insert into customers (customer_id, customer_first_name, customer_last_name, customer_email, customer_age, customer_password) values (3, 'Penelope', 'Walisiak', 'pwalisiak2@live.com', 34, 'd646c01c9b3c7a4daf508423675268d83bd46f22b80e848b5f97f0887e5583eb');
insert into customers (customer_id, customer_first_name, customer_last_name, customer_email, customer_age, customer_password) values (4, 'Katherina', 'Jahndel', 'kjahndel3@cocolog-nifty.com', 85, 'be9b2930184e5191dc044e2b4e4120840026e221af20a139ad633fc32f80267f');
insert into customers (customer_id, customer_first_name, customer_last_name, customer_email, customer_age, customer_password) values (5, 'Kirby', 'Lilloe', 'klilloe4@merriam-webster.com', 35, '83df0311440b35ff7e5bb3b1c5fb54ce871c73c9193b80cebc84ec9acb879794');
insert into customers (customer_id, customer_first_name, customer_last_name, customer_email, customer_age, customer_password) values (6, 'Gasparo', 'Budgen', 'gbudgen5@ovh.net', 88, '0536cfad36d834d99addfc670b28a7a1c5fdcb119b144c10f90f54a243b80c46');

insert into prices_list (price_list_id, price, type_price) values (1, '€9,44', 'rutrum neque');
insert into prices_list (price_list_id, price, type_price) values (2, '€8,80', 'arcu sed');
insert into prices_list (price_list_id, price, type_price) values (3, '€0,14', 'orci pede');
insert into prices_list (price_list_id, price, type_price) values (4, '€4,24', 'id justo');
insert into prices_list (price_list_id, price, type_price) values (5, '€5,88', 'sed sagittis');
insert into prices_list (price_list_id, price, type_price) values (6, '€6,89', 'laoreet ut');
insert into prices_list (price_list_id, price, type_price) values (7, '€9,03', 'vestibulum ante');
insert into prices_list (price_list_id, price, type_price) values (8, '€8,03', 'pulvinar sed');
insert into prices_list (price_list_id, price, type_price) values (9, '€9,94', 'ipsum primis');
insert into prices_list (price_list_id, price, type_price) values (10, '€6,68', 'magnis dis');

insert into payments (payment_id, payment_type) values (1, 'volutpat');
insert into payments (payment_id, payment_type) values (2, 'sit');
insert into payments (payment_id, payment_type) values (3, 'massa');