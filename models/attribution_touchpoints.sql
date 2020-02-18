with sessions as (
    select * from {{ ref('sessions') }}
),

conversion as (
    select * from {{ ref('user_conversion') }}
),

sessions_before_conversion as (

    select
        *,

        count(*) over (
            partition by user_id
        ) as total_sessions, -- total sessions before conversion?

        row_number() over (
            partition by user_id
            order by sessions.started_at
        ) as session_number

    from sessions

    left join conversion using (user_id)

    where sessions.started_at <= conversion.converted_at

),

with_points as (
    select
        *,
        case
            when total_sessions = 1 then 1.0
            when total_sessions = 2 then 0.5
            when session_number = 1 then 0.4
            when session_number = total_sessions then 0.4
            else 0.2 / (total_sessions - 2)
        end as forty_twenty_forty_attribution_points,

        case
            when session_number = 1 then 1.0
            else 0.0
        end as first_touch_attribution_points,

        case
            when session_number = total_sessions then 1.0
            else 0.0
        end as last_touch_attribution_points,

        1.0 / total_sessions as linear_attribution_points,

        revenue * forty_twenty_forty_attribution_points as forty_twenty_forty_attribution_revenue,
        revenue * first_touch_attribution_points as first_touch_attribution_revenue,
        revenue * last_touch_attribution_points as last_touch_attribution_revenue,
        revenue * linear_attribution_points as linear_attribution_revenue


    from sessions_before_conversion
)

select * from with_points
