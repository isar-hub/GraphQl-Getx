import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static List<GetPage> routes(ValueNotifier<GraphQLClient> client) {
    return [
      GetPage(
        name: _Paths.HOME,
        page: () => HomeView( client),  // Pass client here
        binding: HomeBinding(),
      ),
    ];
  }
}
