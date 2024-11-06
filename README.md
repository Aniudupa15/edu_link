# Edu Link 📚

Edu Link is a powerful and user-friendly education management app designed to bridge the gap between students and teachers, providing a collaborative environment for learning, progress tracking, and communication. With an array of features, Edu Link is the one-stop solution for students to access essential academic resources and monitor their performance.

## 🌟 Key Features

- **Course Materials**: Access notes, video lectures, and other educational resources directly from the app.
- **Chat Functionality**: Interact with teachers for instant support and guidance.
- **Attendance Tracking**: Monitor attendance percentage and stay on top of your academic progress.
- **Performance Tracking**: Stay informed of your performance with detailed marks and achievements.

## 🎯 Why Edu Link?

Edu Link aims to simplify the academic journey for students by providing a centralized platform that brings together critical academic resources, real-time communication, and performance insights. With a clean and modern interface, Edu Link empowers students to manage their academic life efficiently, fostering engagement and enhancing the learning experience.

## 🛠️ Tech Stack

Edu Link is built using **Flutter** for seamless cross-platform support, enabling the app to run smoothly on both iOS and Android devices.

### Backend

- **Firestore**: Manages real-time data synchronization, ensuring students and teachers have up-to-date information.

## 🚀 Getting Started

To get Edu Link running on your local device, follow these steps:

1. Clone the repository:

    ```bash
    git clone https://github.com/Aniudupa15/edu_link.git
    ```

2. Navigate into the project directory:

    ```bash
    cd edu_link
    ```

3. Install dependencies:

    ```bash
    flutter pub get
    ```

4. Configure the Gemini API:

    - Go to Google AI Studio and create an API key for the Gemini AI integration.
    - Once you have the API key, create a `constants` folder in the `lib` directory if it doesn’t exist.
    - Inside the `constants` folder, create a new file named `api_keys.dart` and add your Gemini API key as follows:

    ```dart
    // constants/api_keys.dart
    const String GEMINI_API_KEY = 'your-gemini-api-key';
    ```

5. Run the app:

    ```bash
    flutter run
    ```

## 📱 Screenshots

| Home | Chat | Performance |
|------|------|-------------|
| Placeholder | Placeholder | Placeholder |

> Note: Screenshots are placeholders; replace them with actual images from your app.

## 📝 Roadmap

- Enhanced chat features
- Push notifications for new assignments and updates
- Integration with more academic resources
- Advanced performance analytics

## 👥 Contributing

We welcome contributions to Edu Link! If you'd like to collaborate, feel free to:

1. Fork the repository
2. Create a new branch
3. Make your changes
4. Submit a pull request

## 📄 License

Edu Link is licensed under the MIT License.
