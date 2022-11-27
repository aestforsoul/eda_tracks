# importing and wrangling data
library(readr)
library(tidyr)
library(dplyr)

# EDA
library(skimr)

# for plotting
library(ggplot2)
library(Hmisc)

# read data
spotify_songs <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-01-21/spotify_songs.csv')

# check missing values
colSums(is.na(spotify_songs))
# 5 missing values: track_artist, track_album_name

# check duplicates
sum(duplicated(spotify_songs$track_id))
songs_duplicates <- spotify_songs[duplicated(spotify_songs$track_id),] 
# duplicates exist because same songs are in different playlists

# remove duplicates
clean_data <- spotify_songs %>% 
  distinct(track_id,
           .keep_all = TRUE) 

# data structure
glimpse(spotify_songs)
skim(spotify_songs)

summary(spotify_songs)

# define playlist genre
unique(spotify_songs$playlist_genre)

ggplot(data = spotify_songs) + 
  geom_bar(mapping = aes(x = playlist_genre))
spotify_songs %>% count(playlist_genre)

# display mean of track_popularity by playlist_genre
ggplot(data = spotify_songs, aes(x = playlist_genre, 
                          y = track_popularity)) + 
  stat_summary(fun.data = mean_sdl, geom = "bar")

# display mean of speechiness by playlist_genre
ggplot(data = spotify_songs, mapping = aes(x = playlist_genre, 
                                           y = speechiness)) + 
  stat_summary(fun.data = mean_sdl, geom = "bar")

# display distribution of duration in milliseconds
ggplot(data = spotify_songs) +
  geom_histogram(aes(x = duration_ms))

# display distribution of tempo in beats per minute
ggplot(data = spotify_songs) +
  geom_histogram(aes(x = tempo)) 

# display distribution of tempo by playlist_genre
ggplot(data = spotify_songs, aes(x = tempo, color = playlist_genre)) +
  geom_freqpoly(binwidth = 5)