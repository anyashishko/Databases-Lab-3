USE master;
GO
DROP DATABASE IF EXISTS DreamNet;
GO
CREATE DATABASE DreamNet;
GO
USE DreamNet;
GO



-- 1. ������� �����

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



-- 2. ������� ����
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
(1, '������� � ������', '2025-01-15', '� ����� � ������ ���', '���������'),
(2, '���� ��� �������', '2025-02-02', '� ����� � ������� ����', '���������'),
(3, '������', '2025-02-10', '���-�� ����������� ����', '���������'),
(4, '������� ���', '2025-03-01', '����� ����', '��������'),
(5, '�������', '2025-03-05', '�������� � �����', '����������'),
(6, '��� �� ����', '2025-03-11', '��� ����� �� �����', '���������'),
(7, '�����', '2025-03-15', '��� �����', '���������'),
(8, '�������', '2025-04-01', '������� �� ����������', '���������'),
(9, '������������', '2025-04-10', '������� ������', '���������'),
(10, '����', '2025-04-20', '���������� �� �������', '���������');


-- Symbols
INSERT INTO Symbols VALUES
(1, '����', '�������'),
(2, '����', '��������'),
(3, '��������', '�������'),
(4, '�����', '�������'),
(5, '���', '�������'),
(6, '����', '�������'),
(7, '�����', '�������'),
(8, '�������', '��������'),
(9, '����', '�������'),
(10, '�����', '�����');


-- Characters
INSERT INTO Characters VALUES
(1, '�', '��������'),
(2, '����������� �������', '����������� �������'),
(3, '��������������', '����'),
(4, '�������', '��������'),
(5, '�����', '����'),
(6, '����', '����'),
(7, '����', '��������'),
(8, '����', '����'),
(9, '�����', '��������'),
(10, '����������� ������', '����������� �������');




-- Dream_HAS_Symbol (����� Dream -> Symbol)
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
    '�����'
),
(
    (SELECT $node_id FROM Characters WHERE character_id = 3),
    (SELECT $node_id FROM Dreams WHERE dream_id = 3),
    '�����������'
),
(
    (SELECT $node_id FROM Characters WHERE character_id = 2),
    (SELECT $node_id FROM Dreams WHERE dream_id = 8),
    '�������'
),
(
    (SELECT $node_id FROM Characters WHERE character_id = 4),
    (SELECT $node_id FROM Dreams WHERE dream_id = 5),
    '����'
),
(
    (SELECT $node_id FROM Characters WHERE character_id = 5),
    (SELECT $node_id FROM Dreams WHERE dream_id = 7),
    '������ ���'
),
(
    (SELECT $node_id FROM Characters WHERE character_id = 6),
    (SELECT $node_id FROM Dreams WHERE dream_id = 9),
    '�����'
),
(
    (SELECT $node_id FROM Characters WHERE character_id = 7),
    (SELECT $node_id FROM Dreams WHERE dream_id = 5),
    '��������'
),
(
    (SELECT $node_id FROM Characters WHERE character_id = 8),
    (SELECT $node_id FROM Dreams WHERE dream_id = 4),
    '��������'
),
(
    (SELECT $node_id FROM Characters WHERE character_id = 9),
    (SELECT $node_id FROM Dreams WHERE dream_id = 8),
    '�������'
),
(
    (SELECT $node_id FROM Characters WHERE character_id = 10),
    (SELECT $node_id FROM Dreams WHERE dream_id = 6),
    '��������'
);



