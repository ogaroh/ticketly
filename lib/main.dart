import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/network/local_storage_service.dart';
import 'core/navigation/app_router.dart';
import 'shared/theme/app_theme.dart';
import 'shared/theme/theme_cubit.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/domain/usecases/logout_usecase.dart';
import 'features/auth/domain/usecases/get_current_user_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_event.dart';
import 'features/auth/presentation/bloc/auth_state.dart';
import 'features/tickets/data/repositories/ticket_repository_impl.dart';
import 'features/tickets/domain/usecases/get_tickets_usecase.dart';
import 'features/tickets/domain/usecases/mark_ticket_as_resolved_usecase.dart';
import 'features/tickets/presentation/bloc/ticket_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize local storage
  await LocalStorageService.init();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Theme BLoC
        BlocProvider(create: (context) => ThemeCubit()),
        // Auth BLoC
        BlocProvider(
          create: (context) {
            final authRepository = AuthRepositoryImpl();
            return AuthBloc(
              loginUseCase: LoginUseCase(authRepository),
              logoutUseCase: LogoutUseCase(authRepository),
              getCurrentUserUseCase: GetCurrentUserUseCase(authRepository),
            )..add(AuthCheckRequested());
          },
        ),
        // Ticket BLoC
        BlocProvider(
          create: (context) {
            final ticketRepository = TicketRepositoryImpl();
            return TicketBloc(
              getTicketsUseCase: GetTicketsUseCase(ticketRepository),
              markTicketAsResolvedUseCase: MarkTicketAsResolvedUseCase(ticketRepository),
            );
          },
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthAuthenticated) {
                // Navigate to tickets page when authenticated
                AppRouter.router.go('/tickets');
              } else if (state is AuthUnauthenticated) {
                // Navigate to login page when unauthenticated
                AppRouter.router.go('/login');
              }
            },
            child: MaterialApp.router(
              title: 'Ticketly',
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode,
              routerConfig: AppRouter.router,
            ),
          );
        },
      ),
    );
  }
}
