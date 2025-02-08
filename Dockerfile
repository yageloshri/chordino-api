# שלב 1: שימוש בתמונה בסיסית של Python
FROM python:3.9-slim

# שלב 2: עדכון מקורות והתקנת תלותיות בסיסיות
RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common \
    ca-certificates \
    gnupg \
    lsb-release \
    wget \
    ffmpeg \
    python3 \
    python3-pip \
    vamp-plugin-sdk \
    vamp-examples \
    && rm -rf /var/lib/apt/lists/*

# שלב 3: הורדה והתקנה של vamp-plugin-chordino ממקור הקוד
RUN wget https://code.soundsoftware.ac.uk/attachments/download/1202/chordino-1.1.zip \
    && apt-get install -y unzip \
    && unzip chordino-1.1.zip \
    && cd chordino-1.1 \
    && make \
    && make install \
    && cd .. \
    && rm -rf chordino-1.1 chordino-1.1.zip

# שלב 4: העתקת קבצי הפרויקט
WORKDIR /app
COPY . /app

# שלב 5: התקנת ספריות Python
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# שלב 6: פתיחת פורט (אם נדרש)
EXPOSE 5000

# שלב 7: פקודת הפעלה
CMD ["python3", "app.py"]
