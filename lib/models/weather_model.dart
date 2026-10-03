/// Model for daily forecast rows in the 5-day forecast.
class DailyForecastModel {
  final String dayName;
  final String condition;
  final int minTemp;
  final int maxTemp;
  final String weatherType; // 'partly_cloudy', 'sunny', 'rain', 'cloudy'

  const DailyForecastModel({
    required this.dayName,
    required this.condition,
    required this.minTemp,
    required this.maxTemp,
    required this.weatherType,
  });
}

/// Model for detailed weather conditions and farm advisory.
class WeatherModel {
  final String location;
  final String updatedTime;
  final int temperature;
  final int temperatureFahrenheit;
  final String condition;
  final String advisorySubtitle;
  final int feelsLike;
  final int dewPoint;
  final int humidityPercent;
  final int windSpeedKmh;
  final int uvIndex;
  final String uvDescription;
  final int rainProbability;
  final String farmingTipTitle;
  final String farmingTipBody;
  final String soilMoistureSummary;
  final int soilMoisturePercent;
  final String optimalSprayWindow;
  final List<DailyForecastModel> forecastList;

  const WeatherModel({
    required this.location,
    required this.updatedTime,
    required this.temperature,
    required this.temperatureFahrenheit,
    required this.condition,
    required this.advisorySubtitle,
    required this.feelsLike,
    required this.dewPoint,
    required this.humidityPercent,
    required this.windSpeedKmh,
    required this.uvIndex,
    required this.uvDescription,
    required this.rainProbability,
    required this.farmingTipTitle,
    required this.farmingTipBody,
    required this.soilMoistureSummary,
    required this.soilMoisturePercent,
    required this.optimalSprayWindow,
    required this.forecastList,
  });
}
