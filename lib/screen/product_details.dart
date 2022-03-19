import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoqa/controller/controller.dart';
import 'package:zoqa/model/product_detail_model.dart';
import 'package:zoqa/screen/color_ticker.dart';
import 'package:zoqa/service/productClass.dart';

class ProductDetails extends StatefulWidget {
  // Product product;
  // ProductDetails({required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  String color_id = "";
  String batch_code = "";
  String product_code = "";
  String imageurl = "http://zoqa.in/women/";
  final CarouselController _buttonCarouselController = CarouselController();
  bool isAutoPlayEnabled = true;
  int _current = 0;
  bool textClicked = false;
  String selected = "grey";
  String selctedSize = "";
  // int index = 0;
  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    Provider.of<Controller>(context, listen: false).clearproductdetails();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<Controller>(
            builder: (context, value, child) {
              if (value.isLoading == true) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    value.imageList == null || value.imageList!.isEmpty
                        ? Container(
                            height: size.height * 0.4,
                            width: size.width * 0.4,
                            child: Image.network(
                                "https://www.clipartmax.com/png/full/449-4492509_lefroy-ice-breakers-minor-hockey-tournament-sorry-no-image-available.png"),
                          )
                        : CarouselSlider(
                            items: value.imageList!.map((image) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    // decoration: BoxDecoration(

                                    //   image: DecorationImage(
                                    //     // fit: BoxFit.cover,
                                    //       image: NetworkImage(

                                    //           imageurl + image.piFiles!)),
                                    // ),
                                    width: MediaQuery.of(context).size.width,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 2.0),
                                    child: Image.network(
                                      imageurl + image.piFiles!,
                                      //  fit: BoxFit.cover,
                                      // height: 300,width: 600,
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                            options: CarouselOptions(
                              enlargeCenterPage: true,
                                autoPlayInterval: Duration(seconds: 2),
                                aspectRatio: 0,
                                height: size.height * 0.4,
                                autoPlay: isAutoPlayEnabled,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _current = index;
                                  });
                                }),
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: value.imageList!.map(
                        (image) {
                          int indexcaro = value.imageList!.indexOf(image);
                          print("index of image-----${indexcaro}");
                          return Container(
                            width: size.width * 0.02,
                            height: size.height * 0.02,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _current == indexcaro
                                    ? Color.fromRGBO(0, 0, 0, 0.4)
                                    : Color.fromARGB(228, 211, 203, 203)),
                          );
                        },
                      ).toList(), // this was the part the I had to add
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Text(
                      value.productInfoList != null &&
                              value.productInfoList!.length > 0
                          ? value.productInfoList![0].item_name!
                          : " ",
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      value.productInfoList != null &&
                              value.productInfoList!.length > 0
                          ? "(PCODE : ${value.productInfoList![0].product_code} ,  ICODE : ${value.productInfoList![0].batch_code})"
                          : "",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: size.width * 0.4,
                          child: Text(
                            "Color",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: size.width * 0.1,
                          child: Text(":"),
                        ),
                        Text(
                          value.productInfoList != null &&
                                  value.productInfoList!.length > 0
                              ? value.productInfoList![0].color_name!
                              : " ",
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: size.width * 0.4,
                          child: Text(
                            "Rate",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: size.width * 0.1,
                          child: Text(":"),
                        ),
                        Text(
                          value.productInfoList != null &&
                                  value.productInfoList!.length > 0
                              ? value.productInfoList![0].s_rate!
                              : "",
                          // " ${value.productInfoList![index].s_rate!}",
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: size.width * 0.4,
                          child: Text(
                            "Available Sizes",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: size.width * 0.09,
                          child: Text(" :"),
                        ),
                        getSizewidget(value.sizeList!),
                        // Row(
                        //   children: value.sizeList.map((item) {

                        //   }),
                        // )
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: size.width * 0.4,
                          child: Text(
                            "Available Colors",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: size.height * 0.1,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: value.colorList!.length,
                        itemBuilder: (context, indexlisview) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selected =
                                    value.colorList![indexlisview].colorId!;
                                batch_code =
                                    value.colorList![indexlisview].batchCode!;
                                // _current = index;
                                // _buttonCarouselController.animateToPage(_current);
                                isAutoPlayEnabled = !isAutoPlayEnabled;
                                // _buttonCarouselController.stopAutoPlay();
                                print('I HAVE SELECTED $selected');
                              });
                              Provider.of<Controller>(context, listen: false)
                                  .productDetails(
                                      value.productInfoList![0].product_code!,
                                      batch_code,
                                      selected,
                                      context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: value.colorList!.isNotEmpty &&
                                      value.colorList != null &&
                                      value.colorList![indexlisview].piFiles !=
                                          null
                                  ? Container(
                                      width: size.width * 0.2,
                                      height: size.height * 0.25,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(imageurl +
                                              value.colorList![indexlisview]
                                                  .piFiles!),
                                        ),
                                        shape: BoxShape.circle,
                                        border: selected ==
                                                value.colorList![indexlisview]
                                                    .colorId!
                                            ? Border.all(
                                                color: Colors.deepPurple,
                                                width: 4)
                                            : Border.all(color: Colors.grey),
                                      ),
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        shape: BoxShape.circle,
                                      ),
                                      width: size.width * 0.2,
                                      height: size.height * 0.25,
                                      child: Center(
                                        child: RichText(
                                          textAlign: TextAlign.end,
                                          overflow: TextOverflow.ellipsis,
                                          text:TextSpan(
                                            text:  
                                            value
                                            .colorList![indexlisview].colorName!
                                            .toString(),
                                            style: TextStyle(
                                              color: Colors.black
                                            )
                                            )
                                         ),
                                      ),
                                    ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget getSizewidget(List<AvailableSize> strings) {
    print(strings);
    return new Row(
      children: strings
          .map(
            (size) => InkWell(
              onTap: () {
                setState(() {
                  selctedSize = size.m_name!;
                });
              },
              child: new Text(
                " ${size.m_name} ",
                style: TextStyle(
                  color: selctedSize == size.m_name ? Colors.red : Colors.black,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
