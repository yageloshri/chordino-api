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
        # הרצת Chordino עם השם הנכון של הפלאגין
        result = subprocess.run(
            ['vamp-simple-host', 'vamp-plugin-chordino:chordino', file_path],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            check=True
        )

        chords_output = result.stdout.decode('utf-8')
        return jsonify({"chords": chords_output}), 200

    except subprocess.CalledProcessError as e:
        error_message = e.stderr.decode('utf-8')
        return jsonify({"error": f"Chordino processing failed: {error_message}"}), 500

    except Exception as e:
        return jsonify({"error": f"Unexpected error: {str(e)}"}), 500

    finally:
        if os.path.exists(file_path):
            os.remove(file_path)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
