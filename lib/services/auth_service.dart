/// Simple dummy in-memory authentication service for student project prototype.
/// Maintains authentication state locally without any backend, Firebase, or database.
class AuthService {
  // Singleton pattern
  static final AuthService instance = AuthService._internal();
  AuthService._internal();

  bool _isAuthenticated = false;
  String _currentUserName = 'Farmer Vivek';
  String _currentUserEmail = 'farmer@agriassist.com';
  String _currentUserPhone = '+91 98765 43210';

  // Preset demo credentials
  static const String demoEmail = 'farmer@agriassist.com';
  static const String demoPassword = '123456';

  bool get isAuthenticated => _isAuthenticated;
  String get currentUserName => _currentUserName;
  String get currentUserEmail => _currentUserEmail;
  String get currentUserPhone => _currentUserPhone;

  /// Attempt dummy login with preset credentials
  bool login(String email, String password) {
    final cleanEmail = email.trim().toLowerCase();
    final cleanPassword = password.trim();

    if (cleanEmail == demoEmail && cleanPassword == demoPassword) {
      _isAuthenticated = true;
      _currentUserName = 'Farmer Vivek';
      _currentUserEmail = demoEmail;
      return true;
    }
    return false;
  }

  /// Fast-track login for testing and evaluation
  void loginAsDemo() {
    _isAuthenticated = true;
    _currentUserName = 'Demo Farmer';
    _currentUserEmail = demoEmail;
    _currentUserPhone = '+91 98765 43210';
  }

  /// Dummy local account registration
  bool signup({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    _isAuthenticated = true;
    _currentUserName = name.trim();
    _currentUserEmail = email.trim().toLowerCase();
    _currentUserPhone = phone.trim();
    return true;
  }

  /// Clear authentication session
  void logout() {
    _isAuthenticated = false;
  }
}
