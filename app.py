from flask import Flask, request, jsonify
import subprocess
import os

app = Flask(__name__)

@app.route('/extract_chords', methods=['POST'])
def extract_chords():
    audio_file = request.files['audio']
    file_path = f"/tmp/{audio_file.filename}"
    audio_file.save(file_path)

    # הרצת Chordino
    result = subprocess.run(['vamp-simple-host', 'chordinoplugin:chordino', file_path],
                            stdout=subprocess.PIPE, stderr=subprocess.PIPE)

    chords_output = result.stdout.decode('utf-8')
    os.remove(file_path)

    return jsonify({"chords": chords_output})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

