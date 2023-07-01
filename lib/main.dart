import 'package:firebase_core/firebase_core.dart';
import 'dart:math';
import 'package:curved_gradient/curved_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wayaware_app/bloc/auth_state_bloc.dart';
import 'package:wayaware_app/bloc/auth_user_bloc.dart';
import 'package:wayaware_app/bloc/senior_mode_bloc.dart';
import 'package:wayaware_app/firebase_options.dart';
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
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        child: MyHomePage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "wayaware",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
        toolbarHeight: 80,
          backgroundColor: Colors.black,
          title: SizedBox(
              height: 60,
              child: Image.asset(
                "assets/app_icon_inverted.png",
              ))),
      body: Stack(children: [
        //_getVerticalGradient(context, VerticalDirection.up),
        _getDiagonalGradient(context)
      ]),
    );
  }
}

Widget _getVerticalGradient(BuildContext context, VerticalDirection direction) {
  return Align(
    alignment: direction == VerticalDirection.up
        ? Alignment.topCenter
        : Alignment.bottomCenter,
    child: Container(
      height: MediaQuery.sizeOf(context).height / 5,
      decoration: BoxDecoration(
          gradient: CurvedGradient(
              begin: direction == VerticalDirection.up
                  ? Alignment.bottomCenter
                  : Alignment.topCenter,
              end: direction == VerticalDirection.up
                  ? Alignment.topCenter
                  : Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.0)
              ],
              granularity: 999,
              curveGenerator: (x) => pow(sqrt(x), 6) as double)),
    ),
  );
}

Widget _getDiagonalGradient(BuildContext context) {
  return Positioned.fill(
    child: Container(
      height: MediaQuery.sizeOf(context).height / 5,
      decoration: BoxDecoration(
          gradient: CurvedGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.black.withOpacity(0.5),
                Colors.black.withOpacity(0.1)
              ],
              granularity: 999,
              curveGenerator: (x) => pow(sqrt(x), 6) as double)),
    ),
  );
}
