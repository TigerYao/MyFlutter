import 'package:device_info/device_info.dart';
import 'dart:ui';
import 'dart:io';
import 'package:package_info/package_info.dart';

class DeviceInfo{
  static String cv;
  static String pixel;
  static String device;
  static String system;
  static String channelId;
  static String versionName;
  static DeviceInfo _instance;
  static DeviceInfo getInstance(){
    if (_instance == null){
      _instance = DeviceInfo._();
      _instance._init();
    }
    return _instance;
  }

  DeviceInfo._();
  _init() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if(Platform.isIOS){
      //ios相关代码
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      device = iosInfo.model;
      pixel = window.physicalSize.width.toString() +'_'+ window.physicalSize.height.toString();
      cv = packageInfo.version;
      system = iosInfo.systemName;
    }else if(Platform.isAndroid){
      //android相关代码
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      device = androidInfo.model;
      pixel = window.physicalSize.width.toString() +'_'+ window.physicalSize.height.toString();
      cv = packageInfo.version;
      system = androidInfo.version.release;
    }
  }

//  void getDeviceInfo() async {
//    DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();
//    if(Platform.isAndroid) {
//      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//      _readAndroidBuildData(androidInfo);
//    } else if (Platform.isIOS) {
//      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
//      _readIosDeviceInfo(iosInfo);
//    }
//  }
//
//  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
//    return <String, dynamic>{
//      'version.securityPatch': build.version.securityPatch,
//      'version.sdkInt': build.version.sdkInt,
//      'version.release': build.version.release,
//      'version.previewSdkInt': build.version.previewSdkInt,
//      'version.incremental': build.version.incremental,
//      'version.codename': build.version.codename,
//      'version.baseOS': build.version.baseOS,
//      'board': build.board,
//      'bootloader': build.bootloader,
//      'brand': build.brand,
//      'device': build.device,
//      'display': build.display,
//      'fingerprint': build.fingerprint,
//      'hardware': build.hardware,
//      'host': build.host,
//      'id': build.id,
//      'manufacturer': build.manufacturer,
//      'model': build.model,
//      'product': build.product,
//      'supported32BitAbis': build.supported32BitAbis,
//      'supported64BitAbis': build.supported64BitAbis,
//      'supportedAbis': build.supportedAbis,
//      'tags': build.tags,
//      'type': build.type,
//      'isPhysicalDevice': build.isPhysicalDevice,
//      'androidId': build.androidId
//    };
//  }
//
//  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
//    return <String, dynamic>{
//      'name': data.name,
//      'systemName': data.systemName,
//      'systemVersion': data.systemVersion,
//      'model': data.model,
//      'localizedModel': data.localizedModel,
//      'identifierForVendor': data.identifierForVendor,
//      'isPhysicalDevice': data.isPhysicalDevice,
//      'utsname.sysname:': data.utsname.sysname,
//      'utsname.nodename:': data.utsname.nodename,
//      'utsname.release:': data.utsname.release,
//      'utsname.version:': data.utsname.version,
//      'utsname.machine:': data.utsname.machine,
//    };
//  }
}