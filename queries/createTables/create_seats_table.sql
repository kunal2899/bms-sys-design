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