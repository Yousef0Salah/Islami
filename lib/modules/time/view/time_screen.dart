import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami/core/service/prayer_settings_service.dart';
import 'package:islami/modules/time/manager/time_cubit.dart';
import 'package:islami/modules/time/view/time_view.dart';

class TimeScreen extends StatelessWidget {
  const TimeScreen({super.key});
  @override
  Widget build(BuildContext context) {
  
    
    return BlocProvider<TimeCubit>(
      create: (context) => TimeCubit(PrayerSettingsService.instance)..getTime(),

      child: const TimeView()
    
    );
  }
}
