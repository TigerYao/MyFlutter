import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter2/common/constant.dart';
import 'package:flutter2/utils/apputils.dart';
import 'package:flutter2/utils/sputils.dart';

class DioFactory{
  static Dio _dio;

  static DioFactory _instance;
  static SPUtil spUtils;

  static DioFactory getInstance(){
    if (_instance == null){
       DeviceInfo.getInstance();
      _instance = new DioFactory._();
      _instance._init();
    }

    return _instance;
  }

  DioFactory._();

  _init(){
    _dio = new Dio(new Options(
      baseUrl: Constant.baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 100000,
      contentType: ContentType.json,
      responseType: ResponseType.JSON,
      headers: {
        "token" :'',
        'uid': '-1',
        'cv': DeviceInfo.cv,
        'pixel': DeviceInfo.pixel,
        'terminal':'1',
        'device': DeviceInfo.device,
        'system': DeviceInfo.system,
        'channelId':'ht00000020',
        'appType':'2',
        'subject':'1',
        'catgory': '-1'
      }
    ));
  }

  getDio(){
    return _dio;
  }

  putOptions(String token, int uid, int subject, int catgory) async{
    if(spUtils == null)
      spUtils = await SPUtil.getInstance();
    spUtils.setToken(token);
    spUtils.setUid(uid.toString());
    spUtils.setUserSubject(subject);
    spUtils.setUserCatgory(catgory);
  }

  setOptions()async{
    if(spUtils == null)
      spUtils = await SPUtil.getInstance();
    _dio.options.headers['token'] = spUtils.getToken();
    _dio.options.headers['uid'] = spUtils.getUid();
    _dio.options.headers['subject'] =  spUtils.getUserSubject();
    _dio.options.headers['catgory'] = spUtils.getUserCatgory();
  }
}