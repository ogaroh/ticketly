import '../entities/ticket.dart';

abstract class TicketRepository {
  Future<List<Ticket>> getTickets();
  Future<void> markTicketAsResolved(int ticketId);
  Future<List<int>> getResolvedTicketIds();
}