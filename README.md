À, hiểu rồi! Bạn muốn README cho **ToDoList Frontend (FE)** bằng tiếng Anh, tương tự phong cách của BE bạn gửi. Dưới đây là phiên bản chuẩn:

---

# 📝 ToDoList Frontend

> A modern and responsive frontend for managing personal tasks, built with **Flutter**.

---

## 🚀 Features

* ✅ **User Interface**

  * Register, login, and update profile
  * Clean and responsive design
  * Role-based UI adjustments

* 📋 **Task Management**

  * View, create, update, and delete tasks
  * Filter tasks by status (pending, in-progress, completed)
  * Assign tasks to users (for admin roles)

* 🔐 **Authentication**

  * JWT-based login
  * Secure API requests with token handling

* 📱 **User Experience**

  * Smooth navigation between screens
  * Custom widgets for task lists and forms
  * Error handling and loading states

---

## 🛠️ Tech Stack

| Layer            | Technology          |
| ---------------- | ------------------- |
| Framework        | Flutter 3.x         |
| Language         | Dart                |
| State Management | Provider / Riverpod |
| HTTP Client      | Dio / http          |
| Local Storage    | Shared Preferences  |
| Authentication   | JWT                 |

---

## ⚙️ Getting Started

### 📦 Requirements

* Flutter 3.x
* Dart 3.x
* Android Studio / VS Code
* Emulator or physical device

### 🧑‍💻 Run Locally

```bash
# Clone the repository
git clone https://github.com/sontay226/todolist-fe.git
cd todolist-fe

# Get dependencies
flutter pub get

# Run on emulator or device
flutter run
```

---

## 📌 Example Screens & Navigation

* **Authentication**

  * `/login` – Login screen
  * `/signup` – Registration screen

* **User**

  * `/me` – View & update profile
  * Admin-only: `/users` – Manage users

* **Tasks**

  * `/tasks` – Task list
  * `/tasks/create` – Create task
  * `/tasks/:id` – View & edit task

---

## 🧠 Folder Structure

```
├── lib
│   ├── screens       # All screens
│   ├── widgets       # Reusable widgets
│   ├── services      # API calls and logic
│   ├── models        # Task/User models
│   ├── providers     # State management
│   ├── utils         # Helpers & constants
│   └── main.dart     # Entry point
```

---

## ⚠️ Notes

* Replace `localhost` in API URLs with your backend server IP to run on real devices.
* Ensure backend is running before using the app.

---

## 📮 Contact

Made with ❤️ by **@sontay226**
Feel free to contribute or report issues.

---


