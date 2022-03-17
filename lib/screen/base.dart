import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoqa/controller/controller.dart';
import 'package:zoqa/screen/bottom_navigation.dart';
// import 'package:zoqa/screen/available.dart';
// import 'package:zoqa/screen/bottom.dart';
import 'package:zoqa/screen/category.dart';
import 'package:zoqa/screen/newPage.dart';
import 'package:zoqa/screen/productCategory.dart';
import 'package:zoqa/screen/product_details.dart';
import 'package:zoqa/service/productClass.dart';

class Base extends StatefulWidget {
  String subCatName;
  Base({required this.subCatName});
  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {
  int _currentIndex = 0;
  String imgGlobal = "http://zoqa.in/women/";
  @override
  Widget build(BuildContext context) {
    // Provider.of<Controller>(context, listen: false).postProductList(context);
    int _selectedIndex = 0;
    
    
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text(widget.subCatName.toString())),
      body: Consumer<Controller>(
        builder: (context, value, child) {
          if (value.productList!.length == 0 || value.productList! == null || value.productList! .isEmpty) {
            return Container(
                  height: size.height*0.75,
                  alignment: Alignment.center,
                  child: Text(
                    "No More Products ",
                    style: TextStyle(fontSize: 20),
                  ),
                );
          } else {
            return GridView.builder(
              itemCount: value.productList!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8),
              padding: EdgeInsets.all(8),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  // onTap: () {
                  // },
                  child: GestureDetector(
                    onTap: () {
                      value.productDetails(
                      value.productList![index]["product_code"],
                      value.productList![index]["batch_code"],
                      value.productList![index]["color_id"],
                      context
                      );
                      
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetails(),
                        ),
                      );
                    },
                    child: Container(
                      width: size.width * 0.7,
                      height: size.height * 13,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 6,
                          ),
                          Container(
                            width: size.width * 0.25,
                            height: size.height * 0.14,
                            child: Image.network(
                                imgGlobal+value.productList![index]["pi_files"],
                                width: 120,
                                height: 200,
                                fit: BoxFit.fill),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                              child: Text(
                            value.productList![index]["product_code"] + "-" + value.productList![index]["cat_name"],
                            style: TextStyle(
                              fontFamily: "poppins",
                            ),
                          )),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Text(
                              "Rs:" + value.productList![index]["s_rate"],
                              style: TextStyle(
                                  fontFamily: "poppins",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green,width: 2),
                          borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      // bottomNavigationBar: Bottombar(),
      
    );
  }
}
