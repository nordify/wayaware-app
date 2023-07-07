import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:wayaware/pages/about_page.dart';
import 'package:wayaware/pages/map_page.dart';
import 'package:wayaware/pages/settings_page.dart';
import 'package:wayaware/pages/stats_page.dart';
import 'package:wayaware/utils/dock_controller.dart';
import 'package:wayaware/widgets/dock.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DockController _dockController = DockController();
  late final PreloadPageController _pageController;
  int _currentScreen = 0;
  bool _pageSwitchFromDock = false;

  @override
  void initState() {
    _pageController = PreloadPageController(initialPage: _currentScreen);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PreloadPageView(
        physics: const ClampingScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) {
          if (!_pageSwitchFromDock) {
            _dockController.moveSliderTo(index < 2 ? index : index + 1);
          }
          if (_pageSwitchFromDock) {
            if (_currentScreen == index) {
              _pageSwitchFromDock = false;
            }
          }
        },
        preloadPagesCount: 4,
        children: const [MapPage(), StatsPage(), AboutPage(), SettingsPage()],
      ),
      bottomNavigationBar: Dock(
        controller: _dockController,
        initialIndex: _currentScreen,
        onTap: (index) {
          _pageSwitchFromDock = true;

          if (_currentScreen != index) {
            _currentScreen = index;
          }
          _pageController.animateToPage(_currentScreen, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
        },
        items: [
          DockTabItem(icon: Icons.map_rounded),
          DockTabItem(icon: Icons.show_chart_rounded),
          DockFunctionItem(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                  child: const Center(
                    child: Icon(
                      Icons.add_circle,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              function: () {
                HapticFeedback.mediumImpact();
                context.go('/createAnnotation');
              }),
          DockTabItem(icon: Icons.info_rounded),
          DockTabItem(icon: Icons.settings_rounded),
        ],
      ),
    );
  }
}
