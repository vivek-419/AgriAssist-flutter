/// Model representing disease detection results and treatment recommendations.
class DiseaseModel {
  final String id;
  final String cropName;
  final String sampleLabel;
  final String diseaseName;
  final String scientificName;
  final int confidencePercent;
  final String confidenceLevel; // 'High Match', 'Moderate', 'Low'
  final String symptoms;
  final List<String> recommendedSteps;
  final String doctorName;
  final String doctorRole;
  final bool isDoctorOnline;
  final String sampleImageUrl;

  const DiseaseModel({
    required this.id,
    required this.cropName,
    required this.sampleLabel,
    required this.diseaseName,
    required this.scientificName,
    required this.confidencePercent,
    required this.confidenceLevel,
    required this.symptoms,
    required this.recommendedSteps,
    required this.doctorName,
    required this.doctorRole,
    required this.isDoctorOnline,
    required this.sampleImageUrl,
  });
}
