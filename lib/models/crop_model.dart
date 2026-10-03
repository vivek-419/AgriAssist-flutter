/// Model representing a farmer's crop field item.
class CropModel {
  final String id;
  final String name;
  final String acreage;
  final String plantedAgo;
  final String stage;
  final bool isHealthy;
  final String statusLabel;
  final String statusDetail;
  final String? imageUrl;

  const CropModel({
    required this.id,
    required this.name,
    required this.acreage,
    required this.plantedAgo,
    required this.stage,
    required this.isHealthy,
    required this.statusLabel,
    required this.statusDetail,
    this.imageUrl,
  });
}
