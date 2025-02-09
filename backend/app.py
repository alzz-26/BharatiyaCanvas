from flask import Flask, request, jsonify
import torch
from torchvision import transforms
from PIL import Image
import os
import numpy as np
from torchvision.models import resnet18

app = Flask(__name__)

# Load the trained model
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
model_path = "************/backend/best_resnet18.pth"  # Update with your model path
num_classes = 30  # Number of classes in your dataset

# Replace this with your model loading logic
def load_model(weights_path, num_classes, device):
    model = resnet18(pretrained=False)
    model.fc = torch.nn.Linear(model.fc.in_features, num_classes)
    model.load_state_dict(torch.load(weights_path, map_location=device))
    model.to(device)
    model.eval()
    return model

model = load_model(model_path, num_classes, device)

# Define the preprocessing function
def preprocess_image(image_path):
    transform = transforms.Compose([
        transforms.Resize((224, 224)),
        transforms.ToTensor(),
        transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225])
    ])
    image = Image.open(image_path).convert("RGB")
    return transform(image)

# Define the prediction function
def predict_with_logits(model, image_tensor, device=None):
    if device is None:
        device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    
    image_tensor = image_tensor.unsqueeze(0).to(device)
    with torch.no_grad():
        logits = model(image_tensor)
        logits_np = logits.squeeze(0).cpu().numpy()
        probabilities = torch.softmax(logits, dim=1)
        probabilities_np = probabilities.squeeze(0).cpu().numpy()
        predicted_label_idx = torch.argmax(probabilities).item()
        
    
    return predicted_label_idx, probabilities_np

# Define the route for image prediction
@app.route('/predict', methods=['POST'])
def predict():
    if 'image' not in request.files:
        return jsonify({'error': 'No image file provided'}), 400
    
    file = request.files['image']
    
    if file.filename == '':
        return jsonify({'error': 'Empty file name'}), 400
    
    try:
        # Save the image temporarily
        temp_image_path = "temp_image.jpg"
        file.save(temp_image_path)
        
        # Preprocess the image
        image_tensor = preprocess_image(temp_image_path)
        
        # Predict
        predicted_idx, probabilities = predict_with_logits(model, image_tensor, device)
        
        # Map the predicted index to a class label
        class_to_idx = {
            'Aipan Art (Uttarakhand)': 0, 
            'Assamese Miniature Painting (Assam)': 1, 
            'Basholi Painting (Jammu and Kashmir)': 2, 
            'Bhil Painting (Madhya Pradesh)': 3, 
            'Chamba Rumal (Himachal Pradesh)': 4, 
            'Cheriyal Scroll Painting (Telangana)': 5, 
            'Dokra Art(West Bengal)': 6, 
            'Gond Painting (Madhya Pradesh)': 7, 
            'Kalamkari Painting (Andra Pradesh and Telangana)': 8,
            'Kalighat Painting (West Bengal)': 9, 
            'Kangra Painting (Himachal Pradesh)': 10, 
            'Kerala Mural Painting (Kerala)': 11, 
            'Kondapalli Bommallu (Andra Pradesh)': 12, 
            'Kutch Lippan Art (Gujarat)': 13, 
            'Leather Puppet Art (Andra Pradesh)': 14, 
            'Madhubani Painting (Bihar)': 15, 
            'Mandala Art': 16, 
            'Mandana Art (Rajasthan)': 17, 
            'Mata Ni Pachedi (Gujarat)': 18, 
            'Meenakari Painting (Rajasthan)': 19, 
            'Mughal Paintings': 20,
            'Mysore Ganjifa Art (Karnataka)': 21, 
            'Pattachitra Painting (Odisha and Bengal)': 22, 
            'Patua Painting (West Bengal)': 23, 
            'Pichwai Painting (Rajasthan)': 24, 
            'Rajasthani Miniature Painting (Rajasthan)': 25, 
            'Rogan Art from Kutch (Gujarat)': 26, 
            'Sohrai Art (Jharkhand)': 27, 
            'Tikuli Art (Bihar)': 28, 
            'Warli Folk Painting (Maharashtra)': 29
            }
        
        idx_to_class = {v: k for k, v in class_to_idx.items()}
        predicted_label = idx_to_class[predicted_idx]
        probability = {idx_to_class[i]: float(prob) for i, prob in enumerate(probabilities)}
        max_probability = 0.032
        
        # Clean up the temporary file
        os.remove(temp_image_path)

        if max([i/30 for i in probability.values()]) < max_probability :
            return jsonify('Uploaded image is not an indian art form')
        else :
            return jsonify('The uploaded image is {:.3f}% likely {}'.format(probability[predicted_label] * 100, predicted_label))
                #{
                #'predicted_label': predicted_label,
                #'probabilities' : {idx_to_class[i]: float(prob) for i, prob in enumerate(probabilities)}
                #'probability': '{:.3f}'.format(probability[predicted_label] * 100)
                #})
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
