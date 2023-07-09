import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wayaware/bloc/settings_mode_bloc.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with AutomaticKeepAliveClientMixin<AboutPage> {
  get title => null;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<UserSettingsBloc, Map<String, bool>>(
      builder: (context, state) {
        final accessibilityMode = state['accessibility_mode'] ?? false;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.black,
            toolbarHeight: 80,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center, // Hier hinzugefügt
              children: [
                Image.asset(
                  'assets/app_icon_inverted.png',
                  width: 75,
                  height: 75,
                ),
                Text(
                  'About',
                  style: TextStyle(fontSize: accessibilityMode ? 35 : 25, fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ],
            ),
          ),
          body: ListView(
            padding: EdgeInsets.zero,
            physics: const ClampingScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(right: 178, top: 20, bottom: 5),
                      child: Text(
                        'Wayaware',
                        style: TextStyle(fontSize: accessibilityMode ? 40 : 30, fontWeight: FontWeight.w900),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(left: 5, right: 15),
                      child: const Text(
                        'At Wayaware, we are committed to raising awareness and supporting people with disabilities. Our aim is to break down barriers, combat prejudices and create an inclusive society in which all people have equal opportunities and opportunities to participate.',
                        style: TextStyle(fontSize: 18),
                        //    textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(right: 101, top: 30, bottom: 5),
                      child: Text(
                        'Functionalities',
                        style: TextStyle(fontSize: accessibilityMode ? 40 : 30, fontWeight: FontWeight.w900),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(left: 5, right: 15),
                      child: const Text(
                        'Wayaware offers a variety of functions to raise awareness and provide information about different types of disabilities. From stories and stories of people with disabilities to resources and tips on accessibility, our app is a comprehensive tool for anyone who wants to learn more about these important topics.',
                        style: TextStyle(fontSize: 18),
                        //   textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(right: 151, top: 30, bottom: 5),
                      child: Text(
                        'Support us!',
                        style: TextStyle(fontSize: accessibilityMode ? 40 : 30, fontWeight: FontWeight.w900),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(left: 5, right: 15),
                      child: const Text(
                        'We appreciate your support in raising awareness for people with disabilities. Share our app with your friends and family, get involved in local communities and promote accessible environments.',
                        style: TextStyle(fontSize: 18),
                        // textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      height: 10,
                    )
                  ],
                ),
              ),
              Container(
                color: Colors.black,
                height: 15,
              ),
              Container(
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          IconButton(
                            onPressed: () => context.go('/faq'),
                            icon: const Icon(Icons.question_answer, color: Colors.white),
                          ),
                          const Text(
                            'FAQ',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.black,
                height: 30,
              ),
              Container(
                color: Colors.black,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '© 2023 Your Company. Alle Rechte vorbehalten.',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.black,
                height: 120,
              )
            ],
          ),
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
