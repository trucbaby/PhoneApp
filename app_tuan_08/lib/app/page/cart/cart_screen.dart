import 'package:app_tuan_08/app/data/api.dart';
import 'package:app_tuan_08/app/data/sqlite.dart';
import 'package:app_tuan_08/app/model/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  int calculateTotalPrice(List<Cart> products) {
    int totalPrice = 0;
    for (var product in products) {
      if (product != null && product.price != null && product.count != null) {
        int price = product.price.toInt();
        int count = product.count.toInt();

        // Calculate total price
        totalPrice += price * count;
      }
    }
    return totalPrice;
  }

  Future<List<Cart>> _getProducts() async {
    return await _databaseHelper.products();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 11,
          child: FutureBuilder<List<Cart>>(
            future: _getProducts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final itemProduct = snapshot.data![index];
                    return _buildProduct(itemProduct, context);
                  },
                ),
              );
            },
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Tổng hóa đơn : ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              FutureBuilder<List<Cart>>(
                future: _getProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  int totalPrice = calculateTotalPrice(snapshot.data!);
                  return Text(
                    NumberFormat('#,##0').format(totalPrice) + ' VNĐ',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          
          child: Container(
            width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 103, 117, 138),
                borderRadius: BorderRadius.circular(13),
              ),
              child: TextButton(
                
                onPressed: () async {
                  SharedPreferences pref = await SharedPreferences.getInstance();
                  List<Cart> temp = await _databaseHelper.products();
                  await APIRepository()
                      .addBill(temp, pref.getString('token').toString());
                  _databaseHelper.clear();
                },
                child: Text (
                    'Thanh toán',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.normal,),
                  ),
              ),
            )
          ),
        
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildProduct(Cart pro, BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Color.fromARGB(255, 100, 100, 100), width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            pro.img != null
                ? Image.network(
                    pro.img!,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 100,
                    width: 100,
                    color: Colors.grey,
                    child: const Icon(Icons.image, color: Colors.white),
                  ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pro.name,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Giá :' +
                        NumberFormat('#,##0').format(pro.price * pro.count) +
                        ' VNĐ',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 226, 89, 89),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(width: 8),
                                Text(
                                  '${pro.count}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(width: 15),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      DatabaseHelper().add(pro);
                                    });
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              top: -8,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    DatabaseHelper().minus(pro);
                                  });
                                },
                                icon: Icon(
                                  Icons.minimize_outlined,
                                  color: Color.fromARGB(255, 0, 0, 0)
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              DatabaseHelper().deleteProduct(pro.productID);
                            });
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Color.fromARGB(255, 226, 89, 89)
                          ),
                        ),
                      )
                      
                    ],
                    
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
