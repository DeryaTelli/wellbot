# Wellbot Chat App

Wellbot is a Flutter-based AI-powered coaching application that provides personalized conversations with different types of coaches such as Dietitian, Fitness Coach, Yoga Instructor, and Pilates Coach.

---

## App Preview


![Home Screen](https://canva.link/xwb2wf0lw5y2g8s)

---

## Features

* AI-powered chat (Firebase AI - Gemini)
* Chat history with conversation-based sessions
* Local data persistence using SQLite
* Dynamic system prompts via Firebase Remote Config
* Clean architecture using **Cubit (Bloc)**
* Multiple coach personas

---

## Getting Started

### 1. Clone the project

```
git clone https://github.com/YOUR_USERNAME/wellbot.git
cd wellbot
```

### 2. Install dependencies

```
flutter pub get
```

---

## Firebase Setup (IMPORTANT)

This project requires Firebase but configuration files are NOT included in this repository.

You need to add your own Firebase configuration:

### Required files (DO NOT commit these):

* `android/app/google-services.json`
* `ios/Runner/GoogleService-Info.plist`
* `lib/firebase_options.dart`

---

### Steps:

1. Go to Firebase Console
     https://console.firebase.google.com/

2. Create a new project

3. Add Android & iOS apps

4. Download config files:

   * Place `google-services.json` inside:

     ```
     android/app/
     ```
   * Place `GoogleService-Info.plist` inside:

     ```
     ios/Runner/
     ```

5. Generate firebase options:

```
flutterfire configure
```

---

## Remote Config Setup

Add the following parameters in Firebase Remote Config:

| Key                     | Value                                                                       |
| ----------------------- | --------------------------------------------------------------------------- |
| dietitian_system_prompt | You are a professional dietitian. Give practical nutrition advice.          |
| fitness_system_prompt   | You are an energetic fitness coach. Motivate the user and suggest workouts. |
| yoga_system_prompt      | You are a calm yoga instructor. Focus on breathing and mindfulness.         |
| pilates_system_prompt   | You are a pilates coach. Suggest safe and clear movements.                  |

---

## AI Integration

* Uses Firebase AI (Gemini)
* Chat responses are generated dynamically
* Each coach has a different system prompt

---

## Local Storage

* SQLite is used for storing:

  * Chat messages
  * Conversation history

---

## Notes

* Firebase config files are intentionally excluded (.gitignore)
* App will not run without Firebase setup
* AI responses depend on Firebase AI API access

---

