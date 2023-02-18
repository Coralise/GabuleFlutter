import 'dart:convert';
import 'dart:math';

import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:neumorphic_widget/neumorphic_button.dart';

import '../shared/my_icons.dart';
import '../shared/theme.dart';
import '../shared/widgets.dart';
import 'login_screen.dart';
import 'screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.user});
  final dynamic user;

  @override
  State<StatefulWidget> createState() => MainState();
}

class MainState extends State<MainScreen> {
  late Widget currentScreen;
  late dynamic data;

  @override
  void initState() {
    super.initState();
    currentScreen = const HomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: MyTheme.backgroundColor,
      body: MediaQuery.of(context).orientation == Orientation.portrait
          ? portrait(context)
          : landscape(context),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: CircleAvatar(
              backgroundImage:
                  NetworkImage(widget.user['picture']['thumbnail']),
            ),
            onPressed: () {
              scaffoldKey.currentState!.openEndDrawer();
            },
          ),
        ],
        leading: MediaQuery.of(context).orientation == Orientation.portrait
            ? IconButton(
                icon: const Icon(MyIcons.hamburger),
                onPressed: () {
                  scaffoldKey.currentState!.openDrawer();
                })
            : null,
      ),
      drawer: MediaQuery.of(context).orientation == Orientation.portrait
          ? Drawer(
              width: MediaQuery.of(context).size.width / 2,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  burgerDrawer(context),
                ],
              ))
          : null,
      endDrawer: Drawer(
          width: MediaQuery.of(context).size.width / 2,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              userDrawer(context),
            ],
          )),
    );
  }

  Widget portrait(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: currentScreen,
      ),
    );
  }

  Widget landscape(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 5,
                    offset: const Offset(5, 0))
              ]),
              width: MediaQuery.of(context).size.width / 3,
              child: burgerDrawer(context)),
          Flexible(child: portrait(context))
        ],
      ),
    );
  }

  Widget burgerDrawer(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        color: MyTheme.backgroundColor,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(flex: 1, child: header()),
              VertPad(30),
              Flexible(flex: 3, child: lists()),
              Flexible(flex: 1, child: footer())
            ]),
      ),
    );
  }

  Widget userDrawer(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        color: MyTheme.backgroundColor,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  child: LayoutBuilder(
                builder: (context, constraints) =>
                    UserCard(constraints, widget.user),
              )),
              Flexible(
                  child: ButtonSecondaryOutlined(
                      "Log Out",
                      () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ))))
            ]),
      ),
    );
  }

  Widget buttonGroup1(BuildContext context) {
    return Column(
      children: [
        ButtonPrimary(
            "Home",
            () => {
                  if (currentScreen.runtimeType != HomeScreen)
                    updateScreen(Screen.home)
                }),
        const VertPad(10),
        ButtonPrimary("Projects", () => null),
        const VertPad(10),
        ButtonPrimary("Report", () => null)
      ],
    );
  }

  void updateScreen(Screen newScreen) {
    switch (newScreen) {
      case Screen.home:
        setState(() {
          currentScreen = const HomeScreen();
        });
        break;
      case Screen.settings:
        setState(() {
          currentScreen = const SettingsScreen();
        });
        break;
      case Screen.profile:
        setState(() {
          currentScreen = const ProfileScreen();
        });
        break;
    }
  }

  Widget header() {
    return Column(
      children: [
        Flexible(child: Image.asset("assets/images/addu-seal-colorized.png")),
        Text(
          "Community Center Asset Management System",
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Widget lists() {
    return Column(
      children: [
        NeumorphicButton(
            child: Text("Dashboard"),
            onPressed: () {
              updateScreen(Screen.home);
            },
            borderRadius: BorderRadius.circular(10),
            height: 50),
        VertPad(30),
        NeumorphicButton(
            child: Text("Settings"),
            onPressed: () {
              updateScreen(Screen.settings);
            },
            borderRadius: BorderRadius.circular(10),
            height: 50),
        VertPad(30),
        NeumorphicButton(
            child: Text("Profile"),
            onPressed: () {
              updateScreen(Screen.profile);
            },
            borderRadius: BorderRadius.circular(10),
            height: 50)
      ],
    );
  }

  Widget footer() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Flexible(child: Text("Powered by:")),
      Flexible(child: Image.asset("assets/images/arisen-lab-caption.png"))
    ]);
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Post("Dashboard", "assets/images/addu-jacinto.jpg")],
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [Post("Settings", "assets/images/addu-library.jpg"), card()],
      ),
    );
  }

  Widget card() {
    return Container(
      color: Colors.amber,
      height: 700,
      width: 300,
      margin: EdgeInsets.only(bottom: 100),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Post("Profile", "assets/images/addu-students.jpg"),
      ],
    );
  }
}
