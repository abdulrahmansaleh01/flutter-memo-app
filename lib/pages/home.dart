import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int indexTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "My Memo",
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.short_text,
              color: Colors.black,
              size: 33,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 35, top: 15, bottom: 15),
            height: 100,
            width: double.infinity,
            child: Row(
              children: [
                Image(
                    image:
                        // NetworkImage('https://iconfair.com/cepsools/2020/11/Artboard-30-10.png'),
                        NetworkImage(
                            'https://cdn.pixabay.com/photo/2016/10/06/19/02/clipboard-1719736_960_720.png')
                    //
                    ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hi !",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Make your day enjoy by making reminders :)",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Color(0xFFAFB4C6),
                indicatorColor: Color(0xFF417BFB),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 4.0,
                onTap: (index) {
                  setState(() {
                    indexTab = index;
                  });
                },
                tabs: [
                  Tab(
                    child: Text("Your Memo",
                        style: TextStyle(color: Colors.black)),
                  ),
                  Tab(
                    child:
                        Text("Category", style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _bottomButtons(),
    );
  }

  Widget _bottomButtons() {
    return indexTab == 0
        ? FloatingActionButton(
            shape: StadiumBorder(),
            onPressed: null,
            backgroundColor: Color(0xFF417BFB),
            child: Icon(Icons.post_add_sharp),
          )
        : FloatingActionButton(
            shape: StadiumBorder(),
            onPressed: null,
            backgroundColor: Color(0xFF417BFB),
            child: Icon(
              Icons.add,
            ),
          );
  }
}
