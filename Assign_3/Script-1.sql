

--1





--Classes(class, type, country, numGuns, bore, displacement)
DROP TABLE Classes;

CREATE TABLE Classes (
	class CHAR(25),
	TYPE char(2),
	country CHAR(20),
	numGuns int,
	bore int,
	displacement int,
	PRIMARY KEY (class,type)
);

--Ships(name, class, launched)
DROP TABLE ships;

CREATE TABLE ships(
	name char (25),
	class char (25),
	launched int,
	PRIMARY KEY (name,class)
);


--Battles(name, date fought)

CREATE TABLE battles(
	name char (20) PRIMARY KEY,
	date_fought char (20)	
);

DROP TABLE battles;

--Outcomes(ship, battle, result)

CREATE TABLE Outcomes(
	ship char (20),
	battle char(20),
	RESULT char(10)
);

DROP table Outcomes;

insert INTO Classes values ('Bismarck','bb','Germany',8,15,42000); --
insert INTO Classes values ('Kongo','bc','Japan',8,14,32000);
insert INTO Classes values ('North Carolina','bb','USA',9,16,37000); --
insert INTO Classes values ('Renown','bc','Gt. Britain',6,15,32000);
insert INTO Classes values ('Revenge','bb','Gt. Britain',8,15,29000); --
insert INTO Classes values ('Tennessee','bb','USA',12,14,32000); --
insert INTO Classes values ('Yamato','bb','Japan',9,18,65000); --

SELECT *
FROM classes;


insert INTO Ships VALUES ('California','Tennessee',1921);
insert INTO Ships VALUES ('Haruna','Kongo',1915);
insert INTO Ships VALUES ('Hiei','Kongo',1914);
insert INTO Ships VALUES ('Iowa','Iowa',1943);
insert INTO Ships VALUES ('Kirishima','Kongo',1914);
insert INTO Ships VALUES ('Kongo','Kongo',1913);
insert INTO Ships VALUES ('Missouri','Iowa',1944);
insert INTO Ships VALUES ('Musashi','Yamato',1942);
insert INTO Ships VALUES ('New Jersey','Iowa',1943);
insert INTO Ships VALUES ('North Carolina','North Carolina',1941);
insert INTO Ships VALUES ('Ramilles','Revenge',1917);
insert INTO Ships VALUES ('Renown','Renown',1916);
insert INTO Ships VALUES ('Repulse','Renown',1916);
insert INTO Ships VALUES ('Resolution','Revenge',1916);
insert INTO Ships VALUES ('Revenge','Revenge',1916);
insert INTO Ships VALUES ('Royal Oak','Revenge',1916);
insert INTO Ships VALUES ('Royal Sovereign','Revenge',1916);
insert INTO Ships VALUES ('Tennessee','Tennessee',1920);
insert INTO Ships VALUES ('Washington','North Carolina',1941);
insert INTO Ships VALUES ('Wisconsin','Iowa',1944);
insert INTO Ships VALUES ('Yamato','Yamato',1941);

SELECT *
FROM ships;


INSERT INTO Battles VALUES ('North Atlantic','27-May-1941');
INSERT INTO Battles VALUES ('Guadalcanal','15-Nov-1942');
INSERT INTO Battles VALUES ('North Cape','26-Dec-1943');
INSERT INTO Battles VALUES ('Surigao Strait','25-Oct-1944');


SELECT *
FROM Battles;


INSERT INTO Outcomes VALUES ('Bismarck','North Atlantic', 'sunk');
INSERT INTO Outcomes VALUES ('California','Surigao Strait', 'ok');
INSERT INTO Outcomes VALUES ('Duke of York','North Cape', 'ok');
INSERT INTO Outcomes VALUES ('Fuso','Surigao Strait', 'sunk');
INSERT INTO Outcomes VALUES ('Hood','North Atlantic', 'sunk');
INSERT INTO Outcomes VALUES ('King George V','North Atlantic', 'ok');
INSERT INTO Outcomes VALUES ('Kirishima','Guadalcanal', 'sunk');
INSERT INTO Outcomes VALUES ('Prince of Wales','North Atlantic', 'damaged');
INSERT INTO Outcomes VALUES ('Rodney','North Atlantic', 'ok');
INSERT INTO Outcomes VALUES ('Scharnhorst','North Cape', 'sunk');
INSERT INTO Outcomes VALUES ('South Dakota','Guadalcanal', 'ok');
INSERT INTO Outcomes VALUES ('West Virginia','Surigao Strait', 'ok');
INSERT INTO Outcomes VALUES ('Yamashiro','Surigao Strait', 'sunk');



SELECT *
FROM OutComes;


--2

--a

SELECT DISTINCT Ships.name
FROM Classes, Ships
WHERE Classes.displacement > 35000 AND Classes.class = Ships.class AND Ships.launched >= 1921

/*
 * 
 Musashi                  
North Carolina           
Yamato                   
Washington               
 * 
 * 
 */

--b

SELECT Ships.name, Classes.displacement, Classes.numGuns
FROM Classes, Ships, Outcomes
WHERE Outcomes.battle = 'Guadalcanal' AND Outcomes.ship = Ships.name AND Classes.class = Ships.class 
/*
 * 
Kirishima 	32000	8 
 
 */
--c 

SELECT DISTINCT name
FROM ships
UNION
SELECT DISTINCT ship 
FROM outcomes
/*
 * 
 Bismarck            
California          
California               
Duke of York        
Fuso                
Haruna                   
Hiei                     
Hood                
Iowa                     
King George V       
Kirishima           
Kirishima                
Kongo                    
Missouri                 
Musashi                  
New Jersey               
North Carolina           
Prince of Wales     
Ramilles                 
Renown                   
Repulse                  
Resolution               
Revenge                  
Rodney              
Royal Oak                
Royal Sovereign          
Scharnhorst         
South Dakota        
Tennessee                
Washington               
West Virginia       
Wisconsin                
Yamashiro           
Yamato                   
 */




