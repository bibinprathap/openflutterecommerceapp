import 'package:openflutterecommerce/data/model/category.dart';
import 'package:openflutterecommerce/domain/entities/entity.dart';

class ProductCategoryEntity extends Entity<int> {
  final String title;
  final String description;
  final String image;
  final String thumb;
  final int parentId;
  final int orderNumber;
  final int count;
  final List<ProductCategory> submenu;
  ProductCategoryEntity(
       {int id,
      this.title,
      this.description,
      this.image,
      this.thumb,
      this.parentId,
      this.orderNumber,
      this.count,
      this.submenu})
      : super(id);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'thumb': thumb,
      'parentId': parentId,
      'orderNumber': orderNumber,
      'count': count,
      'submenu': submenu
    };
  }

  @override
  List<Object> get props => [
        id,
        title,
        description,
        image,
        thumb,
        parentId,
        orderNumber,
        count,
        submenu
      ];
}
