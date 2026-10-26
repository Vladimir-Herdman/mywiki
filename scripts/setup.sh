#!/usr/bin/env bash
#Setup program and make sure environment can handle build process. If you know
#what you're doing, you don't need this, but I still thought it'd be helpful to
#have an install tool. I always think those're cool.

SCRIPTPATH="$(dirname "$0")"
source "$SCRIPTPATH/libs.sh" #available: LIBS
source "$SCRIPTPATH/required.sh" #available: TOOLS check_required_tools()
source "$SCRIPTPATH/colors.sh"

main() {
    mkdir -p "$SCRIPTPATH/../libs"

    local libgit libname libhash i
    if ! check_required_tools; then
        return 1
    fi

    cd "$SCRIPTPATH/../libs" || exit 1
    for ((i=0; i<${#LIBS[@]}; i+=2)); do
        libgit="https://github.com/${LIBS[i]}"
        libname="${libgit##*/}"
        libhash="${LIBS[(( i+1 ))]}"

        printf "%b%s%b: %s\n" "$GREEN" "DOWNLOAD" "$NC" "$libgit"
        git clone "$libgit" "mywikicurlib" > /dev/null 2>&1
        mkdir -p "$libname"
        printf "%b%s%b: %s\n" "$GREEN" "SETUP LIB" "$NC" "$libname"
        if ! $libname > /dev/null 2>&1; then
            printf "%bERROR%b: Issue setting up lib '%s' for program.\n" "$RED" "$NC" "$libname"
            return 1
        fi
        rm -rf "mywikicurlib"
    done
}

main
