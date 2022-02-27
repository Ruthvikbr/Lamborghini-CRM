import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lamborghini/blocs/home_bloc.dart';
import 'package:lamborghini/model/transaction.dart';
import 'package:lamborghini/model/user.dart';
import 'package:lamborghini/screens/components/list_item_builder.dart';
import 'package:lamborghini/screens/components/transaction_item.dart';
import 'package:lamborghini/services/network/api.dart';
import 'package:lamborghini/services/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key, required this.bloc}) : super(key: key);

  final HomeBloc bloc;

  static Widget create(BuildContext context) {
    final apiBase = Provider.of<ApiBase>(context, listen: false);
    return Provider<HomeBloc>(
      create: (_) => HomeBloc(apiBase: apiBase),
      dispose: (_, bloc) => bloc.dispose(),
      child: Consumer<HomeBloc>(
        builder: (_, bloc, __) => DashboardPage(bloc: bloc),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 100.0, 15.0, 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              color: Colors.amber,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  StreamBuilder<User>(
                    stream: bloc.userStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          !snapshot.hasError &&
                          snapshot.data != null) {
                        return Column(
                          children: [
                            const Text(
                              "POINTS AVAILABLE",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              "${snapshot.data?.points.toStringAsFixed(0) ?? 0.0} PTS",
                              style: const TextStyle(
                                color: Colors.deepOrangeAccent,
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            QrImage(
                              data: snapshot.data?.mobile ?? "",
                              version: QrVersions.auto,
                              size: 200.0,
                            ),
                          ],
                        );
                      }
                      return const CircularProgressIndicator();
                    },
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "TRANSACTIONS",
              style: TextStyle(
                color: Colors.amber,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            StreamBuilder<List<Transaction>>(
              stream: bloc.transactionStream,
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    !snapshot.hasError &&
                    snapshot.data != null) {
                  return Expanded(
                    child: ListItemBuilder<Transaction>(
                      snapshot: snapshot,
                      itemWidgetBuilder: (context, transaction) =>
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: TransactionItem(
                        transaction: transaction,
                      ),
                          ),
                    ),
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<String> getMobile() async {
    String mobile = await SharedPrefs.getStringSharedPreference("mobile");
    debugPrint(mobile);
    return mobile;
  }
}
