import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../theme/primary_theme.dart';
import '../home_page/home_bloc.dart';
import '../home_page/home_provider.dart';

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final materialApp = MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "AtlasTask",
      theme: PrimaryTheme.generateTheme(context),
      home: HomeProvider(),
    );

    return MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<HomeBloc>(create: (context) => HomeBloc(context)),
      ],
      child: materialApp,
    );
  }
}
