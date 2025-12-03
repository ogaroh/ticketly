import 'package:equatable/equatable.dart';

class Ticket extends Equatable {
  const Ticket({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    this.isResolved = false,
  });

  final int id;
  final int userId;
  final String title;
  final String body;
  final bool isResolved;

  Ticket copyWith({
    int? id,
    int? userId,
    String? title,
    String? body,
    bool? isResolved,
  }) {
    return Ticket(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      body: body ?? this.body,
      isResolved: isResolved ?? this.isResolved,
    );
  }

  @override
  List<Object?> get props => [id, userId, title, body, isResolved];
}