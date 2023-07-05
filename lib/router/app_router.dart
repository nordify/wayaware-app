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
  late final AppStateCubit _appStateCubit;
  GoRouter get router => _goRouter;

  AccessibilityModeBloc? _accessibilityModeBloc;

  AppRouter(this.appContext) {
    _appStateCubit = appContext.read<AppStateCubit>();
  }

  late final GoRouter _goRouter = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
            path: '/',
            builder: (context, state) {
              return BlocProvider(
                lazy: false,
                create: (context) => _accessibilityModeBloc = AccessibilityModeBloc(appContext.read<AuthUserBloc>().state!),
                child: const HomePage(),
              );
            },
            routes: [
              GoRoute(path: 'map', builder: (context, state) => const MapPage()),
              GoRoute(
                  path: 'settings',
                  builder: (context, state) {
                    return BlocProvider.value(value: _accessibilityModeBloc!, child: const SettingsPage());
                  })
            ]),
        GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
        GoRoute(path: '/splash', builder: (context, state) => const SplashScreen())
      ],
      redirect: (context, state) {
        final appState = _appStateCubit.state;

        final bool isOnLoginPage = state.matchedLocation == '/login';

        if (appState == AppState.unkown) return "/splash";
        if (appState == AppState.unauthenticated) return "/login";
        if (isOnLoginPage) return "/";

        return null;
      },
      refreshListenable: _appStateCubit);
}