// Home Screen Bloc States
// Author: openflutterproject@gmail.com
// Date: 2020-02-06

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:openflutterecommerce/data/model/product.dart';

@immutable
abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

@immutable
class HomeInitialState extends HomeState {
  @override
  String toString() => 'HomeInitialState';
}

@immutable
class HomeLoadedState extends HomeState {
  final List<Product> salesProducts;
  final List<Product> newProducts;
  final List<Product> newArrivals;
  final List<Product> topSeller;
  final List<Product> availableOffers;

  HomeLoadedState(
      {this.salesProducts,
      this.newProducts,
      this.newArrivals,
      this.topSeller,
      this.availableOffers});

  @override
  String toString() => 'HomeLoadedState';

  @override
  List<Object> get props =>
      [salesProducts, newProducts, topSeller, availableOffers, newArrivals];
}
