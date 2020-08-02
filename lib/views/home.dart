import 'package:covid_19/model/states.dart';
import 'package:flutter/material.dart';
import 'package:covid_19/helper/state_data.dart';
import 'package:covid_19/model/allindia.dart';
import 'package:covid_19/helper/overall_data.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<StateModel> states=new List<StateModel>();
  List<IndiaDataModel> allData=new List<IndiaDataModel>();
  bool _loading=true;

  @override
  void initState() {
    super.initState();
    getState();
  }

  getState() async{
    States state=States();
    await state.getStateName();
    states=state.getStates;
    getAllData();
  }

  getAllData() async{
    IndiaData indiaDataObj=IndiaData();
    await indiaDataObj.getAllDataIndia();
    allData=indiaDataObj.indiaData;
    setState(() {
      _loading=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("COVID-",style: TextStyle(color: Colors.white)),
              Text("19",style: TextStyle(color: Colors.white))
            ],
          ),
          elevation: 0.0,
          backgroundColor: Colors.redAccent,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.info,color: Colors.white,),)
          ],
        ),
        drawer: Drawer(),
        body:_loading ? Center(
          child: CircularProgressIndicator(),
        ) :
        Column(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: Column(
                  children: <Widget>[
                    ///Categories
                    Container(
                      height: 150,
                      child: ListView.builder(
                        itemCount: states.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context , index){
                          return CategoryTile(
                            stateName: states[index].loc.toString(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Text(allData[0].total),
                Text(allData[0].confirmedCases),
                Text(allData[0].confirmedCasesForeign),
                Text(allData[0].discharged),
                Text(allData[0].deaths),
              ],
            )
          ],
        )
    );
  }
}



///CategoryTile

class CategoryTile extends StatelessWidget {
  final String stateName;
  CategoryTile({@required this.stateName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image(
                  image: AssetImage("assets/images/bg.jpg")
                  ,width: 330,height: 140, fit: BoxFit.cover,
                )
            ),
            Container(
              alignment: Alignment.center,
              width: 330,height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child: Text(stateName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///BlogTile

class BlogTile extends StatelessWidget {
  final String data;
  BlogTile({this.data});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Text(data),
        ],
      ),
    );
  }
}

