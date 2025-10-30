#!/usr/bin/env bash
SRVPORT=${SRVPORT:-4499}
RSPFILE=response

rm -f "$RSPFILE"
mkfifo "$RSPFILE"

get_api() {
    read line
    echo "$line"
}

handleRequest() {
    # 1) Process the request
    get_api
    mod=$(fortune)

cat <<EOF > "$RSPFILE"
HTTP/1.1 200


<pre>$(cowsay "$mod")</pre>
EOF
}

prerequisites() {
    command -v cowsay >/dev/null 2>&1 &&
    command -v fortune >/dev/null 2>&1 ||
        {
            echo "Install prerequisites." >&2
            exit 1
        }
}

cleanup() {
    rm -f "$RSPFILE"
    exit 0
}

trap cleanup INT TERM

main() {
    prerequisites
    echo "Wisdom served on port=$SRVPORT..."

    while true; do
        cat "$RSPFILE" | nc -lN "$SRVPORT" | handleRequest
        sleep 0.01
    done
}

main