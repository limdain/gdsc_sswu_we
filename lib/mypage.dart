import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';
import 'main.dart';
import 'camera.dart';
import 'calendar.dart';
import 'appinformation.dart';
import 'imagecount.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 3; // mypage가 선택된 상태로 초기화합니다.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // 설정 페이지로 이동
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Color(0xFFDEF4DF),
                    child: Image.asset('assets/images/we_logo.png', width: 50, height: 50),
                  ),
                ],
              ),
            ),
          ),

          Container(
              margin: EdgeInsets.fromLTRB(30, 20, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Past History', style: TextStyle(fontSize: 17)),
                  Divider(),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('$imageCount', style: TextStyle(fontSize: 25)),
                            Text(' '),
                            Text('Recycling', style: TextStyle(fontSize: 12)),
                            Text('Count', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              )
          ),

          ListTile(
            title: Text('Logout', style: TextStyle(fontSize: 15)),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              _showLogoutDialog(context);
            },
          ),
          ListTile(
            title: Text('App Information', style: TextStyle(fontSize: 15)),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(context, PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => appinformation(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return child;
                },
              ));
            },
          ),

          Divider(),

        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
            BottomNavigationBarItem(icon: Icon(Icons.camera_alt),
                label: 'camera'),
            BottomNavigationBarItem(icon: Icon(Icons.date_range),
                label: 'calendar'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline),
                label: 'mypage'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black54,
          unselectedItemColor: Colors.grey.shade400,
          onTap: (index) async {
            if (index == 0) {
              Navigator.push(context, PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => MyMainPage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return child;
                },
              ));
            }
            if (index == 1) {
              Navigator.push(context, PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => CameraScreen(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return child;
                },
              ));
            }
            if (index == 2) {
              Navigator.push(context, PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => CalendarScreen(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return child;
                },
              ));
            }
          }
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            margin: EdgeInsets.all(10),
            child: Text('Would you like to log out from We:'),
          ),
          backgroundColor: Color(0xFFDEF4DF),
          contentPadding: EdgeInsets.all(10.0), // 내용에 대한 패딩 조정
          actionsPadding: EdgeInsets.symmetric(horizontal: 10.0), // 액션 버튼들의 좌우 패딩 조정

          actions: <Widget>[
            TextButton(
              child: Text('Yes', style: TextStyle(color: Color(0xFF417541),)),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => MyFirebaseApp(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return child;
                    },
                  ),
                );
              },
            ),
            TextButton(
              child: Text('No', style: TextStyle(color: Color(0xFF417541),)),
              onPressed: () {
                Navigator.of(context).pop(); // Dialog 닫기
              },
            ),
          ],
        );
      },
    );
  }

}