## Spotify-data-analysis and query optimization project
Project Category: Advanced
[Click Here to get Dataset](https://www.kaggle.com/datasets/sanjanchaudhari/spotify-dataset)


In this project, I’ll be working with a Spotify dataset that includes all sorts of details about tracks, albums, and artists. Using SQL, I’ll take the data from its original, denormalized form and organize it into a more structured, normalized format. From there, I’ll write SQL queries that range from simple to quite advanced, and I’ll also look for ways to make those queries run more efficiently. The main aim is to sharpen my SQL skills while uncovering interesting and useful insights from the Spotify data.

## Technologies I Used
- SQL (PostgreSQL)
- PGAdmin 4 for database management
- CSV data manipulation

## What I Did in This Project
I took a dataset of Spotify's top streamed tracks and used SQL to uncover insights about:
Which artists and songs dominate the streaming charts
How audio features like tempo and energy affect popularity
Which songs appear most frequently in playlists
How streaming numbers compare across different platforms


## About the Data
I worked with a Spotify dataset from Kaggle that contains:
Artist names and track titles, Release years, Stream counts, Playlist appearances. Audio features (tempo, energy, acousticness, etc.)


## My Setup Process
I created a PostgreSQL database to house the data, Built a table structure matching the dataset columns, Imported the CSV data using PGAdmin, Wrote SQL queries to analyze different aspects of the data


### Querying the Data
After the data is inserted, various SQL queries can be written to explore and analyze the data. Queries are categorized into **easy**, **medium**, and **advanced** levels to help progressively develop SQL proficiency.

#### Easy Queries
- Simple data retrieval, filtering, and basic aggregations.
  
#### Medium Queries
- More complex queries involving grouping, aggregation functions, and joins.
  
#### Advanced Queries
- Nested subqueries, window functions, CTEs, and performance optimization.


## Practice Questions 
### Easy Level
1. Retrieve the names of all tracks that have more than 1 billion streams.
2. List all albums along with their respective artists.
3. Get the total number of comments for tracks where licensed = TRUE.
4. Find all tracks that belong to the album type single.
5. Count the total number of tracks by each artist.

### Medium Level
1. Calculate the average danceability of tracks in each album.
2. Find the top 5 tracks with the highest energy values.
3. List all tracks along with their views and likes where official_video = TRUE.
4. For each album, calculate the total views of all associated tracks.
5. Retrieve the track names that have been streamed on Spotify more than YouTube.

### Advanced Level
1. Find the top 3 most-viewed tracks for each artist using window functions.
2. Write a query to find tracks where the liveness score is above the average.
3. Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album
5. Find tracks where the energy-to-liveness ratio is greater than 1.2.
6. Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.


## Analysis I Performed 
### Throughout this project, I explored:-
- Artist Peformance: Identified which artists have the most streams and tracks,
- Release Patterns: Analyzed how song releases have changed over time,
- Playlist Impact: Examined which songs appear in the most playlists,
- Audio Feature Analysis: Investigated relationships between song characteristics and popularity,
- Cross-Platform Comparison: Compared streaming numbers across different services.


## Query Optimization
### In advanced stages, the focus shifts to improving query performance. Some optimization strategies which I incorporated include:
Indexing: Adding indexes on frequently queried columns.
Query Execution Plan: Using EXPLAIN ANALYZE to review and refine query performance.


## Query Optimization Technique 

To improve query performance, we carried out the following optimization process:

- **Initial Query Performance Analysis Using `EXPLAIN`**
    - We began by analyzing the performance of a query using the `EXPLAIN` function.
    - The query retrieved tracks based on the `artist` column, and the performance metrics were as follows:
        - Execution time (E.T.): **4 ms**
        - Planning time (P.T.): **0.056 ms**
    - Below is the **screenshot** of the `EXPLAIN` result before optimization:
      ![EXPLAIN Before Index](https://github.com/thesmartlad/Spotify-data-analysis/blob/main/before%20query%20optimization.png)

- **Index Creation on the `artist` Column**
    - To optimize the query performance, we created an index on the `artist` column. This ensures faster retrieval of rows where the artist is queried.
    - **SQL command** for creating the index:
      ```sql
      CREATE INDEX artist_index ON spotify_tracks(artist);
      ```

- **Performance Analysis After Index Creation**
    - After creating the index, we ran the same query again and observed significant improvements in performance:
        - Execution time (E.T.): **0.090 ms**
        - Planning time (P.T.): **0.917 ms**
    - Below is the **screenshot** of the `EXPLAIN` query's explaination and it's result after index creation:
      ![Performance Graph](https://github.com/thesmartlad/Spotify-data-analysis/blob/main/after%20query%20optimization%20(analysis).png)
      ![EXPLAIN After Index](https://github.com/thesmartlad/Spotify-data-analysis/blob/main/after%20query%20optimization.png)

- **Graphical Performance Comparison**
    - Diagrams illustrating the comparison between initial query execution time and optimized query execution time after index creation
      ![Performance Graph](https://github.com/thesmartlad/Spotify-data-analysis/blob/main/before%20query%20optimization%20(graphical).png)
      ![Performance Graph](https://github.com/thesmartlad/Spotify-data-analysis/blob/main/after%20query%20optimization%20(graphical).png)


This optimization shows how indexing can drastically reduce query time, improving the overall performance of our database operations in the Spotify project.
---
