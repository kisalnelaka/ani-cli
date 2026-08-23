#!/bin/sh
_page="$(curl -sL -A 'Mozilla/5.0' 'https://anidb.app/anime/tada-never-falls-in-love-5096')"
_title="$(printf "%s" "$_page" | sed -nE 's|.*<h1[^>]*>([^<]+)</h1>.*|\1|p' | head -n 1)"
echo "H1: '$_title'"
_title2="$(printf "%s" "$_page" | sed -nE 's|.*<title>([^<]+)</title>.*|\1|p' | sed 's| - AniDB.*||' | head -n 1)"
echo "Title tag: '$_title2'"
_img="$(printf "%s" "$_page" | sed -nE 's|.*src="([^"]*/poster/[^"]+)".*|\1|p' | head -n 1)"
echo "Img: '$_img'"
