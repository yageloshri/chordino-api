# שלב 1: שימוש בתמונה בסיסית של Python
FROM python:3.9-slim

# שלב 2: עדכון חבילות בסיסיות והתקנת תלותיות
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    gnupg \
    lsb-release \
    vamp-plugin-sdk \
    vamp-examples \
    vamp-plugin-chordino \
    python3 \
    python3-pip \
    ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# שלב 3: העתקת קבצי הפרויקט לתוך ה-Container
WORKDIR /app
COPY . /app

# שלב 4: התקנת ספריות Python לפי requirements.txt
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# שלב 5: פתיחת פורט (אם נדרש לשירות API)
EXPOSE 5000

# שלב 6: פקודת ההפעלה של ה-API
CMD ["python3", "app.py"]
