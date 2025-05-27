-- Create Tables
CREATE TABLE IF NOT EXISTS audio_codecs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS movie_types (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL,
    description TEXT
);

CREATE TABLE IF NOT EXISTS censor_grades (
    id INT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(5) NOT NULL,
    description TEXT
);

CREATE TABLE IF NOT EXISTS genres (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50) NOT NULL,
    description TEXT
);

CREATE TABLE IF NOT EXISTS payment_modes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    type VARCHAR(50) NOT NULL
);

-- Core Tables
CREATE TABLE IF NOT EXISTS theatres (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    location TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS screens (
    id INT PRIMARY KEY AUTO_INCREMENT,
    theatre INT NOT NULL,
    audio_codec INT NOT NULL,
    seating_capacity INT NOT NULL,
    FOREIGN KEY (theatre) REFERENCES theatres(id),
    FOREIGN KEY (audio_codec) REFERENCES audio_codecs(id)
);

CREATE TABLE IF NOT EXISTS movies (
    id INT PRIMARY KEY AUTO_INCREMENT,
    type INT NOT NULL,
    censor_grade INT NOT NULL,
    genre INT NOT NULL,
    name VARCHAR(200) NOT NULL,
    duration INT NOT NULL,
    release_date DATE NOT NULL,
    language VARCHAR(50) NOT NULL,
    FOREIGN KEY (type) REFERENCES movie_types(id),
    FOREIGN KEY (censor_grade) REFERENCES censor_grades(id),
    FOREIGN KEY (genre) REFERENCES genres(id)
);

CREATE TABLE IF NOT EXISTS shows (
    id INT PRIMARY KEY AUTO_INCREMENT,
    movie INT NOT NULL,
    screen INT NOT NULL,
    show_date DATE NOT NULL,
    start_time TIME NOT NULL,
    FOREIGN KEY (movie) REFERENCES movies(id),
    FOREIGN KEY (screen) REFERENCES screens(id)
);

CREATE TABLE IF NOT EXISTS customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    mobile VARCHAR(20),
    password VARCHAR(255) NOT NULL,
    location VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS seats (
    id INT PRIMARY KEY AUTO_INCREMENT,
    screen INT NOT NULL,
    row_code VARCHAR(5) NOT NULL,
    number INT NOT NULL,
    zone VARCHAR(50) NOT NULL,
    type VARCHAR(50) NOT NULL,
    FOREIGN KEY (screen) REFERENCES screens(id),
    UNIQUE KEY unique_seat (screen, row_code, number)
);

CREATE TABLE IF NOT EXISTS payments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    mode INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (mode) REFERENCES payment_modes(id)
);

CREATE TABLE IF NOT EXISTS bookings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    booked_by INT NOT NULL,
    show_id INT NOT NULL,
    FOREIGN KEY (booked_by) REFERENCES customers(id),
    FOREIGN KEY (show_id) REFERENCES shows(id)
);

CREATE TABLE IF NOT EXISTS tickets (
    id INT PRIMARY KEY AUTO_INCREMENT,
    show_id INT NOT NULL,
    payment INT NOT NULL,
    seat INT NOT NULL,
    booking INT NOT NULL,
    FOREIGN KEY (show_id) REFERENCES shows(id),
    FOREIGN KEY (payment) REFERENCES payments(id),
    FOREIGN KEY (seat) REFERENCES seats(id),
    FOREIGN KEY (booking) REFERENCES bookings(id),
    UNIQUE KEY unique_show_seat (show_id, seat)
);

-- Insert Sample Data
INSERT INTO audio_codecs (name) VALUES
('Dolby Atmos'),
('DTS:X'),
('Standard 5.1'),
('Dolby Digital'),
('Auro 11.1');

INSERT INTO movie_types (name, description) VALUES
('2D', 'Standard two-dimensional projection'),
('3D', 'Three-dimensional projection'),
('IMAX', 'Immersive large-format projection'),
('4DX', 'Motion and environmental effects'),
('ScreenX', '270-degree panoramic viewing');

INSERT INTO censor_grades (code, description) VALUES
('U', 'Universal'),
('UA', 'Universal with parental guidance'),
('A', 'Adults only'),
('S', 'Special category'),
('U/A', 'Universal with adult guidance');

INSERT INTO genres (title, description) VALUES
('Action', 'High-energy, fast-paced'),
('Comedy', 'Humorous, light-hearted'),
('Sci-Fi', 'Speculative fiction'),
('Drama', 'Serious, character-driven'),
('Horror', 'Scary and suspenseful'),
('Romance', 'Love and relationships'),
('Thriller', 'Suspense and tension'),
('Animation', 'Animated content');

