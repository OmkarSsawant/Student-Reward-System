// ignore_for_file: unnecessary_const

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_reward_system/data/User.dart';
import 'package:http/http.dart' as http;
import 'package:student_reward_system/screens/dashboard.dart';

class HomePage extends StatefulWidget {
  final bool isRegistration;
  const HomePage({Key? key, required this.isRegistration}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController userPswdController = TextEditingController();

  Container _PaddedField(
      TextEditingController? tc, String hint, String hintText) {
    return Container(
      margin: const EdgeInsets.all(14.0),
      padding: const EdgeInsets.all(14.0),
      child: TextField(
        controller: tc,
        decoration: InputDecoration(
            hintText: hintText,
            label: Text(hint),
            border: OutlineInputBorder()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height,
      child: Row(
        children: [
          Container(
            width: width * 0.6,
            height: height,
            child: Image.asset("images/login.png"),
          ),
          Container(
            width: width * 0.4,
            height: height * .8,
            padding: const EdgeInsets.all(8),
            child: Card(
              elevation: 7.0,
              margin: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("Grow Toghether",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(color: Colors.black87)),
                  ),
                  widget.isRegistration
                      ? _PaddedField(
                          userNameController, "Username", "Ex : CM_B_73")
                      : Container(),
                  _PaddedField(userEmailController, "User email",
                      "Enter Your College Email"),
                  _PaddedField(userPswdController, "Password",
                      "Enter your 6 character password"),
                  SizedBox(
                    height: height * 0.01,
                    width: width * .7,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.isRegistration ? "Register" : "Login",
                              style: const TextStyle(fontSize: 24),
                            ),
                          ),
                          onPressed: () async {
                            var email = userEmailController.value.text;
                            var pswd = userPswdController.value.text;
                            if (!widget.isRegistration) {
                              User loggedIn = User(email, pswd);
                              print("LOGGING " + email + pswd);
                              var res = await http.post(
                                  Uri.parse("http://localhost:7000/login"),
                                  body: loggedIn.toLoginMap());
                              //omkar@mail.com
                              //test123456
                              loggedIn.updateFromResponce(res.body);
                              if (res.statusCode == 200) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) =>
                                        Dashboard(user: loggedIn)));
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (ctx) => const AlertDialog(
                                          content: const Center(
                                            child: const Text(
                                                "Invalid Credentials Please Regitser"),
                                          ),
                                        ));
                              }
                            } else {
                              var userName = userNameController.text;
                              var u = User(email, pswd);
                              u.name = userName;
                              var res = await http.post(
                                  Uri.parse("http://localhost:7000/register"),
                                  body: u.toRegisterMap());
                              print(res.statusCode);
                              if (res.statusCode == 200) {
                                const sb = SnackBar(
                                    content:
                                        Text("Successfully Registered User"));
                                ScaffoldMessenger.of(context).showSnackBar(sb);
                              } else {
                                const sb = SnackBar(
                                    content: Text("Please Try Again !"));
                                ScaffoldMessenger.of(context).showSnackBar(sb);
                              }
                              print(res.body);
                            }
                          }),
                      InkWell(
                          onTap: () {
                            if (widget.isRegistration) {
                              Navigator.of(context).pushNamed("/home");
                            } else {
                              Navigator.of(context).pushNamed("/register");
                            }
                          },
                          child: Text(
                              widget.isRegistration ? "Login" : "Register",
                              style: const TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline)))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
