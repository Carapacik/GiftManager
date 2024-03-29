import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gift_manager/di/service_locator.dart';
import 'package:gift_manager/navigation/route_name.dart';
import 'package:gift_manager/presentation/gifts/view/gifts_page.dart';
import 'package:gift_manager/presentation/home/bloc/home_bloc.dart';
import 'package:gift_manager/presentation/home/models/bottom_tab.dart';
import 'package:gift_manager/presentation/people/people_page.dart';
import 'package:gift_manager/presentation/settings/settings_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<HomeBloc>()..add(const HomePageLoaded()),
      child: const _HomePageWidget(),
    );
  }
}

class _HomePageWidget extends StatefulWidget {
  const _HomePageWidget({super.key});

  @override
  State<_HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<_HomePageWidget> {
  BottomTab _currentTab = BottomTab.gifts;

  final _pages = const <Widget>[
    GiftsPage(),
    PeoplePage(),
    SettingsPage(),
  ];

  void _changeTab(int index) {
    setState(() {
      _currentTab = BottomTab.values[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeGoToLogin) {
          unawaited(
            Navigator.of(context).pushNamedAndRemoveUntil(
              RouteName.login.route,
              (route) => false,
            ),
          );
        }
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentTab.index,
          onTap: _changeTab,
          items: <BottomNavigationBarItem>[
            _createBottomNavBarItem(BottomTab.gifts),
            _createBottomNavBarItem(BottomTab.people),
            _createBottomNavBarItem(BottomTab.settings),
          ],
        ),
        body: IndexedStack(
          index: _currentTab.index,
          children: _pages,
        ),
      ),
    );
  }

  BottomNavigationBarItem _createBottomNavBarItem(BottomTab tab) {
    return BottomNavigationBarItem(
      label: tab.label,
      icon: Icon(tab.icon),
    );
  }
}
