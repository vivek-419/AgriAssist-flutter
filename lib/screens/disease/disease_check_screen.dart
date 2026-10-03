import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_logo.dart';
import 'disease_result_screen.dart';

/// Screen 2: Crop Disease Detection Screen
/// Matches the Figma "Check Crop Health" design precisely.
class DiseaseCheckScreen extends StatefulWidget {
  final XFile? initialImage;
  final ImagePicker? imagePicker;

  const DiseaseCheckScreen({
    super.key,
    this.initialImage,
    this.imagePicker,
  });

  @override
  State<DiseaseCheckScreen> createState() => _DiseaseCheckScreenState();
}

class _DiseaseCheckScreenState extends State<DiseaseCheckScreen> {
  late final ImagePicker _picker;
  XFile? _selectedImage;
  String _selectedCrop = 'Tomato';
  bool _isAnalyzing = false;

  @override
  void initState() {
    super.initState();
    _picker = widget.imagePicker ?? ImagePicker();
    _selectedImage = widget.initialImage;
  }

  final List<String> _cropOptions = const [
    'Tomato',
    'Wheat',
    'Rice',
    'Cotton',
    'Corn',
    'Potato',
    'Soybean',
  ];

  /// Pick image from camera or gallery
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );
      if (image != null) {
        setState(() {
          _selectedImage = image;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not access image: $e'),
            backgroundColor: AppTheme.alertRed,
          ),
        );
      }
    }
  }

  /// Trigger AI disease analysis
  void _analyzeCrop() {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Please take a photo or select an image from your gallery first.',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          backgroundColor: AppTheme.alertRed,
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _isAnalyzing = true;
    });

    // Simulate AI inference time
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        setState(() {
          _isAnalyzing = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DiseaseResultScreen(
              imagePath: _selectedImage?.path,
              cropName: _selectedCrop,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackground,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          physics: const BouncingScrollPhysics(),
          children: [
            // 1. Badge & Page Title Description
            _buildHeaderSection(),
            const SizedBox(height: 14),

            // 2. Crop Image Upload Area
            _buildUploadCard(),
            const SizedBox(height: 14),

            // 3. Crop Selection Dropdown
            _buildCropSelectionDropdown(),
            const SizedBox(height: 14),

            // 4. Tips for Accurate Results Card
            _buildTipsSection(),
            const SizedBox(height: 14),

            // 5. Recent Scan Banner (Yesterday: Tomato)
            _buildRecentScanCard(),
            const SizedBox(height: 18),

            // 6. Analyze Crop Button
            _buildAnalyzeButton(),
            const SizedBox(height: 8),

            // 7. Supported Formats Info Text
            _buildSupportedFormatsInfo(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  /// Custom AppBar with AgriAssist branding and profile
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.scaffoldBackground,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleSpacing: 16,
      title: const Row(
        children: [
          AppLogo(
            size: 42,
            isCircle: true,
            withShadow: true,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'AgriAssist',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.primaryGreen,
                    height: 1.1,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Disease Check',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            IconButton(
              icon: const Icon(
                Icons.notifications_none_rounded,
                color: AppTheme.textPrimary,
                size: 24,
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('No new alerts'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
            Positioned(
              right: 12,
              top: 12,
              child: Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: AppTheme.alertRed,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 2.0),
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

  /// Badge + Title + Description Section
  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
          decoration: BoxDecoration(
            color: AppTheme.mintContainer,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.shield_outlined,
                size: 13,
                color: AppTheme.primaryGreen,
              ),
              SizedBox(width: 4),
              Text(
                'AI Plant Pathology',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primaryGreen,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Check Crop Health',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: AppTheme.textPrimary,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 3),
        const Text(
          'Upload a clear photo of your crop or leaf to identify possible diseases.',
          style: TextStyle(
            fontSize: 12.5,
            color: AppTheme.textSecondary,
            height: 1.35,
          ),
        ),
      ],
    );
  }

  /// Crop Image Upload Area with camera and gallery actions
  Widget _buildUploadCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.borderLight, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          if (_selectedImage != null) ...[
            // Image Preview Container
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: kIsWeb
                      ? Image.network(
                          _selectedImage!.path,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          File(_selectedImage!.path),
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _selectedImage = null;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGreen.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle, color: Colors.white, size: 12),
                        SizedBox(width: 4),
                        Text(
                          'Ready for analysis',
                          style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ] else ...[
            // Center Scanner Icon
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: AppTheme.mintContainer,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(
                Icons.document_scanner_outlined,
                color: AppTheme.primaryGreen,
                size: 28,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Upload Crop Image',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              'Take a photo or choose from gallery',
              style: TextStyle(
                fontSize: 11.5,
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Action Button 1: Take Photo
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton.icon(
              onPressed: () => _pickImage(ImageSource.camera),
              icon: const Icon(Icons.camera_alt_outlined, size: 18),
              label: Text(
                _selectedImage == null ? 'Take Photo' : 'Retake Photo',
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryGreen,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Action Button 2: Choose from Gallery
          SizedBox(
            width: double.infinity,
            height: 44,
            child: OutlinedButton.icon(
              onPressed: () => _pickImage(ImageSource.gallery),
              icon: const Icon(
                Icons.photo_library_outlined,
                size: 18,
                color: AppTheme.primaryGreen,
              ),
              label: Text(
                _selectedImage == null
                    ? 'Choose from Gallery'
                    : 'Choose Different Image',
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primaryGreen,
                ),
              ),
              style: OutlinedButton.styleFrom(
                backgroundColor: AppTheme.mintContainer,
                side: BorderSide.none,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Select Crop Dropdown matching Figma
  Widget _buildCropSelectionDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Select Crop',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
            Text(
              'Required',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppTheme.primaryGreenMedium,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          decoration: BoxDecoration(
            color: AppTheme.surfaceWhite,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppTheme.borderLight, width: 1),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedCrop,
              isExpanded: true,
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppTheme.textPrimary,
              ),
              items: _cropOptions.map((crop) {
                return DropdownMenuItem<String>(
                  value: crop,
                  child: Row(
                    children: [
                      Container(
                        width: 26,
                        height: 26,
                        decoration: const BoxDecoration(
                          color: AppTheme.mintContainer,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.eco,
                          color: AppTheme.primaryGreen,
                          size: 15,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        crop,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    _selectedCrop = val;
                  });
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  /// "Tips for Accurate Results" Card
  Widget _buildTipsSection() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.softGreen,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppTheme.mintContainer, width: 1),
      ),
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      size: 17,
                      color: AppTheme.primaryGreen,
                    ),
                    SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        'Tips for Accurate Results',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.textPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8),
              Text(
                '3 quick steps',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // 3 Step Cards
          _buildTipStepTile(
            stepNumber: '1',
            title: 'Focus on affected leaf',
            subtitle: 'Target spots, blight, or discoloration directly',
          ),
          const SizedBox(height: 8),
          _buildTipStepTile(
            stepNumber: '2',
            title: 'Ensure good natural lighting',
            subtitle: 'Avoid harsh shadows or blurry night shots',
          ),
          const SizedBox(height: 8),
          _buildTipStepTile(
            stepNumber: '3',
            title: 'Keep camera steady',
            subtitle: 'Hold still from 10–15 cm distance for macro close-up',
          ),
        ],
      ),
    );
  }

  /// Individual Tip Step Tile
  Widget _buildTipStepTile({
    required String stepNumber,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderLight, width: 0.8),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: AppTheme.primaryGreen,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              stepNumber,
              style: const TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 10.5,
                    color: AppTheme.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Recent Scan History Card
  Widget _buildRecentScanCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderLight, width: 1),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 40,
              height: 40,
              color: AppTheme.mintContainer,
              child: Image.asset(
                'assets/images/crop_tomato.png',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.eco,
                  color: AppTheme.primaryGreen,
                  size: 20,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Yesterday: Tomato',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),
                SizedBox(height: 1),
                Text(
                  '✓ Early Blight (Treated)',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.primaryGreen,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DiseaseResultScreen(
                    cropName: 'Tomato',
                  ),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              child: Text(
                'View',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primaryGreen,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Primary Action Button "Analyze Crop"
  Widget _buildAnalyzeButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: _isAnalyzing ? null : _analyzeCrop,
        icon: _isAnalyzing
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Icon(Icons.eco, size: 20),
        label: Text(
          _isAnalyzing ? 'Analyzing Leaf Patterns...' : 'Analyze Crop',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.2,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryGreen,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppTheme.primaryGreen.withValues(alpha: 0.6),
          disabledForegroundColor: Colors.white70,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  /// Supported image formats info footer
  Widget _buildSupportedFormatsInfo() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.info_outline,
          size: 13,
          color: AppTheme.textSecondary,
        ),
        SizedBox(width: 5),
        Flexible(
          child: Text(
            'Supported formats: JPG, PNG • Max size 10MB',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppTheme.textSecondary,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
