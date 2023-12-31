import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wayaware/pages/about_page.dart';
import 'package:wayaware/bloc/user_settings_bloc.dart';
import 'package:wayaware/bloc/app_state_cubit.dart';
import 'package:wayaware/bloc/auth_user_bloc.dart';
import 'package:wayaware/pages/create_annotation/camera_page.dart';
import 'package:wayaware/pages/create_annotation/create_annotation_page.dart';
import 'package:wayaware/pages/faq_page.dart';
import 'package:wayaware/pages/home_page.dart';
import 'package:wayaware/pages/legend_page.dart';
import 'package:wayaware/pages/login_page.dart';
import 'package:wayaware/pages/settings_page.dart';
import 'package:wayaware/pages/splash_screen.dart';
import 'package:wayaware/utils/navbar.dart';

class AppRouter {
  final BuildContext appContext;
  late final AppStateCubit _appStateCubit;
  GoRouter get router => _goRouter;

  UserSettingsBloc? _userSettingsBloc;

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
                create: (context) => _userSettingsBloc =
                    UserSettingsBloc(
                        appContext.read<AuthUserBloc>().state!),
                child: const HomePage(),
              );
            },
            routes: [
              GoRoute(path: 'legend', builder: (context, state) => BlocProvider.value(value: _userSettingsBloc!, child: const LegendPage())),
              GoRoute(
                  path: 'faq', builder: (context, state) => BlocProvider.value(value: _userSettingsBloc!, child: const FaqPage())),
              GoRoute(
                  path: 'settings',
                  builder: (context, state) {
                    return BlocProvider.value(
                        value: _userSettingsBloc!,
                        child: const SettingsPage());
                  }),
              GoRoute(
                  path: 'createAnnotation',
                  builder: (context, state) => BlocProvider.value(value: _userSettingsBloc!, child: const CreateAnnotationPage()),
                  routes: [
                    GoRoute(
                        path: 'camera',
                        builder: (context, state) => BlocProvider.value(value: _userSettingsBloc!, child: CameraPage()))
                  ])
            ]),
        GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
        GoRoute(
            path: '/splash', builder: (context, state) => const SplashScreen()),
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
