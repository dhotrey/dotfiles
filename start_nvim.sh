#!/bin/bash

# Start the headless Neovim server
nvim --headless --listen localhost:6666 > /dev/null 2>&1 &
NVIM_PID=$!

# Wait for the server to start
while ! lsof -i :6666 >/dev/null 2>&1; do
    sleep 0.1
done

# Start Neovide and connect to the server
neovide.exe --server=localhost:6666 > /dev/null 2>&1 &

# Disown the background processes
disown $NVIM_PID
disown $!
