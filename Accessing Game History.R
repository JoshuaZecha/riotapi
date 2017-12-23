# Access the Riot API and extract base information on Summoners
# Author: Joshua Zecha 09-17-2017

# Install these packages if not already done:
# install.packages("jsonlite")
# install.packages("dplyr")
# install.packages("stringr")

library(jsonlite)
library(dplyr)
library(stringr)

# Regional codes:
# https://developer.riotgames.com/regional-endpoints.html

#####1.##### 
# This instruction is FOR EUW
#Replace the <text> with own values
# Input: Summoner name + API Key
SUMMONERNAME <- as.data.frame("Nixmuss")
names(SUMMONERNAME)[1]<- "summonername"
SUMMONERNAME$summonername<-as.character(SUMMONERNAME$summonername)

APIKEY <- as.data.frame("RGAPI-d9b91732-1ee1-4067-a2c1-5158f3ad618e")
names(APIKEY)[1]<- "key"
APIKEY$key <-as.character(APIKEY$key)

# Procedure: For each request a "base link is created" The input strings then replace the placeholders for these strings in the base link
baselinkforjsonsummoner<- as.data.frame("https://euw1.api.riotgames.com/lol/summoner/v3/summoners/by-name/SUMMONERNAME?api_key=APIKEY")
names(baselinkforjsonsummoner)[1]<- "link"

#Replace the placholders with the real Summonername and API Key (with stringr)
baselinkforjsonsummoner$full_link_summoner <- str_replace_all(baselinkforjsonsummoner$link, "SUMMONERNAME", SUMMONERNAME$summonername)
baselinkforjsonsummoner$full_link_summoner <-as.character(baselinkforjsonsummoner$full_link_summoner)
baselinkforjsonsummoner$full_link_summoner <- str_replace_all(baselinkforjsonsummoner$full_link_summoner, "APIKEY", APIKEY$key)

#  Now I use the created link in baselinkforjsonsummoner$full_link_summoner to fetch the summoner data from the Riot API as json
jsonsummoner <- fromJSON(baselinkforjsonsummoner$full_link_summoner)
jsonsummoner<-as.data.frame(jsonsummoner)
summonerID <-jsonsummoner%>%select(accountId)
summonerID$accountId<-as.character(summonerID$accountId)

# This step accesses the match history:
baselinkforjsonsummID<-as.data.frame(c("https://euw1.api.riotgames.com//lol/match/v3/matchlists/by-account/SUMMONERID/recent?api_key=APIKEY"))
names(baselinkforjsonsummID)[1]<- "link"

baselinkforjsonsummID$link<-as.character(baselinkforjsonsummID$link)
baselinkforjsonsummID$full_link_recentML <- str_replace_all(baselinkforjsonsummID$link, "SUMMONERID", summonerID$accountId)
baselinkforjsonsummID$full_link_recentML<- as.character(baselinkforjsonsummID$full_link_recentML)
baselinkforjsonsummID$full_link_recentML <- str_replace_all(baselinkforjsonsummID$full_link_recentML, "APIKEY", APIKEY$key)

jsonrecentgames <- fromJSON(baselinkforjsonsummID$full_link_recentML)
jsonrecentgames<-as.data.frame(jsonrecentgames)
jsonrecentgames