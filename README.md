# Dish Search Service

Simple Node + MySQL backend that returns the top 10 restaurants where a searched dish has been ordered the most — restricted by a required price range.

## Features
- Search by dish name (partial, case-insensitive)
- Mandatory `minPrice` and `maxPrice` filters
- Returns restaurant details, dish name, dish price, and total order count for that dish in that restaurant
- Top 10 restaurants sorted by order count

## API
### GET /search/dishes
Query parameters (all required):
- `name` (string): dish name (partial match)
- `minPrice` (number)
- `maxPrice` (number)

Example:
