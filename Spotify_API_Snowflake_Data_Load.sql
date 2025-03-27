create database spotify_api;

create schema spotify_api.stage;

//Create Storage Integration to access S3 bucket
create or replace storage integration spotify_s3
type = EXTERNAL_STAGE
STORAGE_PROVIDER = S3
ENABLED = TRUE
STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::148761637566:role/snowflake-s3-spotify-api'
STORAGE_ALLOWED_LOCATIONS = ('s3://spotify-etl-project-swethagopisetty/transformed_data')
COMMENT = 'Creating connection to S3 Spotify API Transformed Data Bucket';


//Create tables to load data
create or replace table spotify_api.stage.album_data(
album_id string,
name string,
release_date string,
total_tracks number,
url string
);

create or replace table spotify_api.stage.artist_data(
artist_id string,
artist_name string,
external_url string
);

create or replace table spotify_api.stage.song_Data(
song_id string,
song_name string,
duration_ms number,
url string,
popularity number,
song_added string,
album_id string,
artist_id string
);

//CSV File Format of Spotify data
create or replace file format spotify_api_format
type = csv
field_delimiter = ','
skip_header = 1;

//Create stages and corresponding pipes for all 3 incoming files - Album,artist and song data

create or replace stage spotify_api.stage.album_data_stage
storage_integration = spotify_s3
url = 's3://spotify-etl-project-swethagopisetty/transformed_data/album_data/'
file_format = spotify_api_format;

list @spotify_api.stage.album_data_stage;

create or replace pipe spotify_api.stage.album_data_snowpipe
auto_ingest = TRUE
AS
COPY into spotify_api.stage.album_data
from @spotify_api.stage.album_data_stage
pattern = '.*csv.*';

create or replace stage spotify_api.stage.artist_data_stage
storage_integration = spotify_s3
url = 's3://spotify-etl-project-swethagopisetty/transformed_data/artist_data/'
file_format = spotify_api_format;

create or replace pipe spotify_api.stage.artist_data_snowpipe
auto_ingest = TRUE
AS
COPY into spotify_api.stage.artist_data
from @spotify_api.stage.artist_data_stage
pattern = '.*csv.*';

create or replace stage spotify_api.stage.song_data_stage
storage_integration = spotify_s3
url = 's3://spotify-etl-project-swethagopisetty/transformed_data/songs_data/'
file_format = spotify_api_format;


create or replace pipe spotify_api.stage.song_data_snowpipe
auto_ingest = TRUE
AS
COPY into spotify_api.stage.song_data
from @spotify_api.stage.song_data_stage
pattern = '.*csv.*';

//Validate data loads
select * from spotify_api.stage.album_data;
select * from spotify_api.stage.artist_data;
select * from spotify_api.stage.song_data;