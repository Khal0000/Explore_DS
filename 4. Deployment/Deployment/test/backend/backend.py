from flask import Flask, jsonify, request
import pandas as pd
import tensorflow as tf
import pickle
# from tensorflow.keras.preprocessing import image

app = Flask(__name__)

# columns = ["date", 'label']

# import model

pickled_model = pickle.load(open('prep_pipeline.pkl', 'rb'))
saved_model = tf.keras.models.load_model('model_best.hdf5')

@app.route("/")
def hello_world():
    return "<p>Hello, This is my Backend Data!</p>"


@app.route("/forecast", methods=['GET', 'POST'])
def body_inference():
    if request.method == 'POST':
        data = request.json

        new_data = data

        new_data = pd.DataFrame([new_data], columns=['Close'])

        data_inf = pickled_model.transform(new_data)
        X_next = data_inf.reshape(1, 60, 1)
        next_day = saved_model.predict(X_next)
        next_day = pickled_model.inverse_transform(next_day)

        res = next_day[0]

        response = {'code':200, 'status':'OK',
            'result':{'forecast': str(res[0])
            }}
        
        return jsonify(response)
    return "Connection succesfully established"

app.run(debug=True)
