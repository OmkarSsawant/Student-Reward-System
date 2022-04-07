import 'dart:html';

import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final mockCardCountData = {"cards": 7, "used": 0, "remaining": 7};
  final mockCardData = List.generate(
      7,
      (index) => {
            "ThankYouCard$index":
                "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. "
          });
  final mockWinners =
      List.generate(7, (index) => {"Title$index": "EMAIL$index@gmail.com"});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Align(
            alignment: AlignmentDirectional.topStart,
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: Text("Grow Toghether",
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(color: Colors.black87)),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .3,
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Omkar",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              color: const Color.fromARGB(255, 255, 107, 107)),
                    ),
                    Text("Sawant",
                        style: Theme.of(context).textTheme.displayMedium),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(text: "CM-"),
                      TextSpan(text: "B-"),
                      TextSpan(
                          text: "73",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.blueAccent))
                    ]))
                  ],
                )),
                Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: mockCardCountData.keys
                            .map((e) => Score(
                                color: const Color.fromARGB(255, 107, 203, 119),
                                text: e))
                            .toList())),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  "Available Cards",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "                                                                  Winners",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 8,
                child: Container(
                  margin: const EdgeInsets.all(14),
                  color: const Color.fromARGB(97, 158, 158, 158),
                  width: MediaQuery.of(context).size.width * .85,
                  height: MediaQuery.of(context).size.width * .24,
                  child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 25.0,
                      mainAxisSpacing: 25.0,
                      childAspectRatio: 16 / 9,
                      shrinkWrap: true,
                      children: mockCardData
                          .map((e) => RewardCard(
                              title: e.keys.first,
                              desc: e.values.first,
                              image: null))
                          .toList()),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Card(
                    color: const Color.fromARGB(255, 255, 107, 107),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 17, vertical: 7),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * .6,
                      child: ListView(
                        children: mockWinners
                            .map((e) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    elevation: 45,
                                    child: ListTile(
                                      tileColor: Colors.white,
                                      title: Text(e.keys.first),
                                      subtitle: Text(e.values.first),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ))
            ],
          )
        ],
      ),
    );
  }
}

class Score extends StatelessWidget {
  final Color color;
  final String text;
  const Score({Key? key, required this.color, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * .1,
            height: MediaQuery.of(context).size.width * .1,
            decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(50),
                color: color,
                boxShadow: [
                  BoxShadow(blurRadius: 2.8, color: Colors.black12),
                  BoxShadow(
                      spreadRadius: 4.0, blurRadius: 2.8, color: Colors.black12)
                ]),
            child: Center(
              child:
                  Text("7", style: Theme.of(context).textTheme.displayMedium),
            ),
          ),
          Text(text, style: Theme.of(context).textTheme.displaySmall)
        ],
      ),
    );
  }
}

class RewardCard extends StatelessWidget {
  final String title;
  final String desc;
  final ImageProvider? image;
  const RewardCard(
      {Key? key, required this.title, required this.desc, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(6),
      elevation: 16,
      child: Row(
        children: [
          Expanded(
              flex: 7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(desc),
                  )
                ],
              )),
          Expanded(
              flex: 3,
              child: Container(
                color: Colors.amber,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset('images/login.png'),
                    ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.mail_outline_rounded),
                        label: const Text("Apply"))
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
