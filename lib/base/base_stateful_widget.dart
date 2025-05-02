import 'package:car_on_sale_challenge/presentation_layer/constants/app_colors.dart';
import 'package:car_on_sale_challenge/presentation_layer/helpers/loading_dialog.dart';
import 'package:flutter/material.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

abstract class BaseStatefulWidget extends StatefulWidget {
  const BaseStatefulWidget({super.key});
}

abstract class BaseState<T extends BaseStatefulWidget> extends State<T> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
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
  }

  Future<void> showAppDialog(
    String title,
    String errorMessage, {
    VoidCallback? okAction,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Stack(
            children: <Widget>[
              Positioned(
                left: 0,
                child: InkWell(
                  child: Icon(Icons.close),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Center(child: Text(title, textAlign: TextAlign.center)),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(child: Text(errorMessage, textAlign: TextAlign.center)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                      ),
                      child: Text('ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        if (okAction != null) {
                          okAction();
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
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
      leading: BackButton(),
      backgroundColor: mainColor,
      title: Text(getTitle()),
    );
  }

  Widget getBody(BuildContext context);
  LoadingDialog? loadingDialog;

  hideDialog() {
    if (loadingDialog != null) {
      Navigator.of(context).pop();
      loadingDialog = null;
    }
  }

  void showLoadingDialog() async {
    loadingDialog = loadingDialog ?? LoadingDialog();
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => loadingDialog ?? SizedBox.shrink(),
    );
  }
}
