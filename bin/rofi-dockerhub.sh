#!/bin/bash

different_query_string="Different Query"
view_tags_string="View Tags of "

mode_file="/tmp/rofi-docker_mode"
current_mode=""

mode_startpage="startpage"
mode_select="select"
mode_inspect="inspect"
mode_tags="tags"

function set_mode() {
	current_mode="$*"
	echo "$@" > "$mode_file"
}

function run() {
	[ -f "$mode_file" ] && current_mode=$(cat "$mode_file")

	if { { [[ -z "$current_mode" ]] || [[ "$current_mode" = "" ]]; } && [[ "$#" -eq 0 ]]; } \
		|| { [[ "$current_mode" = "$mode_select" ]] && [[ "$*" = "$different_query_string" ]]; }; then
		set_mode startpage
		echo "title:Search Image"
		return
	fi

	function search_mode() {
		echo "title:Select Image"
		set_mode $mode_select

		response=$(curl --no-progress-meter 'https://hub.docker.com/api/content/v1/products/search?page_size=25&q='"$*" -H 'Search-Version: v3')

		echo "$different_query_string"
		echo "$response" | jq '.summaries[] | " " + (.star_count|tostring) + " " + .name + " (" + .pull_count + " 󰇚)"' -r
	}

	function get_full_image_name() {
		image="$1"

		# some images like "postgres" don't have usernames when put in
		# however, in the API, the image DOES have an username; "library"
		if [[ "$image" != *"/"* ]]; then
			image="library/$image"
		fi

		echo "$image"
	}

	function inspect_mode() {
		echo "title:Select Action"
		set_mode $mode_inspect
		image=$(get_full_image_name "$1")

		response=$(curl --no-progress-meter 'https://hub.docker.com/v2/repositories/'"$image"'/')

		echo "$view_tags_string$image"
		echo "  $(echo "$response" | jq -r '.user + "/" + .name')"
		echo " $(echo "$response" | jq -r '.description')"
		echo "$(echo "$response" | jq -r '.star_count')"
		echo "󰇚 $(echo "$response" | jq -r '.pull_count')"
		echo "  $(echo "$response" | jq -r '.last_updated | sub("\\.[[:digit:]]+"; "") | fromdate | strftime("%d.%m.%Y %H:%M")')"
	}

	function view_tags_mode() {
		echo "title:Query Tag"
		set_mode $mode_tags

		image=$(get_full_image_name "$1")

		response=$(curl --no-progress-meter 'https://hub.docker.com/v2/repositories/'"$image"'/tags/?page_size=100')

		echo "$response" | jq -r '.results[] | .name + " (" + ([ .images[].architecture ] | unique | join(", ")) + ")"'
	}

	if [[ $current_mode = "$mode_startpage" ]]; then
		search_mode "$@"
	elif [[ "$current_mode" = "$mode_select" ]]; then
		image=$(echo "$@" | cut -d ' ' -f 3)
		inspect_mode "$image"
	elif [[ "$current_mode" = "$mode_inspect" ]]; then
		if [[ "$*" = "$view_tags_string"* ]]; then
			view_tags_mode "$(echo "$1" | rev | cut -d ' ' -f1 | rev)"
		fi
	fi
}

echo > "$mode_file"
while true; do
	if [ -z "$prompt" ]; then
		input=$(run)
	else
		input=$(run "$prompt")
	fi
	echo "Opening mode $(cat "$mode_file")!"
	header=$(echo "$input" | grep "title:" | sed 's/title://g' | tail -1)
	prompt=$(echo "$input" | grep -v "title:" | rofi -dmenu -p "${header:-Docker}")
	if [ -z "$prompt" ]; then
		exit
	fi
done
