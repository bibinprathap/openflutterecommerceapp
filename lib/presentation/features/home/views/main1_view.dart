// Home Screen View #1: Big top banner, list of products
// Author: openflutterproject@gmail.com
// Date: 2020-02-06

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:openflutterecommerce/config/routes.dart';
import 'package:openflutterecommerce/config/theme.dart';
import 'package:openflutterecommerce/data/model/product.dart';
import 'package:openflutterecommerce/presentation/features/categories/categories.dart';
import 'package:openflutterecommerce/presentation/features/home/home_bloc.dart';
import 'package:openflutterecommerce/presentation/features/home/home_event.dart';
import 'package:openflutterecommerce/presentation/features/home/home_state.dart';
import 'package:openflutterecommerce/presentation/features/wrapper.dart';
import 'package:openflutterecommerce/presentation/widgets/widgets.dart';

class Main1View extends StatefulWidget {
  final Function changeView;
  final List<Product> products;

  const Main1View({Key key, this.products, this.changeView}) : super(key: key);

  @override
  _Main1ViewState createState() => _Main1ViewState();
}

class _Main1ViewState extends State<Main1View> {
  @override
  Widget build(BuildContext context) {
    var _theme = Theme.of(context);
    var width = MediaQuery.of(context).size.width;
    var widgetWidth = width - AppSizes.sidePadding * 2;
    return BlocBuilder<HomeBloc, HomeState>(
        builder: (BuildContext context, HomeState state) {
      return Container(
        child: Column(
          children: <Widget>[
            Container(
                height: width * 1.43,
                width: width,
                decoration: BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.4), BlendMode.dstATop),
                    image: AssetImage('assets/splash/splash-home.png'),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                        left: AppSizes.sidePadding,
                      ),
                      width: width / 2,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(translate('fashionSale'),
                            style: _theme.textTheme.headline
                                .copyWith(fontSize: 34, color: Colors.white)),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: AppSizes.sidePadding,
                          bottom: AppSizes.sidePadding,
                          top: AppSizes.sidePadding),
                      width: 160,
                      child: OpenFlutterButton(
                        title: 'Shop All',
                        width: 160,
                        height: 48,
                        onPressed: (() => Scaffold.of(context).openDrawer()),
                      ),
                    )
                  ],
                )),
            OpenFlutterBlockHeader(
              width: widgetWidth,
              title: 'New',
              linkText: 'View All',
              onLinkTap: () => {
                Navigator.of(context).pushNamed(OpenFlutterEcommerceRoutes.shop,
                    arguments: CategoriesParameters(0))
              },
              description:
                  'Toyota Genuine Spare Parts .Genuine Value And Genuine Safty Online Uae',
            ),
            OpenFlutterProductListView(
              width: widgetWidth,
              products: widget.products,
              onFavoritesTap: ((Product product) => {
                    BlocProvider.of<HomeBloc>(context).add(
                        HomeAddToFavoriteEvent(
                            isFavorite: !product.isFavorite, product: product))
                  }),
            ),
          ],
        ),
      );
    });
  }
}
