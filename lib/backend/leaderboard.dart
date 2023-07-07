import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wayaware/backend/models/user.dart';
import 'package:wayaware/bloc/auth_user_bloc.dart';

class LeaderBoard {
  static Future<void> saveUserPoints(AuthUserBloc authUserBloc, {points = 5}) async {
    final authUser = authUserBloc.state;
    if (authUser == null) return;

    final data = await FirebaseFirestore.instance.collection('leaderboard').doc(authUser.uid).get();
    if (!data.exists) {
      await FirebaseFirestore.instance
          .collection('leaderboard')
          .doc(authUser.uid)
          .set({'name': authUser.displayName, 'points': points, 'avatar_url': authUser.photoURL});
      return;
    }

    //calc new points amount
    num newpoints = (data.data()?['points'] ?? 0);
    newpoints += points;

    await FirebaseFirestore.instance
        .collection('leaderboard')
        .doc(authUser.uid)
        .set({'name': authUser.displayName, 'points': newpoints, 'avatar_url': authUser.photoURL});
  }

  static Future<List<User>> getLeaderBoard({amount = 20}) async {
    final List<User> leaderBoard = [];
    final results = await FirebaseFirestore.instance.collection('leaderboard').orderBy('points', descending: true).limit(amount).get();

    for (final doc in results.docs) {
      if (doc.data().isEmpty) continue;
      leaderBoard.add(User(doc.data()['name'], doc.data()['points'], doc.data()['avatar_url']));
    }

    return leaderBoard;
  }
}
