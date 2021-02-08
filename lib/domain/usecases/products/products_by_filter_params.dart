import 'package:openflutterecommerce/data/model/filter_rules.dart';
import 'package:openflutterecommerce/data/model/sort_rules.dart';

class ProductsByFilterParams {
  final int categoryId;
  final SortRules sortBy;
  final FilterRules filterRules;
  final String slugorurl;

  ProductsByFilterParams(
      {this.categoryId, this.sortBy, this.filterRules, this.slugorurl});

  bool get filterByCategoryOrSlug => categoryId != null || this.slugorurl != null;
}
