import 'package:flutter/material.dart';
import 'package:islami/core/app_image/app_image.dart';
import 'package:islami/core/theme/app_colors.dart';
import 'package:islami/modules/layout/manager/radio_cubit.dart';
import 'package:islami/modules/layout/manager/radio_state.dart';
import 'package:islami/modules/layout/widget/radio_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami/modules/layout/widget/reciter_card.dart';

class RadioScreen extends StatefulWidget {
  const RadioScreen({super.key});

  @override
  State<RadioScreen> createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  bool isRadio = true;



  @override
  Widget build(BuildContext context) {
    return BlocProvider<RadioCubit>(
      create: (context) => RadioCubit(),

      child: BlocBuilder<RadioCubit, RadioState>(
        builder: (context, state) {
          var cubit = BlocProvider.of<RadioCubit>(context);
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImage.radioBg),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  end: .bottomCenter,
                  colors: [
                    AppColors.black.withValues(alpha: 0.7),
                    AppColors.black,
                  ],
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Image.asset(AppImage.homeLogo, width: 300),
                      const SizedBox(height: 50),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                cubit.getRadio();
                                isRadio = true;
                                setState(() {});
                              },
                              child: Container(
                                padding: .all(8),
                                decoration: BoxDecoration(
                                  color: isRadio
                                      ? AppColors.gold
                                      : AppColors.black.withValues(alpha: 0.7),
                                  borderRadius: .circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    'Radio',
                                    style: TextStyle(
                                      fontWeight: .bold,
                                      color: isRadio ? null : Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                cubit.getReciter();
                                isRadio = false;
                                setState(() {});
                              },
                              child: Container(
                                padding: .all(8),
                                decoration: BoxDecoration(
                                  color: isRadio
                                      ? AppColors.black.withValues(alpha: 0.7)
                                      : AppColors.gold,
                                  borderRadius: .circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    'Reciters',
                                    style: TextStyle(
                                      fontWeight: .bold,
                                      color: isRadio
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: isRadio
                            ? ListView.separated(
                                itemBuilder: (context, index) {
                                  return RadioCard(
                                    radioInfo: cubit.radioList[index],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(height: 16);
                                },
                                itemCount: cubit.radioList.length,
                              )
                            : ListView.separated(
                                itemBuilder: (context, index) {
                                  return ReciteCard(
                                    radioInfo: cubit.reciterList[index],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(height: 16);
                                },
                                itemCount: cubit.reciterList.length,
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
