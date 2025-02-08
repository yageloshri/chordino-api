# שלב 1: שימוש בתמונה בסיסית של Python
FROM python:3.9-slim

# שלב 2: עדכון מקורות והתקנת תלותיות
RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common \
    ca-certificates \
    gnupg \
    lsb-release \
    ffmpeg \
    python3 \
    python3-pip \
    vamp-plugin-sdk \
    vamp-examples \
    vamp-plugin-chordino \
    && rm -rf /var/lib/apt/lists/*

# שלב 3: העתקת קבצי הפרויקט
WORKDIR /app
COPY . /app

# שלב 4: התקנת ספריות Python
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# שלב 5: פתיחת פורט (אם נדרש)
EXPOSE 5000

# שלב 6: פקודת הפעלה
CMD ["python3", "app.py"]
