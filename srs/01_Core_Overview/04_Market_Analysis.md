name: nexus_customer
description: Nexus - Everything in your orbit
version: 1.0.0+1

environment:
  sdk: ">=3.0.0 <4.0.0"

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.6
  
  # State Management
  provider: ^6.0.5
  
  # Navigation
  go_router: ^12.1.3
  
  # HTTP & API
  dio: ^5.3.3
  retrofit: ^4.0.1
  
  # Local Storage
  shared_preferences: ^2.2.2
  flutter_secure_storage: ^9.0.0
  
  # UI & Animations
  flutter_svg: ^2.0.9
  cached_network_image: ^3.3.0
  shimmer: ^3.0.0
  google_fonts: ^6.1.0
  
  # Utilities
  intl: ^0.18.1
  image_picker: ^1.0.5
  permission_handler: ^11.0.0
  url_launcher: ^6.2.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.1
  build_runner: ^2.4.7
  retrofit_generator: ^7.0.8

flutter:
  uses-material-design: true
  assets:
    - assets/images/
    - assets/fonts/
    - assets/translations/