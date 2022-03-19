import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zoqa/internetConnection.dart';
import 'package:zoqa/model/product_detail_model.dart';
// import 'package:zoqa/service/internetConnection.dart';

// import '../model/product_detail.dart';

class Controller extends ChangeNotifier {
  var cnprod = 0;
  String urlgolabl = "http://zoqa.in/women/api";
  List<Map<String, dynamic>>? categoryList = [];
  List<Map<String, dynamic>>? newcategoryList = [];
  List<Map<String, dynamic>>? subcategoryList = [];
  List<Map<String, dynamic>>? productList = [];
  bool? isLoading;
  List<AvailableColors>? colorList = [];
  List<AvailableSize>? sizeList = [];
  List<ProductInfo>? productInfoList = [];
  List<Images>? imageList = [];

  /////////////////////////////////////////////////////////
  postCategory(BuildContext context) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          Uri url = Uri.parse("$urlgolabl/main_category_list.php");
          print(url);

          http.Response response = await http.post(
            url,
            // body: body,
          );

          var map = jsonDecode(response.body);
          for (var item in map) {
            categoryList!.add(item);
          }
          notifyListeners();
        } catch (e) {
          print(e);
          return null;
        }
      }
    });
  }

  clearCategory() {
    categoryList!.clear();
    notifyListeners();
  }

  ////////////////////////////////////////
  Future productDetails(String product_code, String batch_code,
      String color_code, BuildContext context) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          Uri url = Uri.parse("$urlgolabl/product_detail.php");
          print(
              "body------------------${batch_code},${product_code},${color_code}");
          Map<String, dynamic> body = {
            "product_code": product_code,
            "batch_code": batch_code,
            "color_id": color_code,
          };
          print("url-----------------${url}");
          isLoading = true;
          notifyListeners();
          http.Response response = await http.post(
            url,
            body: body,
            // headers: headers,
          );
          isLoading = false;
          notifyListeners();
          var map = jsonDecode(response.body);

          ProductDetailsModel productDetails =
              ProductDetailsModel.fromJson(map);
          imageList = productDetails.images;
          productInfoList = productDetails.productInfo;
          sizeList = productDetails.availableSize;
          colorList = productDetails.availableColors;
          notifyListeners();
        } catch (e) {
          print(e);
          return null;
        }
      }
    });
  }

  clearproductdetails() {
    productInfoList!.clear();
    // notifyListeners();
  }

  ////////////////////////////////////////

  Future postsubCategory(String mc_id, BuildContext context) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        Uri url = Uri.parse("$urlgolabl/category_list.php");
        var json_body = {'mc_id': mc_id};
        isLoading = true;
        notifyListeners();
        http.Response response = await http.post(
          url,
          // headers: {'content_type': 'application/json'},
          body: json_body,
        );
         isLoading = false;
          notifyListeners();
          var map = jsonDecode(response.body);

          subcategoryList!.clear();
          for (var item in map) {
            subcategoryList!.add(item);
          }
          print(subcategoryList!.length);
          notifyListeners();
       
      }
    });
  }

  clearsubCategory() {
    subcategoryList!.clear();
    //notifyListeners();
  }

  ////////////////////////////////////////
  Future postProductList(String cat_id, BuildContext context) async {
    NetConnection.networkConnection(context).then((value) async {
      if (value == true) {
        try {
          Uri url = Uri.parse("$urlgolabl/products_list.php");
          var json_body = {'cat_id': cat_id};
          isLoading = true;
          notifyListeners();
          http.Response response = await http.post(
            url,
            // headers: {'Content-type': 'application/json'},
            body: json_body,
          );
           isLoading = false;
          //notifyListeners();
          var map = jsonDecode(response.body);
          print("from post data ${map}");

          productList!.clear();
          cnprod = 0;
          for (var item in map) {
            productList!.add(item);
            cnprod++;
          }
          print(productList!.length);
          notifyListeners();
        } catch (e) {
          print(e);
        }
      }
    });
  }

  clearprodlist() {
    productList!.clear();
    // notifyListeners();
  }
}
