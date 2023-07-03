import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wayaware/bloc/senior_mode_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.black,
          title: const SizedBox(
              height: 60,
              child: Text("Settings"))),
      body: Column(
        children: [
          const Spacer(),
          BlocBuilder<SeniorModeBloc, bool>(
            builder: (context, state) {
              return Switch.adaptive(value: state, onChanged: (value) => context.read<SeniorModeBloc>().add(ModeChange(value)));
            }
            )
        ],
      ),        
    );
  }
}