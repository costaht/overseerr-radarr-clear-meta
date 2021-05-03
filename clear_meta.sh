#!/bin/bash

radarr_db=/home/habner/.config/Radarr/radarr.db
overseerr_db=/root/snap/overseerr/common/db/db.sqlite3

echo 
echo "Movies that will have their metadata removed from Overseerr"
sqlite3 -header -column -readonly $radarr_db 'SELECT TmdbId, title, year FROM Movies WHERE Status = '3' AND Monitored = '0' AND MovieFileId = '0''

read -r -p "Continue? [y/N] " response
response=${response,,}
if [[ "$response" =~ ^(yes|y)$ ]]; then

for i in `sqlite3 -readonly $radarr_db 'SELECT TmdbId FROM Movies WHERE Status = '3' AND Monitored = '0' AND MovieFileId = '0''`
        do
        clear_metadata=`sqlite3 -readonly $overseerr_db 'SELECT id FROM media WHERE tmdbId='$i''`

curl 'http://192.168.1.20:5055/api/v1/media/'$clear_metadata \
  -X 'DELETE' \
  -H 'Accept: application/json, text/plain, */*' \
  -H 'Accept-Language: en-US,en;q=0.9' \
  -H 'Cookie: ####### YOUR COOKIE HERE #############'
done

fi
