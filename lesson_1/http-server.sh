#!/usr/bin/env bash
# LS170 Lesson 4
# HTTP Server Using `nc` and `coproc`

function response_200() {
    echo -ne 'HTTP/1.1 200 OK\r\n'
    echo -ne '\r\n'
    cat "$1"
}

function response_400() {
    echo -ne 'HTTP/1.1 400 Bad Request\r\n'
    echo -ne '\r\n'
}

function response_404() {
    echo -ne 'HTTP/1.1 404 Not Found\r\n'
    echo -ne '\r\n'
}

function server () {
    while true; do
        read method path version

        if test "$method" = "GET"; then
            if test -r "./www/$path"; then
                response_200 "./www/$path"
            else
                response_404
            fi
        else
            response_400
        fi
    done
}

coproc SERVER_PROCESS { server; }

nc -lv 2345 <&"${SERVER_PROCESS[0]}" >&"${SERVER_PROCESS[1]}"
