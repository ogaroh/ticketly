import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/ticket_bloc.dart';
import '../bloc/ticket_event.dart';
import '../bloc/ticket_state.dart';
import '../widgets/ticket_card.dart';

class TicketsPage extends StatefulWidget {
  const TicketsPage({super.key});

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {
  @override
  void initState() {
    super.initState();
    context.read<TicketBloc>().add(TicketsLoadRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tickets'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<TicketBloc>().add(TicketsLoadRequested());
            },
          ),
        ],
      ),
      body: BlocConsumer<TicketBloc, TicketState>(
        listener: (context, state) {
          if (state is TicketError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Theme.of(context).colorScheme.error,
                action: SnackBarAction(
                  label: 'Retry',
                  onPressed: () {
                    context.read<TicketBloc>().add(TicketsLoadRequested());
                  },
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is TicketLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is TicketResolving) {
            // Show the tickets with resolving indicator
            final tickets = state.tickets;
            return RefreshIndicator(
              onRefresh: () async {
                context.read<TicketBloc>().add(TicketsLoadRequested());
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: tickets.length,
                itemBuilder: (context, index) {
                  final ticket = tickets[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: TicketCard(
                      ticket: ticket,
                      onTap: () {
                        context.push('/ticket-detail/${ticket.id}', extra: ticket);
                      },
                    ),
                  );
                },
              ),
            );
          }

          if (state is TicketError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    size: 64,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading tickets',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      state.message,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      context.read<TicketBloc>().add(TicketsLoadRequested());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is TicketLoaded) {
            final tickets = state.tickets;
            
            if (tickets.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.inbox,
                      size: 64,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No tickets found',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<TicketBloc>().add(TicketsLoadRequested());
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: tickets.length,
                itemBuilder: (context, index) {
                  final ticket = tickets[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: TicketCard(
                      ticket: ticket,
                      onTap: () {
                        context.push('/ticket-detail/${ticket.id}', extra: ticket);
                      },
                    ),
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}