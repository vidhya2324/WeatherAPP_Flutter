# 🌤️ Weather App

A simple and beautiful Flutter app that displays real-time weather data and forecast using the [OpenWeatherMap API](https://openweathermap.org/api).

---

## 🚀 Features

- 🌡️ Current temperature with weather condition
- ☁️ Weather icons (sunny, cloudy, rainy)
- 📊 Additional info: Humidity, Pressure, Wind Speed, Sea Level
- ⏰ Hourly forecast displayed horizontally
- 🔄 Refresh button to update data
- 🎨 Smooth and responsive UI using Flutter widgets

---

## 📸 Screenshots

<p align="center">
  <img src="https://github.com/vidhya2324/WeatherAPP_Flutter/blob/master/lib/assests/sample_result.png" width="400"/>
</p>

---

## 🛠️ Technologies Used

- Flutter (Dart)
- OpenWeatherMap API
- HTTP package
- intl package (for formatting time)
- Material Design

---

## 🔑 API Key Setup

1. Go to [OpenWeatherMap](https://openweathermap.org/) and create a free account.
2. Get your API key from the dashboard.
3. Create a file named `secretKey.dart` inside the `lib` folder:

```dart
const String openweatherAPI = "YOUR_API_KEY_HERE";
