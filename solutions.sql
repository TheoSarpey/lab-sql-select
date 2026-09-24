-- ============================================================
-- LAB: SQL SELECT
-- Database: publications.sqlite
-- ============================================================


-- ============================================================
-- CHALLENGE 1
-- Who Have Published What At Where?
--
-- Show:
--   AUTHOR ID
--   LAST NAME
--   FIRST NAME
--   TITLE
--   PUBLISHER
--
-- The result should contain the same number of rows as
-- the titleauthor table.
-- ============================================================

SELECT
    a.au_id AS "AUTHOR ID",
    a.au_lname AS "LAST NAME",
    a.au_fname AS "FIRST NAME",
    t.title AS "TITLE",
    p.pub_name AS "PUBLISHER"
FROM titleauthor AS ta
JOIN authors AS a
    ON ta.au_id = a.au_id
JOIN titles AS t
    ON ta.title_id = t.title_id
JOIN publishers AS p
    ON t.pub_id = p.pub_id
ORDER BY
    a.au_lname,
    a.au_fname,
    t.title;


-- ============================================================
-- CHALLENGE 2
-- Who Have Published How Many At Where?
--
-- Count how many titles each author has published
-- at each publisher.
--
-- The sum of TITLE COUNT should equal the number of
-- records in titleauthor.
-- ============================================================

SELECT
    a.au_id AS "AUTHOR ID",
    a.au_lname AS "LAST NAME",
    a.au_fname AS "FIRST NAME",
    p.pub_name AS "PUBLISHER",
    COUNT(*) AS "TITLE COUNT"
FROM titleauthor AS ta
JOIN authors AS a
    ON ta.au_id = a.au_id
JOIN titles AS t
    ON ta.title_id = t.title_id
JOIN publishers AS p
    ON t.pub_id = p.pub_id
GROUP BY
    a.au_id,
    a.au_lname,
    a.au_fname,
    p.pub_id,
    p.pub_name
ORDER BY
    a.au_lname,
    a.au_fname,
    p.pub_name;


-- ============================================================
-- CHALLENGE 3
-- Best Selling Authors
--
-- Find the top 3 authors based on the total quantity of
-- titles sold.
--
-- TOTAL = SUM of sales.qty
-- ============================================================

SELECT
    a.au_id AS "AUTHOR ID",
    a.au_lname AS "LAST NAME",
    a.au_fname AS "FIRST NAME",
    SUM(s.qty) AS "TOTAL"
FROM authors AS a
JOIN titleauthor AS ta
    ON a.au_id = ta.au_id
JOIN sales AS s
    ON ta.title_id = s.title_id
GROUP BY
    a.au_id,
    a.au_lname,
    a.au_fname
ORDER BY
    TOTAL DESC
LIMIT 3;


-- ============================================================
-- CHALLENGE 4
-- Best Selling Authors Ranking
--
-- Display ALL authors, including authors who have sold
-- zero titles.
--
-- COALESCE converts NULL totals into 0.
-- LEFT JOIN ensures that authors without sales are retained.
-- ============================================================

SELECT
    a.au_id AS "AUTHOR ID",
    a.au_lname AS "LAST NAME",
    a.au_fname AS "FIRST NAME",
    COALESCE(SUM(s.qty), 0) AS "TOTAL"
FROM authors AS a
LEFT JOIN titleauthor AS ta
    ON a.au_id = ta.au_id
LEFT JOIN sales AS s
    ON ta.title_id = s.title_id
GROUP BY
    a.au_id,
    a.au_lname,
    a.au_fname
ORDER BY
    TOTAL DESC,
    a.au_lname,
    a.au_fname;
