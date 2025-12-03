import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {
  const UserModel({
    required super.email,
    required super.isLoggedIn,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  factory UserModel.fromEntity(User user) {
    return UserModel(
      email: user.email,
      isLoggedIn: user.isLoggedIn,
    );
  }

  @override
  UserModel copyWith({
    String? email,
    bool? isLoggedIn,
  }) {
    return UserModel(
      email: email ?? this.email,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }
}