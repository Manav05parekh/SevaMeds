import torch
import numpy as np
import cv2
from flask import Flask, request, jsonify
import werkzeug
import datetime
from IPython.display import display, Image

# Update for Windows compatibility
import pathlib
from pathlib import PosixPath, WindowsPath
temp = pathlib.PosixPath
pathlib.PosixPath = pathlib.WindowsPath

# Model loading (outside a function for efficiency)
model_path = 'best.pt'  # Update with your model path
model = torch.hub.load('ultralytics/yolov5', 'custom', path=model_path, force_reload=True)
model.conf = 0.4

app = Flask(__name__)

def draw_boxes(image, results):
    for box, label, conf in zip(results.xyxy[0], results.names, results.xyxy[0][:, 4]):
        # Extract coordinates
        xmin, ymin, xmax, ymax = map(int, box[:4])
        
        # Draw bounding box
        cv2.rectangle(image, (xmin, ymin), (xmax, ymax), (0, 255, 0), 2)
        
        # Add label and confidence level
        text = f'{label} {conf:.2f}'
        cv2.putText(image, text, (xmin, ymin - 5), cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0, 255, 0), 2)

@app.route('/upload', methods=["POST"])
def upload():
    if request.method == "POST":
        imagefile = request.files['image']
        filename = werkzeug.utils.secure_filename(imagefile.filename)
        x = str(datetime.datetime.now())
        filename = "image.jpeg"
        imagefile.save(filename)

        try:
            img = cv2.imread(filename)
            results = model(filename)

            draw_boxes(img, results)
            
            # Convert the image to PNG format for displaying in Jupyter Notebook
            _, img_png = cv2.imencode('.png', img)
            
            # Display the image in the output cell of the Jupyter Notebook
            display(Image(data=img_png))

            detected_objects = [f'{results.names[int(obj[-1])]} {conf:.2f}' for obj, conf in zip(results.xyxy[0], results.xyxy[0][:, 4])]
            detected_object = results.names[int(results.xyxy[0][0][-1])] if len(results.xyxy[0]) > 0 else "No object detected"
            response = {
                'message': 'Success',
                'detected_objects': detected_object
            }
            print(detected_objects)
            print(response)
            print(detected_object)
            return detected_object
        except Exception as e:
            print(f"Error during object detection: {e}")
            return jsonify({'message': 'Error: Object detection failed'}), 500

if __name__ == "__main__":
    app.run(debug=False, port=5000)