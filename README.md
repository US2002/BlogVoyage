# **BlogVoyage - Flutter Blog Explorer**
BlogVoyage is a Flutter application that allows users to explore and read blogs fetched from a RESTful API. This app also provides an offline feature, allowing users to access previously fetched blog data even when they are not connected to the internet.

## Project Overview
1. **API Integration**: Fetches data from a RESTful API using Flutter's http package.
2. **Blog List View**: Displays a list of blogs, showing each blog's title and associated image.
3. **Detailed Blog View**: Provides a detailed view of a selected blog, including its title and image.
4. **Navigation:**: Implements navigation between the blog list view and the detailed blog view.
5. **Interactive Features:**  Allows users to mark a blog as a favorite (Feature in progress).
6. **State Management:**: Efficiently manages the app's state using Flutter's state management solutions.
7. **Error Handling:** Gracefully handles cases where the API is unavailable or returns an error, displaying a user-friendly error message.
8. **Offline Mode:** Implements offline support using SharedPreferences to store and retrieve previously fetched blog data.

## How to Use
The File Integrity Monitoring System (FIM) is a Java-based application designed to monitor changes in specified directories and generate reports on detected modifications. Here's how it works:
1. **Setup**: Clone this repository to your local machine.
2. **Compilation**:Open the project in your preferred Flutter development environment (e.g., Visual Studio Code, Android Studio). & Install the necessary dependencies by running the following command in the project directory:
3. **Run Application**: Run the app on an emulator or a physical device:
4. Upon launching the app, it will fetch and display a list of blogs from the provided RESTful API.
5. Click on a blog item to view its details in the detailed blog view.
6. The app includes an offline feature, which allows you to access previously fetched blog data even when you are not connected to the internet. This is achieved using SharedPreferences.

## ScreenShots
![App Screenshot](https://github.com/US2002/BlogVoyage/blob/main/Images/1stPage.jpg)
![App Screenshot](https://github.com/US2002/BlogVoyage/blob/main/Images/2ndPage.jpg)

## Future Enhancements
- Implement the "Add to Favorites" feature to allow users to mark blogs as favorites.

## Contributions
Contributions are welcome! If you find any issues, have suggestions, or want to add new features, feel free to open a pull request.

## Feedback and Support
We would love to hear your feedback and suggestions for improving the App. If you encounter any issues or have any questions, please create a new issue in the issue tracker.

## License
This project is licensed under the MIT License
