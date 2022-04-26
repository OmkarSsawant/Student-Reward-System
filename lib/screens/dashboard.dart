import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../data/User.dart';

class Dashboard extends StatefulWidget {
  final User user;
  const Dashboard({Key? key, required this.user}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

const CARD_TYPES = ["thankYou", "wellDone", "excellence", "attitude", "leader"];

class _DashboardState extends State<Dashboard> {
  late User user;
  final mockCardData = List.generate(
      7,
      (index) => {
            "ThankYouCard$index":
                "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. "
          });
  final mockWinners =
      List.generate(7, (index) => {"Title$index": "EMAIL$index@gmail.com"});

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  User getFromArgument(BuildContext context) {
    return (ModalRoute.of(context)!.settings.arguments as User);
  }

  List<String> getRemaingCards(user) {
    var l = CARD_TYPES.toList();
    l.removeWhere((e) => user.cardsUsed.contains(e));
    return l;
  }

  @override
  Widget build(BuildContext context) {
    var cardCounts = {
      "cards": CARD_TYPES.length,
      "used": user.cardsUsed.length,
      "remaining": CARD_TYPES.length - user.cardsUsed.length
    };
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
                      user.name.split(" ").first,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              color: const Color.fromARGB(255, 255, 107, 107)),
                    ),
                    Text(user.name.split(" ").last,
                        style: Theme.of(context).textTheme.displayMedium),
                    // RichText(
                    //     text: TextSpan(children: [
                    //   TextSpan(text: "CM-"),
                    //   TextSpan(text: "B-"),
                    //   TextSpan(
                    //       text: "73",
                    //       style: Theme.of(context)
                    //           .textTheme
                    //           .bodyLarge!
                    //           .copyWith(color: Colors.blueAccent))
                    // ]))
                  ],
                )),
                Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: cardCounts.keys
                            .map((e) => Score(
                                  color:
                                      const Color.fromARGB(255, 107, 203, 119),
                                  text: e,
                                  count: cardCounts[e]!,
                                ))
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
                      children: getRemaingCards(user)
                          .map((e) => RewardCard(
                              title: e,
                              desc: "desc",
                              userMail: user.email,
                              onRewardApplied: (String rt) {
                                user.cardsUsed.add(rt);
                                setState(() {});
                              }))
                          .toList()),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Card(
                    color: Color.fromARGB(79, 15, 1, 1),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 17, vertical: 7),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * .6,
                      child: ListView(
                        children: user.winners
                            .map((e) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    elevation: 45,
                                    child: ListTile(
                                      tileColor: Colors.white,
                                      title: Text(e["userMail"]),
                                      subtitle: Text(e["category"]),
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
  final int count;
  const Score(
      {Key? key, required this.color, required this.text, required this.count})
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
              child: Text(count.toString(),
                  style: Theme.of(context).textTheme.displayMedium),
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
  final String userMail;
  final Function(String rt) onRewardApplied;
  const RewardCard(
      {Key? key,
      required this.title,
      required this.desc,
      this.image,
      required this.userMail,
      required this.onRewardApplied})
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
                        onPressed: () async {
                          final TextEditingController tc =
                              TextEditingController();
                          final TextEditingController rtc =
                              TextEditingController();
                          showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                    content: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            controller: rtc,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            decoration: const InputDecoration(
                                                hintText:
                                                    "Enter the email you want to vote the card"),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            controller: tc,
                                            minLines: 5,
                                            maxLines: 7,
                                            decoration: const InputDecoration(
                                                hintText:
                                                    "Enter your message that made you to vote (Optional)"),
                                          ),
                                        ),
                                        ElevatedButton(
                                            onPressed: () async {
                                              var res2 = await post(
                                                  Uri.parse(
                                                      "http://localhost:7000/send-mail"),
                                                  body: {
                                                    "recieverMail": rtc.text,
                                                    "mailSubject":
                                                        "Congratulations you won reward card for " +
                                                            title,
                                                    "cardImg": "",
                                                    "userMail": userMail,
                                                    "cardType": title,
                                                  });
                                              print(res2.statusCode);
                                              if (res2.statusCode == 200) {
                                                const sb = SnackBar(
                                                    content: Text(
                                                        "Successfully Send Card and Voted"));
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(sb);
                                                onRewardApplied(title);
                                              } else {
                                                const sb = SnackBar(
                                                    content: Text(
                                                        "Please Try Again !"));
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(sb);
                                              }
                                              Navigator.of(context).pop();
                                              print(res2.body);
                                            },
                                            child: const Text("Submit"))
                                      ],
                                    ),
                                  ));
                        },
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
