# Flutter Project Folder Structure

Welcome to the overview of the Flutter project structure. This document explains the purpose of the essential folders and files that Flutter automatically generates, helping you understand how to organize code, manage assets, and maintain scalability.

## 📁 Folder Hierarchy Diagram

```text
hostel_issue_tracker/
├── android/            # Android-specific build and configuration files
├── assets/             # (Optional) Images, fonts, and static files
├── ios/                # iOS-specific build and configuration files
├── lib/                # Core Dart code and application logic
│   ├── main.dart       # Entry point of the app
│   ├── models/         # Data models
│   ├── screens/        # Full-page UI widgets
│   └── widgets/        # Reusable UI components
├── test/               # Automated test files
├── .gitignore          # Git exclusion rules
├── pubspec.yaml        # Project configuration and dependencies
└── README.md           # Project documentation
```

## 📂 Key Folders & Files Explained

| Folder / File | Purpose | Key Details |
| :--- | :--- | :--- |
| **`lib/`** | The most important folder. It contains all the Dart code that forms the logic and UI of the application. | Inside, `main.dart` is the starting point. We organize this into subfolders like `screens`, `widgets`, `models`, and `services` to keep the codebase modular. |
| **`android/`** | Contains configuration files and native build settings specifically for the Android version of the app. | Key file: `android/app/build.gradle` defines the app version, name, and native dependencies. |
| **`ios/`** | Contains configuration files and native build settings specifically for the iOS version of the app (used by Xcode). | Key file: `ios/Runner/Info.plist` defines app permissions and metadata for iOS devices. |
| **`assets/`** | A developer-created folder used to store static resources like images, custom fonts, and JSON files. | These must be explicitly declared in the `pubspec.yaml` file to be bundled with the app. |
| **`test/`** | Designed to hold all automated tests (unit, widget, and integration tests) to ensure code reliability. | `widget_test.dart` is the default file provided to test basic UI rendering and interactions. |
| **`pubspec.yaml`** | The central configuration file for the Flutter project. | It manages all external package dependencies, local asset declarations, fonts, and SDK version constraints. |
| **`.gitignore`** | Tells Git which files and folders to ignore when committing to version control. | Prevents build artifacts (like the `build/` folder) and IDE settings from bloating the repository. |
| **`README.md`** | Documentation outlining what the project is, how to run it, and developer notes. | Crucial for onboarding new developers to the repository. |

## 🧠 Reflection: Scalability & Teamwork

Understanding and adhering to this folder structure is important for several reasons:

1.  **Scalability**: Placing all code inside `lib/` without structure quickly leads to a "spaghetti codebase." By separating features into logical directories (`screens/`, `services/`, etc.), adding a new feature months later remains straightforward without stepping on existing code.
2.  **Team Environment**: A predictable structure acts as a common language among developers. When a teammate needs to update a button's style, they immediately know to check `lib/widgets/`. It reduces the friction of onboarding and minimizes merge conflicts, as developers work in isolated, well-defined areas of the project.
3.  **Cross-Platform Clarity**: Clearly separating the Dart logic (`lib/`) from platform-specific native configurations (`android/` and `ios/`) makes it easier to troubleshoot platform-specific deployment bugs without accidentally modifying the shared UI logic.
