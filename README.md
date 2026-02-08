# 🌐 Unibuy - Multi-Platform Flutter Application

Unibuy is a scalable Flutter application designed to provide **unique and native-feeling experiences** across Android, iOS, and Web platforms.

Instead of a "write once, run everywhere" approach that compromises on platform-specific UX, Unibuy embraces a **platform-adaptive UI architecture**. While the core business logic remains shared, the presentation layer is tailored to respect the design guidelines of each platform (Material You for Android, Cupertino for iOS, and a responsive layout for Web).

---

## 🚀 Key Features

- **Multi-Platform Support**: Dedicated UI implementations for Android, iOS, and Web.
- **Platform-Adaptive Design**: 
  - **Android**: Material Design 3 (Material You)
  - **iOS**: Cupertino (Human Interface Guidelines)
  - **Web**: Responsive, desktop-optimized layout
- **Theming**: Full support for **Dark Mode** and **Light Mode** across all platforms.
- **Robust Routing**: Powered by `go_router` for deep linking and seamless navigation.

---

## 📂 Project Structure

The project structure is designed to separate platform-specific UI code while sharing core logic.

```
lib/
├── core/                   # App-wide core utilities, constants, and config
├── data/                   # Data layer (Repositories, DTOs, Data Sources)
├── domain/                 # Business logic (Entities, Use Cases)
├── ui/                     # 🎨 The Presentation Layer
│   ├── android/            # Android-specific Screens & Widgets
│   ├── ios/                # iOS-specific Screens & Widgets
│   ├── web/                # Web-specific Screens & Widgets
│   └── shared/             # (Optional) Widgets shared across platforms
├── routes/                 # Navigation configuration (go_router)
└── main.dart               # App entry point
```

### 🔀 Routing Strategy

We use [`go_router`](https://pub.dev/packages/go_router) to handle navigation. The router is aware of the current platform and dynamically renders the appropriate screen version (Android, iOS, or Web) for a given route, ensuring users always see the UI intended for their device.

---

## 🛠️ Tech Stack

- **Framework**: Flutter
- **Language**: Dart
- **Routing**: go_router
- **State Management**: [Riverpod](https://riverpod.dev/)
- **Dependency Injection**: [GetIt](https://pub.dev/packages/get_it)

---

## 🏃‍♂️ How to Run

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/yourusername/unibuy.git
    cd unibuy
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Run on Android:**
    ```bash
    flutter run -d android
    ```

4.  **Run on iOS:**
    ```bash
    flutter run -d ios
    ```

5.  **Run on Web:**
    ```bash
    flutter run -d chrome
    ```

---

## 🤝 Contributing

Contributions are welcome! Please follow the project's code style and ensure you test your changes on all supported platforms.
