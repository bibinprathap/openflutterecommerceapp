class ServerAddresses {
  //Server address of your project should go here
  static const serverAddress = 'https://woocommerce.openflutterproject.com/';
  //static const royalServerAddress =
  //  'https://royalautopartsmarket.com/_next/data/HJyrq-cnUjMnsEBNuklcZ/';
  static const royalServerAddress = 'https://royalautopartsmarket.com/api';
  //http://localhost:3000/api/productdetails?slug=OIL-FILTER+BENTLEY07V121717AOE
  //?consumer_key=ck_*****&consumer_secret=cs_**** goes here
  static const _woocommerceKeys = '';
  static const _categorySuffix = '/wp-json/wc/v3/products/categories/'; //id
  static const _productSuffix = ' /wp-json/wc/v3/products/categories/';
  static const _promoSuffix = ' /wp-json/wc/v3/reports/coupons/';
  static const signUp = ''; // TODO need an endpoint for this
  static const forgotPassword = ''; // TODO need an endpoint for this

  /// For more information about wp-rest-api plugin
  /// https://wordpress.org/plugins/jwt-authentication-for-wp-rest-api/
  static const authToken = 'wp-json/jwt-auth/v1/token';

  //CACHED API (for test purposes only)
  static const _productCategoriesCached =
      '/cachedapi/v3/products/categories.json';
  static const _productsCached = '/cachedapi/v3/products/products.json';

  static const _royalProductsCached =
      'catalog/products.json?make=CADILLIC&makeCode=CADILLIC&partsCategory=BAR&partsCategoryCode=BAR&lang=en';

  static const _royalProductCached =
      'productdetails?slug=OIL-FILTER+BENTLEY07V121717AOE';
  static const _promosCached = '/cachedapi/v3/coupon.json';

  static bool useStatic = _woocommerceKeys.isEmpty;

  static String get productCategories =>
      serverAddress +
      (useStatic
          ? _productCategoriesCached
          : serverAddress + _categorySuffix + _woocommerceKeys);

  static String get products => royalServerAddress + _royalProductsCached;

  static String get product => royalServerAddress + _royalProductCached;

  //      static String get products =>
  // serverAddress +
  // (useStatic
  //     ? _productsCached
  //     : serverAddress + _productSuffix + _woocommerceKeys);

  static String get promos =>
      serverAddress +
      (useStatic
          ? _promosCached
          : serverAddress + _promoSuffix + _woocommerceKeys);
}
