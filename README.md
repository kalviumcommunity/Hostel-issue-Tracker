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

## Assignment: Responsive Mobile Interfaces

### Project Title
**Hostel Issue Tracker: Responsive Layout Demo**
This deliverable demonstrates how to construct adaptive layouts in Flutter. The goal is to ensure that the interface remains readable, interactive, and aesthetically pleasing whether viewed on a narrow phone screen or a wider tablet/desktop window, ensuring native-like experiences across form factors.

### Code Snippets
Here is how responsiveness was achieved using `MediaQuery` and `LayoutBuilder`:

**Using `MediaQuery`**
We query the actual dimensions of the screen layout to determine basic breakpoints.
```dart
// 2. Implement Responsiveness with MediaQuery
double screenWidth = MediaQuery.of(context).size.width;
bool isTablet = screenWidth > 600;
```

**Using `LayoutBuilder`**
We conditionally render entirely different layouts (`ListView` vs `GridView`) based on whether the device classifies as a tablet or a phone:
```dart
// 3. Apply Flexible and Adaptive Widgets using LayoutBuilder
body: LayoutBuilder(
  builder: (context, constraints) {
    if (isTablet) {
      // Displaying a two-column grid for tablets
      return _buildTabletLayout(context);
    } else {
      // Displaying a single-column layout for phones
      return _buildMobileLayout(context);
    }
  },
),
```

### Screenshots
*Note: Replace the placeholders below with the actual screenshots of your application.*

![Mobile Portrait Layout](<link_to_mobile_screenshot.png>)
*Figure 1: Single-column View on a Mobile Device*

![Tablet Landscape Layout](<link_to_tablet_screenshot.png>)
*Figure 2: Multi-column Grid View on a Tablet Device*

### Reflection
**Challenges Faced:** 
One of the main challenges of making the layout responsive was deciding the breakpoint at which a UI is no longer optimal as a single column. Ensuring that widgets like `Card` and `ListTile` don't stretch unnervingly on wide screens required switching entirely to a `GridView`, testing different `childAspectRatio` values to find the right balance between height and width for grid items.

**Impact on Usability:**
Responsive design profoundly improves real-world usability. A user accessing the Hostel tracker on a phone needs vertical, easily scrollable information. The same user on a desktop/tablet expects a denser layout utilizing the available horizontal space without wasting margins. Adaptive UI directly controls readability and interaction speed, making the application feel tailor-made for whatever device is being used.

## Assignment: Flutter Environment Setup & First App Run

### 1. Flutter Environment Setup and First App Run
This section verifies that the local development environment is correctly configured with the Flutter SDK, Android Studio, and a working Android Emulator.

### 2. Steps Followed
1. Downloaded and extracted the Flutter SDK.
2. Added the `flutter/bin` directory to the system PATH.
3. Installed Android Studio along with the Android SDK, Android SDK Platform, and Android Virtual Device (AVD) Manager.
4. Installed the Flutter and Dart plugins in Android Studio/VS Code.
5. Created a Pixel 6 Virtual Device running Android 13+ via AVD Manager.
6. Verified the installation and emulator connectivity using `flutter doctor` and `flutter devices`.
7. Created and ran a standard Flutter dummy project (`first_flutter_app`) to confirm the emulator and SDK are communicating perfectly.
8. Successfully ran the `Hostel Issue Tracker` application on the local emulator.

### 3. Setup Verification (Screenshots)

*Note: Replace the placeholders below with the actual screenshots of your environment.*

**Diagnostic Check**
![Flutter Doctor Output](<link_to_flutter_doctor_screenshot.png>)
*Figure 3: Output of `flutter doctor` verifying all necessary components are installed and green.*

**Emulator Run**
![Emulator Running App](<link_to_emulator_screenshot.png>)
*Figure 4: The Flutter application running successfully on the configured Android emulator.*

### 4. Reflection
**Challenges Faced during Installation:**
The most common challenges involve setting up the system PATH correctly to ensure the `flutter` command is recognized everywhere, and resolving licensing issues within Android Studio. Downloading the correct system images for the emulator can also be time-consuming depending on network speeds.

**Preparation for Real Apps:**
Having a stable, fully functional environment eliminates "it works on my machine" issues. The emulator allows rapid testing of UI changes across different emulated hardware configurations without needing a physical device for every test. Relying on `flutter doctor` ensures that any future dependencies or SDK updates can be verified quickly, keeping the development cycle smooth and predictable.

