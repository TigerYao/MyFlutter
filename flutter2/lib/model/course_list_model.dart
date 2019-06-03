class CourseList {
  int cateId;
  String title;
  int order;
  String img;
  int number;
  bool more;
  int typeId;
  List<CourseItem> data;

  CourseList(
      {this.cateId,
        this.title,
        this.order,
        this.img,
        this.number,
        this.more,
        this.typeId,
        this.data});

  CourseList.fromJson(Map<String, dynamic> json) {
    cateId = json['cateId'];
    title = json['title'];
    order = json['order'];
    img = json['img'];
    number = json['number'];
    more = json['more'];
    typeId = json['typeId'];
    if (json['data'] != null) {
      data = new List<CourseItem>();
      json['data'].forEach((v) {
        data.add(new CourseItem.fromJson(v));
      });
    }
  }
}

class CourseItem {
  var id;
   List<String> activeTag;//活动标签
   String actualPrice;//实际价格
   String brief;//描述
   String classId;//课程ID
   var collectId;//合集ID
   var count;//销量
   String img;//图片
   var limit;//限购人数
   var limitType;//限报形式
   String liveDate;//直播日期（区间）
   String price;//原价
   String redEnvelopeId;//红包ID
//     int collageActiveId;//拼团ID
   String collageActiveId;//拼团ID
   int saleEnd;//距离倒计时结束的时间戳
   int lSaleEnd;//距离倒计时结束的时间戳
   var saleStart;//距离倒计时开始的时间戳
   int lSaleStart;//距离倒计时开始的时间戳
   String terminedDesc;//	待售描述
   String timeLength;//	课时描述
   String title;//	课程标题
   String collectTag;//	合集标签
   String collectBrief ;//	精品微课合集描述
   String teacherDesc;
//     int videoType;//	0录播1直播
   String videoType;//	0录播1直播
   bool isCollect;//是否是合集
   bool isRushOut;//是否停售
   bool isSaleOut;//是否售罄
   bool isTermined;//是否待售
   bool secondKill;//是否秒杀
   bool suit;//是否套餐课
  List<Teacher> teacher;

  CourseItem(
      {this.id,
        this.collectTag,
        this.title,
        this.price,
        this.isTermined,
        this.terminedDesc,
        this.teacherDesc,
        this.img,
        this.collectBrief,
        this.limit,
        this.activeTag,
        this.isCollect,
        this.actualPrice,
        this.collectId,
        this.count,
        this.teacher,
        this.limitType,
        this.saleStart,
        this.saleEnd,
        this.isRushOut,
        this.isSaleOut});

  CourseItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    collectTag = json['collectTag'];
    title = json['title'];
    price = json['price'];
    isTermined = json['isTermined'];
    terminedDesc = json['terminedDesc'];
    teacherDesc = json['teacherDesc'];
    img = json['img'];
    collectBrief = json['collectBrief'];
    limit = json['limit'];
    if (json['activeTag'] != null) {
      activeTag = new List<String>();
      json['activeTag'].forEach((v) {
        activeTag.add(v.toString());
      });
    }
    isCollect = json['isCollect'];
    actualPrice = json['actualPrice'];
    collectId = json['collectId'];
    count = json['count'];
    if (json['teacher'] != null) {
      teacher = new List<Teacher>();
      json['teacher'].forEach((v) {
        teacher.add(new Teacher.fromJson(v));
      });
    }
    limitType = json['limitType'];
    saleStart = json['saleStart'];
    saleEnd = json['saleEnd'];
    isRushOut = json['isRushOut'];
    isSaleOut = json['isSaleOut'];
    brief = json['brief'];
  }

}

class Teacher {
  String teacherId;
  String teacherName;
  String roundPhoto;

  Teacher({this.teacherId, this.teacherName, this.roundPhoto});

  Teacher.fromJson(Map<String, dynamic> json) {
    teacherId = json['teacherId'];
    teacherName = json['teacherName'];
    roundPhoto = json['roundPhoto'];
  }

}