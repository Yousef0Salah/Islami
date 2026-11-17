import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami/core/app_image/app_image.dart';
import 'package:islami/core/theme/app_colors.dart';
import 'package:islami/modules/radio/manager/radio_cubit.dart';
import 'package:islami/modules/radio/manager/radio_state.dart';
import 'package:islami/modules/radio/widget/radio_card.dart';
import 'package:islami/modules/radio/widget/radio_tab_button.dart';
import 'package:islami/modules/radio/widget/reciter_card.dart';

class RadioView extends StatelessWidget {
  const RadioView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RadioCubit, RadioState>(
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
                        RadioTabButton(
                          title: 'Radio',
                          isSelected: cubit.isRadio,
                          onTap: () => cubit.changeTab(true),
                        ),
                        RadioTabButton(
                          title: 'Reciters',
                          isSelected: !cubit.isRadio,
                          onTap: () => cubit.changeTab(false),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    if (state is RadioLoadingState ||
                        state is RecitersLoadingState)
                      const Center(child: CircularProgressIndicator())
                    else
                      Expanded(
                        child: cubit.isRadio
                            ? ListView.separated(
                                itemBuilder: (context, index) {
                                  return RadioCard(
                                    radioInfo: cubit.radioList[index],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: 16);
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
                                  return const SizedBox(height: 16);
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
    );
  }
}
