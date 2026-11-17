import 'package:flutter/material.dart';
import 'package:islami/modules/radio/manager/radio_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami/modules/radio/view/radio_view.dart';

class RadioScreen extends StatelessWidget {
  const RadioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RadioCubit>(
      create: (context) => RadioCubit()..getRadio(),

      child: RadioView()
    
    );
  }
}
