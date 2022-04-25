import 'package:http/http.dart' as http;
import 'package:student_reward_system/data/user.dart';

void main() async {
  // var res = await http.post(Uri.parse("http://localhost:7000/login"),
  //     body: {"userMail": "omkar@mail.com", "passWord": "test123456"});
  // print(res.statusCode);
  // // print(res.body);

  // var res2 =
  //     await http.post(Uri.parse("http://localhost:7000/send-mail"), body: {
  //   "recieverMail": "i.m.vighnesh733@gmail.com",
  //   "mailSubject": "cdcdc",
  //   "cardImg": "",
  //   "userMail": "omkar@mail.com",
  //   "cardType": "thankYou",
  // });
  // print(res2.statusCode);
  // print(res2.body);

  var u = User(null, "omkar@mail.com", "test123456");
  var res = await http.post(Uri.parse("http://localhost:7000/login"),
      body: u.toLoginMap());
  print(res.statusCode);
  print(res.body);
}
