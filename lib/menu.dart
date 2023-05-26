import 'package:flutter/material.dart';
import 'package:latihan_responsi/view_char.dart';
import 'package:latihan_responsi/view_chardet.dart';
import 'package:latihan_responsi/view_weapdet.dart';
import 'package:latihan_responsi/view_weapon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  const MainPage({ Key? key }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String? _lastOpen;
  String? _code;

  Future<void> _getLastOpen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _lastOpen = prefs.getString("last_open");
      _code = prefs.getString("code");
    });
  }

  @override
  void initState() {
    super.initState();
    _lastOpen = "";
    _code = "";
    _getLastOpen();
  }

  ColorFilter negativeColorFilter = ColorFilter.matrix([
    -1, 0, 0, 0, 255, // Red
    0, -1, 0, 0, 255, // Green
    0, 0, -1, 0, 255, // Blue
    0, 0, 0, 1, 0, // Alpha
  ]);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        image: DecorationImage(image: NetworkImage("https://4.bp.blogspot.com/-iz7Z_jLPL6E/XQ8eHVZTlnI/AAAAAAAAHtA/rDn9sYH174ovD4rbxsC8RSBeanFvfy75QCKgBGAs/w1440-h2560-c/genshin-impact-characters-uhdpaper.com-4K-2.jpg",))
      ),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.5),
        body: Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Container(
                    padding: EdgeInsets.all(50),
                    decoration: BoxDecoration(
                      // color: Colors.red,
                      // image: DecorationImage(image: NetworkImage("https://upload.wikimedia.org/wikipedia/en/thumb/5/5d/Genshin_Impact_logo.svg/2560px-Genshin_Impact_logo.svg.png"), colorFilter: negativeColorFilter)
                    ),
                    width: MediaQuery.of(context).size.width, 
                    height: MediaQuery.of(context).size.height/2,
                    child: ColorFiltered(
                      colorFilter: negativeColorFilter,
                      child: Image.network("https://upload.wikimedia.org/wikipedia/en/thumb/5/5d/Genshin_Impact_logo.svg/2560px-Genshin_Impact_logo.svg.png",)
                    ),
                    // padding: EdgeInsets.symmetric(horizontal: 30),
                  ),
                ),
                if (_lastOpen != null && _lastOpen != "")
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  child: Card(
                    child: ListTile(
                      onTap: () async {
                        if (_code == "characters") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CharDetails(nameDet: _lastOpen!),
                            )
                          );
                        }else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WeaponDetails(wpname: _lastOpen!),
                            )
                          );
                        }
                      },
                      leading: Image.network('https://api.genshin.dev/${_code}/${_lastOpen!.toLowerCase()}/icon'),
                      title: Text(_lastOpen.toString().toUpperCase()),
                    ),
                  ),
                ),
                // Container(
                //   width: 400, height: 50,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(10)
                //   ),
                //   child: 
                // ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 50,),
                    Container(
                      width: 230, height: 40,
                      child: ElevatedButton(onPressed: () {
                        Navigator.push(context, 
                        MaterialPageRoute(builder: (context) => CharList()));
                      }, child: Text("Characters")),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: 230, height: 40,
                      child: ElevatedButton(onPressed: () {
                        Navigator.push(context, 
                        MaterialPageRoute(builder: (context) => WeaponList()));
                      }, child: Text("Weapons")),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}