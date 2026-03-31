# 🚀 Dou Khaber - Social Media App

**"Give Report"** - Share Your Life Updates with the World!

A modern, feature-rich social media application inspired by Instagram, built with Flutter and Firebase. Dou Khaber (دو خبر) meaning "Give Report/Update" in Urdu, is designed for users to share posts, stories, live streams, and connect with friends in real-time.

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.0+-blue.svg)](https://dart.dev/)
[![Firebase](https://img.shields.io/badge/Firebase-Latest-orange.svg)](https://firebase.google.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-blue.svg)]()

## 📋 Table of Contents

- [Features](#-features)
- [Screenshots](#-screenshots)
- [Tech Stack](#-tech-stack)
- [Project Structure](#-project-structure)
- [Prerequisites](#-prerequisites)
- [Installation](#-installation)
- [Firebase Setup](#-firebase-setup)
- [Configuration](#-configuration)
- [Running the App](#-running-the-app)
- [Architecture](#-architecture)
- [Key Features Explained](#-key-features-explained)
- [Development](#-development)
- [API & Services](#-api--services)
- [Contributing](#-contributing)
- [License](#-license)

## ✨ Features

### 🔐 Authentication & User Management
- **Social Login** - Sign up/Login with Email, Google, Facebook
- **Firebase Authentication** - Secure user authentication
- **User Profiles** - Customizable user profiles with bio, profile picture, and links
- **Profile Verification** - Badge system for verified users
- **Account Privacy** - Private/Public account settings

### 📸 Post & Story Features
- **Create Posts** - Share images, videos, carousel posts, and text
- **Stories** - Share temporary stories that disappear after 24 hours
- **Hashtags** - Tag posts with hashtags for discoverability
- **Location Tagging** - Add location information to posts
- **Post Editing** - Edit caption and content after posting
- **Post Deletion** - Remove posts from your timeline

### 💬 Social Interactions
- **Likes & Comments** - React to posts and engage in conversations
- **Nested Comments** - Reply to specific comments
- **Direct Messaging** - Private messaging between users
- **Real-time Chat** - Instant messaging with Firebase Firestore
- **Group Chats** - Create and manage group conversations
- **Message Status** - Delivery and read receipts

### 🎥 Live Streaming
- **Go Live** - Start live video streaming to followers
- **Live Viewer Count** - Display real-time viewer statistics
- **Live Comments** - Chat during live streams
- **Save Live Video** - Record and save live streams as posts
- **Share Live Link** - Share live stream links with followers

### 👥 Networking Features
- **Follow System** - Follow/Unfollow users
- **Follow Requests** - Request to follow private accounts
- **User Discovery** - Explore and discover new users
- **Search Functionality** - Search users, hashtags, and posts
- **Suggested Users** - Get recommendations based on interests
- **Block & Report** - Block users and report inappropriate content

### 🔔 Notifications
- **Like Notifications** - Get notified when someone likes your post
- **Comment Notifications** - Receive alerts for new comments
- **Follow Notifications** - Know when someone follows you
- **Message Notifications** - Get alerts for new messages
- **Push Notifications** - Real-time push notifications via Firebase Cloud Messaging
- **Notification Center** - View all notifications in one place

### 📊 Feed & Discovery
- **Personalized Feed** - Algorithm-based post recommendations
- **Trending Posts** - Discover trending content
- **Explore Page** - Browse posts by category and interests
- **Save Posts** - Bookmark posts for later viewing
- **Share Posts** - Share posts with followers via direct message
- **Post Recommendations** - Smart recommendations based on likes

### 🎨 User Interface
- **Dark Mode Support** - Eye-friendly dark theme
- **Responsive Design** - Works seamlessly on all screen sizes
- **Smooth Animations** - Beautiful transitions and animations
- **Bottom Navigation** - Easy navigation between sections
- **Custom Widgets** - Beautiful custom UI components

## 🛠 Tech Stack

### Frontend Framework
- **Flutter** (^3.0.0) - Cross-platform mobile development
- **Dart** (^3.0.0) - Programming language

### Backend & Database
- **Firebase Authentication** - User authentication & authorization
- **Firebase Firestore** - Real-time NoSQL database
- **Firebase Storage** - Cloud storage for images and videos
- **Firebase Cloud Messaging** - Push notifications
- **Firebase Analytics** - User behavior tracking
- **Firebase Realtime Database** - Real-time data synchronization

### State Management
- **Provider** (^6.0.0) - Reactive state management
- **Riverpod** - Advanced state management (optional)
- **Get** - State management & navigation (optional)

### Core Packages
- **Firebase Core** (^2.0.0) - Firebase initialization
- **Firebase Auth** (^4.0.0) - Authentication
- **Cloud Firestore** (^4.0.0) - Database
- **Firebase Storage** (^11.0.0) - File storage
- **Firebase Messaging** (^14.0.0) - Push notifications

### UI & Design
- **Cached Network Image** (^3.2.0) - Image caching
- **Image Picker** (^0.8.0) - Pick images from gallery/camera
- **Video Player** (^2.4.0) - Play videos
- **Shimmer** (^2.0.0) - Loading shimmer effect
- **Intl** (^0.18.0) - Date & time formatting

### Navigation & Routing
- **Go Router** (^6.0.0) - Navigation and routing
- **Page Route Transition** - Custom page transitions

### Utilities
- **Timeago** (^4.0.0) - Human-readable timestamps
- **Uuid** (^3.0.0) - Generate unique IDs
- **Dio** (^4.0.0) - HTTP client
- **Connectivity Plus** (^3.0.0) - Check internet connectivity

