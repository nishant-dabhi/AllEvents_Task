# AllEvents-Task

This repository contains a Flutter application featuring Firebase authentication and a dynamic event browsing system. Below is an overview of the app's structure and functionality.

## Screenshots

<img src="https://github.com/user-attachments/assets/a4ac8d29-b614-4a5a-82ac-579b15faad54" height="450">
<img src="https://github.com/user-attachments/assets/1ee82cba-b878-4576-832c-c62fbdd9e900" height="450">
<img src="https://github.com/user-attachments/assets/47755306-e341-4865-97aa-56453b396459" height="450">
<img src="https://github.com/user-attachments/assets/488d435e-9e63-4b09-a55c-f69e29d89897" height="450">
<img src="https://github.com/user-attachments/assets/cf3db8a1-97e3-4a31-b12f-b5711747f170" height="450">
<img src="https://github.com/user-attachments/assets/9c948a1d-fd4a-4d04-bf1d-d9f85cfe6433" height="450">









## Features

### Authentication
- **Sign In & Sign Up:** The first page of the app allows users to sign in or sign up using Firebase Authentication.
- **Error Handling:** Full error handling is implemented, including detailed validation checks for user inputs, such as email format validation.

### Home Page
- **User Greeting:** Displays the logged-in user's name on the AppBar.
- **Event Categories:** The homepage consists of multiple horizontal ListViews, each representing an event category fetched from a remote API.
- **Reusable Card Widgets:** Each event category item is displayed in a reusable `Card` widget.
- **Navigation:** Clicking on a category name navigates to a detailed screen displaying the full list of events in that category.
- **Floating Action Button:** Opens a modal bottom sheet containing a list of all event categories for quick navigation.

### Event Category List Screen
- **View Modes:** Toggle between `ListTile` and `GridTile` views to display event items as a list or grid.
- **Navigation:** Each `Card`, `ListTile`, and `GridTile` is clickable, leading to a detailed web view of the selected event.

### WebView
- **In-App WebView:** Displays detailed information about the selected event.

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/firebase-events-app.git
   ```

2. Navigate to the project directory:
   ```bash
   cd firebase-events-app
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Set up Firebase:
   - Add your `google-services.json` (for Android) or `GoogleService-Info.plist` (for iOS) file to the project.
   - Configure your Firebase project with the required authentication settings.

5. Run the app:
   ```bash
   flutter run
   ```

## Usage

1. **Sign In/Sign Up:** Create a new account or log in using existing credentials.
2. **Browse Events:** Explore event categories on the homepage, view event details in list or grid formats, and navigate to full details via WebView.
3. **Quick Navigation:** Use the floating action button to access a quick view of all event categories.


