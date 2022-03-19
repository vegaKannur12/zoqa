// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:zoqa/controller/controller.dart';
import 'package:zoqa/screen/bottom_navigation.dart';
import 'package:zoqa/screen/category.dart';
import 'package:zoqa/screen/newPage.dart';
import 'package:zoqa/screen/productCategory.dart';
import 'package:zoqa/screen/product_details.dart';
import 'package:zoqa/service/productClass.dart';
import 'package:transparent_image/transparent_image.dart';

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
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    Provider.of<Controller>(context, listen: false).clearprodlist();
  }

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text(
          widget.subCatName.toString(),
        ),
      ),
      body: Consumer<Controller>(builder: (context, value, child) {
        if (value.isLoading == true) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (value.productList!.length == 0 ||
              value.productList! == null ||
              value.productList!.isEmpty) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(
                "No more Products...",
                style: TextStyle(fontSize: 20),
              ),
            );
            // return Container(
            //   height: size.height * 0.75,
            //   alignment: Alignment.center,
            //   child: Text(
            //     "No More Products ",
            //     style: TextStyle(fontSize: 20),
            //   ),
            // );
          } else {
            return GridView.builder(
              itemCount: value.productList!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                childAspectRatio: .57,
              ),
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
                        context,
                      );
                      // Navigator.push(
                      //   context,
                      //   PageTransition(
                      //       type: PageTransitionType.rightToLeft,
                      //       child: ProductDetails(),
                      //       inheritTheme: true,
                      //       ctx: context),
                      // );
                      // Future.delayed(Duration(milliseconds: 190), () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetails(),
                        ),
                      );
                      // });
                    },
                    child: Card(
                      elevation: 4,
                      margin: EdgeInsets.fromLTRB(0.0, 4.0, 4.0, 4.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      shadowColor: Colors.white,
                      color: Colors.white70,
                      child: Stack(
                        children: [
                          // Center(
                          //   child: FadeInImage.memoryNetwork(
                          //     image: imgGlobal +
                          //         value.productList![index]["pi_files"],
                          //     placeholder: kTransparentImage,
                          //     imageErrorBuilder: (context, error, stacktrace) {
                          //       return FadeInImage.memoryNetwork(
                          //         fit: BoxFit.fitHeight,
                          //         placeholder: kTransparentImage,
                          //         image: imgGlobal +
                          //             value.productList![index]["pi_files"],
                          //         imageErrorBuilder:
                          //             (context, error, stacktrace) {
                          //           return Center(
                          //               child: Text('Image Not Available'));
                          //         },
                          //       );
                          //     },
                          //     //  (context, url) =>
                          //     //     new CircularProgressIndicator(),
                          //     // errorWidget: (context, url, error) =>
                          //     //     new Icon(Icons.error),
                          //   ),
                          // ),
                          // Container(
                          //   child: RichText(
                          //     textAlign: TextAlign.end,
                          //     overflow: TextOverflow.ellipsis,
                          //     text: TextSpan(
                          //       style: TextStyle(color: Colors.deepPurple),
                          //       text: value.productList![index]["product_code"],
                          //     ),
                          //   ),
                          // ),
                          Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        imgGlobal +
                                            value.productList![index]
                                                ["pi_files"],
                                      ),
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: RichText(
                                    textAlign: TextAlign.end,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      style: TextStyle(color: Colors.black),
                                      text: value.productList![index]
                                          ["product_code"],
                                    ),
                                  ),
                                ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Container(
                                width: double.infinity,
                                color: Colors.white,
                                child: Text(
                                  value.productList![index]["cat_name"],
                                  style: TextStyle(
                                    // fontFamily: "poppins",
                                    color: Colors.deepPurple,
                                  ),
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                color: Colors.white,
                                child: Text(
                                  "Rs:" + value.productList![index]["s_rate"],
                                  style: TextStyle(
                                      // fontFamily: "poppins",
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                      fontSize: 15),
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        }
      }),
      // bottomNavigationBar: Bottombar(),
    );
  }
}
