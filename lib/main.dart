import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wayaware/bloc/app_state_cubit.dart';
import 'package:wayaware/bloc/auth_state_bloc.dart';
import 'package:wayaware/bloc/auth_user_bloc.dart';
import 'package:wayaware/bloc/wayaware_bloc_observer.dart';
import 'package:wayaware/router/app_router.dart';
import 'package:wayaware/utils/scroll_behavior.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  await Firebase.initializeApp();
  Bloc.observer = WayawareBlocObserver();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        lazy: false,
        create: (_) => AuthStateBloc(),
      ),
      BlocProvider(
        lazy: false,
        create: (context) => AuthUserBloc(context.read<AuthStateBloc>()),
      ),
      BlocProvider(
          lazy: false,
          create: (context) => AppStateCubit(context.read<AuthStateBloc>()))
    ],
    child: const App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Wayaware',
      theme: ThemeData(),
      routerConfig: AppRouter(context).router,
      builder: (context, child) => ScrollConfiguration(
          behavior: WScrollBehavior(), child: child ?? Container()),
      debugShowCheckedModeBanner: false,
    );
  }
}
