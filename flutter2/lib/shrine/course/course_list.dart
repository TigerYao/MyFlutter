import 'package:flutter/material.dart';
import 'package:flutter2/model/course_list_model.dart';
import 'package:flutter2/net/service_api.dart';
import 'package:flutter2/model/category_model.dart';
import 'package:flutter2/shrine/course/course_item.dart';

class CourseListPage extends StatefulWidget {
  final TabController tabController;
  final List<CourseCategoryBean> beans;
  CourseListPage(this.beans, this.tabController)
      : assert(beans != null, tabController != null);

  @override
  State<StatefulWidget> createState() {
    return CourseListPageState();
  }
}

class CourseListPageState extends State<CourseListPage> {
  Future<List<CourseList>> courseItems;
  String mCateId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String cateId = widget.beans[0].cateId.toString();
    courseItems = ServiceApi.getInstance().getCourseList(cateId);
    widget.tabController.addListener((){
      cateId = widget.beans[widget.tabController.index].cateId.toString();
      if (mCateId != null && mCateId == cateId)
        return;
      mCateId = cateId;
      setState(() {
        courseItems = ServiceApi.getInstance().getCourseList(cateId);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
//    return TabBarView(controller: widget.tabController, children: <Widget>[
     return FutureBuilder<List<CourseList>>(
          future: courseItems,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<CourseList> datas = snapshot.data;
              return ListView.builder(
                  itemCount: datas.length,
                  itemBuilder: (context, index) {
                    CourseList item = datas[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        createTitle(item.img, item.title),
                        createListItem(item.data)
                      ],
                    );
                  });
            } else
              return Center(
                child: CircularProgressIndicator(),
              );
          });
//      Text('事业单位'),
//      Text('面试'),
//      Text('公务员'),
//      Text('公务员'),
//      Text('公务员'),
//    ]);
  }

  //内容分类
  Widget createTitle(String img, String title) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: <Widget>[
          Image.network(
            img,
            width: 25,
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

//列表
  Widget createListItem(final List<CourseItem> items) {
    return Card(
      color: Colors.white,
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Container(
          margin: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
          alignment: Alignment.centerLeft,
          child: Column(
            children: <Widget>[
              CourseItemPage(courses:items),
              Center(
                heightFactor: 2,
                child: Text(
                  '查看更多',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              )
            ],
          )),
      semanticContainer: false,
      clipBehavior: Clip.antiAlias,
    );
  }


}
