# Strada-Lusso

**Mehdi Ouali**  
**Matricola:** 345791

## Overview

Strada-Lusso is a luxury car browsing application that allows users to explore a collection of high-end vehicles, view detailed specifications, save favorites, and filter by categories. The app provides an intuitive interface for car enthusiasts to discover and manage their dream car collection with real-time data synchronization through Firebase.

## User Experience

The app opens with a **home screen** displaying a grid of luxury car cards, each showing the car image, name, brand, and price. Users can tap on any car to navigate to the **car details page**, where they can view comprehensive specifications including max speed, acceleration, fuel capacity, and transmission type.

From the home screen, users can access the **favorites page** via the bottom navigation bar to view their saved cars, or use the **search functionality** to find specific models. The heart icon on each car card allows users to quickly add or remove vehicles from their favorites list, with changes instantly reflected across all screens. Category filters enable users to browse cars by type (e.g., sports cars, SUVs, sedans).

![Home Screen](screenshots/home_screen.png)  
![Car Details](screenshots/car_details.png)

## Technology and Implementation

### Main Packages Used
- **`firebase_core`** and **`cloud_firestore`**: Firebase integration for cloud database operations
- **`flutter_bloc`**: State management using the BLoC pattern
- **`get_it`**: Dependency injection for clean architecture
- **Standard Flutter widgets**: Material Design components for UI

### Why Firebase Firestore?
Firebase Firestore was chosen as the backend solution because it provides real-time data synchronization, requires no server setup, and offers seamless integration with Flutter. This allows the app to efficiently store and retrieve car data while maintaining scalability and supporting offline capabilities.

### Implementation Notes
The app follows a clean architecture approach with separation between presentation, domain, and data layers. Navigation is handled using Flutter's built-in navigation system with named routes for better maintainability. The main challenge encountered was ensuring favorites state consistency across multiple screens, resolved by implementing centralized state management with BLoC and shared data sources.
