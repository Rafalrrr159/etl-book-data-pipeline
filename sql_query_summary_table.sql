USE Task1DB;
GO

DROP TABLE IF EXISTS SummaryTable;
GO

SELECT
    [year] AS publication_year,
    COUNT(*) AS book_count,
    ROUND(AVG(
        CASE
            WHEN price LIKE '%€%' THEN CAST(REPLACE(price, '€', '') AS FLOAT) * 1.2
            WHEN price LIKE '%$%' THEN CAST(REPLACE(price, '$', '') AS FLOAT)
            ELSE 0
        END
    ), 2) AS average_price_usd
INTO SummaryTable
FROM RawBooks
GROUP BY [year];
GO

SELECT * FROM SummaryTable ORDER BY publication_year DESC;