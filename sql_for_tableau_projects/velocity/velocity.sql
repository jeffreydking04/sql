-- Regroup the data into less granular bins
-- The strange grouping is because it doubles as group id and for use in the final linear regression
-- We are excluding DC and PR
with assign_group_number as (
    SELECT
        state,
        bracket,
        population_2009,
        population_2016,
        CASE
            when bracket = 'Less than $10,000' then 0
            when bracket = '$10,000 to $14,999' then 0
            when bracket = '$15,000 to $19,999' then 0
            when bracket = '$20,000 to $24,999' then 0
            when bracket = '$25,000 to $29,999' then 0
            when bracket = '$30,000 to $34,999' then 0
            when bracket = '$35,000 to $39,999' then 0.33
            when bracket = '$40,000 to $44,999' then 0.33
            when bracket = '$45,000 to $49,999' then 0.33
            when bracket = '$50,000 to $59,999' then 0.33
            when bracket = '$60,000 to $74,999' then 0.33
            when bracket = '$75,000 to $99,999' then 0.67
            when bracket = '$100,000 to $124,999' then 0.67
            when bracket = '$125,000 to $149,999' then 1
            when bracket = '$150,000 to $199,999' then 1
            when bracket = '$200,000 or more' then 1
        end group_number
    FROM
        household_income_distribution
    WHERE
        state != 'District of Columbia'
        and state != 'Puerto Rico'
),

grouped_summed as (
    SELECT
        state,
        CASE
            when group_number = 0 then '$0 to $34,999'
            when group_number = 1 then '$35,000 to $74,999'
            when group_number = 2 then '$75,000 to $124,999'
            when group_number = 3 then '$125,000 or more'
        end bracket,
        group_number,
        sum(population_2009) pop_2009,
        sum(population_2016) pop_2016
    FROM
        assign_group_number
    group BY
        state,
        group_number
),

-- find the percent of state total population of each bracket
bracket_population_percent_of_total_by_state as (
    SELECT
        state,
        bracket,
        group_number,
        pop_2009,
        pop_2016,
        (pop_2009 / (sum(pop_2009) over (partition by state))) * 100 bracket_percent_of_total_by_state_2009,
        (pop_2016 / (sum(pop_2016) over (partition by state))) * 100 bracket_percent_of_total_by_state_2016
    FROM
        grouped_summed
),

-- take the percentage point difference 2016 less 2009
percentage_point_difference as (
    SELECT
        state,
        bracket,
        group_number,
        bracket_percent_of_total_by_state_2016 - bracket_percent_of_total_by_state_2009 bracket_percent_of_total_by_state_diff
    FROM
        bracket_population_percent_of_total_by_state
),

-- get the slope of the regression line
velocity as (
    SELECT
        state,
        regr_slope(bracket_percent_of_total_by_state_diff, group_number) velocity
    FROM    
        percentage_point_difference
    group by
        state
)

select * from velocity order by state;
