// Category Tile View (with images)
// Author: openflutterproject@gmail.com
// Date: 2020-02-06
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openflutterecommerce/config/routes.dart';
import 'package:openflutterecommerce/config/theme.dart';
import 'package:openflutterecommerce/data/model/category.dart';
import 'package:openflutterecommerce/presentation/features/products/products.dart';
import 'package:openflutterecommerce/presentation/widgets/widgets.dart';

import '../categories.dart';
import '../categories_bloc.dart';
import '../../../widgets/extensions/commerce_image_view.dart';

class CategoriesTileView extends StatefulWidget {
  final Function changeView;

  const CategoriesTileView({Key key, this.changeView}) : super(key: key);

  @override
  _CategoriesTileViewState createState() => _CategoriesTileViewState();
}

class _CategoriesTileViewState extends State<CategoriesTileView>
    with SingleTickerProviderStateMixin {
  final List<String> types = [
    'IDLER',
    'ELECTRICAL',
    'MIRROR',
    'THERMOSTAT AND HOUSING ',
    'A/C',
    'BADGE',
    'CABLE',
    'DAMPER',
    'FAN',
    'Oils & Lubricants',
    'JOINT & KEY & LAMP',
    'NOZZLE & OIL',
    'PANEL & RADIATOR ',
    'SPARK PLUG ',
    'UPPER ARM && VACCUM && WASHER'
  ];
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: types.length,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _theme = Theme.of(context);
    var width = MediaQuery.of(context).size.width;
    return BlocListener<CategoryBloc, CategoryState>(
        listenWhen: (context, state) {
      return state is CategoryErrorState;
    }, listener: (BuildContext context, CategoryState state) {
      return Container(
          padding: EdgeInsets.all(AppSizes.sidePadding),
          child: Text('An error occured',
              style: _theme.textTheme.display1
                  .copyWith(color: _theme.errorColor)));
    }, child:
            BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
      if (state is CategoryTileViewState) {
        var tabViews = <Widget>[];
        for (var category in state.categories) {
          tabViews.add(SingleChildScrollView(
              child: Column(children: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.sidePadding),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 100,
                      alignment: Alignment.centerRight,
                      child: Image(image: category.image.getView()),
                    ),
                    Padding(
                        padding: EdgeInsets.all(AppSizes.sidePadding * 3),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(category.name,
                                  style: _theme.textTheme.display1),
                              category.count != null
                                  ? Text(
                                      category.count.toString() + " Products",
                                      style: _theme.textTheme.display3)
                                  : SizedBox()
                            ]))
                  ],
                )),
            Container(
                padding: EdgeInsets.all(AppSizes.sidePadding),
                child: Column(
                    children: buildCategoryList(
                        category.submenu, width - AppSizes.sidePadding * 3)))
          ])));
        }
        return SafeArea(
            child: OpenFlutterScaffold(
                background: null,
                title: 'Categories',
                bottomMenuIndex: 1,
                tabController: _tabController,
                tabBarList: types,
                body: TabBarView(
                  children: tabViews,
                  controller: _tabController,
                )));
      }
      return Center(child: CircularProgressIndicator());
    }));
  }

  List<Widget> buildCategoryList(
      List<ProductCategory> categories, double width) {
    var elements = <Widget>[];
    for (var i = 0; i < categories.length; i++) {
      elements.add(InkWell(
          onTap: (() {
            Navigator.of(context).pushNamed(
                OpenFlutterEcommerceRoutes.productList,
                arguments: ProductListScreenParameters(categories[i]));
          }),
          child: categories[i].submenu.isNotEmpty
              ? OpenFlutterCategoryTile(
                  height: 100, width: width, category: categories[i])
              : OpenFlutterCatregoryListElement(category: categories[i])));
    }
    return elements;
  }
}
