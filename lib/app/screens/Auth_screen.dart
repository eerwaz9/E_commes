import 'package:flutter/material.dart';
import 'package:shoping/app/widgets/custem_butten.dart';

import '../../components/decortion.dart';
import '../services/Auth_servics.dart';
import '../widgets/custem_widget.dart';

enum AuthEnum { signin, signup }
class AuthScreen extends StatefulWidget {
  static const String routName = '/auth-screen';
  const AuthScreen({Key? key}) : super(key: key);
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _emailText = TextEditingController();
  final TextEditingController _passwordtext = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController emailText = TextEditingController();
  final TextEditingController passwordtext = TextEditingController();
  final Authservics authservics = Authservics();
  AuthEnum _auth = AuthEnum.signup;
  // AuthEnum _auth = AuthEnum.signin;
  final _signUpKey = GlobalKey<FormState>();
  final _signinKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    _emailText.dispose();
    _passwordtext.dispose();
    _username.dispose();
    emailText.dispose();
    passwordtext.dispose();
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    // signUpuser();
    // signinuser();

  }
  void signUpuser() {
    authservics.signUpUser(
        context: context,
        name: _username.text,
        email: _emailText.text,
        password: _passwordtext.text);
  }

  void signinuser() {
    authservics.signinUser(
        context: context, email: emailText.text, password: passwordtext.text);
  }

  @override
  Widget build(BuildContext context) {
    // var student=Provider<StudentPr
    return Scaffold(
      backgroundColor: Decortion.greyBackgroubdColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Center(
                    child: Text(
                      'welcom',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  ListTile(
                    tileColor: _auth == AuthEnum.signup
                        ? Colors.blueGrey
                        : Decortion.NuselectNavBarColor,
                    title: GestureDetector(
                      onTap: () {
                        setState(() {
                          _auth = AuthEnum.signup;
                        });

                      },
                      child:  Text(
                        "new Custemer",
                        style: TextStyle(
                           color:_auth==AuthEnum.signup?Colors.black : Colors.amber,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    leading: GestureDetector(
                      child: Icon(
                        Icons.fiber_dvr_outlined,
                        color: _auth == AuthEnum.signup ? Colors.red : Colors.amber,
                      ),
                      onTap: () {
                        setState(() {
                          _auth = AuthEnum.signup;
                        });
                      },
                    ),
                  ),

                  if (_auth == AuthEnum.signup)
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: Decortion.backgruondColor,
                      child: Form(
                        key: _signUpKey,
                        child: Column(
                          children: [
                            CustemText(
                              icon: Icons.person_2_outlined,
                              controller: _username,
                              lable: 'fullname',
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            CustemText(
                              icon: Icons.email_outlined,
                              controller: _emailText,
                              lable: 'Email',
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            CustemText(
                              icon: Icons.password_outlined,
                              controller: _passwordtext,
                              lable: 'password',
                            isPassword: true,),
                            const SizedBox(
                              height: 8,
                            ),
                            Custembutten(
                                text: "sign Up",
                                onTap: () {
                                  if (_signUpKey.currentState!.validate()) {
                                    signUpuser();
                                  }
                                })
                          ],
                        ),
                      ),
                    ),
                  //#########################################################################
                  ListTile(
                    tileColor: _auth == AuthEnum.signin
                        ? Colors.blueGrey
                        : Decortion.NuselectNavBarColor,
                    title: GestureDetector(
                      onTap: () {
                        setState(() {
                          _auth = AuthEnum.signin;
                        });
                      },
                      child: Text(
                        "have Acount ?",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _auth == AuthEnum.signin
                              ? Colors.black
                              : Colors.amber,
                        ),
                      ),
                    ),
                    leading: GestureDetector(
                      onTap: () {
                        setState(() {
                          _auth = AuthEnum.signin;
                        });
                      },
                      child: Icon(
                        Icons.accessibility_new_outlined,
                        color: _auth == AuthEnum.signin
                            ? Colors.red
                            : Colors.amber,
                      ),
                    ),
                  ),
                  if (_auth == AuthEnum.signin)
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: Decortion.backgruondColor,
                      child: Form(
                        key: _signinKey,
                        child: Column(
                          children: [
                            CustemText(icon: Icons.email_outlined,
                              controller: emailText,
                              lable: 'الايميل',
                            ),
                         const   SizedBox(
                              height: 8,
                            ),
                            CustemText(
                              icon: Icons.password_outlined,
                              controller: passwordtext,
                              lable: 'كلمة المرور',
                          isPassword: true,  ),
                         const   SizedBox(
                              height: 8,
                            ),
                            Custembutten(
                                text: "sign in",
                                onTap: () {
                                  if (_signinKey.currentState!.validate()) {
                                    signinuser();
                                  }
                                })
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
