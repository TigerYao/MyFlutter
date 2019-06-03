import 'package:flutter/material.dart';

import 'package:flutter2/net/service_api.dart';
import 'package:flutter2/model/user_info.dart';
import 'package:flutter2/utils/Toast.dart';
import 'package:flutter2/shrine/app.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ServiceApi serviceApi = ServiceApi();

  @override
  Widget build(BuildContext context) {
//    return MaterialApp(
//        title: '登录',
//        theme: new ThemeData(
//          primarySwatch: Colors.blue,
//        ),
//        home:createLgView());
    return createLgView(context);
  }

  void _loginByPassword() async{
    String userName = _usernameController.text;
    String psw = _passwordController.text;
    UserInfo userInfo = await serviceApi.login(userName, psw).then((userInfo){
      if (userInfo != null) {
        print("---1" + userInfo.toString());
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => AppPage()));
      }else
        Toast.toast(context, "登录失败");
    }).then((userInfo){
      print("---2" + userInfo.toString());
    });
  }

  Widget createLgView(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        centerTitle: true,
        title: Text(
          '登录',
          style: TextStyle(fontSize: 14, color: Colors.black, fontFamily: 'siyuan'),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              height: 48,
              alignment: Alignment.centerLeft,
              color: Colors.grey[200],
              child: Text(
                '华图教育/华图网校/砖题库账号均可登录',
                style: TextStyle(fontSize: 14, color: Colors.grey[500],fontFamily: 'siyuan'),
              ),
              padding: const EdgeInsets.all(8.0),
            ),
            PrimaryColorOverride(
              color: Colors.grey[300],
              child: TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: '用户名',
                  contentPadding: const EdgeInsets.all(8.0),
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 2.0),
            PrimaryColorOverride(
              color: Colors.grey,
              child: TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: '密码',
                  contentPadding: const EdgeInsets.all(8.0),
                  fillColor: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: RaisedButton(
                padding: const EdgeInsets.all(15),
                child: const Text('登录',
                    style: TextStyle(fontSize: 14, color: Colors.white,fontFamily: 'siyuan')),
                elevation: 2.0,
                color: Colors.red,
                shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                onPressed: () {
                  _loginByPassword();
                },
              ),
            ),
            Wrap(
              children: <Widget>[
                ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: const Text('重置'),
                      shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7.0)),
                      ),
                      onPressed: () {
                        _usernameController.clear();
                        _passwordController.clear();
                      },
                    ),
                    RaisedButton(
                      child: const Text('登录'),
                      elevation: 2.0,
                      shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7.0)),
                      ),
                      onPressed: () {
                        _loginByPassword();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PrimaryColorOverride extends StatelessWidget {
  const PrimaryColorOverride({Key key, this.color, this.child})
      : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: Theme.of(context).copyWith(primaryColor: color, backgroundColor: Colors.white),
    );
  }
}
