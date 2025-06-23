# TomatoConnect 🍅

A comprehensive mobile application connecting tomato farmers and buyers through AI-powered disease detection and quality assessment.

## 📱 Overview

TomatoConnect is a Flutter-based mobile application that bridges the gap between tomato farmers and buyers. The app features AI-powered plant disease detection, tomato quality assessment, farm discovery.

### 🎯 Key Features

**For Farmers:**

- 🔬 AI-powered tomato plant disease detection
- 📊 Plant growth tracking and monitoring
- 📸 Camera integration for leaf scanning
- 📈 Detailed care instructions and recommendations


**For Buyers:**

- 🏪 Farm discovery and marketplace browsing
- ⭐ Farm ratings and reviews system
- 📍 Location-based farm search
- ❤️ Favorites and wishlist functionality
- 🔍 Tomato quality scanning


## 🏗️ Architecture

### Frontend (Flutter/Dart)

- **Framework**: Flutter 3.0+
- **Language**: Dart
- **State Management**: Provider pattern
- **Architecture**: Clean Architecture with separation of concerns


### Backend (FastAPI/Python)

- **Framework**: FastAPI
- **Language**: Python 3.9+
- **AI/ML**: TensorFlow/PyTorch for disease detection
- **Database**: JavaScript (development), Node.js(production)


### Additional Services (Node.js)

- **Real-time features**: Socket.io
- **File processing**: Multer
- **Authentication**: JWT
- **Background jobs**: Node-cron


## 📁 Project Structure

```plaintext
tomato_connect/
├── lib/
│   ├── main.dart
│   ├── screens/
│   │   ├── farmer/
│   │   │   ├── farmer_home_screen.dart
│   │   │   ├── scan_leaf_screen.dart
│   │   │   ├── scan_result_screen.dart
│   │   │   ├── fruit_tracking_screen.dart
│   │   │   ├── add_plant_screen.dart
│   │   │   └── farmer_profile_screen.dart
│   │   ├── buyer/
│   │   │   ├── buyer_home_screen.dart
│   │   │   ├── farm_list_screen.dart
│   │   │   ├── farm_detail_screen.dart
│   │   │   ├── camera_screen.dart
│   │   │   ├── quality_result_screen.dart
│   │   │   └── buyer_profile_screen.dart
│   │   └── welcome_screen.dart
│   ├── widgets/
│   │   ├── role_card.dart
│   │   ├── feature_card.dart
│   │   ├── custom_bottom_nav.dart
│   │   ├── farm_card.dart
│   │   ├── plant_card.dart
│   │   ├── category_badge.dart
│   │   ├── star_rating.dart
│   │   └── loading_indicator.dart
│   ├── models/
│   │   └── disease_detection.dart
│   ├── services/
│   │   └── api_service.dart
│   ├── providers/
│   │   ├── auth_provider.dart
│   │   ├── farm_provider.dart
│   │   └── plant_provider.dart
│   └── theme/
│       └── app_theme.dart
├── backend/
│   ├── main.py
│   ├── requirements.txt
│   └── Dockerfile
├── assets/
│   ├── images/
│   └── fonts/
└── README.md
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0 or higher)
- Dart SDK (2.17 or higher)
- Python 3.9+
- Node.js 16+ (for additional services)
- Android Studio / VS Code
- Git


### Installation

1. **Clone the repository**

```shellscript
git clone https://github.com/yourusername/tomato-connect.git
cd tomato-connect
```


2. **Set up Flutter dependencies**

```shellscript
flutter pub get
```


3. **Set up the backend**

```shellscript
cd backend
python -m venv venv

# On Windows
venv\Scripts\activate

# On macOS/Linux
source venv/bin/activate

pip install -r requirements.txt
```


4. **Configure assets**

```shellscript
mkdir -p assets/images
mkdir -p assets/fonts
```


5. **Update API configuration**

Edit `lib/services/api_service.dart` and update the base URL:

```plaintext
// For Android emulator
static const String baseUrl = 'http://10.0.2.2:8000';

// For iOS simulator
static const String baseUrl = 'http://localhost:8000';

