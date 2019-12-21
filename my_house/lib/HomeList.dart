import 'package:flutter/material.dart';
import 'package:my_house/HouseCard.dart';
import 'package:my_house/NewHome.dart';
import 'package:my_house/service/HouseManager.dart';

import 'models/home.dart';

class HomeList extends StatefulWidget {
  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  HouseManager houseManager=HouseManager();

  List<Home> _houseList;
  showHouseList() async{
    print('calling...');
    houseManager.homeList().then((val){
      setState(() {
        if(val!=null){
          _houseList=val;
        }else{
          _houseList=[];
        }
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showHouseList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('House List'),

      ),
      body: Container(
      margin: const EdgeInsets.all(16.0),
      child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
       children:<Widget>[
         Card(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: <Widget>[
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisSize: MainAxisSize.min,
                 children: <Widget>[
                   Text('Name'),
                   Text('Address')
                 ],
               )
             ],
           ),
         ),
          Expanded(
            child: _houseList!=null? ListView.builder(
              shrinkWrap: true,
             
           itemCount: _houseList.length,
                itemBuilder: ( ctxt, index) {
                  return  HouseCard(home: _houseList[index]);
                }
        ):CircularProgressIndicator(),
          )
       ])
      
      
    ),
    floatingActionButton: FloatingActionButton(
      child:Icon(Icons.add),
      onPressed: (){
        final result=Navigator.push(context, MaterialPageRoute(builder: (context) => NewHome()));
        print('Before result $result');
        if(result!=null){
          print('Result is $result');
          showHouseList();
        }
      },
    ),
    );
    
  }
}