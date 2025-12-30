# Kisan-AGI - Agricultural App Architecture

## Overview
A modern, high-contrast agricultural app for Indian farmers with large buttons, clear text, and high accessibility.

## Design Approach
- **Style**: Vibrant & Energetic (agricultural theme with natural green tones)
- **Primary Color**: Deep Emerald Green (#2E7D32) - representing agriculture and growth
- **Secondary Color**: Harvest Gold (#FFB300) - representing prosperity and harvest
- **Background**: Clean Off-White (#FAFAFA) with white cards
- **Typography**: Large, readable fonts (Nunito for warmth and accessibility)
- **Component Structure**: Card-based layouts with generous spacing and soft shadows

## Features & Screens

### 1. Onboarding & Authentication
- **Language Selection Screen** (`/language`)
  - Large language options: English, Hindi
  - Simple, visual selector with flags/icons
  
- **Phone Login Screen** (`/login`)
  - Large phone number input field
  - Clear OTP verification flow
  - High-contrast buttons

### 2. Farmer Dashboard (Home) (`/`)
- **Weather Widget**: Top section showing temperature, humidity (placeholder data)
- **My Crops Section**: Horizontal scrollable list of farmer's crops
- **Recent Scans Section**: Vertical list of past disease diagnoses
- **FAB**: Large, central camera icon for "Scan New Crop"

### 3. Scan Interface (`/scan`)
- Full-screen camera preview placeholder
- Gallery button and Capture button
- Overlay text: "Point camera at the affected leaf"

### 4. Diagnosis & Recovery Plan (`/diagnosis/:id`)
- **Header**: Captured image + detected disease name (large, bold)
- **Recovery Timeline**: Vertical stepper with 3 steps
  - Step 1: Immediate Action (Red accent)
  - Step 2: Treatment/Medicine (Blue accent with "Buy Now" button)
  - Step 3: Prevention (Green accent)

### 5. Community Feed (`/community`)
- List view of farmer posts with images
- Upvote/Reply buttons
- Share crop issues and solutions

## Data Models

### User Model (`lib/models/user_model.dart`)
```dart
- id: String
- name: String
- phoneNumber: String
- language: String (en/hi)
- createdAt: DateTime
- updatedAt: DateTime
```

### Crop Model (`lib/models/crop_model.dart`)
```dart
- id: String
- name: String
- imageUrl: String
- plantedDate: DateTime
- userId: String
- status: String (healthy/diseased)
- createdAt: DateTime
- updatedAt: DateTime
```

### Disease Model (`lib/models/disease_model.dart`)
```dart
- id: String
- name: String
- description: String
- severity: String (low/medium/high)
- imageUrl: String
- cropId: String
- detectedAt: DateTime
```

### RecoveryPlan Model (`lib/models/recovery_plan_model.dart`)
```dart
- id: String
- diseaseId: String
- steps: List<RecoveryStep>
  - RecoveryStep:
    - title: String
    - description: String
    - accentColor: Color (red/blue/green)
    - actionButton: String? (optional)
```

### Post Model (`lib/models/post_model.dart`)
```dart
- id: String
- userId: String
- userName: String
- content: String
- imageUrl: String?
- upvotes: int
- replies: int
- createdAt: DateTime
```

## Services (Local Storage)

### UserService (`lib/services/user_service.dart`)
- Store current user data
- Language preferences
- Sample data: 1 demo user

### CropService (`lib/services/crop_service.dart`)
- CRUD operations for crops
- Sample data: 5 diverse crops (rice, wheat, cotton, sugarcane, tomato)

### DiseaseService (`lib/services/disease_service.dart`)
- Store disease detection history
- Sample data: 3 recent scans with different diseases

### RecoveryPlanService (`lib/services/recovery_plan_service.dart`)
- Get recovery plans for specific diseases
- Sample data: Complete recovery plans for each disease type

### PostService (`lib/services/post_service.dart`)
- CRUD operations for community posts
- Sample data: 6-8 community posts with images

## Navigation Routes

```dart
/ - Dashboard (Home)
/language - Language Selection
/login - Phone Login
/scan - Camera Scan Interface
/diagnosis/:id - Disease Diagnosis & Recovery Plan
/community - Community Feed
```

## Technical Stack
- Flutter 3.6+
- go_router for navigation
- shared_preferences for local storage
- google_fonts (Nunito)
- Provider for state management

## Implementation Steps
1. ✅ Create architecture.md
2. ✅ Update theme.dart with agricultural color palette
3. ✅ Create all data models with proper serialization
4. ✅ Create all service classes with sample data in local storage
5. ✅ Build Language Selection screen
6. ✅ Build Phone Login screen
7. ✅ Build Dashboard/Home screen with all sections
8. ✅ Build Scan Interface screen
9. ✅ Build Diagnosis & Recovery Plan screen
10. ✅ Build Community Feed screen
11. ✅ Set up navigation routes
12. ✅ Test and debug with compile_project

## Implementation Complete ✅

All features have been successfully implemented with:
- Modern agricultural color theme (Emerald Green & Harvest Gold)
- Large, accessible UI components for farmers
- Card-based layouts with generous spacing
- Comprehensive local storage with realistic sample data
- Full navigation flow from onboarding to all core features
