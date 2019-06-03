import 'package:flutter/material.dart';
import 'package:flutter2/shrine/home.dart';
import 'package:flutter2/shrine/main_bottom_bar.dart';
import 'package:flutter2/shrine/course/course.dart';

class AppPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AppPageState();
  }
}

class _AppPageState extends State<AppPage> with SingleTickerProviderStateMixin{
  final PageController _pageController = PageController(initialPage: 0);
  int _tabIndex = 0;

  _onPageChange(int index){
    setState(() {
      _tabIndex = index;
    });
  }

  Image _getBarIcon(int index, bool isActive){
    String path;
    if (index == 0){
      path = isActive ? 'image/tab_one_selected.png' : 'image/tab_one.png';
    }else if(index == 1) 
      path = isActive ? 'image/tab_two_selected.png' : 'image/tab_two.png';
    else if(index == 2)
      path = isActive ? 'image/tab_three_selected.png' : 'image/tab_three.png';
    else if(index == 3)
      path = isActive ? 'image/tab_four_selected.png' : 'image/tab_four.png';
    
    return Image.asset(path, width: 24.0, height: 24.0);
  }
  
  Text _getBarText(int index){
    if(index == 0)
      return Text('题库',style: TextStyle(fontSize: 10),);
    else if(index == 1)
      return Text('课程',style: TextStyle(fontSize: 10),);
    else if(index == 2)
      return Text('学习',style: TextStyle(fontSize: 10),);
    else if(index == 3)
      return Text('我的',style: TextStyle(fontSize: 10),);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'home',
      home: Scaffold(
        body: PageView.builder(
            onPageChanged: _onPageChange,
            controller: _pageController,
            itemBuilder: (context, index){
              if(index == 0)
                return HomePage();
              else if (index == 1)
                  return CoursePage();
              else if (index == 2)
                return Text("学习");
              else if (index == 3)
                return Text("我的");

            },
          itemCount: 4,
        ),
        bottomNavigationBar: BottomBar(
            backgroundColor: Color(0xffeeeff2),
            currentIndex: _tabIndex,
            textFocusColor: Colors.deepOrange,
            onTap: (index){
              _pageController.jumpToPage(index);
              _onPageChange(index);
            },
            items: <BottomBarItem>[
              BottomBarItem(
                icon: _getBarIcon(0, false),
                title: _getBarText(0),
                activeIcon: _getBarIcon(0, true)
              ),
              BottomBarItem(
                  icon: _getBarIcon(1, false),
                  title: _getBarText(1),
                  activeIcon: _getBarIcon(1, true)
              ),
              BottomBarItem(
                  icon: _getBarIcon(2, false),
                  title: _getBarText(2),
                  activeIcon: _getBarIcon(2, true)
              ),
              BottomBarItem(
                  icon: _getBarIcon(3, false),
                  title: _getBarText(3),
                  activeIcon: _getBarIcon(3, true)
              ),
            ]),
      ),
    );
  }
}