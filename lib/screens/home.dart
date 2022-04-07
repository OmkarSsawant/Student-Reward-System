// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Container _PaddedField(
      TextEditingController? tc, String hint, String hintText) {
    return Container(
      margin: const EdgeInsets.all(14.0),
      padding: const EdgeInsets.all(14.0),
      child: TextField(
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
                  _PaddedField(null, "Username", "Ex : CM_B_73"),
                  _PaddedField(null, "User email", "Enter Your College Email"),
                  _PaddedField(
                      null, "Password", "Enter your 6 character password"),
                  SizedBox(
                    height: height * 0.01,
                    width: width * .7,
                  ),
                  ElevatedButton(
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: const Text(
                          "Register",
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                      onPressed: () {
                        //TODO: Add Auth
                        Navigator.of(context).pushNamed('/dashboard');
                      })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
