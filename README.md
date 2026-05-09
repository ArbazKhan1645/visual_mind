# VisualMind - AI-Powered Visual Memory Assistant

<div align="center">

![VisualMind Logo](https://img.shields.io/badge/VisualMind-AI%20Memory%20Assistant-blue?style=for-the-badge&logo=flutter&logoColor=white)
![Flutter](https://img.shields.io/badge/Flutter-3.11.5-02569B?style=flat-square&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.11.5-0175C2?style=flat-square&logo=dart&logoColor=white)
![Android](https://img.shields.io/badge/Android-Supported-3DDC84?style=flat-square&logo=android&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-Supported-000000?style=flat-square&logo=ios&logoColor=white)

**Transform your visual memories into intelligent, searchable knowledge with AI-powered recognition and organization.**

[📱 Download APK](#installation) • [🚀 Live Demo](#demo) • [📖 Documentation](#documentation) • [🐛 Report Issues](https://github.com/ArbazKhan1645/visual_mind/issues)

</div>

---

## 🌟 Overview

VisualMind is a cutting-edge Flutter application that revolutionizes how you capture, organize, and search through your visual memories. Powered by Google ML Kit's advanced AI capabilities, it automatically extracts text, detects objects, and labels images to create a smart, searchable database of your captured moments.

### ✨ Key Features

- **🧠 AI-Powered Recognition**
  - Advanced text recognition (OCR) with multi-language support
  - Intelligent object detection and labeling
  - Smart image classification and categorization

- **📸 Smart Capture**
  - Camera integration with real-time preview
  - Gallery image selection
  - Automatic image compression and optimization

- **🔍 Intelligent Search**
  - Semantic search across extracted text and labels
  - Hybrid search combining text and visual features
  - Relevance scoring and result ranking

- **📱 Modern UI/UX**
  - Beautiful, intuitive interface with smooth animations
  - Dark/light theme support
  - Responsive design for all screen sizes

- **💾 Local Storage**
  - SQLite database for offline functionality
  - Efficient data management and caching
  - Thumbnail generation and storage

## 🚀 Quick Start

### Prerequisites

- Flutter SDK (3.11.5 or higher)
- Dart SDK (3.11.5 or higher)
- Android Studio / VS Code
- Android device or emulator (API 21+)
- iOS device or simulator (iOS 11+)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/ArbazKhan1645/visual_mind
   cd visualmind
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Build Release APK

```bash
flutter build apk --release
```

The APK will be available at `build/app/outputs/flutter-apk/app-release.apk`

## 📱 Screenshots

<div align="center">

| Home Screen | Capture Mode | Search Results |
|-------------|--------------|----------------|
| ![Home](https://via.placeholder.com/200x350/4A90E2/FFFFFF?text=Home+Screen) | ![Capture](https://via.placeholder.com/200x350/50E3C2/FFFFFF?text=Capture+Mode) | ![Search](https://via.placeholder.com/200x350/F5A623/FFFFFF?text=Search+Results) |

*Add your actual screenshots here*

</div>

## 🛠️ Tech Stack

### Frontend
- **Flutter** - Cross-platform UI framework
- **Dart** - Programming language
- **Riverpod** - State management
- **Go Router** - Navigation and routing

### AI & ML
- **Google ML Kit**
  - Text Recognition
  - Image Labeling
  - Object Detection

### Storage & Database
- **SQLite** - Local database
- **SQFlite** - Flutter SQLite plugin
- **Path Provider** - File system access

### UI & UX
- **Google Fonts** - Typography
- **Flutter Animate** - Smooth animations
- **Photo View** - Image viewing
- **Share Plus** - Content sharing

### Development Tools
- **Freezed** - Code generation for immutable classes
- **JSON Serializable** - JSON serialization
- **Build Runner** - Code generation
- **Flutter Lints** - Code quality

## 📋 Usage

### Capturing Memories

1. Open the app and tap the camera button
2. Point your camera at any visual content
3. The app automatically processes the image using AI
4. Extracted text, objects, and labels are saved

### Searching Memories

1. Tap the search icon from the home screen
2. Enter keywords, phrases, or descriptions
3. Choose search mode: Text, Semantic, or Hybrid
4. Browse through relevant results with relevance scores

### Managing Memories

- View memory details with extracted information
- Share memories with others
- Delete unwanted memories
- Filter by memory type (photos, documents, receipts, etc.)

## 🏗️ Architecture

```
lib/
├── app_route.dart              # App routing configuration
├── app_theme.dart              # Theme and styling
├── main.dart                   # App entry point
├── entities/                   # Data models (Freezed)
│   ├── memory_entity/
│   └── search_result_entity/
├── features/                   # Feature modules
│   ├── capture/               # Camera and image capture
│   ├── home/                  # Home screen and memory grid
│   ├── memory/                # Memory detail and management
│   ├── search/                # Search functionality
│   └── settings/              # App settings
├── providers/                 # State management (Riverpod)
├── repositories/              # Data access layer
├── services/                  # Business logic and external APIs
└── database/                  # Database helpers and models
```

## 🤝 Contributing

We welcome contributions! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Setup

1. Ensure you have Flutter and Dart installed
2. Clone your fork: `https://github.com/ArbazKhan1645/visual_mind`
3. Install dependencies: `flutter pub get`
4. Generate code: `flutter pub run build_runner build`
5. Run tests: `flutter test`
6. Run lints: `flutter analyze`

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Arbaz Mashwani**
- Email: mashwnaikhan192@gmail.com
- GitHub: [@arbazmashwani](https://github.com/ArbazKhan1645)
- LinkedIn: [Arbaz Mashwani](https://www.linkedin.com/in/arbaz-mashwani-4b1a25398/)

## 🙏 Acknowledgments

- Google ML Kit for AI capabilities
- Flutter team for the amazing framework
- The open-source community for inspiration and tools

## 📞 Support

If you have any questions or need help:

- 📧 Email: mashwnaikhan192@gmail.com
- 🐛 [Create an Issue](https://github.com/ArbazKhan1645/visual_mind/issues)
- 💬 [Discussions](https://github.com/ArbazKhan1645/visual_mind/discussions)

---

<div align="center">

**Made with ❤️ using Flutter**

⭐ Star this repo if you find it helpful!

[⬆️ Back to Top](#visualmind---ai-powered-visual-memory-assistant)

</div>
