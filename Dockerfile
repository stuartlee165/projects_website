
# Base image to use
FROM python:3-alpine

# COPY from-drive to-docker image
ADD . /app

# Create home directory (if not specified "root" is used
WORKDIR /app

RUN pip install -r requirements.txt

CMD ["python","app.py"]


# To build the Docker Image
### docker build -t website:5thDec22 .

# To run the docker image from port 5000 in docker to port 80 on my browser
### docker run --name website -d -p 80:5000 website:5thDec22

# View running containers and info
### docker ps -a

# View website in browser
### http://0.0.0.0:80
