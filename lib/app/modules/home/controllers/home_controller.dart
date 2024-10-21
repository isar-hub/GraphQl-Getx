import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rick_morty/app/data/models/Model.dart';

class HomeController extends GetxController {

  String get readCharacters => r'''
    query($page: Int) {
      characters(page: $page) {
        info {
          pages
          next
          prev
        }
        results {
          id
          name
          image
          status
        }
      }
    }
  ''';
  final RxList<dynamic> characters = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