## Assignment: Flutter Project Folder Structure Exploration

### Project Setup Overview
The **Hostel Issue Tracker** project is initialized with a standard Flutter application structure, optimized for both Android and iOS cross-platform development. We've logically separated our Dart logic, utilized native folders for platform configurations, and set up a foundation ready to scale.

### Folder Structure Overview
The foundation of a maintainable app lies in its organization. Our project relies on several key directories:
*   `lib/`: The heart of the application containing all Dart code organized by UI screens, reusable widgets, and data models.
*   `pubspec.yaml`: The control center for all project dependencies and assets.
*   `android/` & `ios/`: The bridge folders that compile our Dart code into native mobile experiences.

For a comprehensive explanation of every folder and its specific role, please view the detailed [PROJECT_STRUCTURE.md](./PROJECT_STRUCTURE.md) file.

### Structure Screenshot
*Note: Replace the placeholder below with an actual screenshot of your IDE folder hierarchy.*

![Project Folder Hierarchy](<link_to_folder_screenshot.png>)
*Figure 5: The Hostel Issue Tracker folder tree as seen in the IDE.*

### Reflection on Structure

**Why is it important to understand the role of each folder?**
Understanding the folder roles is like knowing where the tools are in a workshop. It prevents developers from putting native Android configurations into cross-platform UI folders, or accidentally checking in unnecessary build artifacts. This knowledge speeds up development because you instantly know where to look to solve a specific problem—whether it's a UI bug (`lib/`) or a dependency issue (`pubspec.yaml`).

**How does a clean structure help when working in a team environment?**
A clean, modular structure (like separating `screens/` from `widgets/`) enables multiple developers to work on the same application concurrently with minimal merge conflicts. It establishes a consistent convention; a new team member doesn't need to ask where to put a new feature, as the established folder hierarchy dictates the organization organically.

## Assignment: Widget Tree & Reactive UI Model

### Project Title
**Hostel Issue Tracker: Reactive Demo App**
This section demonstrates how Flutter organizes the UI into a hierarchy of widgets (the Widget Tree) and showcases the reactive UI model where state changes efficiently and automatically trigger UI updates.

### Widget Tree Hierarchy
The demo screen `reactive_demo_screen.dart` is constructed using the following widget hierarchy:

```text
Scaffold
 ┣ AppBar
 │  ┗ Text (Title)
 ┗ Center
    ┗ Padding
       ┗ Column
          ┣ Card (Conditionally Visible)
          │  ┗ Padding
          │     ┗ Column
          │        ┣ Icon
          │        ┣ SizedBox
          │        ┗ Text (Count Display)
          ┣ SizedBox
          ┣ ElevatedButton.icon
          ┣ SizedBox
          ┗ OutlinedButton.icon
```

### State Updates Demonstration (Screenshots)

*Note: Replace the placeholders below with the actual screenshots of your application.*

**Initial UI State**
![Initial State](<link_to_initial_state_screenshot.png>)
*Figure 6: The initial state of the application before any interaction (Count: 0, Light Mode).*

**Updated UI State**
![Updated State](<link_to_updated_state_screenshot.png>)
*Figure 7: The updated state after clicking the 'Change State' button (Count: > 0, Dark Mode).*

### Reflection

**What is a widget tree?**
A widget tree is a hierarchical data structure in Flutter where each node represents a UI element (like a text box, button, or layout container). The tree describes the composition of the user interface, starting from the root app configuration down to the smallest visual components. Children widgets are nested within parent widgets, detailing exactly how the UI should be rendered on the screen.

**How does the reactive model work in Flutter?**
Flutter’s reactive model means that the UI is a direct reflection of application state. We do not explicitly tell a widget to redraw or modify its appearance directly (e.g., `textNode.setText("hello")`). Instead, we mutate the underlying state data by wrapping it in a `setState()` call. This function signals to the Flutter framework that internal data has changed, prompting the framework to automatically call the `build()` method again on that specific widget, generating a new, updated widget tree representation.

**Why does Flutter rebuild only parts of the tree and not the entire UI?**
Rebuilding the entire application UI 60+ times a second would be computationally expensive and drain the device battery. Flutter optimizes performance by using an intelligent diffing algorithm. When `setState()` is called on a specific widget (like our `_ReactiveDemoScreenState`), Flutter marks *only* that subtree as "dirty". During the next frame, it rapidly compares the new widget configuration (which is extremely lightweight) against the underlying "Element Tree". It then strategically updates only the final rendering "Render Objects" that actually experienced a change, leaving the rest of the application completely untouched. This selective rebuilding ensures buttery smooth 60/120 FPS performance even in highly dynamic apps.

