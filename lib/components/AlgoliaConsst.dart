import 'package:algolia/algolia.dart';
class AlgoliaApplication{
  static final Algolia algolia = Algolia.init(
    applicationId: 'H2JIP8JXOG', //ApplicationID
    apiKey: '8207f84367f85041f4d43aae0c25a803', //search-only api key in flutter code
  );
}

// const ALGOLIA_APP_ID = "H2JIP8JXOG";
// const ALGOLIA_ADMIN_KEY = "2426d68921bc6ead684f5242503ce3f9";
// const ALGOLIA_INDEX_NAME = "Products";