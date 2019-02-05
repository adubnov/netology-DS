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
SELECT COUNT(1) - COUNT(rating) as movies_without_rating FROM ratings;

-- пятый запрос 3.2 GROUP BY, HAVING вывести top-10 пользователей, у который средний рейтинг выше 3.5
SELECT
    userId,
    AVG(rating) as avg_rating
FROM public.ratings
GROUP BY userId
HAVING AVG(rating) > 3.5
ORDER BY avg_rating DESC;
LIMIT 10;

-- шестой запрос 4.1 Подзапросы: достать любые 10 imbdId из links у которых средний рейтинг больше 3.5
SELECT
      lid.imdbid
FROM links as lid 
INNER JOIN (
      SELECT
            movieid, AVG(rating)
      FROM ratings
      GROUP BY movieid
      HAVING AVG(rating) > 3.5) as rid
ON (lid.movieid = rid.movieid)
LIMIT 10;

--седьмой запрос 4.2 Common Table Expressions: посчитать средний рейтинг по пользователям, у которых более 10 оценок. 
--Нужно подсчитать средний рейтинг по все пользователям, которые попали под условие - то есть в ответе должно быть одно число.
WITH tmp_table
AS (
      SELECT userid, COUNT(rating)   
      FROM ratings
      GROUP BY userid
      HAVING COUNT(rating) > 10
)            
SELECT AVG(rating) FROM public.ratings WHERE userid IN (SELECT userid FROM tmp_table);

