import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter2/model/home_banner_model.dart';
import 'dart:typed_data';

class HomeBannerPage extends StatefulWidget{
  final List<HomeBannerItem> items;
  final _homeBannerHeight;


  HomeBannerPage(this.items, this._homeBannerHeight);

  @override
  State createState() {
    return _HomeBannerState();
  }
}

class _HomeBannerState extends State<HomeBannerPage>{

  static int fakeLength = 1000;

  int _curPageIndex = 0;

  int _curIndicatorsIndex = 0;

  PageController _pageController = new PageController(initialPage: fakeLength ~/ 2);

  List<Widget> _indecators;

  List<HomeBannerItem> _fakeList = [];

  Duration _bannerDuration = new Duration(seconds: 3);

  Duration _bannerAnimationDuration = new Duration(milliseconds: 500);

  Timer _timer;

  bool reverse = false;

  bool _isEndScroll = true;

  @override
  void initState() {
    super.initState();
    _curIndicatorsIndex = fakeLength ~/2;
    initTimer();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }

  initTimer(){
    _timer = new Timer.periodic(_bannerDuration, (timer){
      if(_isEndScroll){
        _pageController.animateToPage(_curPageIndex + 1, duration: _bannerAnimationDuration, curve: Curves.linear);
      }
    });
  }

  _initFakeList() {
    for(int i = 0; i<fakeLength;i++){
      _fakeList.addAll(widget.items);
    }
  }

  _initIndicators() {
    if (_indecators != null)
    _indecators.clear();
    else
      _indecators = List();
    for(int i= 0;i<widget.items.length;i++){
      SizedBox sizedBox = SizedBox(
        width: 5.0,
        height: 5.0,
        child: new Container(
          color: i == _curIndicatorsIndex ? Colors.white : Colors.grey,
        ),
      );
      _indecators.add(sizedBox);
    }
  }

  _changePage(int index){
    _curPageIndex = index;
    _curIndicatorsIndex = widget.items.length == 0 ? 0 : index % widget.items.length;
    setState(() {});
  }

  Widget _buildIndicators(){
    _initIndicators();
    return new Align(
      alignment: Alignment.bottomCenter,
      child: new Container(
        color: Colors.black45,
        height: 20.0,
        child: Center(
          child: SizedBox(
            width: widget.items.length * 16.0,
            height: 5.0,
            child: Row(
              children: _indecators,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPagerView() {
    _initFakeList();
    return NotificationListener(
        onNotification: (ScrollNotification scrollNotification){
          if (scrollNotification is ScrollEndNotification || scrollNotification is UserScrollNotification)
            _isEndScroll = true;
          else
            _isEndScroll = false;

          return false;
        },
        child: PageView.builder(
            controller: _pageController,
            itemBuilder: (BuildContext context, int index){
              return _buildItem(context, index);
            },
          itemCount: _fakeList.length,
          onPageChanged: (index){
              _changePage(index);
          },
        ));
  }

  Widget _buildItem(BuildContext context, int index){
    HomeBannerItem item = _fakeList[index];
    return GestureDetector(
      onTap: (){

      },
      onTapDown: (down){
        _isEndScroll = false;
      },
      onTapUp: (up){
        _isEndScroll = true;
      },
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: item.image,
        height: widget._homeBannerHeight,
        fit: BoxFit.fitWidth,
      ),
    );
  }

  Widget _buildBanner(){
    return new Container(
      height: widget._homeBannerHeight,
      child: Stack(
        children: <Widget>[
          _buildPagerView(),
          _buildIndicators()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBanner();
  }


  final Uint8List kTransparentImage = new Uint8List.fromList(<int>[
    0x89,
    0x50,
    0x4E,
    0x47,
    0x0D,
    0x0A,
    0x1A,
    0x0A,
    0x00,
    0x00,
    0x00,
    0x0D,
    0x49,
    0x48,
    0x44,
    0x52,
    0x00,
    0x00,
    0x00,
    0x01,
    0x00,
    0x00,
    0x00,
    0x01,
    0x08,
    0x06,
    0x00,
    0x00,
    0x00,
    0x1F,
    0x15,
    0xC4,
    0x89,
    0x00,
    0x00,
    0x00,
    0x0A,
    0x49,
    0x44,
    0x41,
    0x54,
    0x78,
    0x9C,
    0x63,
    0x00,
    0x01,
    0x00,
    0x00,
    0x05,
    0x00,
    0x01,
    0x0D,
    0x0A,
    0x2D,
    0xB4,
    0x00,
    0x00,
    0x00,
    0x00,
    0x49,
    0x45,
    0x4E,
    0x44,
    0xAE,
  ]);

}