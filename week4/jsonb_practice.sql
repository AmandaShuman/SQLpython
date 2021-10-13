-- format the stuff that has jsonb formatting
-- so it is easy to read with key/value pairs

SELECT jsonb_pretty(info) AS formatted_info
FROM moma_artists LIMIT 50;


-- parse-display only the display_name and nationality
SELECT 
info -> 'display_name' AS name,
info -> 'nationality' AS naionality
FROM moma_artists 
ORDER BY id
LIMIT 50;

-- getting American artists only in jsonb
SELECT 
info -> 'display_name' AS name,
info -> 'nationality' AS naionality
FROM moma_artists 
WHERE info ->> 'nationality' = 'American'
ORDER BY id
LIMIT 50;

-- how to insert JSON values 3 different ways 
-- only perform 1!
INSERT INTO moma_artists (info) VALUES (
    json_object('{display_name, Ablade Glover, nationality, Ghanaian}')
);

INSERT INTO moma_artists (info) VALUES (
    json_object('{{display_name, Ablade Glover}, {nationality, Ghanaian}}')
);

INSERT INTO moma_artists (info) VALUES (
    json_object('{display_name, nationality}', '{Ablade Glover, Ghanaian}')
);