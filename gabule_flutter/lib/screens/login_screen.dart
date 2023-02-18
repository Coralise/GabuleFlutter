import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:neumorphic_widget/neumorphic_button.dart';
import 'package:neumorphic_widget/neumorphic_card.dart';

import '../shared/widgets.dart';
import 'main_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Future<dynamic> getUser() async {
    var userRes = await get(Uri.http("randomuser.me", "/api"));
    return jsonDecode(userRes.body)['results'][0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).orientation == Orientation.portrait
          ? AppBar()
          : null,
      backgroundColor: Color.fromARGB(255, 221, 221, 221),
      body: MediaQuery.of(context).orientation == Orientation.portrait
          ? portrait(context)
          : landscape(context),
    );
  }

  Widget portrait(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(30),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Flexible(
          flex: 1,
          child: Container(),
        ),
        Flexible(
            flex: 2,
            child: NeumorphicCard(
              backgroundColor: Colors.white,
              shadowBlur: 10,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                          flex: 2,
                          child: Image.asset(
                              "assets/images/addu-seal-colorized.png")),
                      const Flexible(
                          flex: 1,
                          child: Text(
                            "ATENEO DE DAVAO UNIVERSITY",
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 20),
                            textAlign: TextAlign.center,
                          )),
                      Flexible(
                          flex: 1,
                          child: Column(
                            children: [
                              Flexible(
                                child: NeumorphicButton(
                                  child: const Text("Login with Google"),
                                  onPressed: () {
                                    EasyLoading.show(
                                        status: "Logging in...",
                                        maskType: EasyLoadingMaskType.custom);
                                    getUser().then((user) => {
                                          EasyLoading.showSuccess(
                                              "Welcome back, ${user['name']['first']}!",
                                              duration:
                                                  const Duration(seconds: 1),
                                              maskType:
                                                  EasyLoadingMaskType.custom),
                                          Future.delayed(
                                              const Duration(seconds: 1),
                                              () => Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MainScreen(
                                                            user: user,
                                                          ))))
                                        });
                                  },
                                  borderRadius: BorderRadius.circular(10),
                                  height: 40,
                                ),
                              ),
                              VertPad(20),
                              Flexible(
                                child: NeumorphicButton(
                                  child: const Text("Login as Guest"),
                                  onPressed: () {},
                                  borderRadius: BorderRadius.circular(10),
                                  height: 40,
                                ),
                              ),
                            ],
                          )),
                    ],
                  )),
            )),
        Flexible(
          flex: 1,
          child: Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Flexible(child: Text("Powered by:")),
              Flexible(
                  child: Image.asset("assets/images/arisen-lab-caption.png"))
            ]),
          ),
        )
      ]),
    );
  }

  Widget landscape(BuildContext context) {
    return Center(
        child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width / 2,
            child: portrait(context)));
  }
}
