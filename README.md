# Hostel Issue Tracker - Sprint 2

## Project Overview
This project is a mobile application for tracking hostel issues, built with Flutter and Firebase.
This repository contains the source code for the "Sprint 2" assignment and initial project setup.

## 📚 Project Documentation
- **API Documentation:** [Postman Collection (JSON)](docs/flutter_firebase_postman.json)
- **System Architecture:** [ARCHITECTURE.md](ARCHITECTURE.md)
- **Version:** 1.0.0
- **Last Updated:** 2025-11-13

---

## 💡 Reflection: Documentation & Versioning

### a. How API documentation improves collaboration and onboarding
Clear API documentation acts as a single source of truth for both frontend and backend developers. For a Flutter + Firebase project, it helps new team members understand which Firestore collections are being used, what the expected data shapes are, and how authentication is handled without needing to dive deep into the source code or the Firebase Console. This significantly reduces onboarding time and prevents integration errors during development.

### b. How versioning and metadata help maintain long-term consistency
Versioning and metadata (like base URLs and update dates) provide historical context for the project's evolution. As the app grows and the database schema or auth requirements change, versioning allows teams to track which version of the client app works with which API structure. Metadata ensures that everyone is pointing to the correct environment (production vs. staging), preventing accidental data corruption or service outages during environment transitions.

---

## Assignment: Flutter Architecture & Dart Essentials

### 1. StatelessWidget vs StatefulWidget
*   **StatelessWidget**: Used for static UI elements that do not change over time once built. They depend only on the configuration info (arguments) passed to them.
    *   *Example*: Labels (`Text`), Icons (`Icon`), distinct layout containers.
    *   *Code:* `class MyLabel extends StatelessWidget { ... }`

*   **StatefulWidget**: Used for dynamic UI elements that can change their appearance in response to events (user interactions, data arrival). They maintain a mutable `State` object that persists across rebuilds.
    *   *Example*: Counters, Form inputs, Checkboxes, Animations.
    *   *Code:* `class MyCounter extends StatefulWidget { ... }` coupled with `class _MyCounterState extends State<MyCounter> { ... }`

### 2. The Widget Tree & Reactive UI
Flutter models the entire UI as a tree of Widgets.
*   **Composition**: Complex widgets are built by composing simpler widgets (e.g., a `Scaffold` contains an `AppBar` and a `Body`).
*   **Reactive Rendering**: When the state of a widget changes (e.g., `setState()` is called), Flutter marks that widget as "dirty".
*   **Efficient Updates**: The framework re-renders *only* the dirty widgets and their children to the screen, rather than re-drawing the entire application. This "diffing" process against the Element Tree ensures high performance (60/120 FPS).

### 3. Why Dart is Ideal for Flutter
*   **JIT & AOT Compilation**: Dart supports Just-In-Time (JIT) compilation for fast development (Hot Reload) and Ahead-Of-Time (AOT) compilation for high-performance production builds (ARM machine code).
*   **Optimized for UI**: The language syntax is designed for building component-style UIs (e.g., `if` logic inside lists/collections for conditional UI rendering).
*   **Sound Null Safety**: Prevents an entire class of common bugs (null reference exceptions) at compile time.
*   **Single Language**: No context switching between layout (XML/JSX) and logic; everything is Dart.

### 4. Demo App Notes
The `lib/main.dart` file contains a working implementation of a Reactive Counter App.
*   It uses a `StatefulWidget` to track the `_counter` variable.
*   Clicking the Floating Action Button triggers `setState()`.
*   The UI updates instantly to reflect the new number.

## Getting Started
To run this project (once Flutter SDK is installed):
1.  Navigate to this folder in a terminal.
2.  Run `flutter pub get` to install dependencies.
4.  Push to Github.

## Assignment: Firebase & Real-time Integration

