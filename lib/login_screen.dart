import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart'; // WE:
import 'signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'home.dart';
import 'imagecount.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _emailInputText = TextEditingController();
  var _passInputText = TextEditingController();

  void dispose() {
    _emailInputText.dispose();
    _passInputText.dispose();
    super.dispose();
  }

  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false; // 뒤로 가기 버튼을 눌러도 아무런 동작을 하지 않도록 함
        },
      child:Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 170),
                    Text('Login',
                        style: TextStyle(fontSize: 38, fontWeight: FontWeight.w500,)),
                    Text(' '),
                    Text('Access more services by logging in!',
                        style: TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w300,
                          color: Colors.grey[700],
                        )),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 70),
                    Column(
                      children: [
                        Container(
                            width: 400,
                            child: Text('Email', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500,))
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextField(
                            controller: _emailInputText,
                            decoration: InputDecoration(hintText: 'Please enter your email',
                              hintStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey[500],
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black54),
                              ),
                            ),
                            cursorColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: [
                        Container(
                          width: 400,
                          child: Text('Password',style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500,)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextField(
                            controller: _passInputText,
                            obscureText: true,
                            decoration: InputDecoration(hintText: 'Please enter your password',
                              hintStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                color: Colors.grey[500],
                              ),focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black54),
                              ),
                            ),
                            cursorColor: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    if (errorMessage.isNotEmpty) // errorMessage가 비어있지 않을 경우에만 표시
                      Container(
                        child: Column(
                          children: [
                            Text(errorMessage, style: TextStyle(fontSize: 13),),
                            SizedBox(height: 6),
                          ],
                        ),
                      ),
                    if (errorMessage.isEmpty)
                      Container(
                        child: SizedBox(height: 21),
                      ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: Image.asset('assets/images/we_logo.png', width: 24, height: 24),
                        label: Text('Log in', style: TextStyle(color: Colors.black87)),
                        onPressed: () async {
                          if (_emailInputText.text.isEmpty || _passInputText.text.isEmpty) return;

                          try {
                            await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: _emailInputText.text.toLowerCase().trim(),
                              password: _passInputText.text.trim(),
                            );
                            print('success login');

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SplashScreen()),
                            );
                          } on FirebaseAuthException catch (e) {
                            print('an error occurred $e');
                              errorMessage = 'Email or password is incorrect.';
                            setState(() {});
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          backgroundColor: Color(0xFFDEF4DF),
                          minimumSize: Size(88, 36),
                          side: BorderSide(color: Color(0xFFDEF4DF)),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(70, 60, 70, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Divider(
                                thickness: 0.7,
                                color: Colors.black54,
                              ),
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Container(
                                width: 9,
                                height: 9,
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Container(
                                width: 7,
                                height: 7,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Not a member yet?'),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignUpScreen()),
                              );
                            },
                            child: Text('Go to sign up'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      )
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      Navigator.push(context, PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => MyMainPage(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/we_logo.png', width: 100, height: 100),
      ),
    );
  }
}

