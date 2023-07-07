import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wayaware/backend/authentication.dart';
import 'package:wayaware/bloc/settings_mode_bloc.dart';

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
            const Text(
              "Introducing our Senior Mode, designed specifically to enhance the accessibility and usability of our product for seniors. This specialized mode is perfect for individuals who may have difficulty with small text or complex interfaces.",
              style: TextStyle(fontSize: 16),
            ),
            BlocBuilder<UserSettingsBloc, Map<String, bool>>(
                builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Full brightness Mode",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Switch.adaptive(
                      value: state['brightness_mode'] ?? false,
                      onChanged: (value) => context
                          .read<UserSettingsBloc>()
                          .add(LocalChange({'brightness_mode': value})),
                      activeColor: Colors.black),
                ],
              );
            }),
            const Text(
              "The Full Brightness Button is a convenient feature designed to enhance your screen viewing experience by maximizing the display's brightness when activated. With just a simple press, you can instantly achieve optimal visibility, making it ideal for situations where you need a brighter screen, such as working in well-lit environments or enjoying multimedia content in vibrant detail. ",
              style: TextStyle(fontSize: 16),
            ),
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
            const Text(
              "The Keep Screen On Button is a convenient tool that ensures your screen stays on and prevents it from automatically turning off. Designed for both convenience and efficiency, this button eliminates the hassle of constantly touching the screen to prevent it from going into sleep mode.The button is prominently placed on your device's screen, allowing easy access and visibility. ",
              style: TextStyle(fontSize: 16),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 65,
              child: ElevatedButton(
                onPressed: () => _signOut(),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color.fromARGB(255, 1, 1, 1),
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
