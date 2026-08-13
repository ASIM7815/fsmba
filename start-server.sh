#!/bin/bash
# Simple HTTP server to run the exam website

echo "Starting ISL Engineering College Exam Server..."
echo "Server will be available at: http://localhost:8000"
echo "Press Ctrl+C to stop the server"
echo ""

# Check if Python 3 is available
if command -v python3 &> /dev/null; then
    python3 -m http.server 8000
# Check if Python 2 is available
elif command -v python &> /dev/null; then
    python -m SimpleHTTPServer 8000
else
    echo "Error: Python is not installed. Please install Python to run the server."
    exit 1
fi
