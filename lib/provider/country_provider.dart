import 'package:flutter/material.dart';
import 'package:sample/models/country_model.dart';
import 'package:sample/service/api_service.dart';

class CountryProvider with ChangeNotifier{
  var api = ApiService();
  CountryModel country;

  Future<CountryModel> getCountryProvider() async {
    final response = await api.client.get("${api.baseUrl}/api/countries/");
    if(response.statusCode == 200){
      notifyListeners();
      var res = countryModelFromJson(response.body);
      country = res;
      
      return country;
    }else{
      return null;
    }
  }
}