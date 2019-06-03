import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';

class SPUtil{
  static SharedPreferences _prefs;
  static SPUtil _instance;
  static Future<SPUtil> getInstance() async {
    if(_instance == null){
      var lock = new Lock();
      await lock.synchronized(() async{
        if (_instance == null){
          _instance = new SPUtil._();
          await _instance._init();
        }
      });
    }
    return _instance;
  }

  SPUtil._();

  _init() async{
    _prefs = await SharedPreferences.getInstance();
  }

  getSP(){
    return _prefs;
  }

  void setToken(String token){
    _prefs.setString("token", token);
  }
  String getToken(){
    return _prefs.getString('token');
  }

  void setUid(String uid){
    _prefs.setString("uid", uid);
  }

  String getUid(){
    return _prefs.getString('uid');
  }

  void setUserSubject(int subject){
    _prefs.setInt('user.subject', subject);
  }

  int getUserSubject(){
    return _prefs.getInt('user.subject');
  }

  void setUserCatgory(int catgory){
    _prefs.setInt('user.catgory', catgory);
  }

  int getUserCatgory(){
    return _prefs.getInt('user.catgory') ?? -1;
  }

  void setCustomDeviceId(String customDeviceId){
    _prefs.setString("CUSTOM_DEVICE_ID", customDeviceId);
  }

  String getCustomDeviceId(){
    return _prefs.getString('CUSTOM_DEVICE_ID');
  }
}
