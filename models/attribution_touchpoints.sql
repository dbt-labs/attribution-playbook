with touchpoints as (
    select * from {{ ref('user_touchpoints') }}
),

conversion as (
    select * from {{ ref('user_conversion') }}
),

touchpoints_before_conversion as (

    select
        *,

        count(*) over (
            partition by user_id
        ) as total_sessions,

        row_number() over (
            partition by user_id
            order by touchpoints.session_date
        ) as session_number
    
    from touchpoints
    
    left join conversion using (user_id) 

    where touchpoints.session_date <= conversion.converted_date
)

select
*
from touchpoints_before_conversion
