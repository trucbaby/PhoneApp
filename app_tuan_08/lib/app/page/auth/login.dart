import 'package:app_tuan_08/app/config/const.dart';
import 'package:app_tuan_08/app/data/api.dart';
import 'package:app_tuan_08/app/page/auth/forgotpassword.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import '../register.dart';
import 'package:app_tuan_08/mainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../../data/sharepre.dart';
import 'widgetbg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController accountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;

  Future<void> login() async {
    try {
      String token = await APIRepository()
          .login(accountController.text, passwordController.text);
      var user = await APIRepository().current(token);
      saveUser(user);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Mainpage()));
    } catch (e) {
      _showErrorDialog("Login failed", e.toString());
    }
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'Đăng nhập thất bại',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text('Tài khoản hoặc mật khẩu không chính xác!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 150,),
                Container(
                  height: 150,
                  child: Center(
                    child: Text(
                      'PhoneStore',
                      style: textlogo,
                    ),
                  ),
                ),
                
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      //account
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 210, 210, 210),
                          borderRadius: BorderRadius.circular(13),
                          
                        ),
                        child: TextFormField(
                          controller: accountController,
                          decoration: InputDecoration(
                            contentPadding: 
                              const EdgeInsets.symmetric(
                                vertical: 20,
                              ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: 'Tài khoản',
                            hintStyle: TextStyle(color: Color.fromARGB(255, 53, 53, 53)),
                            prefixIcon: const Icon(Icons.person),
                            prefixIconColor: const Color.fromARGB(255, 53, 53, 53),
                          ),
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 20),

                      //password
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 210, 210, 210),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            contentPadding: 
                              const EdgeInsets.symmetric(
                                vertical: 20,
                              ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: 'Mật khẩu',
                            hintStyle: TextStyle(color: Color.fromARGB(255, 53, 53, 53)),
                            prefixIcon: const Icon(Icons.lock),
                            prefixIconColor: const Color.fromARGB(255, 53, 53, 53),
                            suffixIconColor: const Color.fromARGB(255, 53, 53, 53),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),

                      //quen mk
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40
                        ),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const ForgotPassword()),
                                      );
                                    },
                                    child: Text(
                                      "Quên mật khẩu?",
                                      style: TextStyle(color: const Color.fromARGB(255, 53, 53, 53), fontSize: 17),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                          
                        ),
                      ),

                      //BT LOGIN
                      SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 103, 117, 138),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: TextButton(
                            onPressed: login,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              child: Text (
                                'ĐĂNG NHẬP',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                      ),

                      //ĐKI
                      SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40
                        ),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const Register()),
                                      );
                                    },
                                    child: Text(
                                      "Đăng ký tài khoản",
                                      style: TextStyle(color: const Color.fromARGB(255, 53, 53, 53), fontSize: 17),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  )
                  
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
   
