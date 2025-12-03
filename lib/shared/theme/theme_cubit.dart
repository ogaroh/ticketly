import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/network/local_storage_service.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system) {
    _loadThemeMode();
  }

  void _loadThemeMode() async {
    final themeString = LocalStorageService.getThemeMode();
    if (themeString != null) {
      final themeMode = _stringToThemeMode(themeString);
      emit(themeMode);
    }
  }

  void changeTheme(ThemeMode themeMode) async {
    await LocalStorageService.saveThemeMode(_themeModeToString(themeMode));
    emit(themeMode);
  }

  ThemeMode _stringToThemeMode(String value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  String _themeModeToString(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }
}