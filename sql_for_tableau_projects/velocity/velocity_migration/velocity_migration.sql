-- We are looking for household percent of total state to national changed
-- from 2009 to 2016, filtering out DC and PR at the start
with population_sums_by_state as (
    SELECT
        state
        ,sum(population_2009) p_09
        ,sum(population_2016) p_16
        ,sum(population_2016) - sum(population_2009) p_diff
    FROM
        household_income_distribution
    WHERE
        state != 'District of Columbia'
        and state != 'Puerto Rico'
    GROUP BY
        state
)

,state_population_percent_of_national_total as (
    SELECT
        state
        ,p_09
        ,p_16
        ,p_diff
        ,p_09 / (
                sum(p_09) over ()
            ) * 100 state_population_percent_of_national_total_09
        ,p_16/ (
                sum(p_16) over ()
            ) * 100 state_population_percent_of_national_total_16
    FROM
        population_sums_by_state
)

select 
    state
    ,p_09 population_2009
    ,p_16 population_2016
    ,p_diff population_difference
    ,state_population_percent_of_national_total_09
    ,state_population_percent_of_national_total_16
    ,state_population_percent_of_national_total_16 -
        state_population_percent_of_national_total_09 percentage_point_diff
from 
    state_population_percent_of_national_total 
order by state;
