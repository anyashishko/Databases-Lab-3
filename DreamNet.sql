USE master;
GO
DROP DATABASE IF EXISTS DreamNet;
GO
CREATE DATABASE DreamNet;
GO
USE DreamNet;
GO



-- 1. Таблицы узлов

CREATE TABLE Dreams (
    dream_id INT PRIMARY KEY,
    title NVARCHAR(100),
    date DATE,
    description NVARCHAR(255),
    mood NVARCHAR(50)
) AS NODE;

CREATE TABLE Symbols (
    symbol_id INT PRIMARY KEY,
    name NVARCHAR(100),
    type NVARCHAR(50)
) AS NODE;

CREATE TABLE Characters (
    character_id INT PRIMARY KEY,
    name NVARCHAR(100),
    role NVARCHAR(50)
) AS NODE;



-- 2. Таблицы рёбер
CREATE TABLE Dream_HAS_Symbol (
    intensity FLOAT
) AS EDGE;

CREATE TABLE Character_APPEARS_IN_Dream (
    interaction NVARCHAR(100)
) AS EDGE;

CREATE TABLE Symbol_ASSOCIATED_WITH_Symbol (
    association_type NVARCHAR(100)
) AS EDGE;




-- Dreams
INSERT INTO Dreams VALUES
(1, 'Падение в бездну', '2025-01-15', 'Я падал в темную яму', 'тревожный'),
(2, 'Полёт над городом', '2025-02-02', 'Я летал и смотрел вниз', 'радостный'),
(3, 'Погоня', '2025-02-10', 'Кто-то преследовал меня', 'тревожный'),
(4, 'Змеиная яма', '2025-03-01', 'Полно змей', 'страшный'),
(5, 'Детство', '2025-03-05', 'Вернулся в школу', 'ностальгия'),
(6, 'Дом на воде', '2025-03-11', 'Дом стоит на озере', 'спокойный'),
(7, 'Пожар', '2025-03-15', 'Дом горит', 'тревожный'),
(8, 'Свадьба', '2025-04-01', 'Женился на незнакомке', 'радостный'),
(9, 'Исчезновение', '2025-04-10', 'Пропали друзья', 'тревожный'),
(10, 'Горы', '2025-04-20', 'Поднимался на вершину', 'спокойный');


-- Symbols
INSERT INTO Symbols VALUES
(1, 'вода', 'архетип'),
(2, 'змея', 'животное'),
(3, 'лестница', 'предмет'),
(4, 'огонь', 'архетип'),
(5, 'дом', 'предмет'),
(6, 'мост', 'архетип'),
(7, 'дверь', 'предмет'),
(8, 'летание', 'действие'),
(9, 'тьма', 'архетип'),
(10, 'школа', 'место');


-- Characters
INSERT INTO Characters VALUES
(1, 'Я', 'сновидец'),
(2, 'Неизвестная женщина', 'неизвестный человек'),
(3, 'Преследователь', 'враг'),
(4, 'Учитель', 'помощник'),
(5, 'Огонь', 'враг'),
(6, 'Друг', 'друг'),
(7, 'Мать', 'помощник'),
(8, 'Змея', 'враг'),
(9, 'Жених', 'сновидец'),
(10, 'Неизвестный ребёнок', 'неизвестный человек');




-- Dream_HAS_Symbol (связь Dream -> Symbol)
INSERT INTO Dream_HAS_Symbol
VALUES (
    (SELECT $node_id FROM Dreams WHERE dream_id = 1),
    (SELECT $node_id FROM Symbols WHERE symbol_id = 9),
    0.9
),
(
    (SELECT $node_id FROM Dreams WHERE dream_id = 2),
    (SELECT $node_id FROM Symbols WHERE symbol_id = 8),
    0.7
),
(
    (SELECT $node_id FROM Dreams WHERE dream_id = 3),
    (SELECT $node_id FROM Symbols WHERE symbol_id = 9),
    0.6
),
(
    (SELECT $node_id FROM Dreams WHERE dream_id = 4),
    (SELECT $node_id FROM Symbols WHERE symbol_id = 2),
    1.0
),
(
    (SELECT $node_id FROM Dreams WHERE dream_id = 5),
    (SELECT $node_id FROM Symbols WHERE symbol_id = 10),
    0.5
),
(
    (SELECT $node_id FROM Dreams WHERE dream_id = 6),
    (SELECT $node_id FROM Symbols WHERE symbol_id = 1),
    0.8
),
(
    (SELECT $node_id FROM Dreams WHERE dream_id = 7),
    (SELECT $node_id FROM Symbols WHERE symbol_id = 4),
    0.95
),
(
    (SELECT $node_id FROM Dreams WHERE dream_id = 8),
    (SELECT $node_id FROM Symbols WHERE symbol_id = 5),
    0.4
),
(
    (SELECT $node_id FROM Dreams WHERE dream_id = 9),
    (SELECT $node_id FROM Symbols WHERE symbol_id = 9),
    0.9
),
(
    (SELECT $node_id FROM Dreams WHERE dream_id = 10),
    (SELECT $node_id FROM Symbols WHERE symbol_id = 6),
    0.6
);



