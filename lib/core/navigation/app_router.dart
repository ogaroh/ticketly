import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/tickets/presentation/pages/tickets_page.dart';
import '../../features/tickets/presentation/pages/ticket_detail_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/tickets/domain/entities/ticket.dart';
import 'main_navigation.dart';

class AppRouter {
  static const String login = '/login';
  static const String tickets = '/tickets';
  static const String profile = '/profile';
  static const String ticketDetail = '/ticket-detail';

  static final GoRouter _router = GoRouter(
    initialLocation: login,
    routes: [
      GoRoute(
        path: login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      ShellRoute(
        builder: (context, state, child) => MainNavigation(child: child),
        routes: [
          GoRoute(
            path: tickets,
            name: 'tickets',
            builder: (context, state) => const TicketsPage(),
          ),
          GoRoute(
            path: profile,
            name: 'profile',
            builder: (context, state) => const ProfilePage(),
          ),
        ],
      ),
      GoRoute(
        path: '$ticketDetail/:id',
        name: 'ticketDetail',
        builder: (context, state) {
          final ticket = state.extra as Ticket;
          return TicketDetailPage(ticket: ticket);
        },
      ),
    ],
  );

  static GoRouter get router => _router;
}