--d

SELECT c1.country
FROM Classes c1, Classes c2
WHERE c1.country = c2.country AND c1.TYPE = 'bb' AND c2.TYPE = 'bc'

/*
Gt. Britain         
Japan               
 */

--e

SELECT o1.ship
FROM outcomes o1, outcomes o2
WHERE o1.ship = o2.ship AND o1.battle <> o2.battle


--no result

--F

SELECT country
FROM classes
WHERE numGuns = (SELECT max(numGuns)
				FROM classes)	
			
--USA

--g-------

SELECT name
FROM (SELECT name, numGuns, bore FROM Ships NATURAL JOIN Classes) X
WHERE numGuns = (
SELECT max(numGuns)
FROM Ships NATURAL JOIN Classes
WHERE bore=X.bore
);

/*
California               
Musashi                  
North Carolina           
Ramilles                 
Resolution               
Revenge                  
Royal Oak                
Royal Sovereign          
Tennessee                
Washington               
Yamato                   
 */

--h

DROP VIEW mo;
DROP VIEW ro;

CREATE VIEW mo AS
SELECT class
FROM Ships
GROUP BY class
HAVING COUNT(name)>=3;


CREATE VIEW ro AS
SELECT class, ship
FROM Ships, Outcomes
WHERE Ships.name=Outcomes.ship AND Outcomes.result='sunk';


SELECT class, COUNT(ship) AS sunk_ships
FROM mo NATURAL LEFT OUTER JOIN ro
GROUP BY class;

/*
Revenge                  	0
Iowa                     	0
Kongo                    	1
 */

--3

--a 
insert INTO Ships VALUES ('Vittorio Veneto','Italian Vittorio Veneto',1940);
insert INTO Ships VALUES ('Italia','Italian Vittorio Veneto',1940);
insert INTO Ships VALUES ('Roma','Italian Vittorio Veneto',1942);
insert INTO Classes values ('Italian Vittorio Veneto','bb','Italy',null,15,41000); 


--b


DELETE FROM Classes
WHERE class IN (
SELECT class
FROM Classes NATURAL LEFT OUTER JOIN Ships
GROUP BY class
HAVING COUNT(name)<3);

SELECT * 
FROM CLASSES

/*
Kongo                    	bc	Japan               	8	14	32000
Revenge                  	bb	Gt. Britain         	8	15	29000
Italian Vittorio Veneto  	bb	Italy               	[NULL]	15	41000
 */

--c

SELECT *
FROM CLASSES

--bore to cm
UPDATE CLASSES
SET bore = bore*(2.5/1)


--reverse
UPDATE CLASSES
SET bore = bore*(1/2.5)


--Displacement
SELECT * 
FROM CLASSES

--to metric
UPDATE CLASSES
SET DISPLACEMENT= DISPLACEMENT*(1.1)


--reverse
UPDATE CLASSES
SET DISPLACEMENT = DISPLACEMENT*(1/1.1)


--4

--a


DELETE FROM Ships WHERE Ships.class NOT IN (SELECT class FROM classes);
ALTER TABLE Ships ADD FOREIGN KEY (class) REFERENCES Classes(class) ON DELETE CASCADE;



SELECT *
FROM ships --,CLASSES
--WHERE ships.class -- = classes.CLASS

--b 

DELETE FROM Outcomes WHERE Outcomes.battle NOT IN (SELECT name FROM Battles);
ALTER TABLE Outcomes ADD FOREIGN KEY (battle) REFERENCES Battles(name) ON DELETE CASCADE;

--c

DELETE FROM Outcomes WHERE Outcomes.ship NOT IN (SELECT name FROM Ships);
ALTER TABLE Outcomes ADD FOREIGN KEY (ship) REFERENCES Ships(name) ON DELETE CASCADE;

--D

DELETE FROM Classes WHERE bore>16*2.5;
ALTER TABLE Classes ADD CHECK (bore<=16*2.5);


--e

DELETE FROM Classes WHERE numguns>9 AND bore>14*2.5;
ALTER TABLE Classes ADD CHECK (numguns<=9 OR bore<=14*2.5);

--f

/*
ALTER TABLE BATTLES 
ADD CONSTRAINT beforeLaunched
CHECK (checkFunction() = 1);

CREATE FUNCTION checkFunction()
RETURN INT
BEGIN
		RETURN(
			SELECT 
				CASE WHEN Battles.DATE_FOUGHT > Ships.LAUNCHED THEN 1
					ELSE 0 
				END
			FROM Battles, Ships
		)			
END;
 */


DELETE FROM battles, SHIPS, outcomes WHERE Outcomes.battle = battles.name AND Ships.LAUNCHED>Battles.date_fought;
ALTER TABLE Outcomes ADD FOREIGN KEY (ship) REFERENCES Ships(name) ON DELETE CASCADE;

--g


DELETE FROM battles, SHIPS, outcomes WHERE Outcomes.battle = battles.name AND Ships.LAUNCHED>Battles.date_fought;
ALTER TABLE Outcomes ADD FOREIGN KEY (ship) REFERENCES Ships(name) ON DELETE CASCADE;

--h

DELETE FROM battles, SHIPS, outcomes WHERE Outcomes.battle = battles.name AND Ships.LAUNCHED>Battles.date_fought;
ALTER TABLE Outcomes ADD FOREIGN KEY (ship) REFERENCES Ships(name) ON DELETE CASCADE;

