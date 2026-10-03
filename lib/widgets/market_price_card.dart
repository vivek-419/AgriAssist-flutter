import 'package:flutter/material.dart';
import '../models/market_price_model.dart';
import '../theme/app_theme.dart';

/// Reusable Commodity Market Price Card matching the Figma design.
class MarketPriceCard extends StatelessWidget {
  final MarketPriceModel item;
  final VoidCallback? onTap;

  const MarketPriceCard({
    super.key,
    required this.item,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
                // Crop Thumbnail / Icon Container
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 48,
                    height: 48,
                    color: AppTheme.softGreen,
                    child: item.imageUrl != null
                        ? Image.network(
                            item.imageUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                _buildFallbackIcon(),
                          )
                        : _buildFallbackIcon(),
                  ),
                ),
                const SizedBox(width: 12),

                // Commodity Name & APMC Location
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item.commodityName,
                        style: const TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.marketLocation,
                        style: const TextStyle(
                          fontSize: 11.5,
                          color: AppTheme.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                // Price & Percentage Change Pill
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: '₹${item.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.textPrimary,
                          height: 1.0,
                        ),
                        children: [
                          TextSpan(
                            text: ' ${item.unit}',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 2.5,
                      ),
                      decoration: BoxDecoration(
                        color: item.isPositive
                            ? AppTheme.mintContainer
                            : AppTheme.alertRedBackground,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: item.isPositive
                              ? AppTheme.mintContainer
                              : AppTheme.alertRed.withValues(alpha: 0.2),
                          width: 0.8,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${item.isPositive ? '+' : '-'}${item.percentageChange.toStringAsFixed(0)}% ',
                            style: TextStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              color: item.isPositive
                                  ? AppTheme.primaryGreen
                                  : AppTheme.alertRed,
                            ),
                          ),
                          Icon(
                            item.isPositive
                                ? Icons.arrow_upward_rounded
                                : Icons.arrow_downward_rounded,
                            size: 11,
                            color: item.isPositive
                                ? AppTheme.primaryGreen
                                : AppTheme.alertRed,
                          ),
                        ],
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

  Widget _buildFallbackIcon() {
    IconData iconData = Icons.eco;
    if (item.category == 'Grains') {
      iconData = Icons.grain;
    } else if (item.category == 'Vegetables') {
      iconData = Icons.eco;
    } else if (item.category == 'Fruits') {
      iconData = Icons.park_outlined;
    }

    return Center(
      child: Icon(
        iconData,
        color: AppTheme.primaryGreen,
        size: 24,
      ),
    );
  }
}
