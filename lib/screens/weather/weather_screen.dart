import 'package:flutter/material.dart';
import '../../data/dummy_weather_data.dart';
import '../../models/weather_model.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_logo.dart';

/// Screen 3: Weather Forecast Screen
/// Matches the Figma "Weather Forecast" design precisely.
class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WeatherModel weather = dummyWeatherData;

    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackground,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          physics: const BouncingScrollPhysics(),
          children: [
            // 1. Location Pill & Updated Timestamp
            _buildLocationAndUpdatedHeader(weather),
            const SizedBox(height: 12),

            // 2. Current Conditions Card
            _buildCurrentConditionsCard(weather),
            const SizedBox(height: 14),

            // 3. Farming Tip Card (Warm Peach/Amber)
            _buildFarmingTipCard(weather),
            const SizedBox(height: 14),

            // 4. Micro-Climate Radar (Soil Moisture Level)
            _buildMicroClimateRadarCard(weather),
            const SizedBox(height: 18),

            // 5. 5-Day Forecast Section
            _buildFiveDayForecastSection(weather),
            const SizedBox(height: 16),

            // 6. Hourly Spray Window Advisory Card
            _buildHourlySprayWindowCard(context, weather),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  /// AppBar matching Figma: Back Arrow, Brand Icon + "Weather", User Profile Avatar
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.scaffoldBackground,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: AppTheme.textPrimary,
          size: 22,
        ),
        onPressed: () => Navigator.maybePop(context),
      ),
      titleSpacing: 0,
      title: const Row(
        children: [
          AppLogo(
            size: 38,
            isCircle: true,
            withShadow: true,
          ),
          SizedBox(width: 8),
          Text(
            'Weather',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppTheme.textPrimary,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Container(
            width: 34,
            height: 34,
            decoration: const BoxDecoration(
              color: AppTheme.primaryGreen,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 19,
            ),
          ),
        ),
      ],
    );
  }

  /// Location Pill & Updated Timestamp Header
  Widget _buildLocationAndUpdatedHeader(WeatherModel weather) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4.5),
            decoration: BoxDecoration(
              color: AppTheme.mintContainer,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.location_on,
                  color: AppTheme.primaryGreen,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    weather.location,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.primaryGreen,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.sync,
              size: 13,
              color: AppTheme.textSecondary,
            ),
            const SizedBox(width: 3),
            Text(
              weather.updatedTime,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Current Conditions Card with Temperature, Condition, and 2x2 Metrics Grid
  Widget _buildCurrentConditionsCard(WeatherModel weather) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.borderLight, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Sub-header
          const Text(
            'CURRENT CONDITIONS',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: AppTheme.primaryGreen,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),

          // Temperature & Condition with Mild Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: '${weather.temperature}°C',
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.textPrimary,
                          height: 1.0,
                        ),
                        children: [
                          const WidgetSpan(
                            child: SizedBox(width: 6),
                          ),
                          TextSpan(
                            text: '/ ${weather.temperatureFahrenheit}°F',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      weather.condition,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Feels like ${weather.feelsLike}°C • Dew point ${weather.dewPoint}°C',
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Weather Mild Badge Container
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: AppTheme.mintContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.wb_sunny_rounded,
                      color: AppTheme.primaryGreen,
                      size: 26,
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Mild',
                      style: TextStyle(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.primaryGreen,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // 2x2 Grid of Weather Metrics
          Row(
            children: [
              Expanded(
                child: _buildMetricBlock(
                  icon: Icons.water_drop_outlined,
                  iconColor: AppTheme.primaryGreen,
                  iconBgColor: AppTheme.mintContainer,
                  label: 'Humidity',
                  value: '${weather.humidityPercent}%',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildMetricBlock(
                  icon: Icons.air_rounded,
                  iconColor: AppTheme.primaryGreen,
                  iconBgColor: AppTheme.mintContainer,
                  label: 'Wind Speed',
                  value: '${weather.windSpeedKmh} km/h',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _buildMetricBlock(
                  icon: Icons.wb_sunny_outlined,
                  iconColor: const Color(0xFFEA580C),
                  iconBgColor: const Color(0xFFFFEDD5),
                  label: 'UV Index',
                  value: '${weather.uvIndex} ${weather.uvDescription}',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildMetricBlock(
                  icon: Icons.water_drop,
                  iconColor: AppTheme.primaryGreen,
                  iconBgColor: AppTheme.mintContainer,
                  label: 'Precipitation',
                  value: '${weather.rainProbability}%',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Individual Metric Block
  Widget _buildMetricBlock({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.softGreen,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 17),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 10.5,
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 1),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Farming Tip Card (Warm Amber/Peach)
  Widget _buildFarmingTipCard(WeatherModel weather) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF3C7),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFFDE68A), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: const BoxDecoration(
                  color: Color(0xFFB45309),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.eco,
                  color: Colors.white,
                  size: 15,
                ),
              ),
              const SizedBox(width: 8),
              const Flexible(
                child: Text(
                  '🌾 Farming Tip',
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF78350F),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDE68A),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Irrigation',
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF92400E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            weather.farmingTipBody,
            style: const TextStyle(
              fontSize: 12,
              height: 1.45,
              color: Color(0xFF78350F),
            ),
          ),
        ],
      ),
    );
  }

  /// Micro-Climate Radar Card (Soil Moisture Level)
  Widget _buildMicroClimateRadarCard(WeatherModel weather) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppTheme.borderLight, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Radar/Crop Field Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: SizedBox(
              width: 54,
              height: 54,
              child: Image.network(
                'https://images.unsplash.com/photo-1500937386664-56d1dfef3854?w=150&auto=format&fit=crop',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF15803D),
                        Color(0xFF166534),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.grass,
                        color: Colors.white70,
                        size: 28,
                      ),
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: Icon(
                          Icons.water_drop,
                          color: AppTheme.mintContainer,
                          size: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Details Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'MICRO-CLIMATE RADAR',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.primaryGreen,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Soil Moisture Level',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  weather.soilMoistureSummary,
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: AppTheme.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 5-Day Forecast Section with range bars
  Widget _buildFiveDayForecastSection(WeatherModel weather) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header Row
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                '5-Day Forecast',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.textPrimary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 8),
            Flexible(
              child: Text(
                'High / Low Range',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primaryGreen,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Forecast Card Container
        Container(
          decoration: BoxDecoration(
            color: AppTheme.surfaceWhite,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppTheme.borderLight, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          child: Column(
            children: weather.forecastList.asMap().entries.map((entry) {
              final int index = entry.key;
              final DailyForecastModel item = entry.value;
              final bool isLast = index == weather.forecastList.length - 1;

              return Column(
                children: [
                  _buildForecastRow(item),
                  if (!isLast)
                    const Divider(
                      color: AppTheme.borderLight,
                      thickness: 0.6,
                      height: 16,
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  /// Individual Forecast Day Row
  Widget _buildForecastRow(DailyForecastModel item) {
    final IconData iconData;
    final Color iconColor;
    final Color iconBgColor;
    final List<Color> barGradient;

    switch (item.weatherType) {
      case 'sunny':
        iconData = Icons.wb_sunny_rounded;
        iconColor = const Color(0xFFD97706);
        iconBgColor = const Color(0xFFFFEDD5);
        barGradient = const [Color(0xFFFBBF24), Color(0xFFD97706)];
        break;
      case 'rain':
        iconData = Icons.water_drop_rounded;
        iconColor = AppTheme.primaryGreen;
        iconBgColor = AppTheme.mintContainer;
        barGradient = const [Color(0xFF4ADE80), Color(0xFF15803D)];
        break;
      case 'cloudy':
        iconData = Icons.cloud_outlined;
        iconColor = const Color(0xFF64748B);
        iconBgColor = const Color(0xFFF1F5F9);
        barGradient = const [Color(0xFF94A3B8), Color(0xFF475569)];
        break;
      case 'partly_cloudy':
      default:
        iconData = Icons.wb_sunny_outlined;
        iconColor = AppTheme.primaryGreen;
        iconBgColor = AppTheme.mintContainer;
        barGradient = const [Color(0xFF86EFAC), Color(0xFF166534)];
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          // Weather Icon Circle
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(iconData, color: iconColor, size: 20),
          ),
          const SizedBox(width: 10),

          // Day & Condition
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.dayName,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),
                Text(
                  item.condition,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Min Temp
          Text(
            '${item.minTemp}°',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(width: 6),

          // Range Bar
          Container(
            width: 55,
            height: 5,
            decoration: BoxDecoration(
              color: const Color(0xFFE2E8F0),
              borderRadius: BorderRadius.circular(3),
            ),
            alignment: Alignment.centerLeft,
            child: Container(
              width: 45,
              height: 5,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: barGradient),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
          const SizedBox(width: 6),

          // Max Temp
          SizedBox(
            width: 26,
            child: Text(
              '${item.maxTemp}°',
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w800,
                color: AppTheme.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Hourly Spray Window Advisory Card (Bottom Banner)
  Widget _buildHourlySprayWindowCard(
      BuildContext context, WeatherModel weather) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: AppTheme.softGreen,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppTheme.mintContainer, width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              color: AppTheme.primaryGreen,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.calendar_month_outlined,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hourly Spray Window',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Optimal pesticide window: ${weather.optimalSprayWindow}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppTheme.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Spray Window: ${weather.optimalSprayWindow} (Low wind, zero rain)',
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6.5),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                'Details',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
