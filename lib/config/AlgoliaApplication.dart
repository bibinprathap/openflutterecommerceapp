import 'package:algolia/algolia.dart';

class Application {
  static final Algolia algolia = Algolia.init(
    applicationId: '5C48TN6YXN', //ApplicationID
    apiKey:
        "4e0f24fb13ce7d9dfcc4809b5fc4e57a", //search-only api key in flutter code
  );
}
