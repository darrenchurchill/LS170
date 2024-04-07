#!/usr/bin/env bash
# LS170 Lesson 4
# HTTP Server Using `nc` and `coproc`

function server () {
    true
}

coproc SERVER_PROCESS { server; }

nc -lv 2345 <&"${SERVER_PROCESS[0]}" >&"${SERVER_PROCESS[1]}"
