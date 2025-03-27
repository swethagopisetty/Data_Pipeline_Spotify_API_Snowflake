# Spotify Data Pipeline AWS integration into Snowflake

### Introduction

This is an extension of ![Data_Pipeline_AWS_Spotify_API](https://github.com/swethagopisetty/Data_Pipeline_AWS_Spotify_API) project to integrate into Snowflake. In this project we use the existing AWS pipeline and integrate into Snowflake using snowpipe.

### Architecture

![Architecture Diagram](https://github.com/swethagopisetty/Data_Pipeline_Spotify_API_Snowflake/blob/main/Spotify_API_Snowflake_Architecture_Diagram.jpg)

### About Snowflake

Snowflake is a cloud-based data warehousing platform that enables organizations to store,manage and analyze large volumes of data efficiently. It is a Saas offering that operates on AWS,Azure and Google Cloud infrastructure. It is widely used for data analytics and real time data processing.

### About Project

In this projects we use the transformed Spotify API data that is processed by AWS and stored in S3 bucket and load it into Snowflake virtual warehouse tables. Below steps are followed:

  * Snowflake Storage integration helps in establishing a secure connection to S3 through the AWS IAM role.
  * An event is set up in S3 to work with Snowpipe for continuous data ingestion.
  * Snowflake File format and Stage are used to process and load the csv files into the tables.

### Snowflake Concepts Used

```
Storage Integration
Snowpipe
File Format
Stage
Copy command
```