## Assignment: Stateless vs Stateful Widgets Demo (Sprint 2)

### Project Title
**Hostel Issue Tracker: Stateless vs Stateful Interactive Demo**
This demo application showcases the fundamental differences between `StatelessWidget` and `StatefulWidget` in Flutter. The app features a static header combined with a highly interactive body that allows users to increment a counter and toggle between a light and dark theme context.

### Concept Explanations
*   **StatelessWidget**: A widget that does not require mutable state. Once built, it remains static until its parent rebuilds it. We use it for the `DemoHeader` because the title and text remain constant throughout the lifecycle of the screen.
*   **StatefulWidget**: A widget that maintains internal state which can change dynamically during the app's lifecycle. We use it for the `InteractiveArea` to react to button presses (counter) and switch toggles (theme changing), updating the UI visually in real-time.

### Code Snippets
**StatelessWidget Implementation**
```dart
class DemoHeader extends StatelessWidget {
  final String title;

  const DemoHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      // Container styling omitted for brevity
      child: Column(
        children: [
          const Icon(Icons.widgets, size: 48, color: Colors.deepPurple),
          Text(title),
          Text('This header is a StatelessWidget. It remains static.'),
        ],
      ),
    );
  }
}
```

**StatefulWidget Implementation**
```dart
class InteractiveArea extends StatefulWidget {
  const InteractiveArea({super.key});

  @override
  State<InteractiveArea> createState() => _InteractiveAreaState();
}

class _InteractiveAreaState extends State<InteractiveArea> {
  int _counter = 0;
  bool _isDarkMode = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _toggleTheme(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // The build method returns a Column with a Counter button and a Theme Switch.
    // They trigger `_incrementCounter` and `_toggleTheme`, updating the UI dynamically.
  }
}
```

### Screenshots and Video Demo
*Note: Replace the placeholders below with the actual screenshots and video reference.*

**Before Interaction**
![Before Interaction](<link_to_before_screenshot.png>)
*Figure 8: Initial state showing counter at 0 and Light Mode.*

**After Interaction**
![After Interaction](<link_to_after_screenshot.png>)
*Figure 9: Updated state showing incremented counter and Dark Mode.*

**Video Link:** [Link to Demo Video Here](<your_video_link>)

### Reflection
**How do Stateful widgets make Flutter apps dynamic?**
Stateful widgets bring apps to life by listening for data changes and user events. When `setState()` is called, Flutter is notified that the internal context has changed, and it triggers a partial UI rebuild. This allows the application to cleanly re-render forms, counters, or layout themes without needing an entire page refresh, making the app feel responsive and "live."

**Why is it important to separate static and reactive parts of the UI?**
Separating static UI elements (Stateless) from reactive components (Stateful) is crucial for performance and maintainability. It prevents Flutter from unnecessarily rebuilding components that don't need to change. By isolating the dynamic behaviors to smaller Stateful widgets, the framework can perform localized updates, leading to a much more efficient app while keeping our code well-structured.

## Assignment: Hot Reload & DevTools Demonstration (Sprint 2)

### Project Title
**Hostel Issue Tracker: Debugging workflow with DevTools**
This section demonstrates how to use Flutter’s Hot Reload, Debug Console, and DevTools Suite to speed up the development process, monitor state changes in real-time, and profile application performance. We use the existing `StatelessStatefulDemoScreen` to trace interactions.

### Step-by-Step Tool Usage

**1. Hot Reload Workflow**
*   **Action**: Ran the application via `flutter run` or the Start Debugging button in the IDE.
*   **Modification**: Changed a widget property in the codebase (e.g., changed the text `'Count: $_counter'` to `'Current Tally: $_counter'`).
*   **Result**: Saved the file. The UI updated instantaneously on the emulator preserving the current count (the state was not reset to 0).

**2. Debug Console Usage**
*   **Action**: Added a `debugPrint('Counter updated to $_counter');` statement inside the `setState` block of the `_incrementCounter` function.
*   **Trigger**: Clicked the "Increase" button on the running app.
*   **Result**: Observed the precise, formatted log message appearing immediately in the IDE’s Debug Console, proving the internal state updated successfully before the UI rebuilt.

