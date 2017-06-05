
--1

SELECT movie
FROM STARREDIN
WHERE celeb ='Tom Cruise'
	INTERSECT 
SELECT movie
FROM STARREDIN
WHERE celeb ='Penélope Cruz'




--2

SELECT DISTINCT celeb 
FROM STARREDIN
WHERE movie IN (
SELECT movie
FROM STARREDIN
WHERE celeb ='Nicolas Cage'
)
MINUS
SELECT name
FROM Celebs
WHERE name = 'Nicolas Cage'


--2 alternative

SELECT DISTINCT S2.celeb
FROM STARREDIN S1, STARREDIN S2
WHERE S1.movie = S2.movie AND S1.celeb = 'Nicolas Cage' AND S2.celeb <> 'Nicolas Cage'
ORDER BY CELEB


--3

SELECT DISTINCT celeb2,t.movie
FROM STARREDIN t, STARREDIN t1,RELATIONSHIPS
WHERE RELATIONSHIPS.celeb1 = 'Tom Cruise' AND t1.celeb = celeb2 AND t.celeb= 'Tom Cruise' AND t1.movie = t.movie



--4

SELECT DISTINCT celeb1,celeb2,t.movie
FROM STARREDIN t, STARREDIN t1,RELATIONSHIPS
WHERE t1.celeb = celeb2 AND t.celeb= celeb1 AND t1.movie = t.movie AND t.celeb <>celeb2 AND t1.CELEB<>celeb1 AND celeb1<celeb2 
ORDER BY celeb1

--5

SELECT *
FROM (SELECT celeb,count(movie)AS cnt
		FROM STARREDIN
		GROUP BY celeb
		ORDER BY count(movie)DESC)
WHERE cnt >=10;




--6

SELECT DISTINCT t.celeb1,t1.celeb1,t1.celeb2
FROM RELATIONSHIPS t,RELATIONSHIPS t1
WHERE t.celeb1<t1.celeb1 AND t.celeb1 <> t1.celeb2  AND t1.celeb1 <> t.celeb2 AND t.celeb2 = t1.celeb2 
ORDER BY t.CELEB1


--7 Enemies(celeb1, celeb2)


DROP VIEW mo;


	CREATE VIEW mo AS 
		SELECT CELEBs.NAME, count(movie)AS  number_of_movies
		FROM STARREDIN 
		RIGHT OUTER JOIN CELEBS ON Starredin.CELEB = CELEBs.name
		GROUP BY celebs.NAME;
	--WHERE number_of_movies >=1 ;

		SELECT *
		FROM mo;

		
	SELECT DISTINCT enemies.CELEB1,enemies.CELEB2, ab.NUMBER_OF_MOVIES, bc.NUMBER_OF_MOVIES
	FROM ENEMIES, mo ab, mo bc
	WHERE ab.name = CELEB1 AND bc.name = CELEB2
	ORDER BY CELEB1

	
	
	
	

--8

SELECT *
FROM (SELECT celeb,count(album)AS cnt
		FROM RELEASES
		GROUP BY celeb
		ORDER BY count(album)DESC)
WHERE cnt >=2;


--9


SELECT DISTINCT STARREDIN.CELEB
FROM STARREDIN,RELEASES, CELEBS celeb
WHERE STARREDIN.CELEB in RELEASES.CELEB



--10


	CREATE VIEW al AS 
		SELECT *
		FROM (SELECT celeb,count(album)AS number_of_album
		FROM RELEASES
		GROUP BY celeb
		ORDER BY count(album)DESC)
	WHERE number_of_album >=1;

	CREATE VIEW mo AS 
		SELECT *
		FROM (SELECT celeb,count(movie)AS  number_of_movies
		FROM STARREDIN
		GROUP BY celeb
		ORDER BY count(movie)DESC)
	WHERE number_of_movies >=1;
		
		
SELECT DISTINCT STARREDIN.CELEB, al.number_of_album, mo.number_of_movies
FROM STARREDIN,RELEASES,al,mo
WHERE STARREDIN.CELEB in RELEASES.CELEB AND STARREDIN.CELEB = al.celeb AND STARREDIN.CELEB = mo.celeb
ORDER BY celeb

	DROP VIEW al;
	DROP VIEW mo;



--11---Relationships(celeb1, celeb2, started, ended)


	SELECT DISTINCT CELEB1, CELEB2, STARTED, ENDED--, min(r1.started)
	FROM RELATIONSHIPS
	WHERE CELEB1<CELEB2 AND STARTED = (SELECT min(STARTED)
									FROM RELATIONSHIPS
									WHERE RELATIONSHIPS.STARTED = STARTED )
UNION									
	SELECT DISTINCT CELEB1, CELEB2, STARTED, ENDED--, min(r1.started)
	FROM RELATIONSHIPS
	WHERE CELEB1<CELEB2 AND STARTED = (SELECT max(STARTED)
									FROM RELATIONSHIPS
									WHERE RELATIONSHIPS.STARTED = STARTED )

	