-- Character_APPEARS_IN_Dream
INSERT INTO Character_APPEARS_IN_Dream
VALUES (
    (SELECT $node_id FROM Characters WHERE character_id = 1),
    (SELECT $node_id FROM Dreams WHERE dream_id = 1),
    'падал'
),
(
    (SELECT $node_id FROM Characters WHERE character_id = 3),
    (SELECT $node_id FROM Dreams WHERE dream_id = 3),
    'преследовал'
),
(
    (SELECT $node_id FROM Characters WHERE character_id = 2),
    (SELECT $node_id FROM Dreams WHERE dream_id = 8),
    'женился'
),
(
    (SELECT $node_id FROM Characters WHERE character_id = 4),
    (SELECT $node_id FROM Dreams WHERE dream_id = 5),
    'учил'
),
(
    (SELECT $node_id FROM Characters WHERE character_id = 5),
    (SELECT $node_id FROM Dreams WHERE dream_id = 7),
    'сжигал дом'
),
(
    (SELECT $node_id FROM Characters WHERE character_id = 6),
    (SELECT $node_id FROM Dreams WHERE dream_id = 9),
    'исчез'
),
(
    (SELECT $node_id FROM Characters WHERE character_id = 7),
    (SELECT $node_id FROM Dreams WHERE dream_id = 5),
    'помогала'
),
(
    (SELECT $node_id FROM Characters WHERE character_id = 8),
    (SELECT $node_id FROM Dreams WHERE dream_id = 4),
    'угрожала'
),
(
    (SELECT $node_id FROM Characters WHERE character_id = 9),
    (SELECT $node_id FROM Dreams WHERE dream_id = 8),
    'женился'
),
(
    (SELECT $node_id FROM Characters WHERE character_id = 10),
    (SELECT $node_id FROM Dreams WHERE dream_id = 6),
    'наблюдал'
);



-- Symbol_ASSOCIATED_WITH_Symbol
INSERT INTO Symbol_ASSOCIATED_WITH_Symbol
VALUES (
    (SELECT $node_id FROM Symbols WHERE symbol_id = 1),
    (SELECT $node_id FROM Symbols WHERE symbol_id = 4),
    'противоположность'
),
(
    (SELECT $node_id FROM Symbols WHERE symbol_id = 2),
    (SELECT $node_id FROM Symbols WHERE symbol_id = 9),
    'архетипическая связь'
),
(
    (SELECT $node_id FROM Symbols WHERE symbol_id = 3),
    (SELECT $node_id FROM Symbols WHERE symbol_id = 6),
    'метафора'
),
(
    (SELECT $node_id FROM Symbols WHERE symbol_id = 7),
    (SELECT $node_id FROM Symbols WHERE symbol_id = 5),
    'структурная связь'
),
(
    (SELECT $node_id FROM Symbols WHERE symbol_id = 8),
    (SELECT $node_id FROM Symbols WHERE symbol_id = 9),
    'контраст'
),
(
    (SELECT $node_id FROM Symbols WHERE symbol_id = 10),
    (SELECT $node_id FROM Symbols WHERE symbol_id = 5),
    'место действия'
),
(
    (SELECT $node_id FROM Symbols WHERE symbol_id = 2),
    (SELECT $node_id FROM Symbols WHERE symbol_id = 8),
    'трансформация'
),
(
    (SELECT $node_id FROM Symbols WHERE symbol_id = 1),
    (SELECT $node_id FROM Symbols WHERE symbol_id = 9),
    'психологическая связь'
),
(
    (SELECT $node_id FROM Symbols WHERE symbol_id = 4),
    (SELECT $node_id FROM Symbols WHERE symbol_id = 6),
    'противостояние'
),
(
    (SELECT $node_id FROM Symbols WHERE symbol_id = 3),
    (SELECT $node_id FROM Symbols WHERE symbol_id = 7),
    'функциональная пара'
);



