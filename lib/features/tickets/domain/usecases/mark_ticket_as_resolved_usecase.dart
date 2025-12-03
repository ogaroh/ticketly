import '../repositories/ticket_repository.dart';

class MarkTicketAsResolvedUseCase {
  const MarkTicketAsResolvedUseCase(this.repository);
  
  final TicketRepository repository;
  
  Future<void> call(int ticketId) async {
    return await repository.markTicketAsResolved(ticketId);
  }
}