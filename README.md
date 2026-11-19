# Islami 🕌

**Islami** is a Flutter-based Islamic mobile application designed to bring essential daily Islamic features together in one place. It provides prayer times, prayer reminders, Quran radio stations, reciters, and Azkar.

## ✨ Features

- **Prayer Times:** Fetches daily prayer timings using the Aladhan API.
- **Next Prayer Countdown:** A live countdown that updates every second.
- **Prayer Notifications:** Local notifications for prayer times.
- **Adhan Settings:** Customize prayer reminders and Adhan sound preferences.
- **Quran Radio:** Browse and listen to Arabic Quran radio stations.
- **Quran Reciters:** Explore available Quran reciters.
- **Audio Controls:** Play, pause, mute, and unmute audio.
- **Morning & Evening Azkar:** Data models for organizing daily Azkar content.
- **Persistent Settings:** Saves user preferences locally.

## 🛠️ Tech Stack

| Technology | Purpose |
|---|---|
| Flutter & Dart | Cross-platform mobile development |
| BLoC / Cubit | State management |
| Dio | REST API integration |
| Repository Pattern | Data layer organization |
| AudioPlayers | Audio playback |
| Flutter Local Notifications | Prayer reminders |
| SharedPreferences | Local data persistence |
| Timezone | Timezone-aware notification scheduling |
| Google Fonts | Typography |
| Flutter SVG | SVG asset rendering |

## 🏗️ Architecture

The application follows a feature-based structure and uses the Repository Pattern to separate data access from business logic.

- **Presentation Layer:** Flutter UI, Cubits, and States.
- **Data Layer:** Models, remote data sources, and repositories.
- **Core Layer:** Shared services, notification handling, and application utilities.

## 🌐 APIs

- [Aladhan API](https://aladhan.com/prayer-times-api) – Prayer timings.
- Quran Radio and Reciters endpoints – Audio content.

## 🚀 Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK compatible with the project's `pubspec.yaml`

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/Yousef0Salah/Islami.git
   ```

2. Navigate to the project directory:

   ```bash
   cd Islami
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Run the application:

   ```bash
   flutter run
   ```

## 📁 Project Structure

```text
lib/
├── core/
│   ├── service/
│   ├── theme/
│   └── ...
└── modules/
    ├── time/
    ├── radio/
    └── data/
```

## 📚 Key Learning Outcomes

Through this project, I practiced:

- Building modular Flutter applications.
- Managing application state using BLoC and Cubit.
- Integrating REST APIs using Dio.
- Applying the Repository Pattern.
- Implementing audio playback controls.
- Scheduling local notifications with timezone support.
- Managing asynchronous operations and time-based logic.

## 🎥 App Demo

*Video demo coming soon.*

## 👨‍💻 Developer

**Yousef Maarouf**

[GitHub Repository](https://github.com/Yousef0Salah/Islami)

---

*Built with Flutter 💙*