-- MATCH
--1. Найти все сны, в которых встречается символ "змея"
SELECT d.title, s.name AS symbol_name, dhs.intensity
FROM Dreams d, Dream_HAS_Symbol dhs, Symbols s
WHERE MATCH(d - (dhs) -> s)
  AND s.name = 'змея';

--2. Найти всех персонажей, которые появлялись в "тревожных" снах
SELECT c.name, d.title AS dream_title, d.mood
FROM Characters c, Character_APPEARS_IN_Dream cad, Dreams d
WHERE MATCH(c - (cad) -> d)
  AND d.mood = 'тревожный';

--3. Найти пары символов, связанных "архетипической связью"
SELECT s1.name AS symbol_from, s2.name AS symbol_to, sas.association_type
FROM Symbols s1, Symbol_ASSOCIATED_WITH_Symbol sas, Symbols s2
WHERE MATCH(s1 - (sas) -> s2)
  AND sas.association_type = 'архетипическая связь';

--4. Найти, какие персонажи "женились" во сне
SELECT c.name, d.title, cad.interaction
FROM Characters c, Character_APPEARS_IN_Dream cad, Dreams d
WHERE MATCH(c - (cad) -> d)
  AND cad.interaction = 'женился';

-- 5. Найти сны, в которых появлялся символ, связанный с "вода" (через символическую связь)
SELECT DISTINCT d.title AS dream_title
FROM Dreams d, Dream_HAS_Symbol dhs, Symbols s1, Symbol_ASSOCIATED_WITH_Symbol sas, Symbols s2
WHERE MATCH(d - (dhs) -> s1 - (sas) -> s2)
  AND s2.name = 'вода'
UNION
SELECT DISTINCT d.title AS dream_title
FROM Dreams d, Dream_HAS_Symbol dhs, Symbols s1, Symbol_ASSOCIATED_WITH_Symbol sas, Symbols s2
WHERE MATCH(d - (dhs) -> s1 <- (sas) - s2)
  AND s2.name = 'вода';



--SHORTEST_PATH
--1. Кратчайший путь от символа "дом" до "лестница"
WITH WaterToFirePaths AS (
    SELECT 
        s1.name AS StartSymbol,
        LAST_VALUE(related.name) WITHIN GROUP (GRAPH PATH) AS EndSymbol,
        STRING_AGG(related.name, ' -> ') WITHIN GROUP (GRAPH PATH) AS AssociationPath,
        COUNT(related.name) WITHIN GROUP (GRAPH PATH) AS PathLength
    FROM 
        Symbols AS s1,
        Symbol_ASSOCIATED_WITH_Symbol FOR PATH AS sas,
        Symbols FOR PATH AS related
    WHERE MATCH(SHORTEST_PATH(s1(-(sas)->related){1,10}))
    AND s1.name = 'лестница'
)
SELECT 
    StartSymbol, 
    EndSymbol, 
    AssociationPath,
    PathLength
FROM WaterToFirePaths
WHERE EndSymbol = 'дом'
ORDER BY PathLength;

-- 2. Кратчайший путь от символа "вода" до "мост"
WITH SymbolPaths AS (
    SELECT 
        s1.name AS StartSymbol,
        LAST_VALUE(s2.name) WITHIN GROUP (GRAPH PATH) AS EndSymbol,
        STRING_AGG(s2.name, '->') WITHIN GROUP (GRAPH PATH) AS SymbolPath,
        COUNT(s2.name) WITHIN GROUP (GRAPH PATH) AS PathLength
    FROM 
        Symbols AS s1,
        Symbol_ASSOCIATED_WITH_Symbol FOR PATH AS sas,
        Symbols FOR PATH AS s2
    WHERE MATCH(SHORTEST_PATH(s1(-(sas)->s2)+))
    AND s1.name = N'вода'
)
SELECT StartSymbol, EndSymbol, SymbolPath, PathLength
FROM SymbolPaths
WHERE EndSymbol = N'мост'
ORDER BY PathLength;














	SELECT @@SERVERNAME


