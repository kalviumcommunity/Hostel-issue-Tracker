# Hostel Issue Tracker - Sprint 2

## Project Overview
This project is a mobile application for tracking hostel issues, built with Flutter and Firebase.
This repository contains the source code for the "Sprint 2" assignment and initial project setup.

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
3.  Run `flutter run` to launch on an emulator or connected device.
