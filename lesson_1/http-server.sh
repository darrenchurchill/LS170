#!/usr/bin/env bash
# LS170 Lesson 4
# HTTP Server Using `nc` and `coproc`

function response_200() {
    echo -ne 'HTTP/1.1 200 OK\r\n'
    echo -ne '\r\n'
}

function response_400() {
    echo -ne 'HTTP/1.1 400 Bad Request\r\n'
    echo -ne '\r\n'
}

function server () {
    while true; do
        read method path version

        if test "$method" = "GET"; then
            response_200
        else
            response_400
        fi
    done
}

coproc SERVER_PROCESS { server; }

nc -lv 2345 <&"${SERVER_PROCESS[0]}" >&"${SERVER_PROCESS[1]}"
