#!/usr/bin/env bash
# setting the locale, some users have issues with different locales, this forces the correct one
export LC_ALL=en_US.UTF-8

lastfm_username=$1
lastfm_api_key=$2

main() {
  tracks=$(curl -s http://ws.audioscrobbler.com/2.0/\?method\=user.getrecenttracks\&user\=$lastfm_username\&api_key\=$lastfm_api_key\&limit\=1\&format\=json)
  artist=$(echo $tracks | jq -r '.recenttracks.track[] | select(.["@attr"].nowplaying == "true") | .artist."#text"')
  song=$(echo $tracks | jq -r '.recenttracks.track[] | select(.["@attr"].nowplaying == "true") | .name')
  if [ -z "$artist" ] || [ -z "$song" ]; then
    :
  else
    echo ♫ $artist "-" $song
  fi
}

main
