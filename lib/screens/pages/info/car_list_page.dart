import 'package:flutter/material.dart';
import 'package:lamborghini/blocs/categories_bloc.dart';
import 'package:lamborghini/model/car.dart';
import 'package:lamborghini/model/list_item_builder.dart';
import 'package:lamborghini/model/parent.dart';
import 'package:lamborghini/screens/components/app_bar_text_component.dart';
import 'package:lamborghini/screens/components/car_item.dart';
import 'package:lamborghini/screens/pages/info/car_detail_page.dart';
import 'package:lamborghini/services/network/api.dart';
import 'package:provider/provider.dart';

class CarList extends StatefulWidget {
  const CarList({Key? key, required this.bloc, required this.parent})
      : super(key: key);
  final CategoriesBloc bloc;
  final Parent parent;

  static Widget create(BuildContext context, Parent parent) {
    final apiBase = Provider.of<ApiBase>(context, listen: false);
    return Provider<CategoriesBloc>(
      create: (_) => CategoriesBloc(apiBase: apiBase),
      dispose: (_, bloc) => bloc.dispose(),
      child: Consumer<CategoriesBloc>(
        builder: (_, bloc, __) => CarList(
          bloc: bloc,
          parent: parent,
        ),
      ),
    );
  }

  @override
  _CarListState createState() => _CarListState();
}

class _CarListState extends State<CarList> {
  @override
  void initState() {
    super.initState();
    widget.bloc.getCars(widget.parent.parentModelName);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Car>>(
      stream: widget.bloc.carStream,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: AppBarTextComponent(
              text: widget.parent.parentModelName,
            ),
          ),
          backgroundColor: Colors.black,
          body: ListItemBuilder<Car>(
            snapshot: snapshot,
            itemWidgetBuilder: (context, car) => CarItem(
              car: car,
              onPress: () => navigateToCarDetailScreen(
                context,
                car,
              ),
            ),
          ),
        );
      },
    );
  }

  void navigateToCarDetailScreen(BuildContext context, Car car) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => CarDetail(car: car),
    ));
  }
}
