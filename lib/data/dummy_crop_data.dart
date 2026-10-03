import '../models/crop_model.dart';

/// Dummy active crops list matching the Figma dashboard.
final List<CropModel> dummyCropList = [
  const CropModel(
    id: 'crop_1',
    name: 'Tomato',
    acreage: '0.8 Acre',
    plantedAgo: 'Planted 3 weeks ago',
    stage: 'Flowering stage',
    isHealthy: true,
    statusLabel: 'Healthy',
    statusDetail: 'Watering: On Track',
    imageUrl: 'assets/images/crop_tomato.png',
  ),
  const CropModel(
    id: 'crop_2',
    name: 'Wheat',
    acreage: '1.5 Acres',
    plantedAgo: 'Planted 5 weeks ago',
    stage: 'Check moisture & rust spotting',
    isHealthy: false,
    statusLabel: 'Needs Attention',
    statusDetail: 'Check Now >',
    imageUrl: 'assets/images/crop_wheat.png',
  ),
];

const String dummyDailyFarmingTip =
    'Morning humidity is optimal for gentle root irrigation. Avoid heavy nitrogen spraying past midday to keep foliage resilient under direct heat.';
