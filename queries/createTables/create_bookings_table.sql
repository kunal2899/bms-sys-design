CREATE TABLE IF NOT EXISTS bookings (
    id INT PRIMARY KEY AUTO_INCREMENT,
    booked_by INT NOT NULL,
    show_id INT NOT NULL,
    FOREIGN KEY (booked_by) REFERENCES customers(id),
    FOREIGN KEY (show_id) REFERENCES shows(id)
); 