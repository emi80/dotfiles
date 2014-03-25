#!/bin/sh
CACHE=${XDG_CACHE_HOME:-"$HOME/.cache"}/dmenu_run
(
        IFS=:
        if test "`ls -dt $PATH "$CACHE" 2> /dev/null | sed 1q`" != "$CACHE"; then
                mkdir -p "`dirname "$CACHE"`" && lsx $PATH | sort -u > "$CACHE"
        fi
)
exe=`dmenu -b -fn 'Ubuntu Mono-12' -nf '#545454' -nb '#dddddd' -sf '#ffffff' -sb '#285577' "$@"< "$CACHE"` && exec sh -c "$exe"
