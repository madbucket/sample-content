#!/usr/bin/env bash

set -euo pipefail

if [ -f ".env" ]; then
	. .env
fi

OUTPUT_DIR=./images
MAX_HEIGHT=1000
MAX_WIDTH=1600

if [ -z $UNSPLASH_ACCESS_KEY ]; then
	echo "Access key missing."
	exit 1
fi

if [ -z $UNSPLASH_COLLECTION_ID ]; then
	echo "Collection ID missing."
	exit 1
fi

mkdir -p "$OUTPUT_DIR" 2>/dev/null

response=$(curl -s "https://api.unsplash.com/collections/$UNSPLASH_COLLECTION_ID/photos?client_id=$UNSPLASH_ACCESS_KEY&page=1&per_page=500")

echo "$response" >response.json

echo "$response" | jq -c '.[]' | while read -r photo; do

	id=$(echo "$photo" | jq -r '.id')

	# Skip if already downloaded
	if [ -f "$OUTPUT_DIR/$id.jpg" ]; then
		echo "Skipping $id (already exists)"
		continue
	fi

	raw_url=$(echo "$photo" | jq -r '.urls.raw')
	author=$(echo "$photo" | jq -r '.user.name')
	username=$(echo "$photo" | jq -r '.user.username')
	profile=$(echo "$photo" | jq -r '.user.links.html')
	photo_url=$(echo "$photo" | jq -r '.links.html')
	download_location=$(echo "$photo" | jq -r '.links.download_location')

	download_url="${raw_url}&h=${MAX_HEIGHT}&w=${MAX_WIDTH}&fit=max&fm=jpg&q=100"

	echo "Downloading $id..."

	# Track download (per Unsplash API guidelines)
	curl -s "${download_location}?client_id=${UNSPLASH_ACCESS_KEY}" >/dev/null

	curl -fL "$download_url" -o "$OUTPUT_DIR/$id.jpg"

	cat >"$OUTPUT_DIR/$id.json" <<EOF
{
  "id": "$id",
  "author": "$author",
  "username": "$username",
  "profile": "$profile",
  "unsplash_url": "$photo_url",
  "downloaded_at": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
}
EOF
	sleep 0.3
done

echo "All images downloaded."

node optimize.js
