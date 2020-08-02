import 'package:covid_19/model/allindia.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class IndiaData{
  List<IndiaDataModel> indiaData=[];

  Future<void> getAllDataIndia() async{
    String url="https://api.rootnet.in/covid19-in/stats/latest";
    var response=await http.get(url);
    var jsonData=jsonDecode(response.body);

    if(jsonData["data"]!=null){
      IndiaDataModel dataModel=new IndiaDataModel(
          total: jsonData["data"]["summary"]["total"].toString(),
          confirmedCases: jsonData["data"]["summary"]["confirmedCasesIndian"].toString(),
          confirmedCasesForeign: jsonData["data"]["summary"]["confirmedCasesForeign"].toString(),
          discharged: jsonData["data"]["summary"]["discharged"].toString(),
          deaths: jsonData["data"]["summary"]["deaths"].toString()
      );
      indiaData.add(dataModel);
    }

  }

}