**3. Flutter DevTools Inspector**
*   **Action**: Opened Flutter DevTools from the IDE (via the magnifying glass icon or command palette).
*   **Feature Used**: Clicked on the **Widget Inspector** tab.
*   **Result**: Explored the live widget tree. Used the "Select Widget Mode" to click on the screen and instantly highlight the corresponding code and widget properties in the inspector, validating layout constraints and padding visibly.

### Screenshots and Video Demo
*Note: Replace the placeholders below with the actual screenshots and video reference.*

**Hot Reload in Action**
![Hot Reload Update](<link_to_hot_reload_screenshot.png>)
*Figure 10: App displaying immediate UI textual updates after a file save.*

**Debug Console Logging**
![Debug Console](<link_to_debug_console_screenshot.png>)
*Figure 11: The IDE console showing the `debugPrint` output triggered by button presses.*

**DevTools Widget Inspector**
![DevTools Inspector](<link_to_devtools_screenshot.png>)
*Figure 12: Flutter DevTools identifying the layout constraints of the interactive column.*

**Video Link:** [Link to Demo Video Here](<your_video_link>)

### Reflection
**How does Hot Reload improve productivity?**
Hot Reload fundamentally changes the development cycle. Instead of waiting minutes for an application to recompile and launch just to see if a padding adjustment or color tweak looks correct, Hot Reload injects the updated source code directly into the running Dart Virtual Machine in milliseconds. It preserves the current execution state (like user navigation or form inputs), allowing developers to iterate on UI designs instantly and maintain their train of thought.

**Why is DevTools useful for debugging and optimization?**
While `print` statements are fine for simple variable tracking, DevTools provides a forensic view of the entire application structure. The Widget Inspector visually exposes *why* a widget might be overflowing its bounds or ignoring alignment commands. The Performance and Memory tabs are irreplaceable for diagnosing janky animations (identifying frames taking >16ms) or finding memory leaks (like failing to dispose of controllers), moving debugging from guesswork to precision analysis.

**How can you use these tools in a team development workflow?**
In a team context, DevTools establishes a common, objective ground for finding bugs. If a QA engineer reports a UI glitch on a specific device, a developer can run DevTools to inspect exactly how the layout constraints are being calculated for that screen size. Furthermore, using `debugPrint` ensures that logs are clean and not dropped by internal Android/iOS loggers (unlike standard `print`). Teams can mandate checking the Performance tab before a PR is merged to guarantee new features do not degrade the app's framerate.

## Assignment: Multi-Screen Navigation (Sprint 2)

### Project Title
**Hostel Issue Tracker: Profile Routing**
This implementation demonstrates the use of Flutter's `Navigator` class to handle multi-screen transitions using Named Routes. The app now features a structured routing mapped from `main.dart`, connecting the Dashboard to a new dynamically built `ProfileScreen` by passing contextual arguments.

### Code Snippets

**1. Defining Named Routes (`main.dart`)**
We replaced the static `home` property with a routing map. This allows for clean URLs internally and decouples screen definitions.
```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthGate(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
```

**2. Pushing a Route from Home (`home_screen.dart`)**
On the dashboard, we use an `IconButton` to trigger the navigation forward while passing necessary strings to the destination.
```dart
IconButton(
  onPressed: () {
    Navigator.pushNamed(context, '/profile', arguments: 'Hostel Resident');
  },
  icon: const Icon(Icons.person),
  tooltip: 'Profile',
),
```

**3. Receiving Data and Popping (`profile_screen.dart`)**
The Profile screen inherently lacks state, but uses `ModalRoute` to fetch the passed argument instantly as the screen is built. A programmatic back button calls `pop`.
```dart
@override
Widget build(BuildContext context) {
  final args = ModalRoute.of(context)?.settings.arguments as String?;
  final roleText = args ?? 'Unknown Role';
  
  // Scaffold implementation with styling omitted...
  
  ElevatedButton.icon(
    onPressed: () {
      Navigator.pop(context);
    },
    icon: const Icon(Icons.arrow_back),
    label: const Text('Return to Dashboard'),
  )
}
```

### Screenshots and Video Demo
*Note: Replace the placeholders below with actual project media.*

**Dashboard (Home Screen)**
![Home Screen](<link_to_home_screen_screenshot.png>)
*Figure 13: Dashboard with the new Profile navigation icon in the top right.*

**Profile Screen**
![Profile Screen](<link_to_profile_screen_screenshot.png>)
*Figure 14: Profile page successfully displaying the 'Hostel Resident' argument and a return button.*

