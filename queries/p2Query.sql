SELECT
  t.name AS theatre_name,
  sc.id AS screen_number,
  m.name AS movie_name,
  cg.code AS movie_censor_grade,
  g.title AS movie_genre,
  m.language,
  mt.name AS movie_format,
  ac.name AS audio_codec,
  show_date,
  start_time,
  -- duration is in minutes, for better readability, converted to hours and minutes
  CONCAT(
    FLOOR(duration / 60),
    ' hours ',
    LPAD(duration % 60, 2, '0'),
    ' minutes'
  ) AS duration
FROM
  shows s
  JOIN screens sc ON s.screen = sc.id
  JOIN theatres t ON sc.theatre = t.id
  JOIN audio_codecs ac ON sc.audio_codec = ac.id
  JOIN movies m ON s.movie = m.id
  JOIN movie_types mt ON m.type = mt.id
  JOIN censor_grades cg ON m.censor_grade = cg.id
  JOIN genres g ON m.genre = g.id
WHERE
  show_date BETWEEN '2023-05-25' AND '2023-05-30'
  AND t.name IN ('Cineplex', 'Grand Cinema');