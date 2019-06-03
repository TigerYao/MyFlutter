class SignUpTypeBean {


  /**
   * id : 1
   * name : 公务员
   * childrens : [{"id":1,"name":"公务员行测","childrens":[],"tiku":false}]
   * tiku : true
   */

  int id;
  String name;
  bool tiku;
  List<SignUpTypeBean> childrens;
  bool isSelected;

  SignUpTypeBean.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    tiku = json['tiku'];
    isSelected = json['isSelected'];
    if (json.containsKey("childrens")) {
      List<dynamic> datas = json['childrens'];
      childrens = datas.map((f) => SignUpTypeBean.fromJson(f)).toList();
    }
  }

  @override
  String toString() {
    // TODO: implement toString
    return "name = " + name +'， tiku= '+ tiku.toString() +', isSelected = ' + isSelected.toString() + ', childrens = '+ childrens.toString();
  }
}