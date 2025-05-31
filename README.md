
# Flutter Project – User CRUD

This is a research and development project for the course **Mobile Platforms and Frameworks**. It uses the **Flutter** framework to build a cross-platform mobile application that performs CRUD operations on users. The app connects to a public REST API provided by [GoRest](https://gorest.co.in/rest-console).

## Features

- Display users from the public API
- Create new users
- Update existing user information
- Delete users
- User-friendly and responsive UI
- Fully online connection (no SQLite or custom backend)
- Automated tests
- Continuous Integration using GitHub Actions

## How to Run the Project Locally

### Prerequisites

Before running this project, make sure you have Flutter properly installed and configured on your system.

- Install Flutter SDK: [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)
- You can also follow this video tutorial on Flutter setup: [How to install Flutter SDK on Windows](https://youtu.be/BTubOBvfEUE?si=-P4LuN_s4yXwMzgL) by [@munoncode](https://www.youtube.com/@munoncode)
- Ensure you have an emulator set up or connect a physical Android device

### Clone the repository

```bash
git clone https://github.com/JosuePorras/Proyecto-Flutter.git
cd Proyecto-Flutter
```

### Open the project in Android Studio
Open Android Studio

Click on "Open an Existing Project"

Select the Proyecto-Flutter directory

Ensure that both the Flutter and Dart extensions are installed and enabled (Android Studio will prompt if missing)

### Running the App

1. Get dependencies:

```bash
flutter pub get
```

2. Run the app:

```bash
flutter run
```

## Automated Testing

To run tests locally, make sure to generate the necessary files first with:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Then run the tests using:

```bash
flutter test
```

Basic CRUD operations are covered by the included tests.

## GitHub Actions

A workflow has been configured in `.github/workflows/flutter.yml` to automatically run tests on each push or pull request to the `main` branch.

## Video Tutorial

Link: [Watch on YouTube](https://youtu.be/pO2_Yy2KiMk)  
(This video explains the framework, CRUD implementation, testing setup, and CI process.)

## Developers

| Full Name       | GitHub Username |
|----------------|------------------|
| Josué Porras    | [@JosuePorras](https://github.com/JosuePorras) |
| Aaron Matarrita | [@AaronMatarrita](https://github.com/AaronMatarrita) |
| Yeiler Montes   | [@YeilerMR](https://github.com/YeilerMR) |
| Dilan Gutierrez | [@DilanGOD02](https://github.com/DilanGOD02) |

## Main Branch

The main branch for this project is: `main`

## References

This project is part of a comprehensive research assignment focused on investigating various mobile platforms. For further information, refer to the PDF report included in the submission.
