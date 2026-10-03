import 'package:flutter/material.dart';
import '../models/crop_model.dart';
import '../theme/app_theme.dart';

/// Reusable Crop List Item Card matching the Figma design.
class CropCard extends StatelessWidget {
  final CropModel crop;
  final VoidCallback? onTap;

  const CropCard({
    super.key,
    required this.crop,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final String subtitleText = crop.isHealthy
        ? '${crop.plantedAgo} •\n${crop.stage}'
        : crop.stage;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Crop Thumbnail Image Container
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 48,
                    height: 48,
                    color: AppTheme.softGreen,
                    child: crop.imageUrl != null
                        ? (crop.imageUrl!.startsWith('assets/')
                            ? Image.asset(
                                crop.imageUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Center(
                                  child: Icon(
                                    Icons.eco,
                                    color: AppTheme.primaryGreen,
                                    size: 24,
                                  ),
                                ),
                              )
                            : Image.network(
                                crop.imageUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Center(
                                  child: Icon(
                                    Icons.eco,
                                    color: AppTheme.primaryGreen,
                                    size: 24,
                                  ),
                                ),
                              ))
                        : const Center(
                            child: Icon(
                              Icons.eco,
                              color: AppTheme.primaryGreen,
                              size: 24,
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 10),

                // Crop details (Name, acreage, stage)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${crop.name} • ${crop.acreage}',
                        style: const TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitleText,
                        style: const TextStyle(
                          fontSize: 11,
                          height: 1.25,
                          color: AppTheme.textSecondary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                // Status Pill & Action / Status Subtitle
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3.5,
                      ),
                      decoration: BoxDecoration(
                        color: crop.isHealthy
                            ? AppTheme.mintContainer
                            : AppTheme.warningPeach,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: crop.isHealthy
                              ? AppTheme.mintContainer
                              : AppTheme.warningBorder,
                          width: 0.8,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (crop.isHealthy)
                            Container(
                              width: 5,
                              height: 5,
                              decoration: const BoxDecoration(
                                color: AppTheme.accentGreen,
                                shape: BoxShape.circle,
                              ),
                            )
                          else
                            const Icon(
                              Icons.warning_amber_rounded,
                              size: 11,
                              color: AppTheme.warningOrange,
                            ),
                          const SizedBox(width: 4),
                          Text(
                            crop.statusLabel,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: crop.isHealthy
                                  ? AppTheme.primaryGreen
                                  : AppTheme.warningOrange,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      crop.statusDetail,
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight:
                            crop.isHealthy ? FontWeight.w500 : FontWeight.w700,
                        color: crop.isHealthy
                            ? AppTheme.textSecondary
                            : AppTheme.primaryGreen,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
