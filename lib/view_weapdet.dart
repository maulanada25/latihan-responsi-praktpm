import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api.dart';
import 'model_weapondet.dart';

class WeaponDetails extends StatefulWidget {
  final String wpname;
  const WeaponDetails({ Key? key, required this.wpname}) : super(key: key);

  @override
  State<WeaponDetails> createState() => _WeaponDetailsState();
}

class _WeaponDetailsState extends State<WeaponDetails> {
  Future<void> _setLastOpen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('last_open', widget.wpname);
    prefs.setString('code', 'weapons');
  }

  @override
  void initState() {
    super.initState();
    _setLastOpen();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.black.withOpacity(0.9),
      appBar: AppBar(
        title: Text(widget.wpname.toUpperCase() + " Details"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network("https://api.genshin.dev/weapons/"+ widget.wpname + "/icon"),
          _buildDetailedWeaponBody(widget.wpname)
        ],
      ),
    ));
  }
}

Widget _buildDetailedWeaponBody(String name){
  return Container(
    child: FutureBuilder(
      future: ApiDataSource.instance.loadWeapDet(name),
      builder: (context, AsyncSnapshot<dynamic> snapshot){
      if(snapshot.hasError){
        return _buildErrorSection();
      }if(snapshot.hasData){
        WeaponModel weapon = WeaponModel.fromJson(snapshot.data);
        return _buildSuccessBody(weapon);
      }
      return Text("error ngab");
      },
    ),
  );
}

Widget _buildSuccessBody(WeaponModel weap){
  return Column(
    children: [
      Text(weap.name, style: TextStyle(color: Colors.white),),
      _starGenerator(weap.rarity),
    ],
  );
}

Widget _buildErrorSection(){
  return Container(
    child: Text("Ada Error nih"),
  );
}

Widget _buildLoadingSection(){
  return CircularProgressIndicator();
}

Widget _starGenerator(int num) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(
      num,
      (index) => Icon(Icons.star, color: Colors.white,),
    ),
  );
}