import 'package:flutter/material.dart';
import 'package:flutter2/shrine/course/course_list.dart';
import 'package:flutter2/model/category_model.dart';
import 'package:flutter2/net/service_api.dart';

class CoursePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CoursePageState();
  }
}

class _CoursePageState extends State with SingleTickerProviderStateMixin {
  TabController tabController;
  List<CourseCategoryBean> categorys;
  List<Widget> tabs = <Widget>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 0, vsync: this);
    ServiceApi.getInstance()
        .getCategoryList()
        .then((List<CourseCategoryBean> beans) {
      categorys = beans;
      setState(() {
        tabController = TabController(length: beans.length, vsync: this);
        tabs = beans
            .map((bean) => Tab(
                  text: bean.name,
                ))
            .toList();
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: new IconButton(
          // action button
          icon: new Icon(
            Icons.map,
            color: Colors.grey,
          ),
          onPressed: () {},
        ),
        centerTitle: true,
        titleSpacing: 10,
        iconTheme:
            IconThemeData(color: Colors.grey[500], opacity: 0.5, size: 20),
        title: Container(
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[200],
              shape: BoxShape.rectangle),
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.search),
              Text(
                '华图在线课堂',
                style: TextStyle(color: Colors.black38, fontSize: 14),
              )
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
              icon: new Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: () {})
        ],
        bottom: TabBar(
            controller: tabController,
            isScrollable: true,
            labelColor: Colors.black38,
            tabs: tabs),
      ),
      body: categorys == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : CourseListPage(categorys, tabController),
    );
  }
}
