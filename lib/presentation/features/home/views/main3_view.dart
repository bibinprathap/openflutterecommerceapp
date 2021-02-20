// Home Screen View #3: Banners
// Author: openflutterproject@gmail.com
// Date: 2020-02-06

import 'package:flutter/material.dart';
import 'package:openflutterecommerce/config/routes.dart';
import 'package:openflutterecommerce/config/theme.dart';
import 'package:openflutterecommerce/data/model/category.dart';
import 'package:openflutterecommerce/presentation/features/products/products.dart';
import 'package:openflutterecommerce/presentation/features/wrapper.dart';
import 'package:openflutterecommerce/presentation/widgets/widgets.dart';

class Main3View extends StatefulWidget {
  final Function changeView;

  const Main3View({Key key, this.changeView}) : super(key: key);

  @override
  _Main3ViewState createState() => _Main3ViewState();
}

class _Main3ViewState extends State<Main3View> {
  @override
  Widget build(BuildContext context) {
    var _theme = Theme.of(context);
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
        child: Column(children: <Widget>[
      Container(
          height: width * 0.96,
          width: width,
          decoration: BoxDecoration(
            color: const Color(0xff7c94b6),
            image: DecorationImage(
              fit: BoxFit.fill,
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.4), BlendMode.dstATop),
              image: AssetImage('assets/splash/main3.png'),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(
                      left: AppSizes.sidePadding, bottom: AppSizes.sidePadding),
                  width: width,
                  child: Text(
                      'Mercedes Benz Spare Parts Uae,All Over The World Online HURRY UP ',
                      style: _theme.textTheme.headline.copyWith(fontSize: 34))),
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
                  onPressed: (() { 
                     Navigator.of(context).pushNamed(
                OpenFlutterEcommerceRoutes.productList,
                arguments: ProductListScreenParameters(
                    ProductCategory(0, name: "MERCEDES BENZ"),
                    '/productsList?make=MERCEDES BENZ&makeCode=MERCEDES BENZ' ));
                        }),
                ),
              )
            ],
          )),
      Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                  height: width / 2,
                  width: width / 2,
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.only(
                      bottom: AppSizes.sidePadding, left: AppSizes.sidePadding),
                  decoration: BoxDecoration(
                    color: const Color(0xff7c94b6),
                    image: DecorationImage(
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.4), BlendMode.dstATop),
                      fit: BoxFit.fill,
                      image: AssetImage('assets/splash/bottombanner2222.png'),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(
                              left: AppSizes.sidePadding,
                              bottom: AppSizes.sidePadding),
                          width: width,
                          child: Text(
                              'Nissan Altima Headlight Bulb Replacement. HURRY UP!',
                              style: _theme.textTheme.headline
                                  .copyWith(fontSize: 34))),
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
                           onPressed: (() { 
                     Navigator.of(context).pushNamed(
                OpenFlutterEcommerceRoutes.productList,
                arguments: ProductListScreenParameters(
                    ProductCategory(0, name: "NISSAN"),
                    '/productsList?make=MITSUBISHI&makeCode=MITSUBISHI' ));
                        }),
                        ),
                      )
                    ],
                  )),
              Container(
                  height: width / 2,
                  width: width / 2,
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.only(
                      bottom: AppSizes.sidePadding, left: AppSizes.sidePadding),
                  decoration: BoxDecoration(
                    color: const Color(0xff7c94b6),
                    image: DecorationImage(
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.4), BlendMode.dstATop),
                      fit: BoxFit.fill,
                      image: AssetImage('assets/splash/bottombanner.png'),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(
                              left: AppSizes.sidePadding,
                              bottom: AppSizes.sidePadding),
                          width: width,
                          child: Text(
                              'Top Porsche Cayenne Spare Parts Uae- Abudhabi- Dubai',
                              style: _theme.textTheme.headline
                                  .copyWith(fontSize: 34))),
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
                           onPressed: (() { 
                     Navigator.of(context).pushNamed(
                OpenFlutterEcommerceRoutes.productList,
                arguments: ProductListScreenParameters(
                    ProductCategory(0, name: "PORSCHE"),
                    '/productsList?make=PORSCHE&makeCode=PORSCHE' ));
                        }),
                        ),
                      )
                    ],
                  )),
            ],
          ),
          Container(
              height: width / 2 * 1.99,
              width: width / 2,
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: AppSizes.sidePadding),
              decoration: BoxDecoration(
                color: const Color(0xff7c94b6),
                image: DecorationImage(
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.4), BlendMode.dstATop),
                  fit: BoxFit.fill,
                  image: AssetImage('assets/splash/sidebanner.png'),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(
                          left: AppSizes.sidePadding,
                          bottom: AppSizes.sidePadding),
                      width: width,
                      child: Text(
                          'Volkswagen Vento Best In Spare Parts Deliverd From Uae',
                          style: _theme.textTheme.headline
                              .copyWith(fontSize: 34))),
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
                     onPressed: (() { 
                     Navigator.of(context).pushNamed(
                OpenFlutterEcommerceRoutes.productList,
                arguments: ProductListScreenParameters(
                    ProductCategory(0, name: "VOLKS WAGON"),
                    '/productsList?make=VOLKS%20WAGON&makeCode=VOLKS%20WAGON' ));
                        }),
                    ),
                  )
                ],
              )),
        ],
      ),
    ]));
  }
}
