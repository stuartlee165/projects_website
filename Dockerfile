# Base image to use
FROM python:slim

# Create a user (if not specified default "root" is used
RUN useradd website

# Create home directory (if not specified "root" is used
WORKDIR /home/website

# COPY from-drive to-docker image
COPY requirements.txt requirements.txt
COPY static static
COPY templates templates
COPY app.py app.py
COPY boot.sh boot.sh
COPY config.py config.py
COPY requirements.txt requirements.txt

RUN python -m venv website_env
RUN website_env/bin/pip install -r requirements.txt
# Instal gunicorn (development version of flask run - could just add this to requirements.txt)

RUN chmod +x boot.sh

# ENV command sets an environment variable inside the container. Required to
# set FLASK_APP, which is required to use the flask command.
ENV FLASK_APP app.py

# Set the owner of all the directories and files that were stored in /home/website as the new website user.
RUN chown -R website:website ./

# Make this new website user the default for any subsequent instructions, and also for when the container is started.
USER website

# Configure the port that this container will be using for its server (5000= Flask standard port)
EXPOSE 5000


# Define the default command that should be executed when the container is started. 
# This is the command that will start the application web server. 
# To keep things organized stored in separate script.
ENTRYPOINT ["./boot.sh"]


# To build container image: docker build -t website:latest .
# "-t" -> sets the name and tag for the new container image. 
# "." indicates the base directory where the container is to be built. (directory where the Dockerfile is located)
