# 📅 RemindUs

RemindUs adalah aplikasi pengingat (Reminder App) berbasis Flutter yang dikembangkan sebagai proyek pembelajaran sekaligus portofolio. Aplikasi ini berfokus pada pengelolaan jadwal, pengingat, dan alarm dengan tampilan yang sederhana namun modern.

> Status: Development (Phase 2)

---

# ✨ Fitur

## Event Management
- Menambah jadwal
- Mengedit jadwal
- Menghapus jadwal
- Melihat detail jadwal
- Status Event

## Calendar
- Tampilan Calendar
- Pilih tanggal
- Daftar event berdasarkan tanggal

## Reminder
- Alarm berdasarkan waktu
- Notifikasi lokal
- Snooze Alarm
- Stop Alarm

## UI
- Light Mode
- Dark Mode
- Responsive Layout

---

# 🛠 Tech Stack

### Framework
- Flutter
- Dart

### Database
- SQLite (sqflite)

### Notification
- flutter_local_notifications
- timezone

### Local Storage
- SharedPreferences

### UI
- Material Design 3

---

# 📁 Struktur Folder

```
lib/
│
├── config/
│
├── database/
│
├── models/
│
├── pages/
│   ├── home/
│   ├── event/
│   ├── alarm/
│   ├── settings/
│   ├── onboarding/
│   └── welcome/
│
├── services/
│
├── theme/
│
├── widgets/
│
└── main.dart
```

---

# 🚀 Cara Menjalankan

## Clone Repository

```bash
git clone https://github.com/USERNAME/RemindUs.git
```

Masuk folder

```bash
cd RemindUs
```

Install dependency

```bash
flutter pub get
```

Jalankan

```bash
flutter run
```

---

# 📦 Build APK

Debug

```bash
flutter build apk
```

Release

```bash
flutter build apk --release
```

Output

```
build/app/outputs/flutter-apk/app-release.apk
```

---

# 📚 Dependency

- flutter_local_notifications
- sqflite
- path
- intl
- shared_preferences
- timezone

---

# 🎯 Roadmap

## Phase 0
- Project Planning
- Folder Structure

✅ Selesai

---

## Phase 1
- SQLite
- CRUD Event
- Calendar

✅ Selesai

---

## Phase 2
- Notification
- Alarm
- Snooze
- Settings

🟡 Dalam Pengembangan

---

## Phase 3
- Background Alarm
- Boot Receiver
- Battery Optimization
- Full Screen Alarm

🔄 Planned

---

## Phase 4
- Widget
- Backup
- Export
- Import

🔄 Planned

---

## Phase 5
- Google Calendar Sync
- Cloud Backup
- Multi Device

🔄 Planned

---

# 📌 Target Platform

- Android 10+
- Google Play Store

---

# 📸 Screenshot

Coming Soon

---

# 👨‍💻 Developer

Developed by

**Rizqy & Miko**

---

# 📄 License

This project is created for educational purposes and portfolio development.

```

## Aku juga menyarankan menambahkan badge GitHub di bagian atas README

```md
# 📅 RemindUs

![Flutter](https://img.shields.io/badge/Flutter-3.x-blue)
![Platform](https://img.shields.io/badge/Platform-Android-green)
![SQLite](https://img.shields.io/badge/Database-SQLite-orange)
![Status](https://img.shields.io/badge/Status-Development-yellow)
![License](https://img.shields.io/badge/License-Educational-lightgrey)
```

README seperti ini sudah cukup profesional untuk repository GitHub dan memberi gambaran yang jelas mengenai status proyek, teknologi yang digunakan, struktur, serta roadmap pengembangan.