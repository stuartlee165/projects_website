#!/bin/bash
# Script to start the server

# Activate the virtual environment
source website_env/bin/activate
# Run the server with gunicorn
#exec gunicorn -b :5000 --access-logfile - --error-logfile - wsgi:app
exec flask run
# exec triggers the process running the script to be replaced with the command given (instead of starting it as a new process). Required as Docker associates the life of the container to the first process that runs on it. As here the start up process is not the main process of the container this ensure the main process takes the place of that first process (and is not terminated early by Docker).


# Error logs: anything container writes to stdout or stderr will be captured and stored as logs for the container. Therefore --access-logfile and --error-logfile are both configured with a -, which sends the log to standard output so that they are stored as logs by Docker.
