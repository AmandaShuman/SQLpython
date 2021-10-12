/* 
WITH statement finds the frame width and height
This is used in the select statement
to then calculate the frame_area
finally,
GROUP BY to perform a count on the aggregation of
rows, grouped by all the columns
*/


WITH frames AS (
	SELECT
	CEIL(width) + 2 AS frame_width,
	CEIL(height) +4 AS frame_height
	FROM moma_works 
	WHERE classification = 'Photograph' AND height >0 AND width >0
)
SELECT
frame_width,
frame_height,
frame_width * frame_height AS frame_area
FROM frames
GROUP BY frame_width, frame_height, frame_area;