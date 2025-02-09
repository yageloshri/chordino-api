from flask import Flask, request, jsonify
import subprocess
import os

app = Flask(__name__)

# נתיב בדיקה לשרת
@app.route('/', methods=['GET'])
def home():
    return jsonify({"message": "Server is live!"}), 200

@app.route('/extract_chords', methods=['POST'])
def extract_chords():
    if 'audio' not in request.files:
        return jsonify({"error": "No audio file provided"}), 400

    audio_file = request.files['audio']
    if audio_file.filename == '':
        return jsonify({"error": "Empty filename"}), 400

    file_path = f"/tmp/{audio_file.filename}"
    audio_file.save(file_path)

    try:
        # הרצת Chordino
        result = subprocess.run(
            ['vamp-simple-host', 'chordinoplugin:chordino', file_path],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            check=True
