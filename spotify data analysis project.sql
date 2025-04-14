-- advanced SQL project SPOTIFY data analysis

-- create table
DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);

select * from spotify;

select * from spotify where duration_min = 0;

delete from spotify 
where duration_min = 0;


------------------------------------
/*
EASY LEVEL QUESTIONS 
1.Retrieve the names of all tracks that have more than 1 billion streams.
2.List all albums along with their respective artists.
3.Get the total number of comments for tracks where licensed = TRUE.
4.Find all tracks that belong to the album type single.
5.Count the total number of tracks by each artist.
*/

--Q1. Retrieve the names of all tracks that have more than 1 billion streams.
select track from spotify where stream > 1000000000;

--Q2. List all albums along with their respective artists.
select distinct(album), artist from spotify;

--Q3. Get the total number of comments for tracks where licensed = TRUE.
select sum(comments) from spotify where licensed = 'true';

--Q4. Find all tracks that belong to the album type single.
select track, album_type from spotify where album_type like 'single'

--Q5. Count the total number of tracks by each artist.
select artist, count(track) from spotify
group by artist

/*
INTERMEDIATE LEVEL QUESTIONS
Q.1 Calculate the average danceability of tracks in each album.
Q.2 Find the top 5 tracks with the highest energy values.
Q.3 List all tracks along with their views and likes where official_video = TRUE.
Q.4 For each album, calculate the total views of all associated tracks.
Q.5 Retrieve the track names that have been streamed on Spotify more than YouTube.
*/

-- Q.1 Calculate the average danceability of tracks in each album.
select * from spotify;

select album, avg(danceability) from spotify
group by album
order by 2 desc;

-- Q.2 Find the top 5 tracks with the highest energy values.
select track, max(energy) as highest_energy from spotify
group by track
order by highest_energy desc
limit 5;

--Q.3 List all tracks along with their views and likes where official_video = TRUE.
select track, sum(views) as total_views, sum(likes) as total_likes from spotify where official_video = 'true'
group by track
order by total_views desc;


--Q.4 For each album, calculate the total views of all associated tracks.
select album, track, sum(views) as total_views from spotify
group by album, track
order by total_views desc;


--Q.5 Retrieve the track names that have been streamed on Spotify more than YouTube.
select * from spotify;

select * from
(select track, 
sum((case when most_played_on = 'Spotify' then stream end)) as streamed_on_spotify, 
sum((case when most_played_on = 'Youtube' then stream end)) as streamed_on_Youtube 
from spotify
group by track
) as t1
where streamed_on_spotify > streamed_on_youtube;


/* 
ADVANCED LEVEL QUESTIONS
Q.1 Find the top 3 most-viewed tracks for each artist using window functions.
Q.2 Write a query to find tracks where the liveness score is above the average.
Q.3 Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
Q.4 Find tracks where the energy-to-liveness ratio is greater than 1.2.
Q.5 Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.
*/

--Q.1 Find the top 3 most-viewed tracks for each artist using window functions.
select * from spotify;

with temp_cte as(
select artist, track, views, row_number() over(partition by artist order by views desc) as row_num from spotify
)
select artist, track, views from temp_cte where row_num <= 3


--Q.2 Write a query to find tracks where the liveness score is above the average.
-- there could be 2 answers to this question
select * from spotify;

--answer-1 (not dynamic)
select track, liveness from spotify where liveness > '0.19367208624708632';

-- answer-2 (dynamic) (prefer this one mostly)
select track, liveness from spotify where liveness > (select avg(liveness) from spotify);


-- Q.3 Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
select * from spotify;

with temp_cte as(
select album, min(energy) as min_energy, max(energy) as max_energy from spotify
group by album
)
select album, max_energy - min_energy as total_energy from temp_cte
order by total_energy desc;


--Q.4 Find tracks where the energy-to-liveness ratio is greater than 1.2.
select * from spotify where track like 'Despacito';

select track, energy/liveness as ratio from spotify where energy/liveness > 1.2;


--Q.5 Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.
select * from spotify;

select track, views as num_of_views, sum(likes) as sum_of_likes, dense_rank() over(order by views desc) as rank from spotify
group by track, views;


