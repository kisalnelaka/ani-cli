#!/bin/sh
_id="tada-never-falls-in-love-5096"
_cache_dir="/c/Users/kisal/.cache/ani-cli/preview/5.1.0"
mkdir -p "$_cache_dir"
_img_file="$_cache_dir/${_id}.jpg"
_cache_txt="$_cache_dir/${_id}.txt"

_page="$(curl -sL -A 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36' --max-time 10 "https://anidb.app/anime/$_id")"

_title="$(printf '%s' "$_page" | sed -nE 's|.*<meta property="og:title" content="([^"]+)".*|\1|p' | sed 's| [—-] AniDB.*||' | head -n 1)"
[ -z "$_title" ] && _title="$(printf '%s' "$_page" | sed -nE 's|.*<h1[^>]*>([^<]+)</h1>.*|\1|p' | head -n 1)"
[ -z "$_title" ] && _title="$(printf '%s' "$_page" | sed -nE 's|.*<title>([^<]+)</title>.*|\1|p' | sed 's| [—-] AniDB.*||; s| - AniDB.*||' | head -n 1)"
[ -z "$_title" ] && _title="$_id"

_img="$(printf '%s' "$_page" | sed -nE 's|.*<meta property="og:image" content="([^"]+)".*|\1|p' | head -n 1)"
[ -z "$_img" ] && _img="$(printf '%s' "$_page" | sed -nE 's|.*src="([^"]*/poster/[^"]+)".*|\1|p' | head -n 1)"

_mal_id="$(printf '%s' "$_page" | sed -nE 's|.*myanimelist.net/anime/([0-9]+)/.*|\1|p' | head -n 1)"
_score="$(printf '%s' "$_page" | sed -nE 's|.*text-yellow-400".*<\/svg>([0-9.]+)<.*|\1|p' | head -n 1)"
_status="$(printf '%s' "$_page" | sed -nE 's|.*browse\?status=[^"]*"[^>]*>([^<]+)<.*|\1|p' | head -n 1)"
_type="$(printf '%s' "$_page" | sed -nE 's|.*browse\?type=[^"]*"[^>]*>([^<]+)<.*|\1|p' | head -n 1)"
_genres="$(printf '%s' "$_page" | sed -n '/<div class="flex flex-wrap gap-1.5 mb-4">/,/<\/div>/p' | sed -nE 's|.*>([^<]+)<\/a>.*|\1|p' | tr '\n' ',' | sed 's/,$//')"
_desc="$(printf '%s' "$_page" | sed -n '/>Synopsis</,/\/p>/p' | sed -nE 's|.*<p class="text-sm text-faint leading-relaxed">(.*)<\/p>.*|\1|p' | sed 's|<br><br>|\n\n|g; s|<br>|\n|g; s|&#039;|'"'"'|g; s|&quot;|"|g; s|&amp;|\&|g')"
[ -z "$_desc" ] && _desc="$(printf '%s' "$_page" | sed -nE 's|.*og:description" content="([^"]+)".*|\1|p' | sed 's|&#039;|'"'"'|g; s|&quot;|"|g; s|&amp;|\&|g' | head -n 1)"
[ -z "$_desc" ] && _desc="No description available."

_img_viewer="$(command -v chafa || command -v chafa.exe || echo "/c/Users/kisal/scoop/shims/chafa.exe")"

{
  if [ -n "$_img" ] && [ -n "$_img_viewer" ]; then
    [ ! -s "$_img_file" ] && curl -sL -A 'Mozilla/5.0' --max-time 5 "$_img" -o "$_img_file" 2>/dev/null || true
    if [ -s "$_img_file" ]; then
      case "$_img_viewer" in
        *chafa*)  "$_img_viewer" --size=22x8 --colors=256 "$_img_file" 2>/dev/null || true ;;
        *catimg*) "$_img_viewer" -w 44 -H 8 "$_img_file" 2>/dev/null || true ;;
        *) ;;
      esac
    fi
  fi
  printf '\033[1;36m%s\033[0m\n' "$_title"
  _meta=""
  [ -n "$_score" ] && _meta="\033[1;33m★ $_score\033[0m"
  [ -n "$_type" ] && _meta="${_meta:+$_meta | }\033[1;34m$_type\033[0m"
  [ -n "$_status" ] && _meta="${_meta:+$_meta | }\033[1;35m$_status\033[0m"
  [ -n "$_mal_id" ] && _meta="${_meta:+$_meta | }\033[1;30mMAL:$_mal_id\033[0m"
  [ -n "$_meta" ] && printf '%b\n' "$_meta"
  [ -n "$_genres" ] && printf '\033[1;37mGenres:\033[0m %s\n' "$_genres"
  printf '\n\033[1;32mSynopsis:\033[0m\n'
  printf '%s\n' "$_desc"
}
