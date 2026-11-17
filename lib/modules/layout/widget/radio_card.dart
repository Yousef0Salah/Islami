import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami/core/app_image/app_image.dart';
import 'package:islami/modules/layout/data/model/radio_model.dart';
import 'package:islami/core/theme/app_colors.dart';
import 'package:islami/modules/layout/manager/radio_cubit.dart';
import 'package:islami/modules/layout/manager/radio_state.dart';

class RadioCard extends StatelessWidget {
  const RadioCard({super.key, required this.radioInfo});
  final RadioModel radioInfo;

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<RadioCubit>(context);
    return Container(
      height: 135,
      width: .infinity,
      clipBehavior: .antiAlias,
      decoration: BoxDecoration(
        color: AppColors.gold,
        borderRadius: .circular(12),
      ),
      child: BlocBuilder<RadioCubit, RadioState>(
        builder: (context, state) {
          final isCurrentRadio = cubit.currentRadioUrl == radioInfo.url;

          final isPlaying = isCurrentRadio && cubit.isPlaying;
          final ismute = isCurrentRadio && cubit.isMute;
          return Stack(
            alignment: .center,
            children: [
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: isPlaying
                    ? Image.asset(
                        AppImage.soundWave,
                        color: AppColors.gray,
                       
                      )
                    : Image.asset(AppImage.mosque),
              ),
              Column(
                mainAxisAlignment: .spaceAround,
                children: [
                  Text(
                    radioInfo.name,
                    style: TextStyle(fontWeight: .w800, fontSize: 18),
                  ),
                  Row(
                    mainAxisAlignment: .center,
                    children: [
                      const SizedBox(width: 50),
                      InkWell(
                        onTap: () {
                          cubit.playRadio(radioInfo.url);
                        },
                        child: Icon(
                          isPlaying
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          size: 56,
                        ),
                      ),
                      const SizedBox(width: 12),
                      InkWell(
                        onTap: () {
                          if (cubit.isMute) {
                            cubit.unmute();
                          } else {
                            cubit.mute();
                          }
                        },
                        child: Icon(
                          ismute
                              ? Icons.volume_off_rounded
                              : Icons.volume_up_rounded,
                          size: 32,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
