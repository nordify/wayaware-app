import 'package:flutter/material.dart';
import 'package:wayaware/backend/leaderboard.dart';
import 'package:wayaware/utils/os_widgets.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> with AutomaticKeepAliveClientMixin<StatsPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        backgroundColor: Colors.black,
        title: Image.asset(
          'assets/app_icon_inverted.png',
          width: 75,
          height: 75,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 4.0),
        child: FutureBuilder(
          future: LeaderBoard.getLeaderBoard(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return OSWidgets.getCircularProgressIndicator();
      
            final users = snapshot.data ?? [];
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Leaderboard",
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 40.0),
                  ),
                  const SizedBox(height: 10.0,),
                  Expanded(
                    child: ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.black,
                            backgroundImage: users[index].avatarUrl != 'null' ? Image.network(users[index].avatarUrl).image : null,
                          ),
                          title: Text(users[index].name),
                          trailing: Text('${users[index].points} points'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => false;
}