**Video Link:** [Link to Navigation Demo Video](<your_video_link>)

### Reflection
**How does Navigator manage the app’s stack of screens?**
The Flutter `Navigator` operates as a Last-In, First-Out (LIFO) stack overlay. When a user is on the HomeScreen, the stack contains `[/, /home]`. Calling `Navigator.push()` places the new `ProfileScreen` precisely on top of the old screen without destroying the old one `[/, /home, /profile]`. This preserves the scroll positions and state of the Home layer beneath. Calling `Navigator.pop()` simply destroys the top layer, instantly displaying the cached Home layer exactly as it was left.

**What are the benefits of using named routes in larger applications?**
Named routes drastically simplify code maintenance as an app scales. Instead of manually importing the `ProfileScreen` file into 10 different unrelated UI files just to perform a `MaterialPageRoute` build, named routes centralize the destination logic in `main.dart`. UI layers only need to know a simple string `'/profile'` to jump anywhere in the app. This is crucial for deep linking (e.g., clicking a push notification), modular design, keeping compilation fast, and cleanly integrating with sophisticated analytical packages.

## Assignment: Responsive Layout Design (Sprint 2)

### Project Title
**Hostel Issue Tracker: Responsive Core Layouts**
This implementation demonstrates how to build a flexible Dashboard layout utilizing Flutter's core structural widgets: `Container`, `Row`, `Column`, alongside dynamic constraints like `Expanded` and `MediaQuery`. The screen detects the device width to render either a vertically scrollable stack (for phones) or a sophisticated multi-panel Row (for tablets and desktops).

### Code Snippets

**1. Using Containers for Styling and Boundaries**
`Container` widgets are used as customizable boxes. Here, we define a header with specific height, colors, and rounded borders.
```dart
Container(
  width: double.infinity,
  height: 150,
  decoration: BoxDecoration(
    color: Theme.of(context).colorScheme.primaryContainer,
    borderRadius: BorderRadius.circular(16),
  ),
  child: Center(
    child: Text('Header Section'),
  ),
)
```

**2. Assembling Rows and Columns with Expanded**
`Expanded` forces children to consume remaining space. In the Tablet view, we use a `Row` to align two `Expanded` panels side-by-side using `flex` values (2:1 ratio). In the Mobile view, we switch to a `Column` to stack them vertically.
```dart
// Tablet View snippet (Row)
Row(
  children: [
    Expanded(flex: 2, child: Container(color: Colors.blue)),
    const SizedBox(width: 16),
    Expanded(flex: 1, child: Container(color: Colors.green)),
  ],
)

// Mobile View snippet (Column)
Column(
  children: [
    Expanded(child: Container(color: Colors.blue)),
    const SizedBox(height: 16),
    Expanded(child: Container(color: Colors.green)),
  ],
)
```

**3. Injecting MediaQuery for Responsiveness**
We query the device's width natively. If it crosses the 600px breakpoint, we render the `Row` function; otherwise, we render the `Column` layout.
```dart
@override
Widget build(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  bool isWideScreen = screenWidth > 600;

  return Scaffold(
    body: Column(
      children: [
        HeaderContainer(),
        Expanded(
          child: isWideScreen ? _buildWideLayout() : _buildNarrowLayout(),
        ),
      ],
    ),
  );
}
```

### Screenshots and Video Demo
*Note: Replace the placeholders below with actual project media.*

**Mobile Screen (Portrait / Narrow)**
![Mobile Layout](<link_to_mobile_responsive_screenshot.png>)
*Figure 15: The app stacking all containers vertically gracefully on a narrow phone screen.*

**Tablet Screen (Landscape / Wide)**
![Tablet Layout](<link_to_tablet_responsive_screenshot.png>)
*Figure 16: The app detecting a wide display and reorienting the panels into side-by-side Columns.*

**Video Link:** [Link to Responsive Demo Video](<your_video_link>)

### Reflection
**Why is responsiveness important in mobile apps?**
Responsiveness ensures the application remains universally accessible and professional regardless of the user's hardware. With the fragmented screen ecosystem (small phones, folding phones, tablets, and desktops), hard-coding pixel sizes guarantees an app will look broken (overflow errors) on some devices and comically sparse on others. Responsive design maximizes readability and interaction efficiency based natively on available space.