-- Symbol_ASSOCIATED_WITH_Symbol
INSERT INTO Symbol_ASSOCIATED_WITH_Symbol
VALUES (
    (SELECT $node_id FROM Symbols WHERE symbol_id = 1),
    (SELECT $node_id FROM Symbols WHERE symbol_id = 4),
    '�����������������'
),
(
    (SELECT $node_id FROM Symbols WHERE symbol_id = 2),
    (SELECT $node_id FROM Symbols WHERE symbol_id = 9),
    '�������������� �����'
),
(
    (SELECT $node_id FROM Symbols WHERE symbol_id = 3),
    (SELECT $node_id FROM Symbols WHERE symbol_id = 6),
    '��������'
),
(
    (SELECT $node_id FROM Symbols WHERE symbol_id = 7),
    (SELECT $node_id FROM Symbols WHERE symbol_id = 5),
    '����������� �����'
),
(
    (SELECT $node_id FROM Symbols WHERE symbol_id = 8),
    (SELECT $node_id FROM Symbols WHERE symbol_id = 9),
    '��������'
),
(
    (SELECT $node_id FROM Symbols WHERE symbol_id = 10),
    (SELECT $node_id FROM Symbols WHERE symbol_id = 5),
    '����� ��������'
),
(
    (SELECT $node_id FROM Symbols WHERE symbol_id = 2),
    (SELECT $node_id FROM Symbols WHERE symbol_id = 8),
    '�������������'
),
(
    (SELECT $node_id FROM Symbols WHERE symbol_id = 1),
    (SELECT $node_id FROM Symbols WHERE symbol_id = 9),
    '��������������� �����'
),
(
    (SELECT $node_id FROM Symbols WHERE symbol_id = 4),
    (SELECT $node_id FROM Symbols WHERE symbol_id = 6),
    '��������������'
),
(
    (SELECT $node_id FROM Symbols WHERE symbol_id = 3),
    (SELECT $node_id FROM Symbols WHERE symbol_id = 7),
    '�������������� ����'
);



-- MATCH
--1. ����� ��� ���, � ������� ����������� ������ "����"
SELECT d.title, s.name AS symbol_name, dhs.intensity
FROM Dreams d, Dream_HAS_Symbol dhs, Symbols s
WHERE MATCH(d - (dhs) -> s)
  AND s.name = '����';

--2. ����� ���� ����������, ������� ���������� � "���������" ����
SELECT c.name, d.title AS dream_title, d.mood
FROM Characters c, Character_APPEARS_IN_Dream cad, Dreams d
WHERE MATCH(c - (cad) -> d)
  AND d.mood = '���������';

--3. ����� ���� ��������, ��������� "�������������� ������"
SELECT s1.name AS symbol_from, s2.name AS symbol_to, sas.association_type
FROM Symbols s1, Symbol_ASSOCIATED_WITH_Symbol sas, Symbols s2
WHERE MATCH(s1 - (sas) -> s2)
  AND sas.association_type = '�������������� �����';

--4. �����, ����� ��������� "��������" �� ���
SELECT c.name, d.title, cad.interaction
FROM Characters c, Character_APPEARS_IN_Dream cad, Dreams d
WHERE MATCH(c - (cad) -> d)
  AND cad.interaction = '�������';

-- 5. ����� ���, � ������� ��������� ������, ��������� � "����" (����� ������������� �����)
SELECT DISTINCT d.title AS dream_title
FROM Dreams d, Dream_HAS_Symbol dhs, Symbols s1, Symbol_ASSOCIATED_WITH_Symbol sas, Symbols s2
WHERE MATCH(d - (dhs) -> s1 - (sas) -> s2)
  AND s2.name = '����'
UNION
SELECT DISTINCT d.title AS dream_title
FROM Dreams d, Dream_HAS_Symbol dhs, Symbols s1, Symbol_ASSOCIATED_WITH_Symbol sas, Symbols s2
WHERE MATCH(d - (dhs) -> s1 <- (sas) - s2)
  AND s2.name = '����';



--SHORTEST_PATH
--1. ���������� ���� �� ������� "���" �� "��������"
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
    AND s1.name = '��������'
)
SELECT 
    StartSymbol, 
    EndSymbol, 
    AssociationPath,
    PathLength
FROM WaterToFirePaths
WHERE EndSymbol = '���'
ORDER BY PathLength;

-- 2. ���������� ���� �� ������� "����" �� "����"
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
    AND s1.name = N'����'
)
SELECT StartSymbol, EndSymbol, SymbolPath, PathLength
FROM SymbolPaths
WHERE EndSymbol = N'����'
ORDER BY PathLength;














	SELECT @@SERVERNAME


