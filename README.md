# overseerr-radarr-clear-meta
This script cleans the metadata of Movies that were deleted from Radarr.

First it will search on Radarr db for titles with the following caracteristics:
* Status: Released
* Monitoring Status: False
* MovieFileId: 0 (doesn't exist)

And then it will clean the metadata of those titles from Overseerr.

**Don't forget to add your Cookie**

Known issue:
The second time your run the script you're gonna get an error because the title still exist on Radarr, but not on Overseerr.
