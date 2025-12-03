import 'package:flutter_test/flutter_test.dart';
import 'package:interintel/features/auth/domain/entities/user.dart';
import 'package:interintel/features/tickets/domain/entities/ticket.dart';

void main() {
  group('User Entity Tests', () {
    test('should create user with correct properties', () {
      const user = User(
        email: 'test@example.com',
        isLoggedIn: true,
      );

      expect(user.email, 'test@example.com');
      expect(user.isLoggedIn, true);
    });

    test('should create copy with updated properties', () {
      const user = User(
        email: 'test@example.com',
        isLoggedIn: false,
      );

      final updatedUser = user.copyWith(isLoggedIn: true);

      expect(updatedUser.email, 'test@example.com');
      expect(updatedUser.isLoggedIn, true);
    });
  });

  group('Ticket Entity Tests', () {
    test('should create ticket with correct properties', () {
      const ticket = Ticket(
        id: 1,
        userId: 1,
        title: 'Test Ticket',
        body: 'Test body',
        isResolved: false,
      );

      expect(ticket.id, 1);
      expect(ticket.userId, 1);
      expect(ticket.title, 'Test Ticket');
      expect(ticket.body, 'Test body');
      expect(ticket.isResolved, false);
    });

    test('should mark ticket as resolved', () {
      const ticket = Ticket(
        id: 1,
        userId: 1,
        title: 'Test Ticket',
        body: 'Test body',
        isResolved: false,
      );

      final resolvedTicket = ticket.copyWith(isResolved: true);

      expect(resolvedTicket.isResolved, true);
      expect(resolvedTicket.id, ticket.id);
      expect(resolvedTicket.title, ticket.title);
    });
  });
}