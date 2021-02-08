import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:openflutterecommerce/config/server_addresses.dart';
import 'package:openflutterecommerce/data/error/exceptions.dart';
import 'package:openflutterecommerce/domain/usecases/products/get_product_by_id_use_case.dart';
import 'package:openflutterecommerce/domain/usecases/products/products_by_filter_params.dart';

abstract class WoocommercWrapperAbstract {
  Future<List<dynamic>> getCategoryList({int parentId = 0});
  Future<List<dynamic>> getProductList(ProductsByFilterParams params);
  Future<dynamic> getProductDetails(ProductDetailsParams params);
  Future<List<dynamic>> getPromoList({int userId = 0});
}

class WoocommerceWrapper implements WoocommercWrapperAbstract {
  final http.Client client;

  WoocommerceWrapper({@required this.client});

  @override
  Future<List<dynamic>> getProductList(ProductsByFilterParams params) {
    //TODO: make remote request using all paramaters
    return _getApiRequest(
        ServerAddresses.royalServerAddress + params.slugorurl);
  }

  @override
  Future<dynamic> getProductDetails(ProductDetailsParams params) {
    //TODO: make remote request using all paramaters
    return _getApiRequest(ServerAddresses.royalServerAddress +
        "/productdetails?slug=" +
        params.slug);
  }

  @override
  Future<List<dynamic>> getCategoryList({int parentId = 0}) {
    return _getApiRequest(ServerAddresses.productCategories);
  }

  @override
  Future<List> getPromoList({int userId = 0}) {
    return _getApiRequest(ServerAddresses.promos);
  }

  Future<List<dynamic>> _getApiRequest(String url) async {
    final response = await client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      try {
        if (response.body.indexOf("productsList") > -1) {
          Map<String, dynamic> map = json.decode(response.body);
          List<dynamic> data = map['productsList']['products'];

          return data;
        }
        else if (response.body.indexOf("product") ==2) {
          Map<String, dynamic> map = json.decode(response.body);
          Map<String, dynamic>  data = map['product'];

          return [data];
        }
        else {
          return json.decode(response.body);
        }
      } catch (e) {
        print("Error: $e");
      }
    } else {
      throw HttpRequestException();
    }
  }
}
