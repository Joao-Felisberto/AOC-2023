#!/bin/bash

# Stuff I had to install
# - rust
# - nim
# - zig
# - ocaml
# - opam
# - dune (through opam)

select_language() {
    languages=("rust" "nim" "zig" "ocaml" "dart")
    selected=${languages[$((RANDOM % ${#languages[@]}))]}
    echo $selected
}

create_project() {
    day=$1
    part=$2
    lang=$3
    color=$4
    folder="aoc_${day}_${part}_${lang}"

    # Print the chosen language
    echo -e "\nChosen language for Day $day, Part $part: $color$lang\e[0m"

    # Create the folder
    #mkdir -p $folder

    # Enter the folder
    #cd $folder || exit

    # Create files based on language-specific tooling
    case $lang in
        "rust")
            cargo init "$folder"
            ;;
        "nim")
			mkdir "$folder"
			mkdir "$folder/src"
			touch "$folder/src/nim.nim"
			cd "$folder"
            nimble init -y
			cd ..
            ;;
        "zig")
			mkdir "$folder"
			cd "$folder"
            zig init-exe
			cd ..
            ;;
        "ocaml")
			dune init proj "$folder"
            ;;
        "dart")
			dart create -t console "$folder"
            ;;
    esac

    # Return to the parent directory
    #cd ..
}

# Main script
day="$1"
part="$2"
lang="$(select_language)"

# Ensure the languages for part 1 and part 2 are different
last_lang=$(tail -n 1 langs)
second_last_lang=$(tail -n 2 langs | head -n 1)
while [ "$lang" == "$last_lang" ] || [ "$lang" == "$second_last_lang" ]; do
	lang=$(select_language)
done

# Set the color based on the chosen language
case $lang in
    "rust")
        color="\e[1;31m"
        ;;
    "nim")
        color="\e[1;34m"
        ;;
    "zig")
        color="\e[1;33m"
        ;;
    "ocaml")
        color="\e[1;35m"
        ;;
    "dart")
        color="\e[1;32m"
        ;;
esac

create_project "$(printf "%02d" $day)" "$part" "$lang" "$color"

echo "$lang" >> langs
