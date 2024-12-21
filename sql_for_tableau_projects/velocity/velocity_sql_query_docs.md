# Calculating Income Distribution Velocity

## Overview
This SQL query calculates a "velocity" metric for changes in household income distribution across states from 2009 to 2016. The velocity represents both direction and magnitude of change in income bracket populations over time.

## Data Transformation Process

### Initial Grouping and Classification
- Consolidates 16 original income brackets into 4 main groups
- Uses numerical values (0, 0.33, 0.67, 1) that serve multiple purposes:
  - Group identification
  - X-coordinates for regression calculation
- Excludes DC and Puerto Rico from analysis

### Population Aggregation
- Sums household populations within new grouped brackets
- Creates readable bracket labels
- Maintains both 2009 and 2016 populations

### Distribution Calculation
- Calculates each bracket's percentage of state total population
- Uses window functions to partition by state
- Maintains separate calculations for 2009 and 2016

### Change Measurement
- Computes percentage point changes between 2009 and 2016
- Preserves group numbers for regression calculation
- Maintains state-level granularity

### Velocity Calculation
- Uses linear regression to calculate velocity
- Slope represents both direction and magnitude of change
- Grouped by state to get single velocity measure per state

## Key Design Choices
1. Group numbering system (0, 0.33, 0.67, 1):
   - Creates evenly spaced x-coordinates for regression
   - Provides input values for regression calculation

2. Window functions for percentage calculations:
   - Maintains state-level context
   - Allows efficient population proportions calculation
   - Preserves data granularity

3. Linear regression for velocity:
   - Captures both direction and magnitude
   - Provides single comparative metric
   - Allows state-by-state comparison

## Usage Notes
- Query assumes source table 'household_income_distribution' with columns:
  - state (varchar)
  - bracket (varchar)
  - population_2009 (numeric)
  - population_2016 (numeric)
- Output provides velocity measure by state
- Positive velocity indicates movement toward higher income brackets
- Magnitude indicates speed of distribution change

## Implementation Details
- Uses PostgreSQL's REGR_SLOPE function for regression calculation
- Employs CTEs for clear transformation steps
- Maintains data integrity through explicit grouping
