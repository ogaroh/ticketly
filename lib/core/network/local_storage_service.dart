import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _userKey = 'user_data';
  static const String _resolvedTicketsKey = 'resolved_tickets';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _themeKey = 'theme_mode';
  
  static late SharedPreferences _preferences;
  
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }
  
  // User authentication
  static Future<void> saveUser(String email) async {
    await _preferences.setString(_userKey, email);
    await _preferences.setBool(_isLoggedInKey, true);
  }
  
  static String? getUser() {
    return _preferences.getString(_userKey);
  }
  
  static bool isLoggedIn() {
    return _preferences.getBool(_isLoggedInKey) ?? false;
  }
  
  static Future<void> logout() async {
    await _preferences.remove(_userKey);
    await _preferences.setBool(_isLoggedInKey, false);
    // also clear resolved tickets on logout
    await _preferences.remove(_resolvedTicketsKey);
  }
  
  // Ticket resolution
  static Future<void> markTicketAsResolved(int ticketId) async {
    List<int> resolvedTickets = getResolvedTicketIds();
    if (!resolvedTickets.contains(ticketId)) {
      resolvedTickets.add(ticketId);
      await _preferences.setStringList(
        _resolvedTicketsKey, 
        resolvedTickets.map((id) => id.toString()).toList(),
      );
    }
  }
  
  static List<int> getResolvedTicketIds() {
    List<String>? resolvedTicketsString = _preferences.getStringList(_resolvedTicketsKey);
    if (resolvedTicketsString != null) {
      return resolvedTicketsString.map((id) => int.parse(id)).toList();
    }
    return [];
  }
  
  // Theme methods
  static Future<void> saveThemeMode(String themeMode) async {
    await _preferences.setString(_themeKey, themeMode);
  }

  static String? getThemeMode() {
    return _preferences.getString(_themeKey);
  }
}