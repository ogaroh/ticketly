# Ticketly (Ticket Resolution App)

A Flutter application for managing and resolving support tickets with a clean, modern interface using Material 3 design & clean architecture.

## Features

### Main Features

- **Login Screen (Mock Authentication)**
  - Email + password form with validation
  - Fake authentication (accepts any non-empty email/password)
  - Persistent login state using SharedPreferences

- **Tickets List**
  - Fetches tickets from `https://jsonplaceholder.typicode.com/posts`
  - Displays tickets with modern card-based UI
  - Pull-to-refresh functionality
  - Real-time status updates (Open/Resolved)
  - Loading and error states handling

- **Ticket Details Screen**
  - Full title and body display
  - "Mark as Resolved" button
  - Local persistence of resolved state
  - Confirmation dialog before resolving
  - Visual feedback for resolved tickets

- **Bottom Navigation**
  - **Tickets**: Main ticket list view
  - **Profile**: User profile with logout functionality

### Bonus Features

- **Material 3 Theme**
  - Modern design system with dynamic color schemes
  - Consistent theming across all screens

- **Dark Mode Support**
  - Automatic theme switching based on system preference
  - Beautiful dark theme variants

- **Smooth Animations**
  - Page transitions
  - Loading indicators
  - Interactive feedback

- **Responsive UI**
  - Adapts to different screen sizes
  - Touch-friendly interface

- **Custom Launcher Icon**
  - Created a fitting icon from (https://icon.kitchen)
  - Android & iOS

## Architecture

The app follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/                    # Core functionality
│   ├── constants/          # App constants
│   ├── errors/            # Error handling
│   ├── navigation/        # GoRouter configuration
│   ├── network/          # API and local storage services
│   └── utils/            # Utility functions
├── features/              # Feature modules
│   ├── auth/             # Authentication feature
│   │   ├── data/         # Data layer (repositories, models, data sources)
│   │   ├── domain/       # Domain layer (entities, repositories, use cases)
│   │   └── presentation/ # Presentation layer (BLoC, pages, widgets)
│   ├── tickets/          # Tickets feature
│   └── profile/          # Profile feature
└── shared/               # Shared components
    ├── theme/           # App theming
    └── widgets/         # Reusable widgets
```

## Tech Stack

### Required Technologies
- **Flutter** (Stable Channel)
- **Dart**
- **BLoC/Cubit** for state management
- **SharedPreferences** for local storage
- **GoRouter** for routing
- **Clean Architecture** folder structure
- **Material 3** responsive UI

### Additional Dependencies
- `flutter_bloc` - State management
- `equatable` - Value equality
- `http` - API requests
- `shared_preferences` - Local storage
- `go_router` - Navigation
- `json_annotation` & `json_serializable` - JSON serialization

## Getting Started

### Prerequisites
- Flutter SDK (latest stable)
- Dart SDK
- Android Studio / VS Code
- Android/iOS emulator or physical device

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/ogaroh/ticketly
   cd ticketly
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   dart run build_runner build
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## How To Use The App

### Login
- Use any email and password to login (mocked authentication)
- Example: email: `user@example.com`, password: `123456`

### Managing Tickets
1. Browse tickets on the main screen
2. Tap any ticket to view details
3. Use "Mark as Resolved" to resolve tickets
4. Pull down to refresh the list

### Profile
- View logged-in user email
- Access logout functionality
- Future: Settings and help sections

## Key Highlights

### State Management
- **BLoC pattern** for predictable state management
- Separation of business logic from UI
- Event-driven architecture

### Data Persistence
- **Local storage** for user authentication state
- **Resolved tickets** persist across app restarts
- Efficient data caching

### User Experience
- **Material 3** design language
- **Dark/Light** theme support
- **Responsive** design for all screen sizes
- **Loading states** and error handling
- **Pull-to-refresh** functionality
- **Confirmation dialogs** for important actions

### Code Quality
- **Clean Architecture** principles
- **SOLID** principles adherence
- **Separation of concerns**
- **Testable** code structure
- **Type safety** with Dart

## Testing

The app includes unit tests for:
- BLoC state management
- Repository implementations
- Use cases
- Models

Run tests with:
```bash
flutter test
```

## Build

### Debug APK
```bash
flutter build apk --debug
```

### Release APK
```bash
flutter build apk --release
```

The APK will be available in the `build/app/outputs/flutter-apk/` folder

## Future Enhancements
- Branding updates for uniqueness
- Real authentication with backend API
- Ticket creation functionality
- Push notifications for ticket updates
- Offline support with local database
- User settings and preferences
- Ticket search and filtering
- Analytics and reporting

# License
© Erick Ogaro