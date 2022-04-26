import 'dart:convert';

class User {
  late String name;
  final String email;
  final String pswd;
  late List<dynamic> cardsUsed;
  late Map<String, dynamic> cardsRecieved;
  late List<dynamic> cardsSent;
  late List<dynamic> winners;

  User(this.email, this.pswd);

  void updateFromResponce(res) {
    res = jsonDecode(res);
    print("RES : " + res.toString());
    name = res["user"]["userName"];
    print("NAME" + name);
    cardsUsed = res["user"]["cardsUsed"];
    print("CARDS USED " + cardsUsed.length.toString());
    cardsRecieved = res["user"]["cardsRecieved"];
    print("CARDS REC" + cardsRecieved.length.toString());
    cardsSent = res["user"]["cardSent"]["details"];
    print("CARDS REC" + cardsSent.length.toString());
    winners = List.from(res["winners"]);
    print("WINNERS REC" + winners.length.toString());

    print(name.toString() +
        cardsUsed.length.toString() +
        cardsRecieved.toString() +
        cardsSent.toString());
  }

  Map<String, String> toLoginMap() {
    return {"userMail": email, "passWord": pswd};
  }

  Map<String, String> toRegisterMap() {
    return {"userMail": email, "passWord": pswd, "userName": name};
  }
}
