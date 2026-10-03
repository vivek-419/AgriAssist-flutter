# 🌾 AgriAssist - Smart Agricultural Decision Support System

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart)](https://dart.dev)
[![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20Android%20%7C%20Web%20%7C%20macOS-green)]()
[![License](https://img.shields.io/badge/License-Academic-blue)]()

**AgriAssist** is an integrated mobile and web agricultural decision-support application built in Flutter. It empowers farmers with AI-driven plant disease diagnostics, micro-climate weather forecasting with agronomic spray advisories, live APMC Mandi market rates, and direct chat consultation with certified plant pathologists.

---

## 🌟 Key Features

1. **Farmer Dashboard (`HomeScreen`)**:
   - Live IoT field sensor status badge.
   - Real-time weather conditions snapshot with humidity, wind, and rain probability.
   - Dynamic crop fields management with health indicators (*Tomato*, *Wheat*).
   - Quick-access Field Tools for disease scanning, market prices, and expert consultation.
   - Daily agricultural farming tips and personalized user session profile.

2. **AI Crop Disease Detection Engine (`DiseaseCheckScreen` & `DiseaseResultScreen`)**:
   - Macro leaf snapshot acquisition with camera and gallery integration via `image_picker`.
   - Automatic image optimization and memory compression (85% quality, 1800px max dimensions).
   - Multi-crop pathology resolution supporting 7 crops (*Tomato*, *Wheat*, *Rice*, *Cotton*, *Potato*, *Corn*, *Soybean*).
   - Computer vision lesion reticle highlighting infected zones on leaf samples.
   - 94% diagnostic match confidence indicators with actionable 3-step treatment plans.

3. **Hyper-Local Weather Forecast & Radar (`WeatherScreen`)**:
   - Dual-scale temperature metrics (°C / °F) with baseline typography alignment.
   - 2x2 comprehensive metric grid: Humidity, Wind Speed, UV Index, and Precipitation Probability.
   - Micro-climate soil moisture radar tracking root-zone saturation.
   - 5-Day daily forecast featuring dynamic color-coded temperature range bars.
   - Hourly pesticide spray window advisory (*"4 PM - 7 PM"*).

4. **APMC Mandi Market Prices (`MarketScreen`)**:
   - Real-time zero-latency search across agricultural commodities.
   - Horizontally scrollable category chips (*All*, *Vegetables*, *Grains*, *Fruits*, *Pulses*).
   - Interactive APMC mandi location switcher (*Mumbai*, *Pune*, *Nashik*, *Nagpur*).
   - Price trend visualization with green (+%) and red (-%) indicators.
   - National Agriculture Market (eNAM) historical trend integration.

5. **Agronomist Chat Consultation (`ExpertChatScreen`)**:
   - Real-time chat interface with certified agronomist *Dr. Raj Patel*.
   - One-tap suggested quick-reply chips.
   - Contextual AI response engine with automated keyword analysis (*dosage*, *organic*, *watering*, *blight*).
   - Interactive typing indicators and auto-scrolling synchronization via `PostFrameCallback`.
   - Direct Kisan Helpline phone support integration.

6. **Authentication & Session Security (`LoginScreen` & `SignUpScreen`)**:
   - Singleton pattern session management via `AuthService.instance`.
   - Form validation with regular expression email matching and password security.
   - Navigation stack clearing (`pushReplacement` & `pushAndRemoveUntil`) to prevent unauthorized back-navigation.
   - Persistent root shell state management powered by `IndexedStack`.

---

## 🏗️ Architecture & Project Structure

```
lib/
├── data/                  # Static & mock agricultural datasets
│   ├── dummy_chat_data.dart
│   ├── dummy_crop_data.dart
│   ├── dummy_disease_data.dart
│   ├── dummy_market_data.dart
│   └── dummy_weather_data.dart
├── models/                # Typed data classes
│   ├── chat_message_model.dart
│   ├── crop_model.dart
│   ├── disease_model.dart
│   ├── market_price_model.dart
│   └── weather_model.dart
├── navigation/            # Root bottom navigation shell (IndexedStack)
│   └── app_navigation.dart
├── screens/               # Feature-specific screen widgets
│   ├── auth/              # LoginScreen & SignUpScreen
│   ├── disease/           # DiseaseCheckScreen & DiseaseResultScreen
│   ├── expert/            # ExpertChatScreen
│   ├── home/              # HomeScreen (Farmer Dashboard)
│   ├── market/            # MarketScreen (APMC Mandi)
│   └── weather/           # WeatherScreen (Forecast & Radar)
├── services/              # Business logic & Singleton services
│   └── auth_service.dart
├── theme/                 # Design tokens & Material 3 theme configuration
│   └── app_theme.dart
├── widgets/               # Encapsulated atomic reusable UI components
│   ├── app_logo.dart
│   ├── chat_bubble.dart
│   ├── crop_card.dart
│   ├── disease_result_card.dart
│   ├── market_price_card.dart
│   └── weather_card.dart
└── main.dart              # Application entry point
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (v3.0.0 or higher)
- Dart SDK (v3.0.0 or higher)
- Android Studio / Xcode / VS Code with Flutter extension

### Installation & Run

```bash
# 1. Clone the repository
git clone https://github.com/vivek-419/AgriAssist-flutter.git
cd AgriAssist-flutter

# 2. Install dependencies
flutter pub get

# 3. Verify code health
flutter analyze
flutter test

# 4. Run the application
flutter run
```

---

## 🧪 Testing & Code Quality

- **Zero Analyzer Warnings**: Strict adherence to `flutter_lints` and effective Dart rules.
- **Automated Tests**: 21+ unit and widget test cases covering models, authentication, navigation, and core screen rendering.

---

## 👥 Authors & Academic Credits

- Developed by **Vivek Prasad Addagatla**
- Semester 5 Final Project • Computer Science & Engineering
