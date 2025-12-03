import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  const LoginUseCase(this.repository);
  
  final AuthRepository repository;
  
  Future<User?> call(String email, String password) async {
    return await repository.login(email, password);
  }
}