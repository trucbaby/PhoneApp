// ignore_for_file: depend_on_referenced_packages
import 'package:app_tuan_08/app/data/api.dart';
import 'package:app_tuan_08/app/model/bill.dart';
import 'package:app_tuan_08/app/page/history/history_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  Future<List<BillModel>> _getBills() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await APIRepository()
        .getHistory(prefs.getString('token').toString());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BillModel>>(
      future: _getBills(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                'Lịch sử đơn hàng',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23, ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    final itemBill = snapshot.data![index];
                    return _billWidget(itemBill, context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _billWidget(BillModel bill, BuildContext context) {
    return InkWell(
      onTap: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var temp = await APIRepository()
            .getHistoryDetail(bill.id, prefs.getString('token').toString());
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HistoryDetail(bill: temp)));
      },
      
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color.fromARGB(255, 100, 100, 100), width: 1.5),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Expanded(
                flex: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Text(
                      'Người đặt hàng: ' + bill.fullName,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 54, 54, 54),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Tổng tiền : ' +
                          NumberFormat('#,##0').format(bill.total) +
                          'VNĐ',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 226, 89, 89),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text('Ngày đặt: ' + bill.dateCreated, 
                      style: TextStyle(color: Color.fromARGB(255, 130, 130, 130)),),
                    Text('Đã thanh toán', 
                      style: TextStyle(color: Color.fromARGB(255, 8, 154, 40)),),
                  ],
                ),
              ),
              /*Expanded(
                child: Image.asset(
                  'assets/images/qq.png',
                ),
                flex: 3,
              )*/
            ],
          ),
        ),
      ),
    );
  }
}
