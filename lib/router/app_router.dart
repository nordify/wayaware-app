import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wayaware/bloc/accessibility_mode_bloc.dart';
import 'package:wayaware/bloc/app_state_cubit.dart';
import 'package:wayaware/bloc/auth_user_bloc.dart';
import 'package:wayaware/home.dart';
import 'package:wayaware/pages/login_page.dart';
import 'package:wayaware/pages/map_page.dart';
import 'package:wayaware/pages/settings_page.dart';
import 'package:wayaware/pages/splash_screen.dart';

class AppRouter {
  final BuildContext appContext;
  late final AppStateCubit appStateCubit;
  GoRouter get router => _goRouter;

  AppRouter(this.appContext) {
    appStateCubit = appContext.read<AppStateCubit>();
    print(appContext.read<AuthUserBloc>().state);
  }

  late final GoRouter _goRouter = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (_, __) => const HomePage()),
        GoRoute(path: '/login', builder: (_, __) => const LoginPage()),
        GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
        GoRoute(path: '/map', builder: (_, __) => const MapPage()),
        GoRoute(
            path: '/settings',
            builder: (context, state) {
              print(appContext.read<AuthUserBloc>().state);
              return SettingsPage();
            }),
      ],
      redirect: (context, state) {
        final appState = appStateCubit.state;

        final bool isOnLoginPage = state.matchedLocation == '/login';

        if (appState == AppState.unkown) return "/splash";
        if (appState == AppState.unauthenticated) return "/login";
        if (isOnLoginPage) return "/";

        return null;
      },
      refreshListenable: appStateCubit);
}
