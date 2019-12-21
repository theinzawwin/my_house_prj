import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_house/models/home.dart';
import 'package:my_house/service/HouseManager.dart';
import 'package:progress_dialog/progress_dialog.dart';

class NewHome extends StatefulWidget {
  @override
  _NewHomeState createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
   ProgressDialog pr;
  HouseManager houseManager=HouseManager();
  final nameController= TextEditingController();
  final addressController= TextEditingController();
  final areaController = TextEditingController();
  final qtyController = TextEditingController();
  final rateController = TextEditingController();
  final taxController = TextEditingController();
  final remarkController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  houseList()async{
     houseManager.homeList().then((val){
                setState(() {
                  print("Size ${val.length}");
                  val.map((item)=>print("name ${item.name}")).toList();
                });
                    
                  });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    houseList();
  }
  @override
  Widget build(BuildContext context) {
     pr = new ProgressDialog(context,type: ProgressDialogType.Normal);
     pr.style(message: 'Showing some progress...');
    
    //Optional
    pr.style(
          message: 'Please wait...',
          borderRadius: 10.0,
          backgroundColor: Colors.white,
          progressWidget: CircularProgressIndicator(),
          elevation: 10.0,
          insetAnimCurve: Curves.easeInOut,
          progressTextStyle: TextStyle(
              color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
          messageTextStyle: TextStyle(
              color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
        ); 
    return Scaffold(
      appBar: AppBar(
        title: Text('New House'),
      ),
      body: Container(
      padding: const EdgeInsets.all(16.0),
      child:SingleChildScrollView(
        
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                          hintText: 'Name'
                  ),
                  validator: (val){
                    if(val.isEmpty){
                      return 'Please fill Name';
                    }else{
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                    labelText: 'Address',
                          hintText: 'Address'
                  ),
                  validator: (val){
                    if(val.isEmpty){
                      return "Please fill Address";
                    }else{
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: areaController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText:'Arcs',
                    hintText: 'Arcs'
                  ),
                  
                ),
                SizedBox(height: 10.0,),
                TextFormField(
                  controller: qtyController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText:'Flat Qty',
                    hintText: 'Flat Qty'
                  ),
                  
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: rateController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Rate'
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: taxController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Tax Amount'
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: remarkController,
                  decoration: InputDecoration(
                    labelText: 'Remark'
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                RaisedButton(
                  onPressed: ()async{
                  if(_formKey.currentState.validate()){
                     _formKey.currentState.save();
                    save();
                  }  else{
                    Fluttertoast.showToast(msg: 'Please fill complete data',toastLength: Toast.LENGTH_LONG);
                  }
                  
                  
                  },
                  child: Text('Save'),
                )
              ],
          ),
        ),
      ) ,
    ),
    );
    
    
  }
  save()async{
      pr.show();
      try{
        Home h=Home(name: nameController.text,address: addressController.text,area: double.parse(areaController.text),qty:double.parse(qtyController.text),rate: double.parse(rateController.text),tax: double.parse(taxController.text),remark: remarkController.text??"");
      await houseManager.insertHouse(h);
      if(pr.isShowing()){
        pr.hide();
      }
      Fluttertoast.showToast(msg: 'Successfully saved',toastLength: Toast.LENGTH_LONG);
      
      }catch(e){
        print("Exception is $e");
        Fluttertoast.showToast(msg: 'Something Error',toastLength: Toast.LENGTH_LONG);
      }
      Navigator.pop(context,true);
     // await houseList();
    }
}