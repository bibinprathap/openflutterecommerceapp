import 'package:flutter/material.dart';
import 'package:openflutterecommerce/data/model/category.dart';
import 'package:openflutterecommerce/domain/entities/product/product_category_entity.dart';
import 'package:openflutterecommerce/presentation/widgets/independent/scaffold.dart';

class ProductCategoryModel extends ProductCategoryEntity {
  ProductCategoryModel(
      {@required int id,
      @required title,
      @required description,
      @required image,
      @required thumb,
      parentId,
      orderNumber,
      count,
      submenu})
      : super(
            id: id,
            title: title,
            description: description,
            image: image,
            thumb: thumb,
            parentId: parentId,
            orderNumber: orderNumber,
            count: count,
            submenu: submenu);

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    return ProductCategoryModel(
      id: (json['id'] as num).toInt(),
      title: json['name'],
      description: json['description'],
      image: json['image'] != null ? json['image']['src'] : '',
      thumb: json['image'] != null ? json['image']['src'] : '',
      parentId: (json['parent'] as num).toInt(),
      orderNumber: (json['menu_order'] as num).toInt(),
      count: (json['count'] as num).toInt(),
    );
  }
  factory ProductCategoryModel.fromCategoryDef(CategoryDef entity, num l) {

    List<ProductCategory> submenu = [];
    if(entity.children !=null)
    {
      int k = 10000 * l;



      for (int i = 0; i < entity.children.length; i++) {
        k++;
        ProductCategoryModel p = ProductCategoryModel.fromCategoryDef(entity.children[i], k);
        if(p!=null)
        {
          ProductCategory pc =   ProductCategory.fromCategoryDef(p);
          if(pc!=null)
          {
            submenu.add(pc);
          }

        }


      }

    }
    ProductCategoryModel p = ProductCategoryModel(
        id: l,
        title: entity.name,
        description: entity.slug,
        image: entity.image,
        thumb: entity.image,
        parentId: 0,
        orderNumber: l,
        count: entity.items,
        submenu:submenu
       );


    return p;


  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': title,
      'parent': parentId,
      'description': description,
      'image': {
        'src': image,
      },
      'menu_order': orderNumber,
      'count': count,
      'submenu': submenu
    };
  }
}
