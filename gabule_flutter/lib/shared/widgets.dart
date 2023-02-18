import 'package:flutter/material.dart';
import 'package:gabule_flutter/shared/theme.dart';

class ButtonPrimary extends StatelessWidget {
  const ButtonPrimary(
    this.text,
    this.onPressed, {
    Key? key,
  }) : super(key: key);

  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        minimumSize: const MaterialStatePropertyAll(Size.fromHeight(40)),
        backgroundColor: MaterialStatePropertyAll(MyTheme.primaryColor),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        )),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

class ButtonSecondary extends StatelessWidget {
  const ButtonSecondary(
    this.text,
    this.onPressed, {
    Key? key,
  }) : super(key: key);

  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        minimumSize: const MaterialStatePropertyAll(Size.fromHeight(40)),
        backgroundColor: MaterialStatePropertyAll(MyTheme.secondaryColor),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        )),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

class ButtonTertiary extends StatelessWidget {
  const ButtonTertiary(
    this.text,
    this.onPressed, {
    Key? key,
  }) : super(key: key);

  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: MyTheme.secondaryColor),
        ));
  }
}

class ButtonSecondaryOutlined extends StatelessWidget {
  const ButtonSecondaryOutlined(
    this.text,
    this.onPressed, {
    Key? key,
  }) : super(key: key);

  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            minimumSize: const MaterialStatePropertyAll(Size.fromHeight(40)),
            side: MaterialStatePropertyAll(
                BorderSide(color: MyTheme.secondaryColor, width: 3)),
            backgroundColor: const MaterialStatePropertyAll(
                Color.fromARGB(0, 255, 255, 255)),
            shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))))),
        child: Text(
          text,
          style: const TextStyle(color: Colors.black),
        ));
  }
}

class InputField extends StatelessWidget {
  const InputField(
    this.text,
    this.prefixIcon,
    this.obscureText, {
    Key? key,
  }) : super(key: key);

  final String text;
  final IconData prefixIcon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
        obscureText: obscureText,
        maxLines: 1,
        decoration: InputDecoration(
            constraints: const BoxConstraints(maxHeight: 40),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(width: 2, color: Color(0xFF8695fa))),
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(width: 2, color: Color(0xFF8695fa))),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                borderSide:
                    BorderSide(color: MyTheme.secondaryColor, width: 2)),
            labelText: text,
            prefixIcon: Icon(prefixIcon)));
  }
}

class VertPad extends StatelessWidget {
  const VertPad(this.value, {super.key});

  final double value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: value),
    );
  }
}

class HoriPad extends StatelessWidget {
  const HoriPad(this.value, {super.key});

  final double value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: value),
    );
  }
}

class UserCard extends StatelessWidget {
  const UserCard(
    this.constraints,
    this.user, {
    Key? key,
  }) : super(key: key);

  final BoxConstraints constraints;
  final dynamic user;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: constraints.maxWidth,
      height: constraints.maxWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: MyTheme.primaryColor,
          boxShadow: const [
            BoxShadow(blurRadius: 3, offset: Offset(0, 3), color: Colors.grey)
          ]),
      padding: EdgeInsets.all(constraints.maxWidth * .05),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              flex: 2,
              child: LayoutBuilder(
                  builder: (context, constraints) => Container(
                        width: constraints.maxHeight,
                        height: constraints.maxHeight,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 5,
                                  color: Color.fromARGB(111, 0, 0, 0),
                                  offset: Offset(0, 5))
                            ],
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 5)),
                        child: CircleAvatar(
                          radius: constraints.maxWidth - 20,
                          backgroundImage:
                              NetworkImage(user['picture']['large']),
                        ),
                      )),
            ),
            const Flexible(
              flex: 1,
              child: Text(
                "UI/UX DESIGNER",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Flexible(
              flex: 1,
              child: Text(
                user['name']['first'] + " " + user['name']['last'],
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.white),
              ),
            ),
            const Flexible(
              flex: 2,
              child: Text("I can make your dream website come true.",
                  style: TextStyle(fontSize: 12, color: Colors.white)),
            ),
            Flexible(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 46,
                    width: 46,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.adobe,
                      color: Color.fromARGB(255, 9, 56, 95),
                    ),
                  ),
                  const HoriPad(10),
                  Container(
                    height: 46,
                    width: 46,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.flutter_dash,
                      color: Color.fromARGB(255, 28, 153, 255),
                    ),
                  )
                ],
              ),
            )
          ]),
    );
  }
}

class Post extends StatelessWidget {
  final String text;
  final String imagePath;

  const Post(this.text, this.imagePath, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 150),
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(30),
      width: MediaQuery.of(context).size.width,
      height: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          image:
              DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
          boxShadow: [
            BoxShadow(blurRadius: 3, offset: Offset(0, 3), color: Colors.grey)
          ]),
      child: Text(text,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w800, fontSize: 40)),
    );
  }
}
