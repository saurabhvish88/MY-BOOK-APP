# 📚 MyBooks - Flutter App

A beautiful Flutter app to browse, search, and favourite novels using OpenLibrary API.

---

## ✨ Features

- View list of books (from API)
- See book details
- Mark/unmark books as Favourites
- Pagination support
- Search functionality with pagination
- Shimmer loading animation
- Responsive design
- Splash screen with app title

---

## 🏗️ Architecture

App is built using **MVVM (Model-View-ViewModel)** architecture and uses **Provider** for state management.

- `Model`: Represents book data from API (`Book` class).
- `ViewModel`: Business logic (fetching data, pagination, favourites) in `BookViewModel`.
- `View`: UI screens using Flutter widgets.
- `Widgets`: Reusable UI components like `BookCard`.

---

## 📦 Packages Used

- `http`: API calls
- `provider`: State management
- `shimmer`: Loading animations
- `transparent_image`: Placeholder images

---

## 🚀 Getting Started

### 1. Clone the repository:

```bash
git clone https://github.com/saurabhvish88/MY-BOOK/blob/master/README.md
cd mybooks