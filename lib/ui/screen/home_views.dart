import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:sample/provider/country_provider.dart';
import 'package:sample/provider/daily_provider.dart';
import 'package:sample/provider/home_provider.dart';
import 'package:sample/provider/province_provider.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:sample/ui/screen/tentang_page.dart';
import 'package:sample/ui/untils/style_app.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateFormat fn = DateFormat("M-dd-yyyy");
  String _selectedLocation = "ID";
  String datetime = '2-14-2020';

  @override
  void initState(){
    super.initState();
    final now = DateTime.now();
    setState(() {
      datetime = fn.format(DateTime(now.year, now.month, now.day -1 ));
    });
    Provider.of<HomeProvider>(context, listen: false).getHomeProvider();
    Provider.of<CountryProvider>(context, listen: false).getCountryProvider();
    Provider.of<DailyProvince>(context, listen: false).getDailyProvider(datetime);
    Provider.of<ProvinceProvider>(context, listen: false).getProvinceProvider(_selectedLocation);
  }

  @override 
  Widget build(BuildContext context){
    DateFormat fn = DateFormat("yyyy-MM-dd HH:mm:ss");
    final nf = NumberFormat("#,###");
    var home = Provider.of<HomeProvider>(context).home;
    var daily = Provider.of<DailyProvince>(context).daily;
    var province = Provider.of<ProvinceProvider>(context).province;
    var country = Provider.of<CountryProvider>(context).country;

    return Scaffold(
      appBar: AppBar(
        title: Text('Data Covid 19 Indonesia', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        backgroundColor: AppStyle.bgr,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              // Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (BuildContext context) => AboutPage()),
              // );
              Navigator.push(context, 
                  MaterialPageRoute(
                  builder: (BuildContext context) => AboutPage()
                )
              );
            },
          )
        ],
      ),
      body: Container(
        color: AppStyle.bgr,
        padding: EdgeInsets.all(15),
        child: ListView(
          children: <Widget>[
            Card(
              color: Colors.white,
              child: Column( 
                children: <Widget>[
                  if(home != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Theme(
                      data: ThemeData(canvasColor: Colors.black),
                      child: Text(
                        "World \n",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                  
                  confirmDetail(
                      home?.confirmed?.value?.toString(),
                      home?.recovered?.value?.toString(),
                      home?.deaths?.value?.toString(),
                  ),
                ],
              ),
            ),  
            SizedBox(height: 30,),
            Card(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    if (country != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Theme(
                          data: ThemeData(canvasColor: Colors.black),
                          child: DropdownButton(
                            isExpanded: true,
                            // hint: Text(
                            //   'Please choose a location',
                            //   style: TextStyle(color: AppStyle.txg),
                            // ),
                            value: _selectedLocation,
                            onChanged: (newValue) {
                              print(newValue);
                              setState(() {
                                _selectedLocation = newValue;
                              });
                              Provider.of<ProvinceProvider>(context,
                                      listen: false)
                                  .getProvinceProvider(newValue);
                            },
                            items: country.countries.entries
                                .map<DropdownMenuItem<String>>(
                                    (MapEntry<String, String> e) =>
                                        DropdownMenuItem<String>(
                                          value: e.value,
                                          child: Text(
                                            e.key,
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ))
                                .toList(),
                          ),
                        ),
                      ),
                    confirmDetail(
                      province?.confirmed?.value?.toString(),
                      province?.recovered?.value?.toString(),
                      province?.deaths?.value?.toString(),
                    )
                ],
              ),
            ),
            Divider(color: AppStyle.txw),
            ListTile(
              title: Text("Beberapa Kasus \nDi Dunia", style: AppStyle.stdtw),
              trailing: InkWell(
                onTap: () {
                  DatePicker.showDatePicker(context, 
                    showTitleActions: true,
                    minTime: DateTime(2020, 1, 1),
                    maxTime: DateTime(2020, 12, 31), onConfirm: (date) {
                      setState(() {
                        datetime = fn.format(date);
                        Provider.of<DailyProvince>(context, listen: false)
                          .getDailyProvider(datetime);
                      });
                    }
                  );
                },
                child: Text("Update $datetime", 
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            if(daily != null)
              Column(
                 children: daily
                  .map((val) => Card(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        ListTile(
                         title: Text(val?.provinceState ?? '',
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                            trailing: Text(val.countryRegion ?? '',
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)), 
                        ),
                         confirmDetail(
                            val?.confirmed?.toString(),
                            val?.recovered?.toString(),
                            val?.deaths?.toString(),
                         )
                      ],
                    ),
                  ))
                .toList()
              )
          ],
        ),
      ),
    );
  }
  Widget titleWidget(title, subtitle, color) {
    return ListTile(
      title: Text(title, style: AppStyle.stdtw),
      subtitle:
          Text(subtitle, style: AppStyle.subtitleMain.copyWith(color: color)),
    );
  }

   Widget confirmDetail(confirm, recovered, death) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              Text('Terkonfirmasi', style: TextStyle(color: Colors.black)),
              Padding(
                padding: AppStyle.pv10,
                child: Text(confirm ?? '',
                    style: AppStyle.stdtb.copyWith(color: AppStyle.txr)),
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Text('Sembuh', style: TextStyle(color: Colors.black)),
              Padding(
                padding: AppStyle.pv10,
                child: Text(recovered ?? '',
                    style: AppStyle.stdtb.copyWith(color: AppStyle.txg)),
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Text('Meninggal', style: TextStyle(color: Colors.black)),
              Padding(
                padding: AppStyle.pv10,
                child: Text(death ?? '',
                    style: AppStyle.stdtb.copyWith(color: AppStyle.txr)),
              )
            ],
          ),
        )
      ],
    );
  }

}