import 'package:flutter2/model/course_list_model.dart';

class CourseCollectList {
  int current_page;
  List<CourseItem> data;
  int from;
  int last_page;
  var next_page_url;
  String path;
  int per_page;
  var prev_page_url;
  var to;
  int total;

  CourseCollectList.fromJson(Map<String, dynamic> json){
    current_page = json['current_page'];
    from = json['from'];
    last_page = json['last_page'];
    next_page_url = json['next_page_url'];
    total = json['total'];
    List<dynamic> items =json['data'];
    data = items.map((item) => CourseItem.fromJson(item)).toList();
  }
}