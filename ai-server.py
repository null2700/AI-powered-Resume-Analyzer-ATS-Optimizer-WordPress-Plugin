from flask import Flask, request, jsonify
from flask_cors import CORS
import openai

app = Flask(__name__)
CORS(app)

openai.api_key = 'YOUR_API_KEY'

@app.route('/analyze', methods=['POST'])
def analyze():
    data = request.get_json()
    resume = data['resume']

    prompt = f"Analyze this resume and give ATS optimization suggestions:\n{resume}"

    response = openai.ChatCompletion.create(
        model="gpt-3.5-turbo",
        messages=[{"role": "user", "content": prompt}],
        max_tokens=500
    )

    return jsonify({"analysis": response['choices'][0]['message']['content']})

if __name__ == '__main__':
    app.run(debug=True)
