import 'package:flutter/material.dart';

class CustomCart extends StatelessWidget {
  final String value;
  CustomCart({this.value});
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
            BoxDecoration(color: Colors.transparent, shape: BoxShape.circle),
        height: 40,
        width: 40,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(Icons.shopping_cart),
            Align(
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                      radius: 8.0,
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      child: Text(
                        value,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12.0),
                      ),
                    ),
                  )
          ],
        ));
  }
}
