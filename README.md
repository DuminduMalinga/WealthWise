# 💰 WealthWise

> A smart personal finance management app built with Flutter & Firebase — track income, manage expenses, plan budgets, set goals, and monitor investments all in one place.

---

## ✨ Features

- 🔐 **Authentication** — Secure Sign Up & Login with Firebase Auth
- 📊 **Dashboard** — At-a-glance overview of your financial health
- 💵 **Income Tracking** — Log and categorize all your income sources
- 💸 **Expense Tracking** — Record and monitor your spending habits
- 📅 **Budget Management** — Set monthly budgets and track usage
- 🎯 **Goal Setting** — Define and track financial savings goals
- 📈 **Investments** — Keep tabs on your investment portfolio
- 🤝 **Meetings** — Schedule and manage financial advisor meetings
- 👤 **Profile** — Manage your personal account information

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Framework | [Flutter](https://flutter.dev/) (Dart) |
| Backend | [Firebase](https://firebase.google.com/) |
| Authentication | Firebase Auth |
| Database | Cloud Firestore |
| UI | Material Design 3 |
| Fonts | Poppins, Google Fonts |
| Icons | Font Awesome Flutter, Community Material Icons |

---

## 📦 Dependencies

```yaml
firebase_core: ^2.27.0
firebase_auth: ^4.17.0
cloud_firestore: ^4.14.0
google_fonts: ^6.1.0
font_awesome_flutter: ^10.7.0
community_material_icon: ^5.4.55
image_picker: ^0.8.7+4
intl: ^0.18.0
```

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Dart SDK `^3.8.1`)
- A Firebase project with **Authentication** and **Firestore** enabled
- Android Studio / VS Code with Flutter & Dart plugins

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/DuminduMalinga/WealthWise.git
   cd WealthWise
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com)
   - Enable **Email/Password** authentication
   - Enable **Cloud Firestore**
   - Download `google-services.json` (Android) and/or `GoogleService-Info.plist` (iOS) and place them in the appropriate directories

4. **Run the app**
   ```bash
   flutter run
   ```

---

## 📁 Project Structure

```
lib/
├── main.dart                  # App entry point & Firebase initialization
├── screens/
│   ├── Login_screen.dart      # User login
│   ├── Signup_screen.dart     # User registration
│   ├── Home_screen.dart       # App shell / navigation
│   ├── Dashboard_screen.dart  # Financial overview dashboard
│   ├── Income_screen.dart     # Income tracking
│   ├── Expence_screen.dart    # Expense tracking
│   ├── Budget_screen.dart     # Budget management
│   ├── Goal_screen.dart       # Savings goals
│   ├── Investments_screen.dart# Investment portfolio
│   ├── Meetings_screen.dart   # Meeting scheduler
│   └── Profile_screen.dart    # User profile
├── Images/                    # Image assets
├── fonts/                     # Custom font files (Poppins)
└── icons/                     # Icon assets
```

---

## 📱 Supported Platforms

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

---

## 🤝 Contributing

Contributions are welcome! Feel free to open an issue or submit a pull request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is open source. See the repository for license details.

---

<p align="center">Built with ❤️ using Flutter & Firebase</p>
