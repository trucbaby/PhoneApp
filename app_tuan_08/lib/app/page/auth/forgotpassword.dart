import 'package:app_tuan_08/app/page/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:app_tuan_08/app/data/api.dart';
import '../../data/sharepre.dart';
import 'widgetbg.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController accountIDController = TextEditingController();
  TextEditingController idNumberController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  Future<void> forgotPassword() async {
    try {
      String response = await APIRepository().forgotPassword(
        accountIDController.text,
        idNumberController.text,
        newPasswordController.text,
      );

      print('API Response: $response'); // Debugging

      if (response == "ok") {
        var user = await APIRepository().current(response);
        saveUser(user);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        // Show error message based on response
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to reset password: $response')),
        );
      }
    } catch (e) {
      // Handle exceptions including 401 error
      if (e.toString().contains('401')) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Thay đổi thành công')),
        );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quên mật khẩu'),
        backgroundColor:  Color.fromRGBO(239, 239, 239, 0.886),
      ),
      body: Stack(
        children: [
        BackgroundImage(),
        Scaffold(
          backgroundColor:  Color.fromRGBO(239, 239, 239, 0.886),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 100,
                  child: Center(
                    child: Text(
                      'Nhập thông tin',
                      style: TextStyle(fontSize: 25, color: Colors.black),
                    ),
                  ),
                ),
                //
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      //account
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 210, 210, 210),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: TextFormField(
                        controller: accountIDController,
                          decoration: InputDecoration(
                            contentPadding: 
                              const EdgeInsets.symmetric(
                                vertical: 20,
                              ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: 'ID Tài khoản',
                            hintStyle: TextStyle(color: Color.fromARGB(255, 53, 53, 53)),
                            prefixIcon: const Icon(Icons.person),
                            prefixIconColor: const Color.fromARGB(255, 53, 53, 53),
                          ),
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),

                      SizedBox(height: 20),
                      //id Number
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 210, 210, 210),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: TextFormField(
                        controller: idNumberController,
                          decoration: InputDecoration(
                            contentPadding: 
                              const EdgeInsets.symmetric(
                                vertical: 20,
                              ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: 'ID Number',
                            hintStyle: TextStyle(color: Color.fromARGB(255, 53, 53, 53)),
                            prefixIcon: Icon(Icons.confirmation_number),
                            prefixIconColor: const Color.fromARGB(255, 53, 53, 53),
                          ),
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),

                      //mk moi
                      SizedBox(height: 20),
                  
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 210, 210, 210),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: TextFormField(
                        controller: newPasswordController,
                          decoration: InputDecoration(
                            contentPadding: 
                              const EdgeInsets.symmetric(
                                vertical: 20,
                              ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            hintText: 'ID Number',
                            hintStyle: TextStyle(color: Color.fromARGB(255, 53, 53, 53)),
                            prefixIcon: Icon(Icons.lock),
                            prefixIconColor: const Color.fromARGB(255, 53, 53, 53),
                          ),
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                      ),

                      // xav nhan
                      SizedBox(height: 40),
                      Container(
                        width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 103, 117, 138),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: TextButton(
                            onPressed: forgotPassword,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              child: Text (
                                'Xác nhận',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                      ),
                    ],
                  ),
                ),
              ]
            ),
          )
        )
        ]
      ),
      
      
      /*appBar: AppBar(
        title: Text('Quên mật khẩu'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Text(
              'Nhập thông tin để đặt lại mật khẩu',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: accountIDController,
              decoration: InputDecoration(
                labelText: 'Account ID',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: idNumberController,
              decoration: InputDecoration(
                labelText: 'ID Number',
                prefixIcon: Icon(Icons.confirmation_number),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'New Password',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: forgotPassword,
              child: Text('Xác nhận'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ],
        ),
      ),*/
    );
  }
}
