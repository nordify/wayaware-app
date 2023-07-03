import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wayaware_app/bloc/auth_state_bloc.dart';
import 'package:wayaware_app/bloc/auth_user_bloc.dart';
import 'package:wayaware_app/bloc/senior_mode_bloc.dart';
import 'package:wayaware_app/firebase_options.dart';
import 'package:wayaware_app/home.dart';
import 'package:wayaware_app/login/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => AuthStateBloc(),
      ),
      BlocProvider(
        create: (context) => AuthUserBloc(context.read<AuthStateBloc>()),
      ),
      BlocProvider(
        create: (_) => SeniorModeBloc(false),
      ),
    ],
    child: const App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wayaware',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthStateBloc(),
          ),
          BlocProvider(
            create: (context) => AuthUserBloc(context.read<AuthStateBloc>()),
          ),
          BlocProvider(create: (_) => SeniorModeBloc(false))
        ],
        child: const AppNavigation(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AppNavigation extends StatelessWidget {
  const AppNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthStateBloc, AuthState>(builder: (context, authState) {
      switch (authState) {
        case AuthState.authenticated:
          return const HomePage();
        case AuthState.unauthenticated:
          return const LoginPage();
        case AuthState.unkown:
          return Container();
      }
    });
  }
}
