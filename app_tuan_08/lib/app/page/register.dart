import 'package:flutter/material.dart';
import 'package:app_tuan_08/app/data/api.dart';
import 'package:app_tuan_08/app/model/register.dart';
import 'package:app_tuan_08/app/page/auth/login.dart';
import 'package:app_tuan_08/app/page/auth/widgetbg.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _birthDayController = TextEditingController();
  final TextEditingController _numberIDController = TextEditingController();
  final TextEditingController _schoolKeyController = TextEditingController();
  final TextEditingController _schoolYearController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  int _gender = 0; // 1: Male, 2: Female, 0: Other

  bool _obscurePassword = true;

  Future<void> _register() async {
    String response = await APIRepository().register(Signup(
      accountID: _accountController.text,
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
      fullName: _fullNameController.text,
      phoneNumber: _phoneNumberController.text,
      birthDay: _birthDayController.text,
      numberID: _numberIDController.text,
      schoolKey: _schoolKeyController.text,
      schoolYear: _schoolYearController.text,
      gender: getGender(),
      imageUrl: _imageUrlController.text,
    ));

    if (response == "ok") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else {
      // Handle error or show message
      print(response);
    }
  }

  String getGender() {
    if (_gender == 1) {
      return "Male";
    } else if (_gender == 2) {
      return "Female";
    } else {
      return "Other";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Đăng ký'),
          backgroundColor: Color.fromRGBO(239, 239, 239, 0.886),
        ),
        body: Stack(
          children: [
            BackgroundImage(),
            Scaffold(
              backgroundColor: Color.fromRGBO(239, 239, 239, 0.886),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20.0),
                      const Text(
                        'Nhập thông tin đăng ký',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20.0),
                      _buildTextField(
                          _accountController, 'Account', Icons.person),
                      _buildTextField(
                          _passwordController, 'Password', Icons.lock,
                          obscureText: _obscurePassword,
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
                          )),
                      _buildTextField(_confirmPasswordController,
                          'Confirm Password', Icons.lock,
                          obscureText: _obscurePassword,
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
                          )),
                      _buildTextField(_fullNameController, 'Full Name',
                          Icons.person_outline),
                      _buildTextField(_phoneNumberController, 'Phone Number',
                          Icons.phone_android),
                      _buildTextField(
                          _birthDayController, 'Birth Day', Icons.date_range),
                      _buildTextField(_numberIDController, 'Number ID',
                          Icons.confirmation_number),
                      _buildTextField(
                          _schoolKeyController, 'School Key', Icons.vpn_key),
                      _buildTextField(_schoolYearController, 'School Year',
                          Icons.calendar_today),
                      const SizedBox(height: 10.0),
                      const Text("What is your Gender?"),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              title: const Text("Male"),
                              leading: Transform.translate(
                                  offset: const Offset(16, 0),
                                  child: Radio(
                                    value: 1,
                                    groupValue: _gender,
                                    onChanged: (value) {
                                      setState(() {
                                        _gender = value!;
                                      });
                                    },
                                  )),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                                contentPadding: const EdgeInsets.all(0),
                                title: const Text("Female"),
                                leading: Transform.translate(
                                  offset: const Offset(16, 0),
                                  child: Radio(
                                    value: 2,
                                    groupValue: _gender,
                                    onChanged: (value) {
                                      setState(() {
                                        _gender = value!;
                                      });
                                    },
                                  ),
                                )),
                          ),
                          Expanded(
                              child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: const Text("Other"),
                            leading: Transform.translate(
                                offset: const Offset(16, 0),
                                child: Radio(
                                  value: 3,
                                  groupValue: _gender,
                                  onChanged: (value) {
                                    setState(() {
                                      _gender = value!;
                                    });
                                  },
                                )),
                          )),
                        ],
                      ),
                      _buildTextField(
                          _imageUrlController, 'Image URL', Icons.image),
                      const SizedBox(height: 25),
                      Container(
                        width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 103, 117, 138),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: TextButton(
                            onPressed: _register,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              child: Text (
                                'Đăng ký',
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                      ),
                       const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {bool obscureText = false, Widget? suffixIcon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  Widget _buildRadioTile(String title, int value) {
    return Expanded(
      child: ListTile(
        title: Text(title),
        leading: Radio(
          value: value,
          groupValue: _gender,
          onChanged: (int? value) {
            setState(() {
              _gender = value!;
            });
          },
        ),
      ),
    );
  }
}
