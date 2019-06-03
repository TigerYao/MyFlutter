class HomeTreeBean {
  /**
   * {
   * "id":434,
   * "name":"公文",
   * "qnum":59,
   * "rnum":0,
   * "wnum":4,
   * "unum":0,
   * "times":0,
   * "speed":0,
   * "level":2,
   * "accuracy":0,
   * "children":[
   * <p>
   * ],
   * "unfinishedPracticeId":0
   * }
   */

  int id; // 类别Id
  String name; // 类别名称
  int qnum; // 总题数
  int rnum;
  int wnum;
  int unum; // 未做题数
  int times;
  int speed;
  int level; // 当前的级别
  double accuracy; // 正确率
  List<HomeTreeBean> children; //下一级的子Node       先不用
  int unfinishedPracticeId; // 未完成的试卷id

  // 自定义变量
  bool isExpand = false; // 是否展开了
  int parentId; // 父类id
  bool isLineUp; // 是否显示上线
  bool isLineDown; // 是否显示下线
// 自定义变量

  HomeTreeBean.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    qnum = json['qnum'];
    rnum = json['rnum'];
    wnum = json['wnum'];
    unum = json['unum'];
    times = json['times'];
    speed = json['speed'];
    level = json['level'];
    accuracy = json['accuracy'];
    unfinishedPracticeId = json['unfinishedPracticeId'];
    if (json.containsKey('children')){
      List<dynamic> childrenJson = json['children'];
      children = childrenJson.map((child) => HomeTreeBean.fromJson(child)).toList();
    }
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'name == ' + name + "....speed == " + speed.toString() + "...child.." + children.toString();
  }
}
