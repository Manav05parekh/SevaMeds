# SevaMeds - A Donation Platform for NGOs

SevaMeds is a mobile application developed using Flutter, designed to facilitate donations for an NGO. The app allows users to donate in four categories: **Blood**, **Medicine**, **Clothes**, and **Books**. The project includes a backend built with Python Flask and uses a machine learning model to identify medicines through photos. Below is a detailed overview of the features and technologies used.

## Features

### 1. User Authentication
- **Login**, **Register**, and **Profile** pages are available for user management.
- Secure authentication process to ensure privacy and security.

### 2. Donation Options
Users can donate in the following categories:
- **Blood**: Simplified form to record blood type and other donation details.
- **Medicine**: Users input quantity and expiry date. By clicking a photo of the medicine, the app automatically detects the medicine name using a machine learning model.
- **Clothes**: Users can donate clothes by specifying quantity and type.
- **Books**: Users can donate books by entering the details of the books.

### 3. Medicine Donation Feature
- For medicine donations, users provide the quantity and expiry date.
- The app uses **OpenCV** to capture the medicine name through a photo and recognize it with a machine learning model.
- After submitting, the user receives an acknowledgment message in the app and an email with a thank-you note and donation details.

### 4. Acknowledgments and Email Notification
- After a donation is successfully made, the user receives an acknowledgment in-app.
- Additionally, an automated email is sent with the donation summary and a personalized thank-you message.

## Backend
- **Python Flask**: The backend is built using Flask to handle the API requests and responses.
- **Machine Learning**: A model created with **RoboFlow** is integrated to detect the medicine name via photos.
- **Ngrok**: Used for tunneling during development.
- **Postman**: API testing and development done using Postman.

## Machine Learning Model
- The machine learning model was trained using a custom dataset created with **RoboFlow**.
- **OpenCV** is utilized for image capture and preprocessing.
- The model processes the photo to identify the name of the medicine automatically.

## Installation & Setup

### 1. Prerequisites
- Flutter SDK
- Python 3.x
- Flask
- Ngrok
- OpenCV
- RoboFlow API for dataset handling

### 2. Installation Steps
1. Clone the repository:
    ```bash
    git clone https://github.com/yourusername/SevaMeds.git
    ```
2. Navigate to the Flutter project directory:
    ```bash
    cd SevaMeds
    ```
3. Install dependencies:
    ```bash
    flutter pub get
    ```
4. Set up the backend:
    - Navigate to the `backend` directory.
    - Install the required Python packages:
      ```bash
      pip install -r requirements.txt
      ```
    - Start the Flask server:
      ```bash
      python app.py
      ```
    - Start ngrok for tunneling:
      ```bash
      ngrok http 5000
      ```

### 3. Running the App
1. Run the Flutter app on your emulator or connected device:
    ```bash
    flutter run
    ```

## Technologies Used
- **Flutter**: Frontend mobile development.
- **Python Flask**: Backend API.
- **OpenCV**: Image processing for medicine name detection.
- **Machine Learning**: Custom medicine detection model.
- **Ngrok**: Secure tunneling for local development.
- **RoboFlow**: Used for dataset creation.
- **Postman**: For API testing.

## Contributing
Contributions are welcome! Please create an issue or submit a pull request.

## License
This project is licensed under the MIT License.

## Contact
For any questions, feel free to reach out via email at `youremail@example.com`.

