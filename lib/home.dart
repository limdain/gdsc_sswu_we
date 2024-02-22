import 'package:flutter/material.dart';
import 'camera.dart';
import 'mypage.dart';
import 'calendar.dart';
import 'imagecount.dart';

class MyMainPage extends StatefulWidget {
  const MyMainPage({Key? key}) : super(key: key);

  @override
  _MyMainPageState createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 1) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              CameraScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child;
          },
        ),
      );
    }
    if (index == 2) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              CalendarScreen(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child;
          },
        ),
      );
    }
    if (index == 3) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => MyHomePage(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return child;
          },
        ),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedIndex != 3 ? _getBodyWidget() : Container(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt), label: 'camera'),
          BottomNavigationBarItem(
              icon: Icon(Icons.date_range), label: 'calendar'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'mypage'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.grey.shade400,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _getBodyWidget() {
    int imageIndex = (imageCount % 60) ~/ 10 + 1;
    String imageName = 'Otter_$imageIndex.png';

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 60),
              Container(
                padding: EdgeInsets.all(12),
                width: constraints.maxWidth * 0.8,
                height: constraints.maxHeight * 0.1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Otter',
                        style: TextStyle(
                          fontSize: 14,
                        )),
                    Text('level $imageIndex',
                        style: TextStyle(
                          fontSize: 14,
                        )),
                  ],
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(top: constraints.maxHeight * 0.03),
                child: Image.asset('assets/images/$imageName',
                    width: constraints.maxWidth * 0.5,
                    height: constraints.maxWidth * 0.5),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: constraints.maxWidth * 0.8,
                      height: constraints.maxWidth * 0.3,
                      decoration: BoxDecoration(
                        color: Color(0xFFDEF4DF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Number of times recycled',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            imageCount == 1 ? 'once' : '$imageCount times',
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Did you recycle this week?',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}