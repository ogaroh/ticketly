import 'package:equatable/equatable.dart';
import '../../domain/entities/ticket.dart';

abstract class TicketState extends Equatable {
  const TicketState();

  @override
  List<Object?> get props => [];
}

class TicketInitial extends TicketState {}

class TicketLoading extends TicketState {}

class TicketLoaded extends TicketState {
  const TicketLoaded(this.tickets);

  final List<Ticket> tickets;

  @override
  List<Object?> get props => [tickets];
}

class TicketError extends TicketState {
  const TicketError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class TicketResolving extends TicketState {
  const TicketResolving(this.ticketId, this.tickets);

  final int ticketId;
  final List<Ticket> tickets;

  @override
  List<Object?> get props => [ticketId, tickets];
}