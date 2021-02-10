import 'package:flutter/material.dart';
import 'package:openflutterecommerce/data/model/product_attribute.dart';
import 'package:openflutterecommerce/domain/entities/hashtag/hashtag_entity.dart';
import 'package:openflutterecommerce/domain/entities/product/product_category_entity.dart';
import 'package:openflutterecommerce/domain/entities/product/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel(
      {@required int id,
      @required title,
        @required slug,
      @required subTitle,
      @required description,
      @required images,
      @required double price,
      @required salePrice,
      @required thumb,
      @required selectableAttributes,
      rating,
        relatedurl,
      List<ProductCategoryEntity> categories,
      List<HashTagEntity> hashTags,
      orderNumber,
      count})
      : super(
            id: id,
            title: title,
           slug:slug,
            subTitle: subTitle,
            price: price,
          //  discountPercent: salePrice != 0
           //     ? ((price - salePrice) / price * 100).round().toDouble()
          //      : 0.0,
            description: description,
            selectableAttributes: selectableAttributes,
            images: images,
            thumb: thumb,
            rating: rating,
              relatedurl:relatedurl,
            categories: categories,
            hashTags: hashTags);

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    List<String> images = [];
    if (json['images'] != null) {
      (json['images'] as List).forEach((f) => images.add(f['src']));
    }
    return ProductModel(
      id: (json['id'] as num).toInt(),
      title: json['name'],
      slug:json['slug'],
      subTitle: json['categories'] != null ? json['categories'][0]['name'] : '',
      description: stripTags(json['description']),
        relatedurl:json['brand'] != null ? json['brand']['url'] : null,
      rating: json['average_rating'] != null
          ? double.parse(json['average_rating'])
          : 0,
      images: images,
      price: json['regular_price'] != null && json['regular_price'] != ''
          ? double.parse(json['regular_price'])
          : 0,
      salePrice: json['sale_price'] != null && json['sale_price'] != ''
          ? double.parse(json['sale_price'])
          : 0,
      thumb: json['images'] != null ? json['images'][0]['src'] : '',
      //TODO: add all categories related to product
      categories: _getCategoriesFromJson(json),
      orderNumber: (json['menu_order'] as num).toInt(),
      selectableAttributes: _getSelectableAttributesFromJson(json),
      hashTags: _getHashTagsFromJson(json),
    );
  }
  factory ProductModel.royalfromJson(Map<String, dynamic> json, int id) {
    List<String> images = [];
    if (json['images'] != null) {
      (json['images'] as List).forEach((f) => images.add(f));
    }
    try {
      return ProductModel(
        id: id,
        title: json['name'],
        slug: json['slug'],
        subTitle: json['excerpt'] != null ? json['excerpt'] : '',
        description: stripTags(json['description']),
        relatedurl:json['brand'] != null ? json['brand']['url'] : null,
        rating: json['rating'] != null ? json['rating'].toDouble() : 0,
        images: images,
        price: json['price'] != null && json['price'] != ''
            ? json['price'].toDouble()
            : 0,
        salePrice: 0.0,
        // salePrice: json['price'] != null && json['price'] != ''
        //     ? json['price'].toDouble()
        //     : 0,
        thumb: json['images'] != null ? json['images'][0] : '',
        categories:null,
        //TODO: add all categories related to product
       // categories: _getCategoriesFromJson(json),
        orderNumber: 1,
        selectableAttributes:null,
       // selectableAttributes: _getSelectableAttributesFromJson(json),
       // hashTags: _getHashTagsFromJson(json),
        hashTags:null
      );
    } catch (e) {
      print("Error: $e");
    }
  }

  static List<HashTagEntity> _getHashTagsFromJson(Map<String, dynamic> json) {
    List<HashTagEntity> tags = [];
    if (json['tags'] != null) {
      for (var hashTag in json['tags']) {
        tags.add(HashTagEntity(
            id: hashTag['id'] ?? 0, title: hashTag['name'] ?? ''));
      }
    }
    return tags;
  }

  static List<ProductCategoryEntity> _getCategoriesFromJson(
      Map<String, dynamic> json) {
    List<ProductCategoryEntity> categories = [];
    if (json['categories'] != null) {
      for (var category in json['categories']) {
        categories.add(ProductCategoryEntity(
            id: category['id'] ?? 0, title: category['name'] ?? ''));
      }
    }
    return categories;
  }

  static List<ProductAttribute> _getSelectableAttributesFromJson(
      Map<String, dynamic> json) {
    List<ProductAttribute> selectableAttributes = [];
    if (json['attributes'] != null) {
      for (var attribute in json['attributes']) {
        if(attribute["values"]!=null)
          {
            for (var n in json['values']['value']) {
              if(n['key']=="name")
              selectableAttributes.add(ProductAttribute(
                  id: n['key'] ?? 0,
                  name: n['key'] ?? '',
                  options: List<String>.from([n['value']])));
            }
          }

      }
    }
    return selectableAttributes;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': title,
      'description': description,
      'image': {
        'src': images.isNotEmpty ? images[0] : '',
      }
    };
  }

  static String stripTags(String htmlText) {
    RegExp exp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }
}
