import 'base_net.dart';

class ApiDataSource{
  static ApiDataSource instance = ApiDataSource();

  Future<List<dynamic>> loadChar(){
    return BaseNetwork.getList("characters");
  }

  Future<Map<String, dynamic>> loadCharDet(String name){
    String nama = name;
    return BaseNetwork.get("characters/"+ nama);
  }

  Future<List<dynamic>> loadWeapons(){
    return BaseNetwork.getList("weapons");
  }

  Future<Map<String, dynamic>> loadWeapDet(String name){
    String nama = name;
    return BaseNetwork.get("weapons/"+ nama);
  }

  // Future<Map<String, dynamic>> loadWeapDet(){
  //   return BaseNetwork.get("");
  // }
}