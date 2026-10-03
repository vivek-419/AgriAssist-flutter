/// Model representing commodity market price entries from APMC.
class MarketPriceModel {
  final String id;
  final String commodityName;
  final String marketLocation;
  final double price;
  final String unit;
  final double percentageChange;
  final bool isPositive;
  final String category; // 'Vegetables', 'Grains', 'Fruits', 'Pulses'
  final String? imageUrl;

  const MarketPriceModel({
    required this.id,
    required this.commodityName,
    required this.marketLocation,
    required this.price,
    this.unit = '/ kg',
    required this.percentageChange,
    required this.isPositive,
    required this.category,
    this.imageUrl,
  });
}
