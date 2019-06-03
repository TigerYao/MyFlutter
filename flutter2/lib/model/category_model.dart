class CourseCategoryBean {
  int cateId;
  bool checked;
  String name;
  bool isSelected;
  String subjectId;
  List<CategorysBean> categorys;

  CourseCategoryBean.fromJson(Map<String, dynamic> json){
    cateId = json['cateId'];
    checked = json['checked'];
    name = json['name'];
    isSelected = json['isSelected'];
    subjectId = json['subjectId'];
    if(json.containsKey('categorys')) {
      List<dynamic> params = json['categorys'];
      categorys = params.map((item) => CategorysBean.fromJson(item)).toList();
    }
  }
}

class CategorysBean {
  String catname;
  int categoryid;
  CategorysBean.fromJson(Map<String, dynamic> json){
    catname = json['catname'];
    categoryid = json['categoryid'];
  }
}
