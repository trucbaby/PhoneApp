import 'package:app_tuan_08/app/model/bill.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class HistoryDetail extends StatelessWidget {
  final List<BillDetailModel> bill;

  const HistoryDetail({super.key, required this.bill});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(239, 239, 239, 0.886),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(239, 239, 239, 0.886),
      ),
      body: ListView.builder(
        itemCount: bill.length,
        itemBuilder: (context, index) {
          var data = bill[index];
          return Padding(
           
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              
              children: [Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Color.fromARGB(255, 100, 100, 100), width: 1.5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  data.imageUrl != null
                  ? Image.network(data.imageUrl, height: 100,width: 100, fit: BoxFit.cover,)
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
                          data.productName,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'Giá :' +
                              NumberFormat('#,##0').format(data.price * data.count) +
                              ' VNĐ',
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.normal,
                            color: Color.fromARGB(255, 226, 89, 89),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ),
          
              ],
            )
          );
          /*Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Color.fromARGB(255, 0, 0, 0), width: 2.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  data.imageUrl != null
                  ? Image.network(data.imageUrl, height: 100,width: 100, fit: BoxFit.cover,)
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
                          data.productName,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'Giá :' +
                              NumberFormat('#,##0').format(data.price * data.count) +
                              ' VNĐ',
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.normal,
                            color: Color.fromARGB(255, 226, 89, 89),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          );*/
        }
      )
    );
  }
}




    /*Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: bill.length,
        itemBuilder: (context, index) {
          var data = bill[index];
          return Column(
            children: [
              Text(data.productName, 
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),),

              SizedBox(height: 20),
              Image.network(data.imageUrl, height: 300,width: 300,),
              SizedBox(height: 20),

              Text('Giá: '+  data.price.toString() , 
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black
                ),),
              SizedBox(height: 20),
              Text('Tổng tiền: ' + data.total.toString(),
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),),
                Divider(color: const Color.fromARGB(255, 108, 108, 108),),
                SizedBox(height: 20,)
            ],
          );
          
        },
      ),
    );*/
  