# Paperspace base image is located in Dockerhub registry: paperspace/gradient_base
# Paperspace Fast.ai image is located Dockerhub registry: paperspace/fastai

# ==================================================================
# Initial Setup
# ------------------------------------------------------------------
    
    FROM paperspace/gradient-base:pt112-tf29-jax0317-py39-20221019


# ==================================================================
# Directories & Tools
# ------------------------------------------------------------------

    RUN mkdir /content && \
        apt-get update -y && \
        apt-get install -y graphviz


# ==================================================================
# Mambaforge
# ------------------------------------------------------------------

    # Based on https://github.com/conda-forge/miniforge
    
    RUN wget "https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-$(uname)-$(uname -m).sh" && \
        bash Mambaforge-$(uname)-$(uname -m).sh -b && \
        ~/mambaforge/condabin/conda init && \
        /root/mambaforge/bin/mamba install jupyter jupyterlab ipython -c conda-forge -y && \
        rm Mambaforge-$(uname)-$(uname -m).sh
    ENV PATH=$PATH:/root/mambaforge/bin


# ==================================================================
# Fast.ai
# ------------------------------------------------------------------

    RUN python3 -m pip install --upgrade pip && \
        python3 -m pip install --upgrade fastai >=2.6.0 && \
        python3 -m pip install --upgrade fastbook && \
        python3 -m pip install --upgrade jupyterlab-git


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
