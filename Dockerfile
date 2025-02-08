FROM python:3.9-slim

# עדכון מקורות והתקנת תלותים בסיסיים
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

# התקנת התלויות של Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# העתקת קבצי הקוד
COPY . .

# הרצת האפליקציה
CMD ["python", "app.py"]
