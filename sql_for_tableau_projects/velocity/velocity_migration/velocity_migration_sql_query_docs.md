# Calculating State Migration Patterns

## Overview
This SQL query analyzes household migration patterns by calculating changes in each state's share of total national households between 2009 and 2016.

## Data Transformation Process

### State Population Aggregation
- Sums total households by state for both years
- Calculates absolute change in households
- Excludes DC and Puerto Rico from analysis
- Groups data at state level

### National Share Calculation
- Computes each state's percentage of national total
- Uses window functions for national totals
- Maintains values for both 2009 and 2016
- Calculates percentage point change

### Final Output
- State-level household counts for both years
- Absolute population changes
- Percent of national total for both years
- Percentage point change in national share

## Key Measures
1. Raw Population:
   - Total households by state
   - Absolute change 2009-2016
   - Raw migration numbers

2. National Share:
   - Percent of national total
   - Change in national share
   - Relative state growth/decline

## Implementation Details
- Uses window functions for national totals
- Employs CTEs for clear transformation steps
- Maintains data granularity at state level
- Orders output alphabetically by state

## Usage Notes
- Query assumes source table 'household_income_distribution'
- Output provides both absolute and relative measures
- Positive changes indicate growing share of national total
- Negative changes indicate declining share
