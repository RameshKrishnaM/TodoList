# 📱 Shared TODO Flutter App

A real-time collaborative TODO application built using Flutter, Firebase, and Provider in MVVM architecture. Easily create, share, and manage tasks between users with live updates.

---

## 🚀 Features

- 🔐 Firebase Email/Password Authentication  
- ✅ Create & manage TODOs  
- 👥 Share tasks by email with other users  
- 🔄 Real-time sync using Firestore  
- ♾️ Infinite list support  
- 🧑‍💻 MVVM architecture (Provider)  
- 💡 Clean and attractive UI  
- 📱 Responsive design

---

## 📁 Project Structure

```
lib/
├── core/
│   ├── models/
│   │   └── task_model.dart
│   └── services/
│       ├── firebase_init.dart
│       ├── firestore_service.dart
│       └── sharing_service.dart
├── view/
│   └── screens/
│       ├── login_screen.dart
│       └── task_list_screen.dart
├── view_model/
│   ├── auth_view_model.dart
│   ├── task_view_model.dart
│   └── share_view_model.dart
├── main.dart
```

---

## 🛠️ Setup Instructions

### 1. 🔽 Clone the Repository

```bash
git clone https://github.com/your-username/shared-todo-flutter.git
cd shared-todo-flutter
```

### 2. 📦 Install Dependencies

```bash
flutter pub get
```

### 3. 🔥 Set Up Firebase

- Create a project at [Firebase Console](https://console.firebase.google.com/)
- Enable:
  - **Authentication → Email/Password**
  - **Cloud Firestore**
- Add **Android** and/or **iOS** app in Firebase project
- Download and place:
  - `google-services.json` → in `android/app/`
  - `GoogleService-Info.plist` → in `ios/Runner/`
- Configure using CLI:

```bash
flutterfire configure
```

---

### 4. 🔐 Firestore Security Rules

Paste this into Firestore → Rules:

```js
service cloud.firestore {
  match /databases/{database}/documents {
    match /tasks/{taskId} {
      allow read, write: if request.auth != null &&
        (request.auth.uid == resource.data.ownerId ||
         request.auth.uid in resource.data.sharedWith);
    }

    match /users/{userId} {
      allow read: if true;
      allow write: if request.auth.uid == userId;
    }
  }
}
```

---

### 5. 📊 Firestore Index (Required)

You must create a composite index for:

| Collection | Field        | Order         |
|------------|--------------|---------------|
| `tasks`    | `sharedWith` | arrayContains |
|            | `createdAt`  | descending    |

Firebase will auto-generate a link to create this index in logs if missing.

---

### 6. ▶️ Run the App

```bash
flutter run
```

---

## 📦 Dependencies Used

| Package          | Use Case                         |
|------------------|----------------------------------|
| `firebase_core`  | Firebase core setup              |
| `firebase_auth`  | Email/Password Auth              |
| `cloud_firestore`| Realtime database                |
| `provider`       | State management (MVVM)          |
| `share_plus`     | Share tasks via media/email      |
| `fluttertoast`   | User feedback notifications      |

---

## 📸 Screenshots

> Add your app screenshots in a folder called `screenshots/` and link here if uploading to GitHub.

---

## 👨‍💻 Author

**Ramesh Krishna**  
Flutter Developer (1.10+ yrs experience)  
- 📞 +91 6382480112  
- 📧 krish852000@gmail.com  
- 🌐 [LinkedIn](https://linkedin.com/in/krish0805)  
- 💻 [GitHub](https://github.com/Anonymkrish)

---

## 📜 License

This project is licensed under the [MIT License](LICENSE).  
Free to use, modify, and distribute.