// For physical device (replace with your computer's IP)
static const String baseUrl = 'http://192.168.1.100:8000';
```




### Running the Application

1. **Start the backend server**

```shellscript
cd backend
uvicorn main:app --reload
```


2. **Run the Flutter app**

```shellscript
flutter run
```


3. **For web development** (optional)

```shellscript
flutter run -d chrome
```




## 📱 Features in Detail

### AI Disease Detection

- Real-time camera integration
- Machine learning model for disease identification
- Detailed care instructions
- Confidence scoring
- Treatment recommendations


### Farm Marketplace

- Location-based farm discovery
- Advanced filtering and search
- Farm ratings and reviews
- Direct contact with farmers
- Product availability tracking


### Quality Assessment

- Image-based tomato quality analysis
- Freshness scoring
- Ripeness detection
- Storage recommendations


## 🛠️ Technologies Used

### Frontend

- **Flutter**: Cross-platform mobile development
- **Dart**: Programming language
- **Provider**: State management
- **Camera**: Image capture functionality
- **HTTP**: API communication
- **Google Fonts**: Typography
- **Image Picker**: Gallery/camera selection


### Backend

- **FastAPI**: Modern Python web framework
- **Pillow**: Image processing
- **NumPy**: Numerical computations
- **Pydantic**: Data validation


### Development Tools

- **Git**: Version control
- **Docker**: Containerization
- **VS Code**: IDE
- **Android Studio**: Mobile development
- **Postman**: API testing


## 🔧 Configuration

### Environment Variables

Create a `.env` file in the backend directory:

```plaintext
# API Configuration
API_HOST=0.0.0.0
API_PORT=8000
DEBUG=True

# Database
DATABASE_URL=sqlite:///./tomato_connect.db

# AI Model
MODEL_PATH=./models/disease_detection.pkl

# File Upload
UPLOAD_DIR=./uploads
MAX_FILE_SIZE=10485760  # 10MB
```

### Flutter Configuration

Update `pubspec.yaml` for additional assets:

```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/images/
  fonts:
    - family: Poppins
      fonts:
        - asset: assets/fonts/Poppins-Regular.ttf
        - asset: assets/fonts/Poppins-Bold.ttf
          weight: 700
```

## 🧪 Testing

### Unit Tests

```shellscript
flutter test
```

### Integration Tests

```shellscript
flutter test integration_test/
```

### Backend Tests

```shellscript
cd backend
pytest
```

## 📦 Building for Production

### Android APK

```shellscript
flutter build apk --release
```

### Android App Bundle

```shellscript
flutter build appbundle --release
```

### iOS

```shellscript
flutter build ios --release
```

## 🚀 Deployment

### Backend Deployment (Docker)

```shellscript
cd backend
docker build -t tomato-connect-api .
docker run -p 8000:8000 tomato-connect-api
```

### Mobile App Distribution

- **Android**: Google Play Store
- **iOS**: Apple App Store


## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request


### Development Guidelines

- Follow Flutter/Dart style guidelines
- Write unit tests for new features
- Update documentation for API changes
- Use meaningful commit messages
- Ensure code passes all tests


## 📄 API Documentation

The API documentation is available at `http://localhost:8000/docs` when running the backend server.

### Key Endpoints

- `POST /detect` - Disease detection from image
- `POST /detect-base64` - Disease detection from base64 image
- `GET /` - Health check


## 🐛 Known Issues

- Camera permission handling on some Android devices
- iOS simulator camera limitations
- Large image processing may cause timeouts


## 📞 Support

For support and questions:

- **Email**: [support@tomatoconnect.com](mailto:support@tomatoconnect.com)
- **Issues**: [GitHub Issues](https://github.com/ahmedyehiax/tomato-connect/issues)
- **Documentation**: [Wiki](https://github.com/ahmedyehiax/tomato-connect/wiki)


## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Authors

- **Your Name** - *Initial work* - [YourGitHub](https://github.com/ahmedyehiax)


## 🙏 Acknowledgments

- Flutter team for the amazing framework
- FastAPI for the modern Python web framework
- TensorFlow team for AI/ML capabilities
- Open source community for various packages used



---

**Made with ❤️ for farmers and tomato enthusiasts worldwide** 🍅
