import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int indexTab = 0;
  TabController _tabController;

  void initState() {
    // TODO: implement initState
    _tabController = new TabController(length: 2, vsync: this, initialIndex: 0)
      ..addListener(() {});
    super.initState();
  }

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
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[200],
            ),
            child: TabBar(
              isScrollable: true,
              indicatorPadding: EdgeInsets.all(10),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.blue[400],
              labelStyle: TextStyle(fontSize: 20),
              labelPadding:
                  EdgeInsets.only(left: 35, right: 35, top: 12, bottom: 12),
              indicator: BoxDecoration(
                  color: Colors.blue[400],
                  borderRadius: BorderRadius.circular(20)),
              controller: _tabController,
              indicatorColor: Color(0xFF417BFB),
              onTap: (index) {
                setState(() {
                  indexTab = index;
                });
              },
              tabs: [
                Text("Your Memo"),
                Text("Category"),
                // Text("Tes"),
              ],
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
