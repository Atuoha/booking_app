
````markdown
# Salon Booking App MVP
A simple Flutter mobile app that lets customers book salon services by selecting a service, date, and time. Bookings are stored locally and can be viewed or deleted.

---

## Features
- Choose from multiple salon services  
- Pick date and time with native Flutter pickers  
- Store bookings locally with `SharedPreferences`  
- View all bookings in a list  
- Delete bookings with confirmation dialog  

---

## Getting Started

### Prerequisites

- Flutter SDK installed  
- Android Studio (for Android emulator) or Xcode (for iOS simulator) installed  
- Emulator/simulator or physical device set up  

### Installation

1. Clone the repo  
   ```bash
   git clone <your-repo-url>
   cd <repo-folder>
````

2. Install dependencies

   ```bash
   flutter pub get
   ```

### Running the App

1. Launch your emulator or simulator:

    * **Android Emulator:**
      Open Android Studio → Tools → AVD Manager → Start a virtual device

    * **iOS Simulator (macOS only):**
      Run in terminal:

      ```bash
      open -a Simulator
      ```

2. Run the app:

   ```bash
   flutter run
   ```

The app will launch on the selected device.

---

## Dependencies
* [flutter](https://flutter.dev)
* [shared\_preferences](https://pub.dev/packages/shared_preferences)
* [intl](https://pub.dev/packages/intl)

---

## Project Structure
* `main.dart` — app entry point and UI
* `BookingController` — business logic, local storage
* `BookingList` — widget to display bookings with delete option



