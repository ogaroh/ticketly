import '../entities/ticket.dart';
import '../repositories/ticket_repository.dart';

class GetTicketsUseCase {
  const GetTicketsUseCase(this.repository);
  
  final TicketRepository repository;
  
  Future<List<Ticket>> call() async {
    return await repository.getTickets();
  }
}