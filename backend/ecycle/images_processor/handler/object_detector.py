from PIL import Image
from ultralytics import YOLO
# from image_processor.handler.save_result import save_image
import threading
from django.conf import settings


import os
current_dir = os.path.dirname(os.path.abspath(__file__))
model_path = os.path.join(current_dir, 'trained_model/best.pt')


def save_image(results):
    for r in results:
        im_array = r.plot()  # plot a BGR numpy array of predictions
        im = Image.fromarray(im_array[..., ::-1])  # RGB PIL image
        im.save('results.jpg')  # save image



def detect_object(image_url):
    # Load a pretrained YOLOv8n model
    image_link=settings.BACKEND_URL+image_url
    model = YOLO(model_path)

    # Define path to the image file
    print(image_link)
    source = image_link

    # Run inference on the source
    results = model.predict(source)  # list of Results objects

    names = model.names
    a=set()

    # print(results[0].names) # To determine total category made for detection
    threading.Thread(target=save_image, args=(results,)).start()
    # Show the results
    for r in results:
            for c in r.boxes.cls:
                #  print(names[int(c)]) # get class name corrosponding to class number detected
                a.add(names[int(c)]) # add to set object


    for item in a:
         print(item) # print detected object uniquely
    return a

# detect_object()