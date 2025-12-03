import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';
import '../../../../core/network/local_storage_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<User?> login(String email, String password) async {
    try {
      // Mock authentication - accept any non-empty email and password
      if (email.isNotEmpty && password.isNotEmpty) {
        await LocalStorageService.saveUser(email);
        return UserModel(email: email, isLoggedIn: true);
      }
      return null;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await LocalStorageService.logout();
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      final email = LocalStorageService.getUser();
      final isLoggedIn = LocalStorageService.isLoggedIn();
      
      if (email != null && isLoggedIn) {
        return UserModel(email: email, isLoggedIn: true);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get current user: $e');
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    try {
      return LocalStorageService.isLoggedIn();
    } catch (e) {
      return false;
    }
  }
}