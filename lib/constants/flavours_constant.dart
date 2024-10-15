enum Flavor { DEVELOPMENT, PRODUCTION }

class FlavorValues {
  final String baseApiUrl;

  FlavorValues({required this.baseApiUrl});
}

class FlavorConfig {
  static late Flavor flavor;
  static late FlavorValues values;

  FlavorConfig({required Flavor flavor, required FlavorValues values}) {
    FlavorConfig.flavor = flavor;
    FlavorConfig.values = values;
  }

  static bool isDevelopment() => flavor == Flavor.DEVELOPMENT;
  static bool isProduction() => flavor == Flavor.PRODUCTION;
}
