import 'package:equatable/equatable.dart';
import 'package:openflutterecommerce/data/error/exceptions.dart';
import 'package:openflutterecommerce/domain/entities/entity.dart';
import 'package:openflutterecommerce/domain/entities/product/product_category_entity.dart';

import 'commerce_image.dart';

class ProductCategory extends Equatable {
  final int id;
  final int parentId;
  final int count;
  final String name;
  final String description;
  final CommerceImage image;
  final bool isCategoryContainer;
  final List<ProductCategory> submenu;

  ProductCategory(this.id,
      {int parentId,
      this.name,
      this.description,
      this.image,
        this.count,
      bool isCategoryContainer,
      List<ProductCategory> submenu})
      : parentId = parentId ?? 0,
        isCategoryContainer = isCategoryContainer ?? false,
        submenu = submenu;

  @override
  List<Object> get props => [id, parentId, name, image, submenu];

  @override
  bool get stringify => true;

  @override
  factory ProductCategory.fromCategoryDef(Entity entity) {
    if (entity is ProductCategoryEntity) {
      return ProductCategory(entity.id,
          parentId: entity.parentId,
          name: entity.title,
          description: entity.description,
          submenu: entity.submenu,
          count:entity.count,
          isCategoryContainer: entity.submenu.isNotEmpty,

          image: CommerceImage(
              0, //TODO: remove id from CommerceImage
              entity.image,
              '',isLocal: true));
    } else {
      throw EntityModelMapperException(
          message: 'Entity should be of type ProductCategoryEntity');
    }
  }
}
