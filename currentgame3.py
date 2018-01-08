#Python 3.x
#Fetching-script
import urllib.request, json
import pickle
name="Wakz"
apikey="RGAPI-926447e6-9c03-4f1d-87fc-582359f77daf"
baselink1="https://euw1.api.riotgames.com/lol/summoner/v3/summoners/by-name/SUMMONERNAME?api_key=APIKEY"

baselink2=baselink1.replace("SUMMONERNAME",name)
baselink2=baselink2.replace("APIKEY",apikey)

#Now fetch the data as json from riotgames api. we get the dictionary from which we extract the accountId.
# We need the accountId in order to get the matchlist data which contains the matchID
# https://stackoverflow.com/a/12965254/8259308

with urllib.request.urlopen(baselink2) as url:
    data = json.loads(url.read().decode())

accid=data['accountId']
accid=str(accid)

baselink3="https://euw1.api.riotgames.com/lol/match/v3/matchlists/by-account/accountId?api_key=APIKEY"
baselink4=baselink3.replace("APIKEY",apikey)
baselink4=baselink4.replace("accountId",accid)

with urllib.request.urlopen(baselink4) as url:
    data = json.loads(url.read().decode())

matchId=data['matches'][0]['gameId']
matchId=str(matchId)
# print(matchId)

baselink5="https://euw1.api.riotgames.com/lol/match/v3/matches/matchId?api_key=APIKEY"
baselink6=baselink5.replace("APIKEY",apikey)
baselink6=baselink6.replace("matchId",matchId)


with urllib.request.urlopen(baselink6) as url:
    data = json.loads(url.read().decode())
#print(data.keys())
identities=data['participantIdentities']
identities=str(identities)
#print(identities)
#matchId=data['matches'][0]['gameId']
championId=data['participants'][2]['championId']
championId=str(championId)
print(championId)
#The static api has limitations, so we won't fetch new data from it each time: it is saved as an external file called "champdata"
# The following commented lines show how the champdata file can be renewed (e.g. if a new champ is introduced)

baselink9="https://euw1.api.riotgames.com/lol/static-data/v3/champions?api_key=APIKEY"
baselink10=baselink9.replace("APIKEY",apikey)
print(baselink10)
#print(data['data']['name'][41])

#example for pickle:

a = {'Spieler1': 'Teemo'}

with open('champdata.pickle', 'wb') as handle:
    pickle.dump(a, handle, protocol=pickle.HIGHEST_PROTOCOL)

with open('champdata.pickle', 'rb') as handle:
    b = pickle.load(handle)
print (a == b)

#example for export of dict to .json:
