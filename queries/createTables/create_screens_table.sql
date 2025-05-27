CREATE TABLE IF NOT EXISTS screens (
    id INT PRIMARY KEY AUTO_INCREMENT,
    theatre INT NOT NULL,
    audio_codec INT NOT NULL,
    seating_capacity INT NOT NULL,
    FOREIGN KEY (theatre) REFERENCES theatres(id),
    FOREIGN KEY (audio_codec) REFERENCES audio_codecs(id)
); 