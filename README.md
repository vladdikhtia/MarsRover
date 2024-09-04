# MarsRover App

**MarsRover** is an iOS application built with **SwiftUI** that allows users to explore photos taken by NASA's Mars rovers. The app utilizes **NASA's Mars Rover Photos API** to fetch images based on the user's selection of rover, camera, and date. It provides a modern, intuitive interface with features like full-screen image viewing, image caching, and persistent storage of user filters.

## Features

- **Select Mars Rover, Camera, and Date:**
  - Users can choose between different Mars rovers (Curiosity, Opportunity, Spirit), select specific cameras, and specify a date to view corresponding photos.
  
- **Full-Screen Image Viewing:**
  - Users can tap on an image to view it in full-screen mode, with the ability to resize and scroll through the image.

- **Image Caching:**
  - The app caches images to ensure a smooth and responsive experience when viewing photos.

- **Network Implementation:**
  - The app's network layer is implemented using **Combine** and **Async/Await**. This ensures a robust and modern approach to handling asynchronous data fetching.

- **Filter Persistence:**
  - The app uses **CoreData** to remember the user's filter selections (rover, camera, and date). This allows users to return to their previous selections and continue their exploration seamlessly.

- **Pagination (Lazy Load on Scroll):**
  - Although lazy loading on scroll is not fully implemented, there is code in the codebase attempting to address this feature. Users interested in exploring this functionality can refer to the implementation attempts in the code.

## Setup

- **Platform:** iOS 13+
- **Orientation:** Vertical Interface Only
- **Architecture:** MVVM (Model-View-ViewModel)
- **UI Framework:** SwiftUI

## API Reference

The app uses the [Mars Rover Photos API](https://api.nasa.gov/index.html#browseAPI) provided by NASA. You can obtain an API key by filling out the form on [NASA's API page](https://api.nasa.gov).
