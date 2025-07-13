# 🧱 Scalable Flutter App Architecture

A clean, modular, and scalable Flutter project structure designed for medium to large applications. This template promotes separation of concerns, testability, and maintainability.

---

## 📂 Folder Structure

lib/
│
├── core/                   # App-wide core utilities and configurations
│   ├── constants/          # Constant values (colors, strings, etc.)
│   ├── services/           # Common services (e.g., API, local storage)
│   ├── exceptions/         # Custom exceptions
│   ├── utils/              # General-purpose helper functions
│   └── config/             # App-wide configuration (theme, env, etc.)
│
├── data/                   # Data layer (optional if using clean architecture)
│   ├── models/             # Plain data models (DTOs)
│   ├── datasources/        # Remote/local data sources
│   └── repositories/       # Repository implementations
│
├── domain/                 # Business logic (optional, for clean architecture)
│   ├── entities/           # Business models
│   ├── usecases/           # Application-specific logic
│   └── repositories/       # Abstract repository interfaces
│
├── presentation/           # UI layer
│   ├── routes/             # Navigation configuration
│   ├── widgets/            # Shared widgets across features
│   └── pages/              # Non-feature-specific screens
│
├── features/               # Modular features
│   ├── auth/               # Example feature: Authentication
│   │   ├── data/
│   │   ├── domain/
│   │   ├── presentation/
│   │   └── widgets/
│   │
│   ├── home/               # Example feature: Home screen
│   │   ├── data/
│   │   ├── domain/
│   │   ├── presentation/
│   │   └── widgets/
│   │
│   └── ...                 # Additional features
│
├── main.dart               # App entry point
└── injection.dart          # Dependency injection setup
