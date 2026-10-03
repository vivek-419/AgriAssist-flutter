import '../models/disease_model.dart';

/// Default dummy disease result (Tomato) for prototype backward compatibility.
final DiseaseModel dummyDiseaseResult = cropDiseaseResults['Tomato']!;

/// Map of realistic dummy disease diagnoses for all supported crops in AgriAssist.
final Map<String, DiseaseModel> cropDiseaseResults = {
  'Tomato': const DiseaseModel(
    id: 'disease_tomato_01',
    cropName: 'Tomato',
    sampleLabel: 'Analyzed Leaf Sample • Tomato',
    diseaseName: 'Tomato Early Blight',
    scientificName: 'Alternaria solani',
    confidencePercent: 92,
    confidenceLevel: 'High Match',
    symptoms:
        'Dark brown spots with concentric rings and yellow halos on leaves, typically starting on older foliage. May cause leaf yellowing and premature leaf drop if left unmanaged.',
    recommendedSteps: [
      'Prune infected foliage: Remove heavily affected leaves to curb fungal spore dispersion.',
      'Modify irrigation: Avoid watering leaves directly. Apply drip irrigation or direct base-soil hydration.',
      'Targeted treatment: Consider bio-fungicide (e.g. copper-based spray) after agronomic confirmation.',
    ],
    doctorName: 'Dr. Raj Patel',
    doctorRole: 'Lead Pathologist • Vegetable Crops',
    isDoctorOnline: true,
    sampleImageUrl:
        'https://images.unsplash.com/photo-1592417817098-8f3d6eb222e4?w=600&auto=format&fit=crop',
  ),
  'Wheat': const DiseaseModel(
    id: 'disease_wheat_01',
    cropName: 'Wheat',
    sampleLabel: 'Analyzed Leaf Sample • Wheat',
    diseaseName: 'Wheat Leaf Rust (Brown Rust)',
    scientificName: 'Puccinia triticina',
    confidencePercent: 94,
    confidenceLevel: 'High Match',
    symptoms:
        'Small, reddish-orange to brown pustules scattered across the upper surface of wheat leaves. Causes reduced photosynthetic area and shriveled grain development.',
    recommendedSteps: [
      'Apply systemic fungicide: Spray Propiconazole 25% EC (1ml/L) or Tebuconazole at first appearance of rust pustules.',
      'Nutrient management: Maintain balanced potassium and nitrogen; avoid excess nitrogen that creates vulnerable foliage.',
      'Micro-climate monitoring: Ensure field drainage to reduce morning dew retention on upper canopies.',
    ],
    doctorName: 'Dr. Raj Patel',
    doctorRole: 'Lead Agronomist • Cereal & Field Crops',
    isDoctorOnline: true,
    sampleImageUrl:
        'https://images.unsplash.com/photo-1574323347407-f5e1ad6d020b?w=600&auto=format&fit=crop',
  ),
  'Rice': const DiseaseModel(
    id: 'disease_rice_01',
    cropName: 'Rice',
    sampleLabel: 'Analyzed Leaf Sample • Rice',
    diseaseName: 'Rice Bacterial Leaf Blight',
    scientificName: 'Xanthomonas oryzae',
    confidencePercent: 89,
    confidenceLevel: 'High Match',
    symptoms:
        'Water-soaked to yellowish-white lesions along leaf margins. Lesions coalesce and turn grayish-white, causing leaf drying and significant canopy wilting.',
    recommendedSteps: [
      'Water management: Drain standing water from the paddy temporarily to lower humidity within the canopy.',
      'Targeted bactericide: Spray Copper Oxychloride (500g/acre) combined with Streptomycin sulphate (30g/acre).',
      'Pause fertilizer: Avoid top-dressing nitrogen until the bacterial progression is halted.',
    ],
    doctorName: 'Dr. Raj Patel',
    doctorRole: 'Agronomist • Paddy Pathology',
    isDoctorOnline: true,
    sampleImageUrl:
        'https://images.unsplash.com/photo-1536304993881-ff6e9eefa2a6?w=600&auto=format&fit=crop',
  ),
  'Cotton': const DiseaseModel(
    id: 'disease_cotton_01',
    cropName: 'Cotton',
    sampleLabel: 'Analyzed Leaf Sample • Cotton',
    diseaseName: 'Cotton Leaf Curl Virus (CLCuV)',
    scientificName: 'Begomovirus sp.',
    confidencePercent: 91,
    confidenceLevel: 'High Match',
    symptoms:
        'Upward or downward curling of leaf margins, thick enations on underside of main veins, and stunted plant growth transmitted by whiteflies.',
    recommendedSteps: [
      'Whitefly vector control: Spray Diafenthiuron 50% WP (1g/L) or Pyriproxyfen 10% EC to eliminate insect vectors.',
      'Weed host eradication: Remove and destroy alternate weed host plants along field borders.',
      'Foliar nutrition: Apply Zinc + Boron micronutrient booster to promote resilient new foliage growth.',
    ],
    doctorName: 'Dr. Raj Patel',
    doctorRole: 'Specialist • Cash & Fiber Crops',
    isDoctorOnline: true,
    sampleImageUrl:
        'https://images.unsplash.com/photo-1594488507851-955a15328827?w=600&auto=format&fit=crop',
  ),
  'Potato': const DiseaseModel(
    id: 'disease_potato_01',
    cropName: 'Potato',
    sampleLabel: 'Analyzed Leaf Sample • Potato',
    diseaseName: 'Potato Late Blight',
    scientificName: 'Phytophthora infestans',
    confidencePercent: 95,
    confidenceLevel: 'High Match',
    symptoms:
        'Dark water-soaked lesions on leaf tips and stems that rapidly enlarge, producing fine white fungal mildew growth on the underside during humid weather.',
    recommendedSteps: [
      'Immediate chemical control: Spray Metalaxyl + Mancozeb 72 WP (2.5g/L) across the entire crop canopy.',
      'Irrigation care: Discontinue overhead sprinkler irrigation; apply furrow or drip irrigation.',
      'Tuber protection: Ensure proper soil earthing-up to prevent fungal spores from washing into root tubers.',
    ],
    doctorName: 'Dr. Raj Patel',
    doctorRole: 'Lead Pathologist • Tuber Crops',
    isDoctorOnline: true,
    sampleImageUrl:
        'https://images.unsplash.com/photo-1518977676601-b53f82aba655?w=600&auto=format&fit=crop',
  ),
  'Corn': const DiseaseModel(
    id: 'disease_corn_01',
    cropName: 'Corn',
    sampleLabel: 'Analyzed Leaf Sample • Corn',
    diseaseName: 'Northern Corn Leaf Blight',
    scientificName: 'Exserohilum turcicum',
    confidencePercent: 88,
    confidenceLevel: 'High Match',
    symptoms:
        'Long, elliptical grayish-green or tan lesions running parallel to leaf veins that eventually turn papery and dry out.',
    recommendedSteps: [
      'Foliar fungicide: Apply Mancozeb 75 WP (2.5g/L) or Azoxystrobin spray at early sign of lesion expansion.',
      'Residue management: Practice post-harvest tillage to incorporate infected crop residues into the soil.',
      'Canopy spacing: Maintain recommended planting spacing for optimal air circulation.',
    ],
    doctorName: 'Dr. Raj Patel',
    doctorRole: 'Field Crop Agronomist',
    isDoctorOnline: true,
    sampleImageUrl:
        'https://images.unsplash.com/photo-1551754655-cd27e38d2076?w=600&auto=format&fit=crop',
  ),
  'Soybean': const DiseaseModel(
    id: 'disease_soybean_01',
    cropName: 'Soybean',
    sampleLabel: 'Analyzed Leaf Sample • Soybean',
    diseaseName: 'Soybean Rust',
    scientificName: 'Phakopsora pachyrhizi',
    confidencePercent: 90,
    confidenceLevel: 'High Match',
    symptoms:
        'Tiny brown to tan lesions with raised pustules on the lower leaf surface, causing premature leaf yellowing and rapid defoliation.',
    recommendedSteps: [
      'Preventive spray: Apply Hexaconazole 5% EC (2ml/L) or Propiconazole at first sign of lower canopy pustules.',
      'Field scout: Intensify monitoring after continuous overcast or rainy weather spells.',
      'Nutritional defense: Apply foliar Potassium Nitrate (1%) to bolster cell wall strength.',
    ],
    doctorName: 'Dr. Raj Patel',
    doctorRole: 'Oilseed & Legume Agronomist',
    isDoctorOnline: true,
    sampleImageUrl:
        'https://images.unsplash.com/photo-1599420186946-7b6fb4e297f0?w=600&auto=format&fit=crop',
  ),
};

/// Helper method to retrieve tailored dummy disease results by crop name.
DiseaseModel getDiseaseResultForCrop(String? cropName) {
  if (cropName == null || cropName.trim().isEmpty) {
    return dummyDiseaseResult;
  }

  final String cleanName = cropName.trim();
  for (final key in cropDiseaseResults.keys) {
    if (cleanName.toLowerCase().contains(key.toLowerCase()) ||
        key.toLowerCase().contains(cleanName.toLowerCase())) {
      return cropDiseaseResults[key]!;
    }
  }

  return dummyDiseaseResult;
}
