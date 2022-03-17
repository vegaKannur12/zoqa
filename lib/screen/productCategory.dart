import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoqa/controller/controller.dart';
import 'package:zoqa/controller/subCategory_controller.dart';
import 'package:zoqa/model/subCategory_model.dart';
import 'package:zoqa/screen/base.dart';

class ProductCategory extends StatefulWidget {
  String catName;
  ProductCategory({required this.catName});
  @override
  State<ProductCategory> createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> {
  int? tappedIndex;
  // @override
  // void initState() {
  //   super.initState();
  // }
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<String> category = [];
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
          title: Text(widget.catName.toString()),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Consumer<Controller>(
            builder: (context, value, child) {
              if (value.subcategoryList!.length == 0 ||
                  value.subcategoryList! == null ||
                  value.subcategoryList!.isEmpty) {
                return Container(
                  height: size.height*0.75,
                  alignment: Alignment.center,
                  child: Text(
                    "No Products Exist in ${widget.catName}",
                    style: TextStyle(fontSize: 20),
                  ),
                );
              } else {
                print("length;;;;;;;;;;;;;;;;${value.subcategoryList!.length}");
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: value.subcategoryList!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: tappedIndex == index
                              ? Colors.green
                              : Colors.grey[300],
                        ),
                        child: ListTile(
                          onTap: () {
                            value.postProductList(
                                value.subcategoryList![index]["cat_id"],
                                context);
                            setState(() {
                              tappedIndex = index;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Base(
                                        subCatName:
                                            value.subcategoryList![index]
                                                ["cat_name"],
                                      )),
                            );
                          },
                          title: Text(
                            value.subcategoryList![index]["cat_name"],
                            style:
                                TextStyle(fontFamily: "poppins", fontSize: 20),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ));
  }
}
