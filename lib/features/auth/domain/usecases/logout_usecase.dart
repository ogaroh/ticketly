import '../repositories/auth_repository.dart';

class LogoutUseCase {
  const LogoutUseCase(this.repository);
  
  final AuthRepository repository;
  
  Future<void> call() async {
    return await repository.logout();
  }
}