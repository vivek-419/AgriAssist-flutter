import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agri_assist/main.dart';
import 'package:agri_assist/services/auth_service.dart';
import 'package:agri_assist/widgets/market_price_card.dart';

void main() {
  setUp(() {
    AuthService.instance.logout();
  });

  // ==========================================
  // AUTHENTICATION FLOW TESTS
  // ==========================================

  testWidgets(
      'Auth Flow 1: Unauthenticated app launch displays Login Screen with brand and inputs',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(const AgriAssistApp());
    await tester.pumpAndSettle();

    // Verify Login Screen Header & Inputs
    expect(find.text('AgriAssist'), findsOneWidget);
    expect(find.text('Smart support for better farming'), findsOneWidget);
    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text('Login to continue managing your crops'), findsOneWidget);
    expect(find.text('Email Address'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Continue as Demo Farmer'), findsOneWidget);
    expect(find.text('Sign Up'), findsOneWidget);

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });

  testWidgets(
      'Auth Flow 2: Invalid login credentials trigger SnackBar error message',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(const AgriAssistApp());
    await tester.pumpAndSettle();

    final Finder emailField = find.widgetWithText(TextFormField, 'Enter your email');
    final Finder passwordField = find.widgetWithText(TextFormField, 'Enter your password');

    await tester.enterText(emailField, 'wrong@example.com');
    await tester.enterText(passwordField, 'wrongpass');
    await tester.tap(find.text('Login'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    // Verify Invalid Credentials Error SnackBar
    expect(find.text('Invalid email or password'), findsOneWidget);
    expect(AuthService.instance.isAuthenticated, isFalse);

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });

  testWidgets(
      'Auth Flow 3: Valid credentials (farmer@agriassist.com / 123456) log in successfully',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(const AgriAssistApp());
    await tester.pumpAndSettle();

    final Finder emailField = find.widgetWithText(TextFormField, 'Enter your email');
    final Finder passwordField = find.widgetWithText(TextFormField, 'Enter your password');

    await tester.enterText(emailField, 'farmer@agriassist.com');
    await tester.enterText(passwordField, '123456');
    await tester.tap(find.text('Login'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    // Verify successfully entered Home Dashboard
    expect(find.text('Good morning, Farmer!'), findsOneWidget);
    expect(AuthService.instance.isAuthenticated, isTrue);

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });

  testWidgets(
      'Auth Flow 4: Continue as Demo Farmer bypasses manual input and enters Dashboard',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(const AgriAssistApp());
    await tester.pumpAndSettle();

    final Finder demoBtn = find.text('Continue as Demo Farmer');
    expect(demoBtn, findsOneWidget);
    await tester.tap(demoBtn);
    await tester.pumpAndSettle();

    // Verify entered Home Dashboard
    expect(find.text('Good morning, Farmer!'), findsOneWidget);
    expect(AuthService.instance.isAuthenticated, isTrue);

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });

  testWidgets(
      'Auth Flow 5: Sign Up form validation, account creation, and redirect to Dashboard',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(const AgriAssistApp());
    await tester.pumpAndSettle();

    // Tap "Sign Up" from Login screen
    await tester.tap(find.text('Sign Up'));
    await tester.pumpAndSettle();

    // Verify on Sign Up Screen
    expect(find.text('Create Your Account'), findsOneWidget);
    expect(find.text('Join AgriAssist and manage your crops smarter'), findsOneWidget);

    // Enter form details
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Enter your full name'), 'Ramesh Kumar');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Enter your email'), 'ramesh@agriassist.com');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Enter 10-digit mobile number'), '9876543210');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Create password (min 6 chars)'), 'secret123');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Re-enter your password'), 'secret123');

    // Tap "Create Account"
    await tester.tap(find.text('Create Account'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    // Verify success SnackBar and Dashboard entry
    expect(find.text('Account created successfully'), findsOneWidget);
    expect(find.text('Good morning, Farmer!'), findsOneWidget);
    expect(AuthService.instance.isAuthenticated, isTrue);

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });

  testWidgets(
      'Auth Flow 6: Profile modal and Logout clears authentication and returns to Login',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(const AgriAssistApp(isTestingAuthenticated: true));
    await tester.pumpAndSettle();

    expect(find.text('Good morning, Farmer!'), findsOneWidget);

    // Tap on Profile Avatar in AppBar
    final Finder profileAvatar = find.byIcon(Icons.person).first;
    await tester.tap(profileAvatar);
    await tester.pumpAndSettle();

    // Verify Profile Modal opened
    expect(find.text('Active Farmer Session'), findsOneWidget);
    expect(find.text('Logout'), findsOneWidget);

    // Tap "Logout"
    await tester.tap(find.text('Logout'));
    await tester.pumpAndSettle();

    // Verify logged out and back on Login screen
    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text('Logged out successfully'), findsOneWidget);
    expect(AuthService.instance.isAuthenticated, isFalse);

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });

  // ==========================================
  // DASHBOARD & FEATURE SCREEN TESTS
  // ==========================================

  testWidgets('AgriAssist home screen responsiveness on standard phone (390x844)',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(const AgriAssistApp(isTestingAuthenticated: true));
    await tester.pumpAndSettle();

    // Verify critical elements are present
    expect(find.text('AgriAssist'), findsWidgets);
    expect(find.text('Good morning, Farmer!'), findsOneWidget);
    expect(find.text('Mumbai, Maharashtra'), findsOneWidget);
    expect(find.text('Field Tools'), findsOneWidget);
    expect(find.text('Check Crop Disease'), findsOneWidget);
    expect(find.text('Market Prices'), findsOneWidget);
    expect(find.text('Ask an Expert'), findsOneWidget);
    expect(find.text('My Crops'), findsOneWidget);

    // Scroll to see the bottom daily tip
    await tester.scrollUntilVisible(
      find.text('Daily Farming Tip'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Daily Farming Tip'), findsOneWidget);

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });

  testWidgets('AgriAssist home screen responsiveness on compact phone (360x640)',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(const AgriAssistApp(isTestingAuthenticated: true));
    await tester.pumpAndSettle();

    expect(find.text('Good morning, Farmer!'), findsOneWidget);
    expect(find.text('Field Tools'), findsOneWidget);
    expect(find.text('Check Crop Disease'), findsOneWidget);

    // Scroll to bottom
    await tester.scrollUntilVisible(
      find.text('Daily Farming Tip'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Daily Farming Tip'), findsOneWidget);

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });

  testWidgets(
      'Navigate to Weather Forecast Screen and verify all components & responsiveness',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(const AgriAssistApp(isTestingAuthenticated: true));
    await tester.pumpAndSettle();

    // Tap on View Forecast in Weather Card
    final Finder viewForecastFinder = find.text('View Forecast');
    expect(viewForecastFinder, findsOneWidget);
    await tester.tap(viewForecastFinder);
    await tester.pumpAndSettle();

    // Verify Weather Screen header and details
    expect(find.text('Weather'), findsOneWidget);
    expect(find.text('CURRENT CONDITIONS'), findsOneWidget);
    expect(find.textContaining('28°C'), findsWidgets);
    expect(find.textContaining('82°F'), findsOneWidget);
    expect(find.text('Partly Cloudy'), findsWidgets);
    expect(find.text('Humidity'), findsOneWidget);
    expect(find.text('72%'), findsOneWidget);
    expect(find.text('Wind Speed'), findsOneWidget);
    expect(find.text('12 km/h'), findsOneWidget);
    expect(find.text('UV Index'), findsOneWidget);
    expect(find.text('5 Mod'), findsOneWidget);
    expect(find.text('Precipitation'), findsOneWidget);
    expect(find.text('10%'), findsOneWidget);
    expect(find.text('🌾 Farming Tip'), findsOneWidget);
    expect(find.text('Irrigation'), findsOneWidget);
    expect(find.text('MICRO-CLIMATE RADAR'), findsOneWidget);
    expect(find.text('Soil Moisture Level'), findsOneWidget);

    // Scroll to verify 5-day forecast and spray window
    await tester.scrollUntilVisible(
      find.text('Hourly Spray Window'),
      200,
      scrollable: find.byType(Scrollable).first,
    );

    expect(find.text('5-Day Forecast'), findsOneWidget);
    expect(find.text('Today'), findsOneWidget);
    expect(find.text('Tomorrow'), findsOneWidget);
    expect(find.text('Wednesday'), findsOneWidget);
    expect(find.text('Thursday'), findsOneWidget);
    expect(find.text('Friday'), findsOneWidget);
    expect(find.text('Hourly Spray Window'), findsOneWidget);

    // Test back button
    final Finder backButton = find.byIcon(Icons.arrow_back);
    expect(backButton, findsOneWidget);
    await tester.tap(backButton);
    await tester.pumpAndSettle();

    // Confirmed back on home screen
    expect(find.text('Good morning, Farmer!'), findsOneWidget);

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });

  testWidgets(
      'Crop Disease Detection screen validation, components, and result screen flow',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(const AgriAssistApp(isTestingAuthenticated: true));
    await tester.pumpAndSettle();

    // Switch to Disease Check tab (index 1)
    final Finder diseaseTab = find.text('Disease Check');
    expect(diseaseTab, findsWidgets);
    await tester.tap(diseaseTab.first);
    await tester.pumpAndSettle();

    // Verify Disease Check screen elements
    expect(find.text('AI Plant Pathology'), findsOneWidget);
    expect(find.text('Check Crop Health'), findsOneWidget);
    expect(
      find.text(
          'Upload a clear photo of your crop or leaf to identify possible diseases.'),
      findsOneWidget,
    );
    expect(find.text('Upload Crop Image'), findsOneWidget);
    expect(find.text('Take Photo'), findsOneWidget);
    expect(find.text('Choose from Gallery'), findsOneWidget);
    expect(find.text('Select Crop'), findsOneWidget);
    expect(find.text('Tomato'), findsWidgets);
    expect(find.text('Tips for Accurate Results'), findsOneWidget);

    // Scroll to see recent scan card and analyze button
    await tester.scrollUntilVisible(
      find.text('Supported formats: JPG, PNG • Max size 10MB'),
      200,
      scrollable: find.byType(Scrollable).first,
    );

    expect(find.text('Yesterday: Tomato'), findsOneWidget);
    expect(find.text('Analyze Crop'), findsOneWidget);
    expect(
      find.text('Supported formats: JPG, PNG • Max size 10MB'),
      findsOneWidget,
    );

    // Test pressing Analyze Crop without image (validation message)
    await tester.tap(find.text('Analyze Crop'));
    await tester.pump();
    expect(
      find.text(
          'Please take a photo or select an image from your gallery first.'),
      findsOneWidget,
    );
    await tester.pump(const Duration(seconds: 4)); // dismiss snackbar

    // Tap "View" on the Recent Scan card to navigate to Disease Result screen
    final Finder viewRecentFinder = find.text('View');
    expect(viewRecentFinder, findsOneWidget);
    await tester.tap(viewRecentFinder);
    await tester.pumpAndSettle();

    // Verify Disease Result screen components
    expect(find.text('Disease Result'), findsOneWidget);
    expect(find.text('Possible Disease Detected'), findsOneWidget);
    expect(find.text('AI Engine 4.2'), findsOneWidget);
    expect(find.text('Tomato Early Blight'), findsOneWidget);
    expect(find.text('Alternaria solani'), findsOneWidget);
    expect(find.text('Diagnostic Confidence'), findsOneWidget);
    expect(find.text('92%'), findsOneWidget);
    expect(find.text('Symptoms'), findsOneWidget);
    // Scroll down to verify recommended action steps, doctor, and action buttons
    await tester.scrollUntilVisible(
      find.text('Check Another Crop'),
      200,
      scrollable: find.byType(Scrollable).first,
    );

    expect(find.text('Recommended Action'), findsOneWidget);
    expect(find.text('3 Steps'), findsOneWidget);
    expect(find.text('Dr. Raj Patel'), findsOneWidget);
    expect(find.text('Ask an Expert'), findsOneWidget);
    expect(find.text('Check Another Crop'), findsOneWidget);

    // Test back button / Check Another Crop pops back to Disease Check screen
    final Finder backFinder = find.byIcon(Icons.arrow_back);
    await tester.tap(backFinder);
    await tester.pumpAndSettle();
    expect(find.text('Analyze Crop'), findsOneWidget);

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });

  testWidgets(
      'Market Prices screen search, category filters, market selector, and responsiveness',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(const AgriAssistApp(isTestingAuthenticated: true));
    await tester.pumpAndSettle();

    // Switch to Market tab (index 2)
    final Finder marketTab = find.text('Market');
    expect(marketTab, findsWidgets);
    await tester.tap(marketTab.first);
    await tester.pumpAndSettle();

    // Verify Header & Components
    expect(find.text('Market Prices'), findsOneWidget);
    expect(find.text('LIVE APMC'), findsOneWidget);
    expect(find.text("Today's agricultural market prices"), findsOneWidget);
    expect(find.text('Market: Mumbai (APMC)'), findsOneWidget);

    // Verify all 5 dummy crops are displayed initially
    expect(find.text('Tomato'), findsOneWidget);
    expect(find.text('Onion'), findsOneWidget);
    expect(find.text('Potato'), findsOneWidget);
    expect(find.text('Wheat'), findsOneWidget);
    expect(find.text('Rice (Basmati)'), findsOneWidget);

    // Test Search Functionality: Search "Wheat"
    final Finder searchField = find.byType(TextField);
    expect(searchField, findsOneWidget);
    await tester.enterText(searchField, 'Wheat');
    await tester.pumpAndSettle();

    expect(find.widgetWithText(MarketPriceCard, 'Wheat'), findsOneWidget);
    expect(find.widgetWithText(MarketPriceCard, 'Tomato'), findsNothing);
    expect(find.widgetWithText(MarketPriceCard, 'Onion'), findsNothing);

    // Clear search
    await tester.enterText(searchField, '');
    await tester.pumpAndSettle();
    expect(find.widgetWithText(MarketPriceCard, 'Tomato'), findsOneWidget);
    expect(find.widgetWithText(MarketPriceCard, 'Wheat'), findsOneWidget);

    // Test Filter Chips: Tap "Grains"
    final Finder grainsChip = find.text('Grains');
    expect(grainsChip, findsOneWidget);
    await tester.tap(grainsChip);
    await tester.pumpAndSettle();

    expect(find.widgetWithText(MarketPriceCard, 'Wheat'), findsOneWidget);
    expect(
        find.widgetWithText(MarketPriceCard, 'Rice (Basmati)'), findsOneWidget);
    expect(find.widgetWithText(MarketPriceCard, 'Tomato'), findsNothing);

    // Tap "Vegetables"
    final Finder vegChip = find.text('Vegetables');
    await tester.tap(vegChip);
    await tester.pumpAndSettle();

    expect(find.widgetWithText(MarketPriceCard, 'Tomato'), findsOneWidget);
    expect(find.widgetWithText(MarketPriceCard, 'Onion'), findsOneWidget);
    expect(find.widgetWithText(MarketPriceCard, 'Potato'), findsOneWidget);
    expect(find.widgetWithText(MarketPriceCard, 'Wheat'), findsNothing);

    // Tap "All"
    final Finder allChip = find.text('All');
    await tester.tap(allChip);
    await tester.pumpAndSettle();
    expect(find.widgetWithText(MarketPriceCard, 'Wheat'), findsOneWidget);
    expect(find.widgetWithText(MarketPriceCard, 'Tomato'), findsOneWidget);

    // Test Market Selector Modal
    await tester.tap(find.text('Market: Mumbai (APMC)'));
    await tester.pumpAndSettle();
    expect(find.text('Select Mandi / Market'), findsOneWidget);
    expect(find.text('Pune (APMC)'), findsOneWidget);

    await tester.tap(find.text('Pune (APMC)'));
    await tester.pumpAndSettle();
    expect(find.text('Market: Pune (APMC)'), findsOneWidget);

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });

  testWidgets('Market Prices screen responsiveness on compact phone (360x640)',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(const AgriAssistApp(isTestingAuthenticated: true));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Market').first);
    await tester.pumpAndSettle();

    expect(find.text('Market Prices'), findsOneWidget);

    // Scroll to bottom
    await tester.scrollUntilVisible(
      find.text('View 30-Day Price History'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('View 30-Day Price History'), findsOneWidget);

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });

  testWidgets(
      'Expert Chat screen conversation flow, message sending, simulated reply & responsiveness',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(const AgriAssistApp(isTestingAuthenticated: true));
    await tester.pumpAndSettle();

    // Switch to Expert tab (index 3)
    final Finder expertTab = find.text('Expert');
    expect(expertTab, findsWidgets);
    await tester.tap(expertTab.first);
    await tester.pumpAndSettle();

    // Verify Expert Profile Header
    expect(find.text('Dr. Raj Patel'), findsOneWidget);
    expect(
      find.text('Agricultural Expert • Plant Pathology'),
      findsOneWidget,
    );
    expect(find.text('Online • Replies in ~5m'), findsOneWidget);
    expect(
      find.text('Active Session: Field Sector 4 (Tomatoes)'),
      findsOneWidget,
    );

    // Verify Initial Conversation
    expect(
      find.text('Hello! How can I help you with your crop?'),
      findsOneWidget,
    );
    expect(
      find.text('My tomato leaves have started developing dark spots.'),
      findsOneWidget,
    );
    expect(
      find.text('Please share a clear image of the affected leaves.'),
      findsOneWidget,
    );

    // Verify Message Composer UI elements
    expect(find.byIcon(Icons.attach_file_rounded), findsOneWidget);
    expect(find.byIcon(Icons.camera_alt_outlined), findsOneWidget);
    expect(find.text('Type your message...'), findsOneWidget);
    expect(find.byIcon(Icons.send_rounded), findsOneWidget);

    // Test Sending a Message: "What fungicide should I use for blight?"
    final Finder inputField = find.byType(TextField);
    await tester.enterText(
      inputField,
      'What fungicide should I use for blight?',
    );
    await tester.pump();

    final Finder sendButton = find.byIcon(Icons.send_rounded);
    await tester.tap(sendButton);
    await tester.pump();

    // Verify farmer message added immediately
    expect(
      find.text('What fungicide should I use for blight?'),
      findsOneWidget,
    );
    expect(find.text('Dr. Raj Patel is typing...'), findsOneWidget);

    // Wait for simulated expert response delay
    await tester.pump(const Duration(milliseconds: 1000));
    await tester.pumpAndSettle();

    // Verify simulated expert response arrived
    expect(
      find.text(
        'That confirms typical Early Blight symptoms. Prune the lowest infected leaves and spray with a copper-based fungicide before evening.',
      ),
      findsOneWidget,
    );

    // Test quick suggestion chip: "Recommended dosage?"
    final Finder dosageChip = find.text('Recommended dosage?');
    expect(dosageChip, findsOneWidget);
    await tester.tap(dosageChip);
    await tester.pump();

    expect(find.text('Recommended dosage?'), findsWidgets);
    await tester.pump(const Duration(milliseconds: 1000));
    await tester.pumpAndSettle();

    expect(
      find.text(
        'For Early Blight in tomatoes, apply Copper Hydroxide (2g per liter) or Mancozeb 75 WP (2.5g per liter) uniformly over the foliage.',
      ),
      findsOneWidget,
    );

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });

  testWidgets('Expert Chat screen responsiveness on compact phone (360x640)',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(const AgriAssistApp(isTestingAuthenticated: true));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Expert').first);
    await tester.pumpAndSettle();

    expect(find.text('Dr. Raj Patel'), findsOneWidget);
    expect(find.text('Type your message...'), findsOneWidget);

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });

  testWidgets(
      'Connected Flow: Home Quick Action cards navigate directly to respective tabs',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(const AgriAssistApp(isTestingAuthenticated: true));
    await tester.pumpAndSettle();

    // 1. Tap "Check Crop Disease" hero card on Home Screen
    final Finder checkDiseaseCard = find.text('Check Crop Disease');
    expect(checkDiseaseCard, findsOneWidget);
    await tester.tap(checkDiseaseCard);
    await tester.pumpAndSettle();

    // Verify switched to Disease Check tab
    expect(find.text('AI Plant Pathology'), findsOneWidget);
    expect(find.text('Check Crop Health'), findsOneWidget);

    // Switch back to Home tab
    await tester.tap(find.text('Home').first);
    await tester.pumpAndSettle();
    expect(find.text('Good morning, Farmer!'), findsOneWidget);

    // 2. Tap "Market Prices" quick action card on Home Screen
    final Finder marketPricesCard = find.text('Market Prices');
    expect(marketPricesCard, findsOneWidget);
    await tester.tap(marketPricesCard);
    await tester.pumpAndSettle();

    // Verify switched to Market tab
    expect(find.text('LIVE APMC'), findsOneWidget);

    // Switch back to Home tab
    await tester.tap(find.text('Home').first);
    await tester.pumpAndSettle();

    // 3. Tap "Ask an Expert" quick action card on Home Screen
    final Finder askExpertCard = find.text('Ask an Expert');
    expect(askExpertCard, findsOneWidget);
    await tester.tap(askExpertCard);
    await tester.pumpAndSettle();

    // Verify switched to Expert tab
    expect(find.text('Dr. Raj Patel'), findsOneWidget);

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });

  testWidgets(
      'Connected Flow: Disease Result Screen "Ask an Expert" and back navigation to Disease Check',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(const AgriAssistApp(isTestingAuthenticated: true));
    await tester.pumpAndSettle();

    // Switch to Disease Check tab
    await tester.tap(find.text('Disease Check').first);
    await tester.pumpAndSettle();

    // Tap "View" on Recent Scan to open Disease Result screen
    await tester.scrollUntilVisible(
      find.text('View'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('View'));
    await tester.pumpAndSettle();

    // Verify on Disease Result screen
    expect(find.text('Disease Result'), findsOneWidget);
    expect(find.text('Tomato Early Blight'), findsOneWidget);

    // Scroll to "Ask an Expert" button and tap it
    await tester.scrollUntilVisible(
      find.text('Ask an Expert'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Ask an Expert'));
    await tester.pumpAndSettle();

    // Verify on Expert Chat screen
    expect(find.text('Dr. Raj Patel'), findsOneWidget);
    expect(find.text('Type your message...'), findsOneWidget);

    // Navigate back from Expert Chat to Disease Result via back button
    final Finder expertBackFinder = find.byIcon(Icons.arrow_back);
    expect(expertBackFinder, findsOneWidget);
    await tester.tap(expertBackFinder);
    await tester.pumpAndSettle();
    expect(find.text('Disease Result'), findsOneWidget);

    // Tap "Check Another Crop" button to pop back to Disease Check
    await tester.scrollUntilVisible(
      find.text('Check Another Crop'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Check Another Crop'));
    await tester.pumpAndSettle();

    // Verify back on Disease Check screen
    expect(find.text('Analyze Crop'), findsOneWidget);

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });

  testWidgets(
      'Connected Flow: Home Attention Crop navigates directly to Disease Result screen',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(const AgriAssistApp(isTestingAuthenticated: true));
    await tester.pumpAndSettle();

    // Scroll down on Home Screen to reveal the "Needs Attention" Wheat crop card
    await tester.drag(find.byType(ListView).first, const Offset(0, -300));
    await tester.pumpAndSettle();

    final Finder attentionCrop = find.textContaining('Wheat');
    expect(attentionCrop, findsOneWidget);
    await tester.tap(attentionCrop);
    await tester.pumpAndSettle();

    // Verify pushed to Disease Result Screen with Wheat diagnosis
    expect(find.text('Disease Result'), findsOneWidget);
    expect(find.text('Wheat Leaf Rust (Brown Rust)'), findsOneWidget);
    expect(find.text('Puccinia triticina'), findsOneWidget);

    // Pop back to Home Screen
    final Finder backFinder = find.byIcon(Icons.arrow_back);
    await tester.tap(backFinder);
    await tester.pumpAndSettle();

    expect(find.text('My Crops'), findsOneWidget);

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });

  testWidgets(
      'Responsive Audit: Small Android phone (320x480) across all 4 main tabs without overflow',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(320, 480);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(const AgriAssistApp(isTestingAuthenticated: true));
    await tester.pumpAndSettle();

    // Tab 0: Home Screen on 320x480
    expect(find.text('AgriAssist'), findsWidgets);
    expect(find.text('Good morning, Farmer!'), findsOneWidget);

    // Scroll to see Field Tools on small screen
    await tester.drag(find.byType(ListView).first, const Offset(0, -300));
    await tester.pumpAndSettle();
    expect(find.text('Field Tools'), findsOneWidget);

    // Tab 1: Disease Check Screen on 320x480
    await tester.tap(find.text('Disease Check').first);
    await tester.pumpAndSettle();
    expect(find.text('Check Crop Health'), findsOneWidget);
    expect(find.text('Upload Crop Image'), findsOneWidget);

    // Scroll to see Select Crop
    await tester.drag(find.byType(ListView).first, const Offset(0, -200));
    await tester.pumpAndSettle();
    expect(find.text('Select Crop'), findsOneWidget);

    // Tab 2: Market Screen on 320x480
    await tester.tap(find.text('Market').first);
    await tester.pumpAndSettle();
    expect(find.text('Market Prices'), findsOneWidget);
    expect(find.text('LIVE APMC'), findsOneWidget);

    // Tab 3: Expert Chat Screen on 320x480
    await tester.tap(find.text('Expert').first);
    await tester.pumpAndSettle();
    expect(find.text('Dr. Raj Patel'), findsOneWidget);
    expect(find.text('Type your message...'), findsOneWidget);

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });

  testWidgets(
      'Responsive Audit: Standard Android phone (412x915 Pixel 7) across all screens',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(412, 915);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(const AgriAssistApp(isTestingAuthenticated: true));
    await tester.pumpAndSettle();

    // Home Screen
    expect(find.text('AgriAssist'), findsWidgets);
    expect(find.text('Good morning, Farmer!'), findsOneWidget);

    // Weather Screen
    await tester.tap(find.text('View Forecast'));
    await tester.pumpAndSettle();
    expect(find.text('CURRENT CONDITIONS'), findsOneWidget);
    expect(find.text('5-Day Forecast'), findsOneWidget);

    // Back to Home
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // Disease Check & Result
    await tester.tap(find.text('Disease Check').first);
    await tester.pumpAndSettle();
    await tester.drag(find.byType(ListView).first, const Offset(0, -250));
    await tester.pumpAndSettle();
    await tester.tap(find.text('View'));
    await tester.pumpAndSettle();
    expect(find.text('Disease Result'), findsOneWidget);
    expect(find.text('Tomato Early Blight'), findsOneWidget);

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });

  testWidgets(
      'Responsive Audit: Large Android device / Foldable (600x1024) across all screens',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(600, 1024);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(const AgriAssistApp(isTestingAuthenticated: true));
    await tester.pumpAndSettle();

    // Home
    expect(find.text('AgriAssist'), findsWidgets);
    expect(find.text('Good morning, Farmer!'), findsOneWidget);
    expect(find.text('Field Tools'), findsOneWidget);
    expect(find.text('My Crops'), findsOneWidget);

    // Market
    await tester.tap(find.text('Market').first);
    await tester.pumpAndSettle();
    expect(find.text('Market Prices'), findsOneWidget);
    expect(find.text('Tomato'), findsOneWidget);
    expect(find.text('Wheat'), findsOneWidget);

    // Expert Chat
    await tester.tap(find.text('Expert').first);
    await tester.pumpAndSettle();
    expect(find.text('Dr. Raj Patel'), findsOneWidget);
    expect(find.text('Type your message...'), findsOneWidget);

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });

  testWidgets(
      'Full End-to-End 19-Step User Journey: Launch, Weather, Disease Check, Expert Chat, Market & Navigation',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;

    // Step 1: Launch application
    await tester.pumpWidget(const AgriAssistApp(isTestingAuthenticated: true));
    await tester.pumpAndSettle();

    // Step 2: Home screen loads
    expect(find.text('AgriAssist'), findsWidgets);
    expect(find.text('Good morning, Farmer!'), findsOneWidget);

    // Step 3: Weather card displays
    expect(find.text('Mumbai, Maharashtra'), findsOneWidget);
    expect(find.textContaining('28'), findsWidgets);
    expect(find.text('View Forecast'), findsOneWidget);

    // Step 4: Open Weather Forecast
    await tester.tap(find.text('View Forecast'));
    await tester.pumpAndSettle();
    expect(find.text('Weather'), findsOneWidget);
    expect(find.text('CURRENT CONDITIONS'), findsOneWidget);

    // Step 5: Return to Home
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    expect(find.text('Good morning, Farmer!'), findsOneWidget);

    // Step 6: Open Disease Check
    await tester.tap(find.text('Disease Check').first);
    await tester.pumpAndSettle();
    expect(find.text('Check Crop Health'), findsOneWidget);
    expect(find.text('Upload Crop Image'), findsOneWidget);

    // Step 7: Select crop
    expect(find.text('Select Crop'), findsOneWidget);
    expect(find.text('Tomato'), findsWidgets);

    // Step 8: Choose an image / validation & scan preview
    expect(find.text('Take Photo'), findsOneWidget);
    expect(find.text('Choose from Gallery'), findsOneWidget);

    // Scroll to see recent scan card
    await tester.scrollUntilVisible(
      find.text('Yesterday: Tomato'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Yesterday: Tomato'), findsOneWidget);

    // Step 9: Analyze crop (via Recent scan result inspection)
    final Finder viewFinder = find.text('View');
    expect(viewFinder, findsOneWidget);
    await tester.tap(viewFinder);
    await tester.pumpAndSettle();

    // Step 10: Disease Result appears
    expect(find.text('Disease Result'), findsOneWidget);
    expect(find.text('Possible Disease Detected'), findsOneWidget);
    expect(find.text('Tomato Early Blight'), findsOneWidget);
    expect(find.text('92%'), findsOneWidget);

    // Step 11: Ask an Expert
    await tester.scrollUntilVisible(
      find.text('Ask an Expert'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Ask an Expert'), findsOneWidget);
    await tester.tap(find.text('Ask an Expert'));
    await tester.pumpAndSettle();

    // Step 12: Expert Chat opens
    expect(find.text('Dr. Raj Patel'), findsOneWidget);
    expect(
      find.text('Agricultural Expert • Plant Pathology'),
      findsOneWidget,
    );

    // Step 13: Send a message
    final Finder messageInput = find.byType(TextField);
    expect(messageInput, findsOneWidget);
    await tester.enterText(
      messageInput,
      'Can you recommend a dosage for early blight treatment?',
    );
    await tester.pump();

    final Finder sendBtn = find.byIcon(Icons.send_rounded);
    await tester.tap(sendBtn);
    await tester.pump();

    expect(
      find.text('Can you recommend a dosage for early blight treatment?'),
      findsOneWidget,
    );
    await tester.pump(const Duration(milliseconds: 1000));
    await tester.pumpAndSettle();

    // Step 14: Return to Home
    // Pop Expert Chat back to Disease Result
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    expect(find.text('Disease Result'), findsOneWidget);

    // Pop Disease Result back to Disease Check
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    expect(find.text('Disease Check'), findsWidgets);

    // Switch to Home tab
    await tester.tap(find.text('Home').first);
    await tester.pumpAndSettle();
    expect(find.text('Good morning, Farmer!'), findsOneWidget);

    // Step 15: Open Market
    await tester.tap(find.text('Market').first);
    await tester.pumpAndSettle();
    expect(find.text('Market Prices'), findsOneWidget);
    expect(find.text('LIVE APMC'), findsOneWidget);

    // Step 16: Search for Tomato
    final Finder marketSearchField = find.byType(TextField);
    await tester.enterText(marketSearchField, 'Tomato');
    await tester.pumpAndSettle();
    expect(find.widgetWithText(MarketPriceCard, 'Tomato'), findsOneWidget);
    expect(find.widgetWithText(MarketPriceCard, 'Onion'), findsNothing);

    // Step 17: Apply category filter
    await tester.enterText(marketSearchField, '');
    await tester.pumpAndSettle();
    final Finder grainsChip = find.text('Grains');
    await tester.tap(grainsChip);
    await tester.pumpAndSettle();

    // Step 18: Verify filtered results
    expect(find.widgetWithText(MarketPriceCard, 'Wheat'), findsOneWidget);
    expect(
      find.widgetWithText(MarketPriceCard, 'Rice (Basmati)'),
      findsOneWidget,
    );
    expect(find.widgetWithText(MarketPriceCard, 'Tomato'), findsNothing);

    // Step 19: Open Expert through bottom navigation
    await tester.tap(find.text('Expert').first);
    await tester.pumpAndSettle();
    expect(find.text('Dr. Raj Patel'), findsOneWidget);
    expect(find.text('Online • Replies in ~5m'), findsOneWidget);

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });
}
