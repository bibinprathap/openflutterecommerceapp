import 'package:openflutterecommerce/data/repositories/abstract/category_repository.dart';
import 'package:openflutterecommerce/data/model/category.dart';
import 'package:openflutterecommerce/data/woocommerce/models/product_category_model.dart';
import 'package:openflutterecommerce/presentation/widgets/widgets.dart';

class LocalCategoryRepository extends CategoryRepository {
  @override
  Future<List<ProductCategory>> getCategories(
      {int parentCategoryId = 0}) async {
    List<ProductCategory> categories = [];

    for (int i = 0; i < shopCategoriesDef.length; i++) {
      ProductCategoryModel p = ProductCategoryModel.fromCategoryDef(shopCategoriesDef[i], i);
      if(p!=null)
        {
          ProductCategory pc =   ProductCategory.fromCategoryDef(p);
          if(pc!=null)
            {
              categories.add(pc);
            }

        }



    }
    if (parentCategoryId == 0) {
      return categories;
    } else {

      ProductCategory p = categories
          .firstWhere((element) => element.id == parentCategoryId, orElse: () {
        return null;
      });

      return p == null ? [] : p.submenu;
    }
  }

  @override
  Future<ProductCategory> getCategoryDetails(int categoryId) {
    // TODO: implement getCategoryDetails
    return null;
  }
}
