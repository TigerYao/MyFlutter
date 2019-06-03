import 'package:flutter/material.dart';
import 'package:flutter2/shrine/app.dart';
import 'package:flutter2/shrine/login.dart';
import 'package:flutter2/utils/sputils.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SPUtil>(
      future: SPUtil.getInstance(),
      builder: (context, snapShot) {
        if (snapShot.hasData) {
//          if (snapShot.data.getToken() != null) {
//            return AppPage();
//          } else
            return new MaterialApp(
              home: LoginPage(),
            );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
