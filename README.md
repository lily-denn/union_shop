# Union Shop

A fully-featured Flutter e-commerce application for the University of Portsmouth Student Union, providing a complete shopping experience with responsive design for both mobile and desktop platforms.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [How to Run](#how-to-run)
- [Project Structure](#project-structure)
- [Testing](#testing)
- [Technology Stack](#technology-stack)

## Overview

Union Shop is a comprehensive e-commerce application built with Flutter that replicates the functionality of the University of Portsmouth Student Union's online shop. The application features a complete shopping experience including product browsing, cart management, custom personalization services, and a fully responsive design that adapts seamlessly between mobile and desktop views.

## Features

### Navigation & Layout

#### Responsive Navigation Bar
- **Desktop View (≥900px)**:
  - Full horizontal menu with hover effects and smooth underline animations
  - Click-to-toggle dropdown for "The Print Shack" section with precise button alignment
  - All navigation links visible in a single row
  - Custom hover states with animated underlines

- **Mobile View (<900px)**:
  - Collapsible hamburger menu with smooth slide-down animation
  - Expandable "Print Shack" section with ExpansionTile
  - Optimized touch targets for mobile interaction
  - Automatic menu closure on navigation

- **Common Features**:
  - Promotional banner with sale announcements
  - Shopping cart, user profile, and search icons
  - Dynamic logo sizing based on screen width
  - Network image loading with error handling

#### Footer Component
- Consistent footer across all pages
- Links and information sections
- Reusable widget architecture

### Pages & Views

#### Home Page (`home_page.dart`)
- Landing page with featured content
- Responsive grid layout
- Quick access to collections and promotions
- Adaptive spacing for different screen sizes

#### Collections & Shopping

**Collections Overview** (`collections_page.dart`)
- Browse all available product collections
- Grid layout with collection cards
- Responsive design adapting to screen width

**Individual Collection** (`collection_page.dart`)
- Display products within a specific collection
- Product grid with images and details
- Filtering and sorting capabilities

**Sale Collection** (`salecollection_page.dart`)
- Special sale items with discounted pricing
- Promotional messaging
- Limited-time offers display

**Product Details** (`product_page.dart`)
- Comprehensive product information
- Image gallery
- Size and color selection
- Quantity adjustment
- Add to cart functionality

#### Shopping Cart (`cart_page.dart`)

**Desktop Layout (>900px)**:
- Full table view with columns: Product, Price, Quantity, Total
- Inline quantity adjustment with up/down arrow buttons
- Remove item buttons visible per item
- Side-by-side note section and checkout summary
- Real-time subtotal calculation

**Mobile Layout (≤900px)**:
- Stacked card layout for each item
- Edit mode toggle for quantity adjustment
- Collapsible item details
- Full-width checkout button
- Compact quantity controls

**Common Features**:
- Quantity increment/decrement with validation
- Minimum quantity of 1 (cannot decrement below)
- Text input for direct quantity entry
- Item removal functionality
- Order notes section
- Subtotal with tax/shipping information
- Form validation for quantity inputs
- Persistent controller state management

#### The Print Shack

**About Page** (`print_shack_about.dart`)
- Information about custom printing services
- Service details and offerings
- Contact information

**Personalisation** (`personalisation.dart`)
- Custom product personalization interface
- Text customization options
- Design preview
- Form-based customization

#### Additional Pages

**About Us** (`about_page.dart`)
- Welcome message and company information
- Service descriptions with rich text formatting
- Interactive links (e.g., link to personalization services)
- Delivery and returns information
- Responsive padding and layout

**Sign In** (`sign_in.dart`)
- User authentication interface
- Login/registration forms
- Input validation
- Secure credential handling

### Technical Implementation

#### Responsive Design
- **Primary Breakpoint**: 900px (mobile/desktop switch)
- **Secondary Breakpoints**: 600px, 650px for fine-tuned adjustments
- MediaQuery-based responsive layouts
- LayoutBuilder for component-level responsiveness
- Adaptive font sizes, padding, and spacing

#### State Management
- StatefulWidget for interactive components
- setState for local state updates
- Controller management for form inputs
- TextEditingController for quantity fields
- State persistence across rebuilds

#### Custom Widgets

**`_UnderlineOnHoverButton`** (navbar)
- Hover state detection with MouseRegion
- Animated text decoration (underline)
- Custom padding and styling
- Supports trailing widgets (e.g., dropdown arrow)

**Cart Item Components**
- Desktop: `_buildDesktopCartItem()`
- Mobile: `_buildMobileCartItem()`
- Shared logic with responsive presentation

#### Navigation System
- Named routes defined in `main.dart`
- Route paths: `/`, `/about`, `/collections`, `/cart`, `/sign_in`, `/product`, `/print_shack`
- Navigation using `Navigator.pushNamed()` and `Navigator.push()`
- MaterialPageRoute for dynamic page transitions
- Back navigation support with `Navigator.pop()`

#### UI/UX Features
- **Overlay System**: Print Shack dropdown using OverlayEntry and LayerLink
- **Hover Effects**: MouseRegion for desktop hover states
- **Touch Interactions**: InkWell and GestureDetector for tap handling
- **Form Validation**: Input validation for quantities and text fields
- **Error Handling**: Graceful fallbacks for network images
- **Loading States**: Proper widget lifecycle management

#### Color Scheme
- **Primary Purple**: `#4d2963` (brand color)
- **Secondary Purple**: `#7B2D8B` (accents)
- **Dark Grey**: `#424242` (text)
- **Light Backgrounds**: Various grey tones for depth
- **Interactive Elements**: Purple highlights for links and buttons

## How to Run

### Prerequisites

Before running the application, ensure you have the following installed:

- **Flutter SDK** (3.0 or higher)
- **Dart SDK** (comes with Flutter)
- **Git** for version control
- **IDE**: Visual Studio Code, Android Studio, or IntelliJ IDEA
- **Web Browser**: Google Chrome (recommended for web development)

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/lily-denn/union_shop.git
   cd union_shop
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Verify your Flutter installation**
   ```bash
   flutter doctor
   ```
   Ensure all required components are installed. Address any issues reported.

### Running the Application

#### Web (Recommended for Development)
The application is optimized for web development and testing:

```bash
flutter run -d chrome
```

**To view in mobile mode:**
1. Open Chrome DevTools (F12 or Right-click → Inspect)
2. Click the "Toggle device toolbar" icon (Ctrl+Shift+M)
3. Select a mobile device preset (e.g., iPhone 12 Pro, Pixel 5)
4. Refresh if necessary

**To test desktop responsiveness:**
- Resize the browser window to > 900px width
- Or select "Responsive" mode in DevTools and adjust dimensions

#### Desktop Platforms

**Windows:**
```bash
flutter run -d windows
```

**macOS:**
```bash
flutter run -d macos
```

**Linux:**
```bash
flutter run -d linux
```

#### Mobile Platforms

**Android Emulator:**
```bash
flutter run -d android
```

**iOS Simulator (macOS only):**
```bash
flutter run -d ios
```

### Building for Production

#### Web Build
```bash
flutter build web
```
Output: `build/web/` directory (deploy to any web hosting service)

#### Desktop Builds

**Windows:**
```bash
flutter build windows --release
```
Output: `build/windows/runner/Release/`

**macOS:**
```bash
flutter build macos --release
```

**Linux:**
```bash
flutter build linux --release
```

#### Mobile Builds

**Android APK:**
```bash
flutter build apk --release
```
Output: `build/app/outputs/flutter-apk/app-release.apk`

**iOS (macOS only, requires Apple Developer account):**
```bash
flutter build ios --release
```

### Hot Reload

While the app is running, you can make changes to the code and see them instantly:
- **Hot Reload**: Press `r` in the terminal (or save file in IDE)
- **Hot Restart**: Press `R` in the terminal (full restart)
- **Quit**: Press `q` in the terminal

## Project Structure

```
lib/
├── main.dart                      # Application entry point and routing
├── views/                         # Page screens
│   ├── home_page.dart            # Landing/home page
│   ├── about_page.dart           # About the Union Shop
│   ├── cart_page.dart            # Shopping cart with full functionality
│   ├── collections_page.dart     # All product collections
│   ├── collection_page.dart      # Single collection detail view
│   ├── salecollection_page.dart  # Sale items collection
│   ├── product_page.dart         # Individual product details
│   ├── print_shack_about.dart    # Print Shack information
│   ├── personalisation.dart      # Custom printing/personalization
│   └── sign_in.dart              # User authentication
└── widgets/                       # Reusable components
    ├── app_navbar.dart           # Navigation bar (responsive)
    └── app_footer.dart           # Footer component

test/
├── views/                         # Page-level widget tests
│   ├── about_page_test.dart
│   ├── cart_test.dart
│   ├── collection_page_test.dart
│   ├── collections_page_test.dart
│   ├── home_page_test.dart
│   ├── personalisation_test.dart
│   ├── print_shack_about_test.dart
│   ├── product_page_test.dart
│   ├── salecollection_page_test.dart
│   └── sign_in_test.dart
└── widgets/                       # Component-level tests
    ├── app_footer_test.dart
    └── app_navbar_test.dart

android/                          # Android-specific configuration
ios/                              # iOS-specific configuration
web/                              # Web-specific assets and config
windows/                          # Windows-specific configuration
linux/                            # Linux-specific configuration
macos/                            # macOS-specific configuration

pubspec.yaml                      # Project dependencies and assets
analysis_options.yaml             # Dart analyzer configuration
README.md                         # This file
```

## Testing

The application includes comprehensive test coverage for all pages and widgets, with **177 passing tests**.

### Running Tests

**Run all tests:**
```bash
flutter test
```

**Run specific test file:**
```bash
flutter test test/views/cart_test.dart
```

**Run tests with verbose output:**
```bash
flutter test --verbose
```

**Run tests with coverage:**
```bash
flutter test --coverage
```

**Generate coverage report (requires lcov):**
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
```

### Test Coverage

**Views (Pages):**
- Home Page: Navigation, layout, widget presence
- About Page: Text content, links, responsive layout
- Cart Page: 
  - Desktop/mobile layouts
  - Quantity increment/decrement
  - Item removal
  - Subtotal calculation
  - Form validation
- Collections Pages: Display, navigation
- Product Page: Details, interactions
- Sign In: Form elements, validation
- Print Shack: About and personalization features

**Widgets:**
- Navbar: Responsive behavior, navigation links, dropdowns, icons
- Footer: Content, links, layout

### Test Features
- Widget finding and interaction testing
- Responsive layout validation
- User interaction simulation (taps, text input)
- State change verification
- Error handling tests
- Overflow suppression for UI tests

## Technology Stack

### Core Framework
- **Flutter**: 3.x (cross-platform UI framework)
- **Dart**: 3.5.4+ (programming language)

### Dependencies
Listed in `pubspec.yaml`:
- `flutter`: Flutter SDK
- `cupertino_icons`: iOS-style icons

### Development Tools
- **flutter_test**: Widget testing framework
- **Dart Analyzer**: Static code analysis
- **Hot Reload**: Fast iterative development

### Supported Platforms
- ✅ Web (Chrome, Firefox, Safari, Edge)
- ✅ Windows Desktop
- ✅ macOS Desktop
- ✅ Linux Desktop
- ✅ Android Mobile
- ✅ iOS Mobile

### Responsive Design Implementation
- `MediaQuery`: Screen size detection
- `LayoutBuilder`: Component-level responsiveness
- Breakpoint-based layouts (900px primary threshold)
- Adaptive widgets (different for mobile/desktop)

## Development Notes

### Code Quality
- Dart formatter applied
- No analyzer errors, warnings, or suggestions
- Consistent code style
- Proper widget decomposition
- Reusable component architecture

### Performance Considerations
- Efficient widget rebuilds with `setState`
- Proper controller disposal
- Optimized image loading with error handling
- Minimal widget tree depth where possible

### Best Practices Followed
- Clear file organization
- Descriptive variable and function names
- Comments for complex logic
- Proper error handling
- Consistent styling patterns
- Responsive design patterns

### Known Limitations
- Cart data is not persisted (resets on app restart)
- No backend integration (static data)
- No real payment processing
- Images are placeholder/AI-generated

## Troubleshooting

### Common Issues

**Flutter command not found**
- Ensure Flutter SDK is installed and in your PATH
- Run `flutter doctor` to verify installation
- Restart your terminal/IDE after installation

**Dependencies not resolving**
```bash
flutter clean
flutter pub get
```

**Hot reload not working**
- Save the file to trigger hot reload
- Try hot restart (R in terminal)
- Restart the application completely if issues persist

**Web app not loading**
- Ensure Chrome is installed
- Try: `flutter run -d web-server --web-port=8080`
- Check browser console for errors

**Build failures**
- Run `flutter clean` then rebuild
- Update Flutter: `flutter upgrade`
- Check `flutter doctor` for missing dependencies

**Test failures**
- Ensure dependencies are up to date: `flutter pub get`
- Run tests with verbose flag: `flutter test --verbose`
- Check for analyzer errors: `flutter analyze`

