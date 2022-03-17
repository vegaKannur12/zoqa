import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoqa/controller/controller.dart';
// import 'package:zoqa/controller/category_controller.dart';
import 'package:zoqa/screen/productCategory.dart';

class Category extends StatefulWidget {
  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  bool isSelected = false;
  // List<String> category = ["Kids", "Women", "Men"];
  int? tappedIndex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final auth =
        Provider.of<Controller>(context, listen: false).postCategory(context);
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<MainCategoryController>(context, listen: false).postCategory();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
        title: Text("ZOQA"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Consumer<Controller>(
          builder: (context, value, child) {
            if (value.categoryList == null) {
              return Center(
                child: Text("No data...."),
              );
            } else {
              return ListView.builder(
                itemCount: value.categoryList!.length,
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
                        title: Text(
                          value.categoryList![index]["mc_name"],
                          style: TextStyle(fontFamily: "fantasy", fontSize: 20),
                        ),
                        onTap: () {
                          setState(() {
                            tappedIndex = index;
                          });
                          value.postsubCategory(
                              value.categoryList![index]["mc_id"], context);
                          print("mc_id-----${value.categoryList![index]["mc_id"]}");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductCategory(catName: value.categoryList![index]["mc_name"],),
                            ),
                          );
                         
                        },
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
