USE labor_sql;

SELECT model, type, price 
FROM printer
WHERE price<300
ORDER BY type DESC;

SELECT name
FROM battles
WHERE name LIKE '% %' AND name NOT LIKE '%c';

SELECT name,ships.class,launched,country
FROM Classes,Ships
WHERE classes.class=ships.class;

SELECT DISTINCT maker 
FROM product
WHERE type="PC" 
	AND NOT "Laptop" = SOME( SELECT type FROM product s WHERE s.maker=product.maker); 
    
    
SELECT name, launched, displacement
FROM Classes RIGHT JOIN ships ON classes.class=ships.class
WHERE type = 'bb' AND launched>1922 AND displacement>35000;

SELECT concat('code: ', code) code , concat("model: ", model) model,
 concat("speed: ", speed) speed, concat("ram: ", ram) ram,
 concat("hd: ", hd) hd, concat("cd: ", cd) cd, concat("price: ", price) price
FROM PC;

SELECT battle, Classes.country, count(Outcomes.battle) count
FROM Outcomes LEFT JOIN Battles ON Battles.name=Outcomes.battle 
	JOIN Ships on Outcomes.Ship=Ships.name LEFT JOIN Classes ON Ships.class=Classes.class 
GROUP BY Battle;
 
SELECT maker, AVG(screen) 
FROM laptop LEFT JOIN product ON laptop.model=product.model
GROUP BY maker;

SELECT tabl.name, tabl.numGuns, bore,displacement,type,country,launched,tabl.class
FROM (
	SELECT s.name, numGuns, bore,displacement,type,country,launched, s.class,
		CASE WHEN c.numGuns = 9 THEN 1 ELSE 0 END AS conditional_1,
		CASE WHEN  c.bore= 9  THEN 1 ELSE 0 END AS conditional_2,
		CASE WHEN c.displacement= 46000 THEN 1 ELSE 0 END AS conditional_3,
		CASE WHEN c.type= 'bb' THEN 1 ELSE 0 END AS conditional_4,
		CASE WHEN  c.country= "Japan" THEN 1 ELSE 0 END AS conditional_5,
		CASE WHEN  s.launched = 1916 THEN 1 ELSE 0 END AS conditional_6,
		CASE WHEN s.class = "Revenge" THEN 1 ELSE 0 END AS conditional_7

 FROM ships s INNER JOIN classes c ON s.class = c.class
) tabl
WHERE (conditional_1+conditional_2+conditional_3+conditional_4+conditional_5+conditional_6+conditional_7)>=3;

SELECT class
FROM ships
GROUP BY class
HAVING count(class) = 1
UNION SELECT ship
FROM outcomes
WHERE EXISTS(SELECT * FROM classes WHERE classes.class = outcomes.ship) 
AND NOT EXISTS(SELECT * FROM ships WHERE ships.name = outcomes.ship)
GROUP BY ship
HAVING count(ship) = 1;