#!/bin/sh
ciphers='ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305'
tls13_ciphers='TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256'
agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36"

_page="$(curl -sL -A "$agent" --ciphers "$ciphers" --tls13-ciphers "$tls13_ciphers" 'https://anidb.app/anime/tada-never-falls-in-love-5096')"
_title="$(printf "%s" "$_page" | sed -nE 's|.*<h1[^>]*>([^<]+)</h1>.*|\1|p' | head -n 1)"
echo "H1 with ciphers: '$_title'"
_img="$(printf "%s" "$_page" | sed -nE 's|.*src="([^"]*/poster/[^"]+)".*|\1|p' | head -n 1)"
echo "Img with ciphers: '$_img'"
