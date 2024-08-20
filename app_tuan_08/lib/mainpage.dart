import 'dart:convert';
import 'package:app_tuan_08/app/model/user.dart';
import 'package:app_tuan_08/app/page/cart/cart_screen.dart';
import 'package:app_tuan_08/app/page/category/category_list.dart';
import 'package:app_tuan_08/app/page/detail.dart';
import 'package:app_tuan_08/app/page/history/history_screen.dart';
import 'package:app_tuan_08/app/page/home/home_screen.dart';
import 'package:app_tuan_08/app/page/product/product_list.dart';
import 'package:app_tuan_08/app/route/page3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:app_tuan_08/app/page/auth/widgetbg.dart';
import 'app/page/defaultwidget.dart';
import 'app/data/sharepre.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  User user = User.userEmpty();
  int _selectedIndex = 0;
  bool _isDarkMode = false;

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  _loadWidget(int index) {
    var nameWidgets = "Home";
    switch (index) {
      case 0:
        {
          return HomeBuilder();
        }
      case 1:
        {
          return HistoryScreen();
        }
      case 2:
        {
          return CartScreen();
        }
      case 3:
        {
          return const Detail();
        }
      default:
        nameWidgets = "None";
        break;
    }
    return DefaultWidget(title: nameWidgets);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromRGBO(239, 239, 239, 0.886),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(239, 239, 239, 0.886),
          foregroundColor: const Color.fromARGB(255, 103, 117, 138),
          /*title: const Text(
            'Mobell',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),*/
          centerTitle: true,
          /*actions: [
            IconButton(
              icon: Icon(
                _isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_sharp,
                color: _isDarkMode ? Colors.yellow : Colors.red,
              ),
              onPressed: _toggleDarkMode,
            ),
          ],*/
          
        ),
        drawer: Drawer(
          backgroundColor: Color.fromRGBO(239, 239, 239, 0.886),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      user.imageURL!.length < 5
                          ? const SizedBox()
                          : CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                user.imageURL!,
                              )),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        user.fullName!,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                iconColor: Colors.black,
                title: const Text('Trang chủ', style: TextStyle(color: Colors.black),),
                onTap: () {
                  Navigator.pop(context);
                  _selectedIndex = 0;
                  setState(() {});
                },
              ),
              ListTile(
                leading: const Icon(Icons.history),
                iconColor: Colors.black,
                title: const Text('Lịch sử', style: TextStyle(color: Colors.black),),
                onTap: () {
                  Navigator.pop(context);
                  _selectedIndex = 1;
                  setState(() {});
                },
              ),
              ListTile(
                leading: const Icon(Icons.shop),
                iconColor: Colors.black,
                title: const Text('Giỏ hàng', style: TextStyle(color: Colors.black),),
                onTap: () {
                  Navigator.pop(context);
                  _selectedIndex = 2;
                  setState(() {});
                },
              ),
              ListTile(
                leading: const Icon(Icons.category),
                iconColor: Colors.black,
                title: const Text('Danh mục', style: TextStyle(color: Colors.black),),
                onTap: () {
                  Navigator.pop(context);
                  _selectedIndex = 0;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CategoryList()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.production_quantity_limits),
                iconColor: Colors.black,
                title: const Text('Sản phẩm', style: TextStyle(color: Colors.black),),
                onTap: () {
                  Navigator.pop(context);
                  _selectedIndex = 0;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProductList()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.pages),
                iconColor: Colors.black,
                title: const Text('Giới thiệu', style: TextStyle(color: Colors.black),),
                onTap: () {
                  Navigator.pop(context);
                  _selectedIndex = 0;
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Page3()));
                },
              ),
              const Divider(
                color: Colors.black,
              ),
              user.accountId == ''
                  ? const SizedBox()
                  : ListTile(
                      leading: const Icon(Icons.exit_to_app),
                      iconColor: Colors.black,
                      title: const Text('Đăng xuất', style: TextStyle(color: Colors.black),),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Đăng xuất'),
                              content:
                                  Text('Bạn có chắc muốn đăng xuất không?'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Không'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text('Có'),
                                  onPressed: () {
                                    logOut(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
       
          items: const <BottomNavigationBarItem>[
            
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Trang chủ', 
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_added),
              label: 'Lịch sử',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: 'Giỏ hàng',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Thông tin',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color.fromARGB(255, 92, 92, 92),
          unselectedItemColor: Color.fromARGB(255, 103, 117, 138),
          onTap: _onItemTapped,
        ),
        body: _loadWidget(_selectedIndex),
      ),
    );
  }
}
