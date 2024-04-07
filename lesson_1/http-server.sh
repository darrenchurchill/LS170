#!/usr/bin/env bash
# LS170 Lesson 4
# HTTP Server Using `nc` and `coproc`

function server () {
    while true; do
        read method path version

        if test "$method" = "GET"; then
            echo 'HTTP/1.1 200 OK'
        else
            echo 'HTTP/1.1 400 Bad Request'
        fi
    done
}

coproc SERVER_PROCESS { server; }

nc -lv 2345 <&"${SERVER_PROCESS[0]}" >&"${SERVER_PROCESS[1]}"
