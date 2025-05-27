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