#!/bin/sh

export DISPLAY=:10.0

echo "-- Shutdown: Shutting down"

type() {
    xdotool search --class Stardew windowactivate keydown $1
    sleep 0.5
    xdotool search --class Stardew windowactivate keyup $1
}

move() {
    xdotool search --class Stardew mousemove $1 $2
}

click() {
    xdotool search --class Stardew mousedown 1
    sleep 0.5
    xdotool search --class Stardew mouseup 1
}

type slash
type d
type e
type b
type u
type g
type space
type s
type l
type e
type e
type p
type Return

sleep 60

echo "-- Shutdown done"