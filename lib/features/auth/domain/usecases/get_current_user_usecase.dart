import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  const GetCurrentUserUseCase(this.repository);
  
  final AuthRepository repository;
  
  Future<User?> call() async {
    return await repository.getCurrentUser();
  }
}