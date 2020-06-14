import 'package:flutter/material.dart';
import 'package:flutter_chat_app/ui/views/startup/startup_viewmodel.dart';
import 'package:stacked/stacked.dart';

class StartupView extends StatelessWidget {
  const StartupView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupViewModel>.reactive(
      onModelReady: (model) => model.handleStartUpLogic(),
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: Text('Start up view'),
        ),
      ),
      viewModelBuilder: () => StartupViewModel(),
    );
  }
}
