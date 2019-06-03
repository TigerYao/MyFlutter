import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget{
  final List<BottomBarItem> items;
  final int currentIndex;
  final Color backgroundColor;
  final Color textFocusColor;
  final ValueChanged<int> onTap;


  BottomBar({@required this.items, this.currentIndex, this.backgroundColor,
      this.textFocusColor, this.onTap});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BottomBarState();
  }
}

class _BottomBarState extends State<BottomBar>{
  @override
  Widget build(BuildContext context) {
    final List<Widget> children = List();
    for(int i = 0;i< widget.items.length;i++){
      children.add(_createItem(i));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: children,
    );
  }

  Widget _createItem(int index){
    BottomBarItem item = widget.items[index];
    bool selected = index == widget.currentIndex;
    return Expanded(
        flex: 1,
        child: Container(
          color: widget.backgroundColor,
          padding: EdgeInsets.only(top: 4, bottom: 4),
          child: InkResponse(
            onTap: (){
              if (widget.onTap != null)
                  widget.onTap(index);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                selected ? item.activeIcon : item.icon,
                DefaultTextStyle.merge(
                  style: TextStyle(
                    fontSize: 10,
                    color: selected ? widget.textFocusColor : Colors.black38
                  ),
                  child: item.title
                )
              ],
            ),
          ),
        ));
  }
}

class BottomBarItem {
  final Widget icon;
  final Widget activeIcon;
  final Widget title;

  BottomBarItem({@required this.icon, this.activeIcon, this.title}):assert(icon != null);

}