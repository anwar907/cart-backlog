import 'package:flutter/material.dart';
import 'package:todos/data/models/todo_models.dart';
import 'package:todos/data/repository/repository.dart';
import 'package:todos/data/storage/db_helper.dart';
import 'package:todos/presentation/ui/widgets/counter_value.dart';
import 'package:todos/presentation/ui/widgets/custom_cart.dart';

import 'checkout_page.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  int total;
  Future _future;

  @override
  void initState() {
    preferance();
    _future = getListDataTodo();
    super.initState();
  }

  preferance() async {
    var data = DatabaseHelper().getData();

    data.then((result) {
      setState(() {
        total = result.qty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Product'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0, top: 5.0),
            child: CustomCart(
              value: total == null ? '0' : '$total',
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<TodoModels>>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(child: CircularProgressIndicator());
            } else {
              return RefreshIndicator(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            title: Text(snapshot.data[index].title),
                            trailing: GestureDetector(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTileItem(
                                  product: snapshot.data[index],
                                )
                              ],
                            )));
                      }),
                  onRefresh: () {
                    return preferance();
                  });
            }
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ChechoutPage()));
          },
          child: Icon(Icons.exit_to_app)),
    );
  }
}
