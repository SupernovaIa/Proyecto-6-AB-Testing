query = """
SELECT 
    user_id, 
    user_type, 
    country, 
    recommendation_system, 
    content_id, 
    content_duration, 
    content_type, 
    content_rating, 
    view_id,
    view_date, 
    duration_viewed, 
    recommendation_id, 
    recommended_by, 
    interaction_id, 
    interaction_type
FROM combined_user_data ;
"""