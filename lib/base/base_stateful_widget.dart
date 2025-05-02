import 'package:car_on_sale_challenge/business_layer/module_configurator.dart';
import 'package:car_on_sale_challenge/presentation_layer/constants/app_colors.dart';
import 'package:car_on_sale_challenge/presentation_layer/helpers/loading_dialog.dart';
import 'package:flutter/material.dart';

abstract class BaseStatefulWidget extends StatefulWidget {
  const BaseStatefulWidget({super.key});
}

abstract class BaseState<T extends BaseStatefulWidget> extends State<T> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ModuleConfigurator(context).configureDrawer(),
      builder: (context, snapshot) {
        return PopScope(
          child: Scaffold(
            key: _scaffoldKey,
            endDrawer: snapshot.data,
            floatingActionButton: getFloatingActionButton(),
            appBar: getAppbar(),
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: getBody(context),
              ),
            ),
            bottomNavigationBar: getBottomNavigationBar(),
          ),
        );
      },
    );
  }

  Widget getBottomNavigationBar() => SizedBox.shrink();

  String getTitle() {
    return '';
  }

  Widget getFloatingActionButton() => SizedBox.shrink();

  PreferredSizeWidget getAppbar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: mainColor,
      foregroundColor: whiteColor,
      title: Text(getTitle()),
    );
  }

  void showSnack(String msg, {VoidCallback? handler, String? actionTitle}) {
    final currentContext = _scaffoldKey.currentContext;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        action:
            handler == null
                ? null
                : SnackBarAction(label: actionTitle ?? '', onPressed: handler),
      ),
    );
  }

  Widget getBody(BuildContext context);
}
