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

#####1.##### FOR EUW
# Input: Summoner name + API Key

#Replace values inside <> with own values

SUMMONERNAME <- as.data.frame("<Summonername>")
names(SUMMONERNAME)[1]<- "summonername"
SUMMONERNAME$summonername<-as.character(SUMMONERNAME$summonername)

APIKEY <- as.data.frame("<API_KEY>")
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
# convert to df
jsonsummoner<-as.data.frame(jsonsummoner)
summonerID <-jsonsummoner%>%select(accountId)
summonerID$accountId<-as.character(summonerID$accountId)

baselinkforjsonsummID<-as.data.frame(c("https://euw1.api.riotgames.com//lol/match/v3/matchlists/by-account/SUMMONERID/recent?api_key=APIKEY"))
names(baselinkforjsonsummID)[1]<- "link"

baselinkforjsonsummID$link<-as.character(baselinkforjsonsummID$link)
baselinkforjsonsummID$full_link_recentML <- str_replace_all(baselinkforjsonsummID$link, "SUMMONERID", summonerID$accountId)
baselinkforjsonsummID$full_link_recentML<- as.character(baselinkforjsonsummID$full_link_recentML)
baselinkforjsonsummID$full_link_recentML <- str_replace_all(baselinkforjsonsummID$full_link_recentML, "APIKEY", APIKEY$key)

jsonrecentgames <- fromJSON(baselinkforjsonsummID$full_link_recentML)
jsonrecentgames<-as.data.frame(jsonrecentgames)

###Extracting a Champion ID (ID)in this case Teemo or LULU)#######

###this may depend on patch:
allchampions <- fromJSON("http://ddragon.leagueoflegends.com/cdn/6.24.1/data/en_US/champion.json")
allchampions<-as.data.frame(allchampions)
lulu_id<-allchampions%>%select(data.Lulu.key)%>%filter( row_number() == 1L)
teemo_id<-allchampions%>%select(data.Teemo.key)%>%filter( row_number() == 1L)
teemo_id$data.Teemo.key<-as.character(teemo_id$data.Teemo.key)

#####Mastery########## -> Not reliable working yet
baselinkforjsonmastery<-as.data.frame(c("https://euw1.api.riotgames.com//lol/champion-mastery/v3/champion-masteries/by-summoner/SUMMONERID/by-champion/CHAMPID?api_key=APIKEY"))
names(baselinkforjsonmastery)[1]<- "link"

baselinkforjsonmastery$link<-as.character(baselinkforjsonmastery$link)
baselinkforjsonmastery$full_link_recentML <- str_replace_all(baselinkforjsonmastery$link, "SUMMONERID", summonerID$accountId)
baselinkforjsonmastery$full_link_recentML<- as.character(baselinkforjsonmastery$full_link_recentML)
baselinkforjsonmastery$full_link_recentML <- str_replace_all(baselinkforjsonmastery$full_link_recentML, "APIKEY", APIKEY$key)
baselinkforjsonmastery$full_link_recentML<- as.character(baselinkforjsonmastery$full_link_recentML)
baselinkforjsonmastery$full_link_recentML <- str_replace_all(baselinkforjsonmastery$full_link_recentML, "CHAMPID", teemo_id$data.Teemo.key)
mastery <- fromJSON(baselinkforjsonmastery$full_link_recentML)
mastery<-as.data.frame(mastery)