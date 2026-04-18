#!/bin/bash

TEMPLATE=$(<template.html)
PUBLIC_DIR=public
IMAGES_DIR=images

shopt -s nullglob

files=(./${IMAGES_DIR}/*.json)

gallery=''

if ((${#files[@]} == 0)); then
	echo "No JSON files found"
else
	mkdir -p $PUBLIC_DIR/$IMAGES_DIR 2>/dev/null
	rsync -a $IMAGES_DIR/*.webp $PUBLIC_DIR/$IMAGES_DIR

	for file in "${files[@]}"; do
		id=$(jq -r '.id' "$file")
		author=$(jq -r '.author' "$file")
		profile=$(jq -r '.profile' "$file")
		unsplash=$(jq -r '.unsplash_url' "$file")
		image=${IMAGES_DIR}/${id}.webp

		read -r -d '' item <<-EOF
			<figure>
				<a
					href="${image}" 
					class="card"
					title="by ${author} on Unsplash"
					target="_blank"
				>
					<img src="${image}" /> 
				</a>
				<figcaption>
					by <a href="$profile" target="_blank">$author</a> on 
					<a href="$unsplash" target="_blank">Unsplash</a> 
				</figcaption>
			</figure>
		EOF

		gallery="${gallery}\n${item}\n"
	done
fi

echo -e "${TEMPLATE/__ITEMS__/$gallery}" >"$PUBLIC_DIR/index.html"
