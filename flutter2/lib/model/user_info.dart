class UserInfo {
  int id;
  String email;
  String mobile;
  String nick;
  String uname;
  int status;
  int expireTime;
  String token;
  int subject;
  int catgory;
  String subjectName;
  int area;
  String areaName;
  String avatar;
  int qcount;
  int errorQcount;

  bool firstLogin;

  UserInfo.fromJson(Map<String, dynamic> json)
  : id = json['id'],
    email = json['email'],
    mobile = json['mobile'],
    nick = json['nick'],
    uname = json['uname'],
    status = json['status'],
    expireTime = json['expireTime'],
    token = json['token'],
    subject = json['subject'],
    catgory = json['catgory'],
    subjectName = json['subjectName'],
    area = json['area'],
    areaName = json['areaName'],
    avatar = json['avatar'], qcount = json['qcount'],
    errorQcount = json['errorQcount'],
    firstLogin = json['firstLogin'];

// RegisterFreeCourseBean registerFreeCourseDetailVo;
@override
  String toString() {
    // TODO: implement toString
    return 'token='+token+", mobile="+mobile;
  }
}
