import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/ticket.dart';

part 'ticket_model.g.dart';

@JsonSerializable()
class TicketModel extends Ticket {
  const TicketModel({
    required super.id,
    required super.userId,
    required super.title,
    required super.body,
    super.isResolved = false,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) =>
      _$TicketModelFromJson(json);

  Map<String, dynamic> toJson() => _$TicketModelToJson(this);

  factory TicketModel.fromEntity(Ticket ticket) {
    return TicketModel(
      id: ticket.id,
      userId: ticket.userId,
      title: ticket.title,
      body: ticket.body,
      isResolved: ticket.isResolved,
    );
  }

  @override
  TicketModel copyWith({
    int? id,
    int? userId,
    String? title,
    String? body,
    bool? isResolved,
  }) {
    return TicketModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      body: body ?? this.body,
      isResolved: isResolved ?? this.isResolved,
    );
  }
}