CREATE TABLE IF NOT EXISTS shows (
    id INT PRIMARY KEY AUTO_INCREMENT,
    movie INT NOT NULL,
    screen INT NOT NULL,
    show_date DATE NOT NULL,
    start_time TIME NOT NULL,
    FOREIGN KEY (movie) REFERENCES movies(id),
    FOREIGN KEY (screen) REFERENCES screens(id)
); 