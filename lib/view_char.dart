import 'package:flutter/material.dart';
import 'package:latihan_responsi/api.dart';
import 'package:latihan_responsi/view_chardet.dart';

class CharList extends StatefulWidget {
  const CharList({ Key? key }) : super(key: key);

  @override
  State<CharList> createState() => _CharListState();
}

class _CharListState extends State<CharList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text("Character List"),
      ),
      body: Container(
        child: _buildListCharBody(),
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

Widget _buildListCharBody(){
  return Container(
    child: FutureBuilder(
      future: ApiDataSource.instance.loadChar(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> ss){
        if(ss.hasError){
          // print(ss.error);
          return _buildErrorSection();
        }if(ss.hasData){
          // print(ss.data);
          // List<String> chara = ss.data;
          return _buildSuccessCharSection(context, ss.data);
        }
        return _buildLoadingSection();
      },
    )
  );
}

Widget _buildSuccessCharSection(BuildContext context, List<dynamic> chara){
  // List<dynamic> charList = chara.values.toList();
  return Container(
    child: ListView.builder(
      itemCount: chara.length,
      itemBuilder: (BuildContext context, index){
        return _buildCharItem(context, chara[index]);
      }
    ),
  );
}

Widget _buildCharItem(BuildContext context, String name){
  return InkWell(
    onTap: () {
      Navigator.push(context, 
      MaterialPageRoute(builder: (context) => CharDetails(nameDet: name)));
    },child: ListTile(
      leading: Image.network("https://api.genshin.dev/characters/"+ name +"/icon"),
      title: Text(name.toUpperCase()),
    ),
  );
}