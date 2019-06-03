import 'package:flutter/material.dart';
import 'package:flutter2/shrine/home_banner.dart';
import 'package:flutter2/common/constant.dart';
import 'package:flutter2/net/service_api.dart';
import 'package:flutter2/model/home_banner_model.dart';
import 'package:flutter2/model/tip_bean.dart';
import 'package:flutter2/model/HomeTreeBean.dart';
import 'package:flutter2/shrine/login.dart';

class HomePage extends StatelessWidget {
  var _homeBannerData;
  var _matchIdForNewTip;
  ServiceApi _serviceApi;
  @override
  Widget build(BuildContext context) {
    if (_serviceApi == null) _serviceApi = ServiceApi.getInstance();
    _homeBannerData = _serviceApi.getBannerDatas();
    _matchIdForNewTip = _serviceApi.getMatchIdForNewTip();
    return Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
          new IconButton(
            // action button
            icon: new Icon(Icons.map),
            onPressed: () {},
          ),
          new IconButton(
            // action button
            icon: new Icon(Icons.add),
            onPressed: () {},
          ),
          new IconButton(
            // action button
            icon: new Icon(Icons.clear),
            onPressed: () {},
          ),
          new IconButton(
            // action button
            icon: new Icon(Icons.cancel),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          _createBody(),
        ],
      ),
    );
  }

  Widget _createBanner() {
    return new Align(
      alignment: Alignment.topCenter,
      child: new FutureBuilder<List<HomeBannerItem>>(
        future: _homeBannerData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<HomeBannerItem> items = snapshot.data;
            return HomeBannerPage(items, Constant.bannerHeight);
          } else if (snapshot.hasError) {
            return new Text("错误  ${snapshot.error}");
          }
          // By default, show a loading spinner
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _createTipView() {
    return Container(
      height: 100,
      child: FutureBuilder<List<TipNewBean>>(
          future: _matchIdForNewTip,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<TipNewBean> items = snapshot.data;
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return new Container(
                        margin: const EdgeInsets.all(10),
                        width: 80.0,
                        color: Colors.blue,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(icon: Icon(Icons.map), onPressed: () {}),
                            Text(
                              '${index}',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ));
                  });
            } else if (snapshot.hasError) {
              return new Text("错误  ${snapshot.error}");
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  Widget _createHomeNewTip() {
    return Container(
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          RaisedButton(
            padding: const EdgeInsets.only(
                left: 35.0, top: 20.0, right: 35.0, bottom: 20.0),
            child: const Text('精品微课',
                style: TextStyle(
                    fontSize: 14, color: Colors.white, fontFamily: 'siyuan')),
            elevation: 2.0,
            color: Colors.red,
            shape: new RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            onPressed: () {},
          ),
          RaisedButton(
            padding: const EdgeInsets.only(
                left: 35.0, top: 20.0, right: 35.0, bottom: 20.0),
            child: const Text('备考精华',
                style: TextStyle(
                    fontSize: 14, color: Colors.white, fontFamily: 'siyuan')),
            elevation: 2.0,
            color: Colors.red,
            shape: new RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _createBody() {
    return Column(
      children: <Widget>[
        _createBanner(),
        _createTipView(),
        _createHomeNewTip(),
        _HomeList()
      ],
    );
  }
}

class _HomeList extends StatefulWidget {
  @override
  State createState() => _HomeListState();
}

class _HomeListState extends State<_HomeList> {
  var _futureBuilderFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureBuilderFuture = ServiceApi.getInstance().getHomeDatas();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<List<HomeTreeBean>>(
      future: _futureBuilderFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _createExpandList(snapshot.data);
        } else if (snapshot.hasError) {
          return Text("错误");
        }
        return Center(
          child: CircularProgressIndicator(),
        );;
      },
    );
  }

  Widget _createExpandList(List<HomeTreeBean> beans) {
    return SingleChildScrollView(
      child: Container(
        child: _createExpandView(beans),
      ),
    );
  }

  Widget _createExpandView(List<HomeTreeBean> beans) {
    return ExpansionPanelList(
      animationDuration: Duration(milliseconds: 500),
      expansionCallback: (panelIndex, isExpanded) {
        setState(() {
          beans[panelIndex].isExpand = !isExpanded;
        });
      },
      children: beans.map((bean) {
        return ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return ListTile(
                title: Text(
                  bean.name,
                  style: TextStyle(color: Colors.black),
                ),
              );
            },
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: getChildrenPannle(bean),
            ),
            isExpanded: bean.isExpand);
      }).toList(),
    );
  }

  List<Widget> getChildrenPannle(HomeTreeBean bean) {
    List<Widget> childViews = new List();
    List<HomeTreeBean> items = bean.children;
    for (int i = 0; i < items.length; i++) {
      HomeTreeBean item = items[i];
      Widget widget = new Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.centerLeft,
        child: ListTile(
          title: Text(
            item.name,
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
      childViews.add(widget);
    }
    return childViews;
  }
}
