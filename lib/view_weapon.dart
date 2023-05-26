import 'package:flutter/material.dart';
import 'package:latihan_responsi/api.dart';
import 'package:latihan_responsi/view_chardet.dart';
import 'package:latihan_responsi/view_weapdet.dart';

class WeaponList extends StatefulWidget {
  const WeaponList({ Key? key }) : super(key: key);

  @override
  State<WeaponList> createState() => _WeaponListState();
}

class _WeaponListState extends State<WeaponList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text("Weapon List"),
      ),
      body: Container(
        child: _buildListWeapBody()
      ),
    ));
  }
}

Widget _buildErrorSection(){
  return Container(
    child: Text("Ada Error nih"),
  );
}

Widget _buildLoadingSection(){
  return CircularProgressIndicator();
}

Widget _buildListWeapBody(){
  return Container(
    child: FutureBuilder(
      future: ApiDataSource.instance.loadWeapons(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> ss){
        if(ss.hasError){
          return _buildErrorSection();
        }if(ss.hasData){
          // List<String> chara = ss.data;
          return _buildSuccessWeapBody(context, ss.data);
        }
        return _buildLoadingSection();
      },
    )
  );
}

Widget _buildSuccessWeapBody(BuildContext context, List<dynamic> weapon){
  return Container(
    child: ListView.builder(
      itemCount: weapon.length,
      itemBuilder: (BuildContext context, index){
        return _buildWeapItem(context, weapon[index]);
      }
    ),
  );
}

Widget _buildWeapItem(BuildContext context, String name){
  return InkWell(
    onTap: () {
      Navigator.push(context, 
      MaterialPageRoute(builder: (context) => WeaponDetails(wpname: name,)));
    },child: ListTile(
      leading: Image.network("https://api.genshin.dev/weapons/"+ name +"/icon"),
      title: Text(name.toUpperCase()),
    ),
  );
}