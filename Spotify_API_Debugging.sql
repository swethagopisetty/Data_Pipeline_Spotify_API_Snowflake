desc pipe spotify_api.stage.album_data_snowpipe;

//View Stage files
list @spotify_api.stage.artist_data_stage;

//Test Copy Statement
COPY into spotify_api.stage.album_data
from @spotify_api.stage.album_data_stage
pattern = '.*csv.*';

//Check Pipe Status
select system$pipe_status('spotify_api.stage.artist_data_snowpipe');

select system$pipe_status('spotify_api.stage.album_data_snowpipe');

//To view copy history of both batch load and snowpipe load
select * from snowflake.account_usage.copy_history where table_name = 'SONG_DATA';

//If the Pipe status is not running or status is STOPPED_STAGE_DROPPED due to a DDL operation then pause and recreate the pipe 
ALTER PIPE spotify_api.stage.song_data_snowpipe SET PIPE_EXECUTION_PAUSED=true;

//Validate pipe is running
desc pipe spotify_api.stage.artist_data_snowpipe;

//Loadfiles that are available before pipe ceration or ones that are loaded when pipe is not running
alter pipe spotify_api.stage.song_data_snowpipe refresh;



alter pipe spotify_api.stage.song_data_snowpipe set PIPE_EXECUTION_PAUSED = false;

select SYSTEM$PIPE_FORCE_RESUME('spotify_api.stage.song_data_snowpipe');