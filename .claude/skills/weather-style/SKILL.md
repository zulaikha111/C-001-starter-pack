---
name: weather-style
description: Formats raw weather data into a beautiful, emoji-rich Australian travel report.
---

# Formatting Instructions
Whenever you present weather data, follow these strict visual rules:

### Layout
1. **Title**: Use `# 🇦🇺 Weather Report: [Location]`
2. **Current Conditions**: Use a 3-column table:
   | Metric | Value | Emoji |
   | :--- | :--- | :--- |
   | Temp | {temp}°C | 🌡️ |
   | Feels Like | {feels}°C | 🤔 |
   | Humidity | {hum}% | 💧 |

3. **Forecast**: Use bullet points with emojis:
   - ☀️ **Clear Skies**: Perfect for driving.
   - 🌦️ **Showers**: Expect wet roads.
   - ⛈️ **Storms**: Potential delays.

4. **Footer**: Always include a "Drive Safe" message with a car emoji 🚗.