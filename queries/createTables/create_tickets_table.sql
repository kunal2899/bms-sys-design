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