INSERT INTO payment_modes (type) VALUES
('Credit Card'),
('Debit Card'),
('UPI'),
('Net Banking'),
('Digital Wallet'),
('Cash');

-- Core Tables Data
INSERT INTO theatres (name, location) VALUES
('Grand Cinema', '123 Main St, New York'),
('Star Theatres', '456 Elm Ave, Old York'),
('Cineplex', '789 Park Road, New York'),
('Royal Cinemas', '321 Broadway, New York'),
('Metro Movies', '654 5th Avenue, New York');

INSERT INTO screens (theatre, audio_codec, seating_capacity) VALUES
(1, 1, 200),
(1, 3, 150),
(2, 2, 250),
(2, 1, 180),
(3, 4, 220),
(3, 5, 160),
(4, 1, 190),
(5, 2, 210);

INSERT INTO movies (type, censor_grade, genre, name, duration, release_date, language) VALUES
(1, 2, 1, 'The Great Escape', 150, '2023-01-15', 'English'),
(2, 1, 2, 'Laugh Out Loud', 100, '2023-02-20', 'English'),
(3, 2, 3, 'Cosmic Journey', 180, '2023-03-10', 'English'),
(1, 2, 4, 'The Last Stand', 140, '2023-04-05', 'English'),
(2, 1, 5, 'Midnight Horror', 120, '2023-05-01', 'English'),
(3, 2, 6, 'Love Story', 160, '2023-06-15', 'English');

INSERT INTO shows (movie, screen, show_date, start_time) VALUES
(1, 1, '2023-05-28', '19:00:00'),
(2, 2, '2023-05-28', '14:30:00'),
(1, 1, '2023-05-29', '21:00:00'),
(3, 3, '2023-05-28', '18:00:00'),
(4, 4, '2023-05-28', '20:30:00'),
(5, 5, '2023-05-28', '22:00:00'),
(6, 6, '2023-05-29', '15:00:00'),
(1, 7, '2023-05-29', '16:30:00'),
(2, 8, '2023-05-29', '19:30:00');

INSERT INTO customers (name, email, mobile, password, location, city) VALUES
('Devansh Sharma', 'devansh@example.com', '+1234567890', 'abcdef12345', 'Downtown', 'New York'),
('Bobby Singh', 'bobby@example.com', '+1987654321', 'ghijkl67890', 'Uptown', 'New York'),
('Aditi Dahare', 'aditi@example.com', '+1122334455', 'mnopqr11223', 'Midtown', 'New York'),
('Rahul Verma', 'rahul@example.com', '+1456789012', 'stuvwx34567', 'Westside', 'New York'),
('Priya Patel', 'priya@example.com', '+1567890123', 'yzabcd78901', 'Eastside', 'New York'),
('Amit Kumar', 'amit@example.com', '+1678901234', 'efghij23456', 'Northside', 'New York');

INSERT INTO seats (screen, row_code, number, zone, type) VALUES
(1, 'A', 1, 'Standard', 'Regular'),
(1, 'A', 2, 'Standard', 'Regular'),
(1, 'B', 5, 'Premium', 'Recliner'),
(2, 'C', 10, 'Standard', 'Regular'),
(3, 'D', 3, 'Premium', 'Regular'),
(4, 'A', 1, 'Standard', 'Regular'),
(5, 'B', 2, 'Premium', 'Recliner'),
(6, 'C', 3, 'Standard', 'Regular'),
(7, 'D', 4, 'Premium', 'Regular'),
(8, 'A', 5, 'Standard', 'Regular');

INSERT INTO payments (mode, amount, created_at) VALUES
(1, 25.00, '2023-05-27 10:00:00'),
(2, 12.50, '2023-05-27 11:30:00'),
(1, 25.00, '2023-05-27 12:00:00'),
(3, 18.00, '2023-05-27 13:00:00'),
(4, 30.00, '2023-05-27 14:00:00'),
(5, 22.50, '2023-05-27 15:00:00'),
(1, 27.00, '2023-05-27 16:00:00'),
(2, 15.00, '2023-05-27 17:00:00');

INSERT INTO bookings (booked_by, show_id) VALUES
(1, 1),
(2, 2),
(1, 1),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(1, 7),
(2, 8);

INSERT INTO tickets (show_id, payment, seat, booking) VALUES
(1, 1, 1, 1),
(1, 1, 2, 1),
(2, 2, 4, 2),
(1, 3, 3, 3),
(4, 4, 5, 4),
(5, 5, 6, 5),
(6, 6, 7, 6),
(7, 7, 8, 7),
(8, 8, 9, 8),
(9, 1, 10, 9);