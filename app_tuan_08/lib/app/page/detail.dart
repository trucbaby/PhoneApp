import 'dart:convert';

import 'package:flutter/material.dart';
import '../model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  User user = User.userEmpty();

  getDataUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String strUser = pref.getString('user')!;

    user = User.fromJson(jsonDecode(strUser));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getDataUser();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle mystyle = const TextStyle(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(239, 239, 239, 0.886),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/avatar.png'), // Thay đổi bằng link avatar của bạn
            ),
            SizedBox(height: 16),
            Text(
              'Thông tin cá nhân',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
           
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
             
                SizedBox(width: 8),
                Text('${user.fullName}', style: TextStyle(fontSize: 18),),
              ],
            ),
            /*SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.phone, color: Colors.blue),
                SizedBox(width: 8),
                Text('+1 234 567 890'),
              ],
            ),*/
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  const Divider(),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Tài khoản'),
                    subtitle: Text('${user.idNumber}'),
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('Liên lạc'),
                    subtitle: Text('${user.phoneNumber}'),
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(Icons.date_range),
                    title: Text('Ngày sinh'),
                    subtitle: Text('${user.birthDay}'),
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(Icons.school),
                    title: Text('Giới tính'),
                    subtitle: Text('${user.gender}'),
                  ),
                  const Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
      /*body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // Cover photo
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/bia.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Avatar
                Positioned(
                  bottom: -40,
                  left: 25,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/avatar.png'),
                        radius: 43,
                        backgroundColor: Colors.white,
                      ),
                      Positioned(
                        left: 95,
                        bottom: 10,
                        child: Text('${user.fullName}', style: mystyle),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50), // Space for the avatar to fit
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Thông tin cá nhân",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                 

                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text("Tài khoản ", style: mystyle),
                      const SizedBox(width: 65),
                      Text(
                        "${user.idNumber}",
                        style: const TextStyle(
                       color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Text("Liên lạc ", style: mystyle),
                      const SizedBox(width: 82),
                      Text(
                        "${user.phoneNumber}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Text("Giới tính ", style: mystyle),
                      const SizedBox(width: 77),
                      Text(
                        "${user.gender}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Text("Ngày sinh ", style: mystyle),
                      const SizedBox(width: 63),
                      Text(
                        "${user.birthDay}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),*/
    );
  }
}
