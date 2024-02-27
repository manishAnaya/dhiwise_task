# Financial Goals App

## Overview

Welcome to the Financial Goals App! This Flutter application allows users to set and track their financial goals. The app includes features such as user authentication, goal creation, and detailed goal viewing.

## Prerequisites

Before running the application, make sure you have the following:

- Flutter SDK installed
- Firebase account and project set up

## Firebase Configuration

1. Go to the [Firebase Console](https://console.firebase.google.com/).
2. Create a new project or select an existing one.
3. Navigate to Project Settings.
4. Find your Firebase configuration details (apiKey, authDomain, projectId, storageBucket, messagingSenderId, appId).
5. Copy these details.

## Project Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/manishAnaya/dhiwise_task


## Ensure that your Firebase Firestore security rules are configured as follows:

rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if true;
    }
  }
}

## App Screens and details:

1. Welcome Screen:
Upon launching the app, users are greeted with a welcome screen.

2. Sign In Screen:
Existing users can log in using their credentials.
The app uses Firebase Authentication for secure sign-in.

3. Sign Up Screen:
New users can register by providing necessary details.
Firebase Authentication ensures the security of user registration.

4. Home Screen:
After signing in, users are directed to the home screen.
Here, users can view their existing financial goals.
Users can add a new financial goal by tapping on the floating action button at the bottom.

5. Goal Detail Screen:
Users can view the details of a specific financial goal by clicking on the corresponding goal card on the home screen.