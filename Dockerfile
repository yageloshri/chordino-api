# שלב 1: שימוש בתמונה בסיסית של Python
FROM python:3.9-slim

# שלב 2: עדכון מקורות והתקנת תלותיות
RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common \
    ca-certificates \
    gnupg \
    lsb-release \
    wget \
    git \
    build-essential \
    vamp-plugin-sdk \
    vamp-examples \
    ffmpeg \
    python3 \
    python3-pip \
    python3-dev \
    libsndfile1 \
    libsndfile1-dev \
    && rm -rf /var/lib/apt/lists/*

# שלב 3: הורדה והתקנה של Chordino ממקור הקוד ב-GitHub
RUN git clone https://github.com/ohollo/chord-extractor.git \
    && cd chord-extractor \
    && pip install . \
    && cd .. \
    && rm -rf chord-extractor

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
