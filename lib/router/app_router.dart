import 'package:go_router/go_router.dart';
import 'package:wayaware/bloc/app_state_cubit.dart';
import 'package:wayaware/home.dart';
import 'package:wayaware/pages/login_page.dart';
import 'package:wayaware/pages/map_page.dart';
import 'package:wayaware/pages/settings_page.dart';
import 'package:wayaware/pages/splash_screen.dart';

class AppRouter {
  final AppStateCubit appStateCubit;
  GoRouter get router => _goRouter;

  AppRouter(this.appStateCubit);

  late final GoRouter _goRouter = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (_, __) => const HomePage()),
        GoRoute(path: '/login', builder: (_, __) => const LoginPage()),
        GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
        GoRoute(path: '/map', builder: (_, __) => const MapPage()),
        GoRoute(path: '/settings', builder: (_, __) => const SettingsPage()),
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
