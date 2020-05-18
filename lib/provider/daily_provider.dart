import 'package:sample/models/daily_model.dart';
import 'package:sample/service/api_service.dart';
import 'package:flutter/material.dart';

class DailyProvince extends ChangeNotifier{
  var api = ApiService();
  List<DailyModel> daily;

  Future<List<DailyModel>> getDailyProvider(String id) async {
    final response = await api.client.get("${api.baseUrl}/api/daily/$id");
    if(response.statusCode == 200){
      notifyListeners();
      var res = dailyModelFromJson(response.body);
      daily = res;
      return daily;
    }else{
      return null;
    }
  }

}