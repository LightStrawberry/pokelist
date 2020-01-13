import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokelist/page/stat.dart';

class DetailPage extends StatefulWidget {
  final String id;
  const DetailPage(this.id);

  @override
  State<StatefulWidget> createState() => _DetailState(id);
}

class _DetailState extends State<DetailPage> with SingleTickerProviderStateMixin {
  // final String id;
  // const _DetailState(this.id);
  String id;
  _DetailState(String id){  // 有参构造函数，
    this.id = id;
  }

  final _bottomNavigationColor = Colors.blue;
  int _currentIndex = 0;
  var _controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[
          DetailStatPage(id),
          // SkillPage(id),
        ],
        // 可以左右滑动
        // physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _bottomNavigationColor,
              ),
              title: Text(
                'STAT',
                style: TextStyle(color: _bottomNavigationColor),
              )),
              BottomNavigationBarItem(
              icon: Icon(
                Icons.email,
                color: _bottomNavigationColor,
              ),
              title: Text(
                'SKILL',
                style: TextStyle(color: _bottomNavigationColor),
              )),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}