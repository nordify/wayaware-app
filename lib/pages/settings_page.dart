import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wayaware/backend/authentication.dart';
import 'package:wayaware/bloc/accessibility_mode_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with AutomaticKeepAliveClientMixin<SettingsPage> {
  Future<void> _signOut() async {
    HapticFeedback.mediumImpact();
    Authentication.signOut();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          toolbarHeight: 80,
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          title: const Text(
            "Settings",
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      body: Padding(
        padding: const EdgeInsets.only(
            top: 20.0, bottom: 40.0, right: 20.0, left: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<UserSettingsBloc, Map<String, bool>>(
                builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Senior Mode",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Switch.adaptive(
                      value: state['accessibility_mode'] ?? false,
                      onChanged: (value) => context
                          .read<UserSettingsBloc>()
                          .add(LocalChange({'accessibility_mode': value})),
                      activeColor: Colors.black),
                ],
              );
            }),
            BlocBuilder<UserSettingsBloc, Map<String, bool>>(
                builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Contrast Mode",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Switch.adaptive(
                      value: state['contrast_mode'] ?? false,
                      onChanged: (value) => context
                          .read<UserSettingsBloc>()
                          .add(LocalChange({'contrast_mode': value})),
                      activeColor: Colors.black),
                ],
              );
            }),
            BlocBuilder<UserSettingsBloc, Map<String, bool>>(
                builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Keep Screen On",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Switch.adaptive(
                      value: state['screen_alway_on'] ?? false,
                      onChanged: (value) => context
                          .read<UserSettingsBloc>()
                          .add(LocalChange({'screen_alway_on': value})),
                      activeColor: Colors.black),
                ],
              );
            }),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 65,
              child: ElevatedButton(
                onPressed: () => _signOut(),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  "Logout",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
