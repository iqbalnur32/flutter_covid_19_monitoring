import 'package:sample/models/home_models.dart';
import 'package:sample/service/api_service.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier{
  var api = ApiService();
  HomeModel home;

  Future<HomeModel> getHomeProvider() async {
    final response = await api.client.get("${api.baseUrl}/api");

    if(response.statusCode == 200) {
      notifyListeners();
      var res = homeModelFormJson(response.body);
      home = res;
      return res;
    }else{
      return null;
    }
  }
}