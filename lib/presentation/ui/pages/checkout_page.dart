import 'package:flutter/material.dart';
import 'package:todos/data/storage/db_helper.dart';
import 'package:todos/presentation/ui/pages/product_list_page.dart';

class ChechoutPage extends StatefulWidget {
  @override
  _ChechoutPageState createState() => _ChechoutPageState();
}

class _ChechoutPageState extends State<ChechoutPage> {
  String title;
  int total;
  int id;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() {
    var data = DatabaseHelper().getData();

    data.then((value) {
      setState(() {
        id = value.id;
        title = value.title;
        total = value.qty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Checkout'),
        ),
        body: Container(
            child: Column(
          children: [
            ListTile(
              title: Text(title == null ? "Tidak ada Data" : title),
              trailing: Text(total == null ? '0' : '$total'),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    DatabaseHelper().deleteData(id);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ProductListPage()));
                  });
                  
                },
                child: Text("Beli"))
          ],
        )));
  }
}
