import 'package:firebase_core/firebase_core.dart';
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

  runApp(BlocProvider(
    create: (_) => SeniorModeBloc(false),
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "wayaware",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      body: TextButton(onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute<void>(
      builder: (BuildContext context) => const LoginPage())), child: Text("eee")),
    );
  }
}