### 1. Firebase Setup for Flutter
To run this application with Firebase features:
1.  **Create a Firebase Project**: Go to [console.firebase.google.com](https://console.firebase.google.com/).
2.  **Add Android/iOS App**: Register the app with package name `com.example.hostel_issue_tracker`.
3.  **Download Config**: Get `google-services.json` (Android) or `GoogleService-Info.plist` (iOS) and place them in the respective folders:
    *   `android/app/google-services.json`
    *   `ios/Runner/GoogleService-Info.plist`
4.  **FlutterFire Configuration**: Alternatively, run `flutterfire configure` in the terminal to automatically generate `lib/firebase_options.dart`.

### 2. Case Study: "The To-Do App That Wouldn't Sync"
**Scenario Analysis:**
Syncly faced issues with delayed updates, insecure sessions, and file storage. Here is how Firebase solves these:

*   **Authentication (Secure Sessions)**:
    *   *Problem*: Building secure login from scratch is complex and prone to vulnerabilities.
    *   *Firebase Solution*: `FirebaseAuth` handles token management, session persistence, and secure hashing automatically. In our app, we use `FirebaseAuth.instance.authStateChanges()` to listen to session state and redirect the user instantly between Login/Home screens.

*   **Cloud Firestore (Real-time Sync)**:
    *   *Problem*: Polling a database for changes causes delays and wastes bandwidth.
    *   *Firebase Solution*: Firestore uses listeners (WebSockets under the hood). When one user adds a task, Firestore pushes the change to all connected clients immediately.
    *   *Implementation*: We used `StreamBuilder` listening to `FirebaseFirestore.instance.collection('issues').snapshots()`. This ensures the UI rebuilds exactly when data changes, providing a "live" feel without a refresh button.

*   **Cloud Storage (Scalable Media)**:
    *   *Problem*: Handling large file uploads requires robust servers.
    *   *Firebase Solution*: Firebase Storage scales automatically to handle user-generated content (images/videos) securely.

### 3. How to Verify
1.  **Login**: Create an account using the "Sign Up" button.
2.  **Real-time Test**: Run the app on two different emulators. Add an issue on Device A; observe it appear instantly on Device B.
3.  **Persistance**: Restart the app; the user remains logged in and data persists.

## Assignment: Design to Code & Responsive UI

### 1. Design Thinking Process
*   **Empathize**: Students need a quick way to report issues without complicated forms.
*   **Define**: The problem is that current reporting is slow and opaque. The UI must be transparent and fast.
*   **Ideate & Prototype**:
    *   *Mobile*: A simple list view for quick scrolling.
    *   *Tablet/Desktop*: A dashboard grid view to see multiple issues at once.
*   **Translation**: We used Flutter's `LayoutBuilder` to switch between a `ListView` (Mobile) and `GridView` (Tablet).

### 2. Case Study: "The App That Looked Perfect, But Only on One Phone"
**Scenario Analysis:**
FlexiFit failed because they designed for a single screen size (fixed pixels).

*   **Responsive Strategy**:
    *   **MediaQuery**: Used to determine screen width and adjust the Login Container size (max width 400px on tablets) so it doesn't stretch weirdly.
    *   **LayoutBuilder**: Used in the `HomeScreen` to toggle between a standard `Scaffold` body and a `Row` with a `NavigationRail` for wider screens.
    *   **Flexible/Expanded**: Used `Expanded` inside the Row to ensure the content takes up remaining space without overflowing.

### 3. Verification
*   **Mobile**: Run on a phone emulator -> See a List View.
*   **Tablet**: Run on a tablet emulator (or resize window) -> See a Grid View with a Side Navigation Rail.
*   **Styling**: The app now uses a consistent Purple/Teal theme with rounded corners (`borderRadius: 12`) matching modern Material 3 design.

## Assignment: Flutter Basics & Folder Structure

### 1. Folder Structure
We have organized the code to be modular and scalable:
*   `lib/main.dart`: Entry point of the app. Initializes Firebase and theme, then launches `WelcomeScreen`.
*   `lib/screens/`: Contains all full-page UI widgets.
    *   `welcome_screen.dart`: The introductory landing page with a "Get Started" interaction.
    *   `login_screen.dart`: Handles User Auth (Sign In/Sign Up).
    *   `home_screen.dart`: The main dashboard for viewing and reporting issues.
*   `lib/widgets/`: (Future use) Reusable small UI components (e.g., custom buttons, cards).
*   `lib/models/`: (Future use) Data models for Issue, User, etc.

### 2. Demo & Reflection
**Features:**
*   **Welcome Screen**: Features a custom UI with an Image, Title, and an interactive Button.
*   **State Management**: clicking "Get Started" triggers a visual state change (button animation) before navigating.
*   **Navigation**: Seamless flow from Welcome -> Login -> Home.

**Reflection:**
Flutter's widget-based composition makes it easy to build complex UIs from simple building blocks. Dividing the app into `screens` and separate files keeps `main.dart` clean and makes the codebase easier to navigate as it grows.



