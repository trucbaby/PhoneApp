// ignore_for_file: depend_on_referenced_packages
import 'dart:io';
import 'package:app_tuan_08/app/data/api.dart';
import 'package:app_tuan_08/app/data/sqlite.dart';
import 'package:app_tuan_08/app/model/cart.dart';
import 'package:app_tuan_08/app/model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeBuilder extends StatefulWidget {
  const HomeBuilder({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeBuilder> createState() => _HomeBuilderState();
}

class _HomeBuilderState extends State<HomeBuilder> {
  final DatabaseHelper _databaseService = DatabaseHelper();

  Future<List<ProductModel>> _getProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<ProductModel> allProducts = await APIRepository().getProductAdmin(
        prefs.getString('accountID').toString(),
        prefs.getString('token').toString());

    List<ProductModel> filteredProducts =
        allProducts.where((product) => product.categoryId == 13).toList();

    return filteredProducts;
  }

  Future<void> _onSave(ProductModel pro) async {
    _databaseService.insertProduct(Cart(
        productID: pro.id,
        name: pro.name,
        des: pro.description,
        price: pro.price,
        img: pro.imageUrl,
        count: 1));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductModel>>(
      future: _getProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No products available"));
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        
                        fillColor: Color.fromRGBO(239, 239, 239, 0.886),
                        border: OutlineInputBorder(
                          
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(color: Color.fromARGB(255, 100, 100, 100), width: 1.5),
                        ),
                        hintText: "Tìm kiếm",
                        prefixIcon: Icon(Icons.search),
                        prefixIconColor: Colors.black
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              //slide show
              CarouselSlider(
                
                options: CarouselOptions(
                  height: 250,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.85,
                ),
                items: [
                  'assets/images/bg2.jpg',
                  'assets/images/bg3.jpg',
                  'assets/images/bg4.jpg',
                  'assets/images/bg5.jpg',
                ].map((imgPath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                              image: AssetImage(imgPath), fit: BoxFit.cover),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
               Divider(color: Color.fromARGB(255, 103, 117, 138), ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                child: const Text(
                  'IPhone',
                  style: TextStyle(
                    fontSize: 25,
                    color: Color.fromARGB(255, 37, 37, 37),
                  
                  ),
                ),
              ),
             
              const SizedBox(height: 20),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 1.4),
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 8,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final pro = snapshot.data![index];

                  return Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Color.fromARGB(255, 100, 100, 100), width: 1.5),
                    ),
                    surfaceTintColor: Color.fromARGB(255, 100, 100, 100),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        
                        children: [
                          (pro.imageUrl == null ||
                                  pro.imageUrl == '' ||
                                  pro.imageUrl == 'Null')
                              ? const SizedBox()
                              : Container(
                                  height: 110,
                                  width: 110,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(pro.imageUrl),
                                          fit: BoxFit.cover)),
                                  alignment: Alignment.center,
                                  child: Image.network(pro.imageUrl),
                                ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  pro.name,
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  'Giá : ' +
                                      NumberFormat('#,##0').format(pro.price) +
                                      ' VNĐ',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            child: TextButton(
                              onPressed: () async {
                                _onSave(pro);
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 40),
                                backgroundColor: const Color.fromARGB(255, 103, 117, 138),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Thêm',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20,),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
