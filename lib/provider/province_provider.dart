import 'package:sample/models/detail_country.dart';
import 'package:sample/service/api_service.dart';
import 'package:flutter/material.dart';

class ProvinceProvider extends ChangeNotifier{
  var api = ApiService();
  DetailCountry province;

  Future<DetailCountry> getProvinceProvider(String id) async {
    final response = await api.client.get("${api.baseUrl}/api/countries/$id");
    if(response.statusCode == 200){
      notifyListeners();
      var res = detailCountryFromJson(response.body);
      province = res;
      return res;
    }else{
      return null;
    }
  }
}
