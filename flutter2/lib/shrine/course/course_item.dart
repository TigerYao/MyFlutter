import 'package:flutter/material.dart';
import 'package:flutter2/model/course_list_model.dart';
import 'package:flutter2/net/service_api.dart';
import 'package:flutter2/model/course_collect_model.dart';

class CourseItemPage extends StatefulWidget {
  final List<CourseItem> courses;
  final String cateId;

  CourseItemPage({this.courses, this.cateId});

  @override
  State<StatefulWidget> createState() {
    return _CourseItemPageState();
  }
}

class _CourseItemPageState extends State<CourseItemPage> {
  int currentPage = 0;
  List<CourseItem> items;
  @override
  void initState() {
    super.initState();
    if (widget.courses == null || widget.courses.isEmpty)
      ServiceApi.getInstance()
          .getCollectCourseBean(widget.cateId, currentPage, 20)
          .then((CourseCollectList beans) {
        items = beans.data;
        setState(() {});
      });
    else
      items = widget.courses;
  }

  @override
  Widget build(BuildContext context) {
    return items == null || items.isEmpty
        ? Center(
            child: CircularProgressIndicator(),
          )
        : createCourses(items);
  }

  Widget createCourses(List<CourseItem> items) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          CourseItem item = items[index];
          return Container(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                child: Column(
                  children: createCourseItem(item),
                ),
                onTap: () {
                  if (item.isCollect) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => new Scaffold(
                              appBar: AppBar(
                                title: Text(item.title),
                              ),
                              body: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: SingleChildScrollView(
                                    child: CourseItemPage(
                                        cateId: item.collectId.toString()),
                                  )),
                            )));
                  }
                },
              ));
        });
  }

  List<Widget> createCourseItem(CourseItem item) {
    List<Widget> items = <Widget>[];
    if (item.collectTag != null) {
      Widget collect = Container(
          alignment: Alignment.centerLeft,
          child: Text(
            item.collectTag,
            style: TextStyle(color: Colors.black, fontSize: 12),
          ));
      items.add(collect);
    }
    Widget titleWidget = Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Text(
        item.title,
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
    );
    items.add(titleWidget);
    if (item.brief != null && item.brief.isNotEmpty) {
      Widget briefView = Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Text(
          item.title,
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
      );
      items.add(briefView);
    }
    if (item.teacher != null || item.teacher.length > 0) {
      Widget widget = ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: item.teacher.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            Teacher teacher = item.teacher[index];
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage(teacher.roundPhoto),
                  radius: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 5, bottom: 5, left: 5),
                  child: Text(teacher.teacherName,
                      style: TextStyle(color: Colors.black, fontSize: 8)),
                )
              ],
            );
          });

      items.add(Container(
        height: 80,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            widget,
            Container(
              padding: const EdgeInsets.all(15),
              alignment: Alignment.bottomRight,
              child: Column(
                children: <Widget>[
                  Text(
                    '¥' + item.actualPrice,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      '${item.count}人已抢',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ));
      items.add(new Divider());
    }
    return items;
  }
}
