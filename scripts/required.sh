#!/usr/bin/env bash
#Tools needed to setup this whole operation. Optional version string if that's
#ever necessary.

TOOLS=(
    'cmake' ''
    'git' ''
)

check_required_tools() {
    local name version i
    for ((i=0; i<${#TOOLS[@]}; i+=2)); do
        name="${TOOLS[i]}"
        version="${TOOLS[(( i+1 ))]}"

        if ! hash "$name" 2>/dev/null; then
            printf "ERROR: tool '%s' is not available on system path.\n" "$name"
            return 1
        fi
    done

    return 0
}
