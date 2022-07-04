import pickle
import tensorflow as tf
import pandas as pd

def forecast(data):
    pickled_model = pickle.load(open('prep_pipeline.pkl', 'rb'))
    saved_model = tf.keras.models.load_model('model_best.hdf5')

    data_inference = pd.DataFrame(data.history(period="60d"), columns=['Close'])

    data_inf = pickled_model.transform(data_inference)
    X_next = data_inf.reshape(1, 60, 1)
    next_day = saved_model.predict(X_next)
    next_day = pickled_model.inverse_transform(next_day)
    return next_day

