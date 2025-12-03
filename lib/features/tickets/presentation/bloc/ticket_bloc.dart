import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_tickets_usecase.dart';
import '../../domain/usecases/mark_ticket_as_resolved_usecase.dart';
import 'ticket_event.dart';
import 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  TicketBloc({
    required GetTicketsUseCase getTicketsUseCase,
    required MarkTicketAsResolvedUseCase markTicketAsResolvedUseCase,
  })  : _getTicketsUseCase = getTicketsUseCase,
        _markTicketAsResolvedUseCase = markTicketAsResolvedUseCase,
        super(TicketInitial()) {
    on<TicketsLoadRequested>(_onTicketsLoadRequested);
    on<TicketResolveRequested>(_onTicketResolveRequested);
  }

  final GetTicketsUseCase _getTicketsUseCase;
  final MarkTicketAsResolvedUseCase _markTicketAsResolvedUseCase;

  Future<void> _onTicketsLoadRequested(
    TicketsLoadRequested event,
    Emitter<TicketState> emit,
  ) async {
    emit(TicketLoading());
    try {
      final tickets = await _getTicketsUseCase();
      emit(TicketLoaded(tickets));
    } catch (e) {
      emit(TicketError(e.toString()));
    }
  }

  Future<void> _onTicketResolveRequested(
    TicketResolveRequested event,
    Emitter<TicketState> emit,
  ) async {
    // Keep current tickets and show resolving state
    final currentState = state;
    if (currentState is TicketLoaded) {
      emit(TicketResolving(event.ticketId, currentState.tickets));
    }
    
    try {
      await _markTicketAsResolvedUseCase(event.ticketId);
      // Reload tickets to reflect the change
      final tickets = await _getTicketsUseCase();
      emit(TicketLoaded(tickets));
    } catch (e) {
      // Restore previous state and show error
      if (currentState is TicketLoaded) {
        emit(TicketLoaded(currentState.tickets));
      }
      emit(TicketError('Failed to mark ticket as resolved: ${e.toString()}'));
    }
  }
}