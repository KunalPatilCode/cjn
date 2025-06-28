# CJN - Career & Job Network

A 24/7 platform for jobs, employability, corporate branding, and career development built with Flutter and Firebase.

## Features

- **User Authentication**: Register, Login, and Password Reset with Firebase Auth
- **User Types**: Support for Candidates, Employers, and Viewers
- **Comprehensive Registration**: Detailed user profiles with country codes, skills, and experience
- **Firebase Integration**: Real-time database with Firestore
- **Dark Theme**: Modern dark UI design
- **Video Player**: YouTube video integration
- **Mobile Ads**: Google Mobile Ads integration

## Prerequisites

- Flutter SDK (3.7.0 or higher)
- Android Studio / VS Code
- Firebase project
- Android emulator or physical device

## Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/KunalPatilCode/cjn.git
cd cjn
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Firebase Configuration

#### Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project or use existing one
3. Enable Authentication with Email/Password
4. Create Firestore Database

#### Configure Android App
1. In Firebase Console, add Android app with package name: `com.example.cgn`
2. Download `google-services.json`
3. Place it in `android/app/google-services.json`

#### Configure iOS App (Optional)
1. In Firebase Console, add iOS app with your bundle ID
2. Download `GoogleService-Info.plist`
3. Place it in `ios/Runner/GoogleService-Info.plist`

### 4. Update Firebase Configuration

Replace the placeholder values in `android/app/google-services.json`:

```json
{
  "project_info": {
    "project_number": "YOUR_PROJECT_NUMBER",
    "project_id": "YOUR_PROJECT_ID",
    "storage_bucket": "YOUR_PROJECT_ID.firebasestorage.app"
  },
  "client": [
    {
      "client_info": {
        "mobilesdk_app_id": "YOUR_MOBILE_SDK_APP_ID",
        "android_client_info": {
          "package_name": "com.example.cgn"
        }
      },
      "api_key": [
        {
          "current_key": "YOUR_API_KEY"
        }
      ],
      "services": {
        "appinvite_service": {},
        "other_platform_oauth_client": []
      }
    }
  ],
  "configuration_version": "1"
}
```

### 5. Run the App

```bash
flutter run
```

## Project Structure

```
lib/
├── main.dart                 # App entry point with Firebase initialization
├── services/
│   └── auth_service.dart     # Firebase authentication service
├── screens/
│   ├── login.dart           # Login screen
│   ├── register.dart        # Registration screen
│   └── video_player_screen.dart # Video player screen
└── widgets/
    └── navigation_drawer.dart # App navigation drawer
```

## Dependencies

- **firebase_core**: Firebase core functionality
- **firebase_auth**: User authentication
- **cloud_firestore**: NoSQL database
- **provider**: State management
- **youtube_player_flutter**: YouTube video player
- **cached_network_image**: Image caching
- **google_mobile_ads**: Mobile advertisements

## Features in Detail

### Authentication
- Email/Password registration and login
- Password reset functionality
- User type selection (Candidate, Employer, Viewer)
- Form validation with error handling

### User Registration
- Comprehensive user profile creation
- Country code selection (200+ countries)
- Role selection (20+ tech roles)
- Date of birth picker
- Skills and experience tracking

### Database
- User data stored in Firestore
- Real-time data synchronization
- Secure data access rules

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support, email support@cjn.com or create an issue in this repository.

## Security

- API keys and sensitive configuration files are not included in the repository
- Use environment variables for production deployments
- Follow Firebase security best practices

---

**Note**: Make sure to replace all placeholder values in configuration files with your actual Firebase project details before running the app.
