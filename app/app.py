from flask import Flask
app = Flask(__name__)

def wrap_html(message):
    html = """
        <html>
        <body>
            <div style='text-align:center;font-size:80px;'>
                <h3>Testing this Hello World"</h3>
            </div>
        </body>
        </html>""".format(message)
    return html

@app.route('/')
def hello_world():
    return 'Hello World!'

@app.route('/health')
def health_check():
    return 'Health OK'

if __name__ == '__main__':
    app.run(debug=False, host='0.0.0.0')