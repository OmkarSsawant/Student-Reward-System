import 'dart:convert';

class User {
  late String name;
  final String email;
  final String pswd;
  late List<dynamic> cardsUsed;
  late List<dynamic> cardsRecieved;
  late List<dynamic> cardsSent;

  User(this.email, this.pswd);

  void updateFromResponce(res) {
    res = jsonDecode(res);
    name = res["user"]["userName"];
    cardsUsed = res["user"]["cardsUsed"];
    var cardsRecieved = res["user"]["cardsRecieved"];
    var cardsSent = res["user"]["cardSent"]["details"];
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
