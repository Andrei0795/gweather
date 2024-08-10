# gweather

## Short Description

A very simple weather app that showcases the display of a list containing weather alerts in the US.

## Overview

This application is a simple yet effective weather app that provides users with a list of weather alerts in the United States. The app displays all relevant details on a single screen for easy access.

## Features

- **Weather Alerts List**: Each alert is presented in a cell within the list, displaying the following details:
  - Event Name
  - Start Date
  - End Date
  - Sender Name
  - Duration of the Alert
  - Unique Image: Each cell contains an image fetched from a specific link.

## Technologies Used

- **Alamofire**: Utilized for network requests and image handling, ensuring efficient data retrieval and display.
- **UIKit**: Implemented using storyboards to manage and present the app’s user interface seamlessly.

## Architecture

- **MVVMC**: The app is built following the Model-View-ViewModel-Coordinator architecture, promoting a clear separation of concerns.
- **Clean Architecture**: Incorporated to enhance the scalability and maintainability of the app, making it easier to navigate and extend.
