#!/bin/sh
curl -sL -A 'Mozilla/5.0' 'https://anidb.app/anime/gintama-1816' | tr '"' '\n' | grep -E 'https://.*poster.*\.jpg' | sort -u
