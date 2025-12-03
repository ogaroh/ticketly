import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.email,
    required this.isLoggedIn,
  });

  final String email;
  final bool isLoggedIn;

  User copyWith({
    String? email,
    bool? isLoggedIn,
  }) {
    return User(
      email: email ?? this.email,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }

  @override
  List<Object?> get props => [email, isLoggedIn];
}