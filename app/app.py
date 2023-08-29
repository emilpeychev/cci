from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello World!'

@app.route('/health')
def health_check():
    return 'Health OK'

if __name__ == '__main__':
    app.run(debug=False, host='0.0.0.0')
