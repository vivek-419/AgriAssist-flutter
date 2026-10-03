import '../models/weather_model.dart';

/// Dummy weather dataset matching the Figma prototype.
final WeatherModel dummyWeatherData = WeatherModel(
  location: 'Mumbai, Maharashtra',
  updatedTime: 'Updated 10m ago',
  temperature: 28,
  temperatureFahrenheit: 82,
  condition: 'Partly Cloudy',
  advisorySubtitle: 'Good Spraying Window',
  feelsLike: 30,
  dewPoint: 22,
  humidityPercent: 72,
  windSpeedKmh: 12,
  uvIndex: 5,
  uvDescription: 'Mod',
  rainProbability: 10,
  farmingTipTitle: 'Farming Tip',
  farmingTipBody:
      'Rain is expected tomorrow. Consider checking irrigation requirements before watering your crops to conserve water and prevent root rot.',
  soilMoistureSummary:
      'Optimal 64% saturation across primary root depth zones.',
  soilMoisturePercent: 64,
  optimalSprayWindow: '4 PM - 7 PM',
  forecastList: const [
    DailyForecastModel(
      dayName: 'Today',
      condition: 'Partly Cloudy',
      minTemp: 24,
      maxTemp: 28,
      weatherType: 'partly_cloudy',
    ),
    DailyForecastModel(
      dayName: 'Tomorrow',
      condition: 'Sunny',
      minTemp: 24,
      maxTemp: 29,
      weatherType: 'sunny',
    ),
    DailyForecastModel(
      dayName: 'Wednesday',
      condition: 'Rain',
      minTemp: 23,
      maxTemp: 27,
      weatherType: 'rain',
    ),
    DailyForecastModel(
      dayName: 'Thursday',
      condition: 'Rain',
      minTemp: 23,
      maxTemp: 26,
      weatherType: 'rain',
    ),
    DailyForecastModel(
      dayName: 'Friday',
      condition: 'Cloudy',
      minTemp: 24,
      maxTemp: 29,
      weatherType: 'cloudy',
    ),
  ],
);
