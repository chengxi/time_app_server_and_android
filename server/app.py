from flask import Flask, jsonify
import datetime

app = Flask(__name__)

@app.route('/time', methods=['GET'])
def get_current_time():
    now = datetime.datetime.now()
    return jsonify({'current_time': now.strftime("%Y-%m-%d %H:%M:%S")})

if __name__ == '__main__':
    app.run(debug=True)