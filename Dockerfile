FROM ubuntu:20.04

RUN apt-get update && apt-get install -y \
    vamp-plugin-sdk vamp-examples vamp-plugin-chordino python3 python3-pip ffmpeg

RUN pip3 install flask

COPY . /app
WORKDIR /app

EXPOSE 5000

CMD ["python3", "app.py"]

