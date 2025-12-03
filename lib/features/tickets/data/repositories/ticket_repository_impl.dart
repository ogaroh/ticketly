import '../../domain/entities/ticket.dart';
import '../../domain/repositories/ticket_repository.dart';
import '../datasources/ticket_api_service.dart';
import '../../../../core/network/local_storage_service.dart';

class TicketRepositoryImpl implements TicketRepository {
  @override
  Future<List<Ticket>> getTickets() async {
    try {
      final ticketModels = await TicketApiService.fetchTickets();
      final resolvedTicketIds = await getResolvedTicketIds();
      
      return ticketModels.map((ticketModel) {
        final isResolved = resolvedTicketIds.contains(ticketModel.id);
        // Convert TicketModel to Ticket entity
        return Ticket(
          id: ticketModel.id,
          userId: ticketModel.userId,
          title: ticketModel.title,
          body: ticketModel.body,
          isResolved: isResolved,
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to get tickets: $e');
    }
  }

  @override
  Future<void> markTicketAsResolved(int ticketId) async {
    try {
      await LocalStorageService.markTicketAsResolved(ticketId);
    } catch (e) {
      throw Exception('Failed to mark ticket as resolved: $e');
    }
  }

  @override
  Future<List<int>> getResolvedTicketIds() async {
    try {
      return LocalStorageService.getResolvedTicketIds();
    } catch (e) {
      throw Exception('Failed to get resolved ticket IDs: $e');
    }
  }
}