"""Flask configuration."""
from os import environ, path

# Python-dotenv reads key-value pairs from a .env file and can set them as environment variables.
# from dotenv import load_dotenv

# Keep secret key in .env file
basedir = path.abspath(path.dirname(__file__))
# load_dotenv(path.join(basedir, ".env"))

# "development" => enables debug mode
# when using in procuction change to "production"
SECRET_KEY = "highonthehilltherewasthorwithhishammer"
FLASK_ENV = "development"
# DEBUG = True
