CREATE VIEW combined_user_data AS
SELECT
    v.user_id,
    u.user_type,
    u.date_of_registration,
    u.country,
    u.preferences,
    u.recommendation_system,
    v.content_id,
    c.release_date AS content_release_date,
    c.duration AS content_duration,
    c.content_type,
    c.rating AS content_rating,
    v.id AS view_id,
    v.view_date,
    v.duration_viewed,
    r.id AS recommendation_id,
    r.recommended_by,
    r.recommendation_date,
    ui.id AS interaction_id,
    ui.interaction_type,
    ui.interaction_date
FROM
    views v
INNER JOIN users u ON v.user_id = u.id
INNER JOIN content c ON v.content_id = c.id
LEFT JOIN user_interactions ui ON u.id = ui.user_id 
LEFT JOIN recommendations r ON v.user_id = r.user_id AND v.content_id = r.content_id ;



query=""" 
SELECT u.id AS id_usuario,
user_type AS tipo_usuario,
u.recommendation_system AS sistema_usuario,
c.id AS id_contenido,c.duration AS duracion_contenido,
c.content_type AS tipo_contenido,
c.rating AS valoraciones,
v.user_id AS numero_sesion,
v.content_id AS recomendaciones_vistas,
duration_viewed AS minutos_sesion,
v.recommendation_system AS sistema_sesion,
ui.id AS numero_interaccion,
ui.content_id AS id_contenido_interaccion,
ui.interaction_type AS tipo_interaccion,
r.content_id AS recomendaciones_totales,
v.view_date AS fecha_sesion

FROM users u 
INNER JOIN "views" v ON u.id = v.user_id 
INNER JOIN user_interactions ui ON u.id = ui.user_id 
INNER JOIN "content" c ON c.id = v.content_id
INNER JOIN "recommendations" r on r."user_id" = u.id;


/*
views, content, and users are INNER JOINED because every record in the view must have a valid user and content. 
A view with no associated user or content would be meaningless in this context.
user_interactions and recommendations are LEFT JOINED to include all records from views, even if there are no associated interactions or recommendations. 
This ensures that visualizations without these optional relationships are still included in the analysis.
*/