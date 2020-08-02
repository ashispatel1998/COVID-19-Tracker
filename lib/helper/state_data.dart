import 'dart:convert';
import 'package:covid_19/model/states.dart';
import 'package:http/http.dart' as http;


class States{
  List<StateModel> getStates=[];

  Future<void> getStateName() async{
    String url="https://api.rootnet.in/covid19-in/stats/latest";
    var response=await http.get(url);
    var jsonData=jsonDecode(response.body);

    if(jsonData!=null){
      jsonData["data"]["regional"].forEach((element){
        StateModel stateModel=new StateModel(
            loc: element["loc"]
        );
        getStates.add(stateModel);
      });
    }
  }
}
