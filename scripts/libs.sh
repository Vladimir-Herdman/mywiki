#!/usr/bin/env bash
#LIBS: git commits for the repo to get a specific version, so it stays
#consistent/is updateable.

#Then, functions for each libs setup (from the libs directory).

#The libname followed by the commit has to use. Comment is the version or date.

LIBS=(
    'webview/webview' 'f244320ab0d82fdab98a094e02996fc26d0ffd0c' #oct 21, 2026
)

webview() {
    cp -r  mywikicurlib/core/include/webview/* ./webview
    return 0
}