**What challenges did you face while managing layout proportions?**
The main challenge was handling constraints inside nested widgets. For example, placing a `Container` inside an unbounded `Column` without wrapping it in an `Expanded` widget leads to layout exceptions. Learning when to use specific fixed heights versus relative flexible `flex` values required mental mapping to visualize how Flutter’s layout engine negotiates space from parent to child.

**How can you improve your layout for different screen orientations?**
Beyond `MediaQuery` width checks, layouts can be improved by wrapping crucial scrolling elements in `SafeArea` to prevent notches and system menus from clipping text. Furthermore, using `LayoutBuilder` instead of relying completely on global `MediaQuery` helps widgets define their structure based strictly on the bounds given by their direct parent, allowing responsive components to be reused anywhere in the app regardless of where they are placed.

## Assignment: Scrollable Views with ListView & GridView (Sprint 2)

### Project Title
**Hostel Issue Tracker: Scrollable Data Sets**
This section demonstrates how to build responsive, scrollable interfaces optimized for larger datasets using Flutter's `ListView.builder` and `GridView.builder`. We combined a horizontal scrolling list and a vertical grid into a master `SingleChildScrollView` to build a complex, unified scrolling screen reminiscent of modern application dashboards.

### Code Snippets

**1. Using ListView.builder for Horizontal Categories**
We bind `scrollDirection: Axis.horizontal` to create a swipable carousel of category cards. A fixed-height `SizedBox` constrains it.
```dart
SizedBox(
  height: 160,
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: 10,
    itemBuilder: (context, index) {
      return Container(
        width: 140,
        // Container styling and Column children...
        child: Text('Category ${index + 1}'),
      );
    },
  ),
)
```

**2. Assembling GridView.builder for Dense Data**
We generate a 2-column grid using `SliverGridDelegateWithFixedCrossAxisCount`. To prevent scrolling conflicts with the parent `SingleChildScrollView`, we disable its internal physics and force it to wrap its contents fully.
```dart
GridView.builder(
  physics: const NeverScrollableScrollPhysics(), // Defers scrolling to the parent
  shrinkWrap: true, // Forces the GridView to calculate its full height
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 16,
    mainAxisSpacing: 16,
  ),
  itemCount: 12,
  itemBuilder: (context, index) {
    return Container(
      // Styling...
      child: Center(child: Text('Grid Item ${index + 1}')),
    );
  },
)
```

### Screenshots and Video Demo
*Note: Replace the placeholders below with actual project media.*

**ListView (Horizontal Scroll)**
![ListView Snapshot](<link_to_listview_screenshot.png>)
*Figure 17: The top section featuring horizontally scrollable category cards.*

**GridView (Vertical Scroll)**
![GridView Snapshot](<link_to_gridview_screenshot.png>)
*Figure 18: The bottom section featuring the 2-column vertical grid nested gracefully down the page.*

**Video Link:** [Link to Scrolling Demo Video](<your_video_link>)

### Reflection
**How do ListView and GridView improve UI efficiency?**
Instead of attempting to squeeze infinite elements into a rigid screen or building complex constraint negotiations manually, `ListView` and `GridView` natively handle infinite overflow gracefully by providing high-performance scrollable viewports. They organize data strictly into rows or columns/tiles, enforcing visual consistency effortlessly across any aspect ratio.

**Why is using builder constructors (ListView.builder, GridView.builder) recommended for large data sets?**
Standard `ListView()` requires you to initialize and load every single widget inside its children array immediately, even if they are far off-screen. This is devastating to memory and startup times for lists with hundreds of items. 
The `.builder()` constructor fixes this by implementing lazy loading. It acts as an infinite callback, only requesting Flutter to allocate memory and render a widget *exactly* when the user scrolls near that specific `index`. Once a widget scrolls entirely off-screen, it is destroyed to reclaim memory, allowing lists of 10,000 items to run incredibly smoothly on weak hardware.

**What are common performance pitfalls to avoid with scrolling views?**
The most severe pitfall is nested scrolling conflicts resulting in massive layout sweeps—specifically, nesting a `ListView` inside an unbounded `Column` throws unbounded height exceptions. To fix this, developers often use `shrinkWrap: true` on the inner list view. However, applying `shrinkWrap` to a list that possesses hundreds of items nullifies the `.builder` memory optimizations, as it forces the list to render everything instantly just to calculate its total height! True high-performance scrolling applications heavily rely on Slivers (`CustomScrollView`, `SliverList`) to coordinate multi-axis and heterogeneous scrollable content cleanly without `shrinkWrap`.
