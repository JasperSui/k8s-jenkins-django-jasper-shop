FROM python:3.6.2

WORKDIR /usr/src/app
EXPOSE 8000

ENV PYTHONUNBUFFERED 1

RUN apt-get update && \
    apt-get install vim gettext -y \
    unzip

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

# Update the repository
# "/usr/src/app/" is added in the directory to make sure that will always be in that location
COPY . /usr/src/app/