SELECT ('ФИО: Александр Дубнов');
-- первый запрос 1.1 SELECT , LIMIT - выбрать 10 записей из таблицы ratings (Для всех дальнейших запросов выбирать по 10 записей, если не указано иное)
SELECT * FROM ratings LIMIT 10;

-- второй запрос 1.2 WHERE, LIKE - выбрать из таблицы links всё записи, у которых imdbid оканчивается на "42", а поле movieid между 100 и 1000 (Ограничивем вывод 10 записями)
SELECT
      imdbid,
      movieid
FROM links 
WHERE 
      imdbid like '%42'
      AND movieid between 100 AND 1000 -- так же можно и так: "AND movieid >= 100 AND movieid <= 1000"
LIMIT 10;

-- третий запрос 2.1 INNER JOIN выбрать из таблицы links все imdbId, которым ставили рейтинг 5 (Ограничивем вывод 10 записями)
SELECT imdbid
FROM links
INNER JOIN ratings
    ON links.movieid=ratings.movieid
WHERE ratings.rating = 5
LIMIT 10;

-- четвертый запрос 3.1 COUNT() Посчитать число фильмов без оценок

