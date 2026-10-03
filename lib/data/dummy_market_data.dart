import '../models/market_price_model.dart';

/// Dummy APMC market commodities dataset matching the Figma prototype.
final List<MarketPriceModel> dummyMarketPriceList = [
  const MarketPriceModel(
    id: 'mkt_1',
    commodityName: 'Tomato',
    marketLocation: 'Mumbai APMC Market',
    price: 32.0,
    unit: '/ kg',
    percentageChange: 8.0,
    isPositive: true,
    category: 'Vegetables',
    imageUrl: 'https://images.unsplash.com/photo-1592417817098-8f3d6eb222e4?w=150&auto=format&fit=crop',
  ),
  const MarketPriceModel(
    id: 'mkt_2',
    commodityName: 'Onion',
    marketLocation: 'Mumbai APMC Market',
    price: 28.0,
    unit: '/ kg',
    percentageChange: 3.0,
    isPositive: false,
    category: 'Vegetables',
    imageUrl: 'https://images.unsplash.com/photo-1618512496248-a07fe83aa8cb?w=150&auto=format&fit=crop',
  ),
  const MarketPriceModel(
    id: 'mkt_3',
    commodityName: 'Potato',
    marketLocation: 'Mumbai APMC Market',
    price: 24.0,
    unit: '/ kg',
    percentageChange: 5.0,
    isPositive: true,
    category: 'Vegetables',
    imageUrl: 'https://images.unsplash.com/photo-1518977676601-b53f82aba655?w=150&auto=format&fit=crop',
  ),
  const MarketPriceModel(
    id: 'mkt_4',
    commodityName: 'Wheat',
    marketLocation: 'Mumbai APMC Market',
    price: 31.0,
    unit: '/ kg',
    percentageChange: 2.0,
    isPositive: true,
    category: 'Grains',
    imageUrl: 'https://images.unsplash.com/photo-1574323347407-f5e1ad6d020b?w=150&auto=format&fit=crop',
  ),
  const MarketPriceModel(
    id: 'mkt_5',
    commodityName: 'Rice (Basmati)',
    marketLocation: 'Mumbai APMC Market',
    price: 48.0,
    unit: '/ kg',
    percentageChange: 1.0,
    isPositive: false,
    category: 'Grains',
    imageUrl: 'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=150&auto=format&fit=crop',
  ),
];

final List<String> marketCategories = [
  'All',
  'Vegetables',
  'Grains',
  'Fruits',
  'Pulses',
];
