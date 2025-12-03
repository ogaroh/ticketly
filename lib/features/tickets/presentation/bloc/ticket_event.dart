import 'package:equatable/equatable.dart';

abstract class TicketEvent extends Equatable {
  const TicketEvent();

  @override
  List<Object> get props => [];
}

class TicketsLoadRequested extends TicketEvent {}

class TicketResolveRequested extends TicketEvent {
  const TicketResolveRequested({required this.ticketId});

  final int ticketId;

  @override
  List<Object> get props => [ticketId];
}

class TicketResolveSuccess extends TicketEvent {
  const TicketResolveSuccess({required this.ticketId});

  final int ticketId;

  @override
  List<Object> get props => [ticketId];
}