-- etldoc: layer_skiing[shape=record fillcolor=lightpink, style="rounded,filled",
-- etldoc:     label="layer_skiing |<z12> z12|<z13> z13|<z14_> z14+" ];

CREATE OR REPLACE FUNCTION layer_skiing(bbox geometry, zoom_level int)
RETURNS TABLE(geometry geometry, class text, name text, occupancy int, capacity int, duration int) AS $$
    SELECT geometry, aerialway AS class, name, occupancy, capacity, duration FROM (
        -- etldoc:  osm_skiing_aerial_linestring -> layer_skiing:z10_
        SELECT geometry, aerialway, name, occupancy, capacity, duration
        FROM osm_skiing_aerial_linestring WHERE zoom_level >= 10
    ) AS zoom_levels
    WHERE geometry && bbox;
$$ LANGUAGE SQL IMMUTABLE;
