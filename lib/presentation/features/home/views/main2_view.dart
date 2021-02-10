// Home Screen View #2: small top banner, list of products sale and new
// Author: openflutterproject@gmail.com
// Date: 2020-02-06

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openflutterecommerce/config/routes.dart';
import 'package:openflutterecommerce/config/theme.dart';
import 'package:openflutterecommerce/data/model/product.dart';
import 'package:openflutterecommerce/presentation/features/categories/categories.dart';
import 'package:openflutterecommerce/presentation/features/home/home_bloc.dart';
import 'package:openflutterecommerce/presentation/features/home/home_event.dart';
import 'package:openflutterecommerce/presentation/features/wrapper.dart';
import 'package:openflutterecommerce/presentation/widgets/widgets.dart';

class Main2View extends StatefulWidget {
  final Function changeView;
  final List<Product> salesProducts;
  final List<Product> availableOffers;
  final List<Product> newProducts;
  final List<Product> topSeller;

  const Main2View(
      {Key key,
      this.changeView,
      this.salesProducts,
      this.availableOffers,
      this.newProducts,
      this.topSeller})
      : super(key: key);

  @override
  _Main2ViewState createState() => _Main2ViewState();
}

class _Main2ViewState extends State<Main2View> {
  @override
  Widget build(BuildContext context) {
    var _theme = Theme.of(context);
    var width = MediaQuery.of(context).size.width;
    var widgetWidth = width - AppSizes.sidePadding * 2;
    return SingleChildScrollView(
        child: Column(children: <Widget>[
      Container(
          height: width * 0.72,
          width: width,
          decoration: BoxDecoration(
            color: const Color(0xff7c94b6),
            image: DecorationImage(
              fit: BoxFit.fill,
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.4), BlendMode.dstATop),
              image: AssetImage('assets/splash/topbanner.jpg'),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(left: AppSizes.sidePadding),
                  width: width,
                  child: Text(
                      'Get Quotation for Your Vehicle"s Spare Parts From Different Suppliers',
                      style: _theme.textTheme.headline
                          .copyWith(fontSize: 24, color: Colors.white))),
              SizedBox(
                height: 20,
              ),
              Container(
                  padding: EdgeInsets.only(left: AppSizes.sidePadding),
                  width: width,
                  child: Text(
                      'You Can Choose Suppliers who give better product in cheep price and fast delivery',
                      style: _theme.textTheme.headline
                          .copyWith(fontSize: 14, color: Colors.white))),
              SizedBox(
                height: 10,
              ),
              OpenFlutterButton(
                title: 'Search Spare Parts',
                width: 260,
                height: 48,
                onPressed: () {
                  showSearch(context: context, delegate: DataSearch());
                },
              )
            ],
          )),
      OpenFlutterBlockHeader(
        width: widgetWidth,
        title: 'Featured Products',
        linkText: 'View All',
        onLinkTap: () => {
          Navigator.of(context).pushNamed(OpenFlutterEcommerceRoutes.shop,
              arguments: CategoriesParameters(2))
        },
        description: 'Spare Parts For Your Car',
      ),
      OpenFlutterProductListView(
          width: widgetWidth,
          products: widget.salesProducts,
          onFavoritesTap: ((Product product) => {
                BlocProvider.of<HomeBloc>(context).add(HomeAddToFavoriteEvent(
                    isFavorite: !product.isFavorite, product: product))
              })),
      Padding(padding: EdgeInsets.only(top: AppSizes.sidePadding)),
      OpenFlutterBlockHeader(
        width: widgetWidth,
        title: 'Bestsellers',
        linkText: 'View All',
        onLinkTap: () => {
          Navigator.of(context).pushNamed(OpenFlutterEcommerceRoutes.shop,
              arguments: CategoriesParameters(3))
        },
        description:
            'You Can Choose Spare Part Suppliers who give better product in cheep price and fast delivery',
      ),
      OpenFlutterProductListView(
        width: widgetWidth,
        products: widget.newProducts,
        onFavoritesTap: ((Product product) => {
              BlocProvider.of<HomeBloc>(context).add(HomeAddToFavoriteEvent(
                  isFavorite: !product.isFavorite, product: product))
            }),
      ),
      Padding(padding: EdgeInsets.only(top: AppSizes.sidePadding)),
      OpenFlutterBlockHeader(
        width: widgetWidth,
        title: 'Top Rated',
        linkText: 'View All',
        onLinkTap: () => {
          Navigator.of(context).pushNamed(OpenFlutterEcommerceRoutes.shop,
              arguments: CategoriesParameters(3))
        },
        description:
            'Widerange Of Auto Spare Parts Uae Bring From The Global In Short Period *Available Now',
      ),
      OpenFlutterProductListView(
        width: widgetWidth,
        products: widget.topSeller,
        onFavoritesTap: ((Product product) => {
              BlocProvider.of<HomeBloc>(context).add(HomeAddToFavoriteEvent(
                  isFavorite: !product.isFavorite, product: product))
            }),
      ),
      Padding(padding: EdgeInsets.only(top: AppSizes.sidePadding)),
      OpenFlutterBlockHeader(
        width: widgetWidth,
        title: 'Available Offers',
        linkText: 'View All ',
        onLinkTap: () => {
          Navigator.of(context).pushNamed(OpenFlutterEcommerceRoutes.shop,
              arguments: CategoriesParameters(3))
        },
        description: 'Top Online Car Parts Dubai – Uae Order Now',
      ),
      OpenFlutterProductListView(
        width: widgetWidth,
        products: widget.availableOffers,
        onFavoritesTap: ((Product product) => {
              BlocProvider.of<HomeBloc>(context).add(HomeAddToFavoriteEvent(
                  isFavorite: !product.isFavorite, product: product))
            }),
      ),
      OpenFlutterButton(
        title: 'View All Spare Parts',
        width: 260,
        height: 48,
        onPressed: () => {
          Navigator.of(context).pushNamed(OpenFlutterEcommerceRoutes.shop,
              arguments: CategoriesParameters(0))
        },
      )
    ]));
  }
}
