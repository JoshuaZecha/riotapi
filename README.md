# Accessing the RIOT API with R - 
File: Accessing Game History.R
## What does this file do?
It extracts the json info retrieved from the riot api into R data frames. These data frames can be further analyzed with the knwon R tools.

## What is my output?

jsonrecentgames is a data frame with the match history (last 20 games). We can additionally continue working with the Summoner ID, which is given in the data frame summonerID

It requires the following steps to work:

a) You need a League of Legends account. Register on for your respective region. 
b) Go to https://developer.riotgames.com/ . Log in with your League of Legends account data.  
c) Generate your own API key.  
d) Replace <Summonername> with a the Summoner Name of interest.  
e) Replace the <API_KEY> with your own API key.
 
 ##
  
Notes: 

This file is currently for EUW only. Nevertheless this can easily be applied to NA. Just replace "euw1.api.riotgames.com" in the baselinkforjsonsummoner with na1.api.riotgames.com . This may be different for older accounts. For further reference see https://developer.riotgames.com/regional-endpoints.html .
