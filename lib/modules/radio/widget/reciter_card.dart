import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami/core/app_image/app_image.dart';
import 'package:islami/core/theme/app_colors.dart';
import 'package:islami/modules/data/model/reciters_model.dart';
import 'package:islami/modules/radio/manager/radio_cubit.dart';
import 'package:islami/modules/radio/manager/radio_state.dart';

class ReciteCard extends StatelessWidget {
  const ReciteCard({super.key, required this.radioInfo});
  final ReciterModel radioInfo;

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
          final isCurrentRadio =
              cubit.currentRadioUrl ==
              '${radioInfo.moshaf[0].server}${cubit.suraIndex}.mp3';

          final isPlaying = isCurrentRadio && cubit.isPlaying;
          return Stack(
            alignment: .center,
            children: [
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: isPlaying
                    ? Image.asset(AppImage.soundWave, color: AppColors.gray)
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
                      InkWell(
                        onTap: () {
                          cubit.skipPrevious();
                          cubit.playRadio(
                            '${radioInfo.moshaf[0].server}${cubit.suraIndex}.mp3',
                          );
                        },
                        child: Icon(Icons.skip_previous_rounded, size: 32),
                      ),
                      InkWell(
                        onTap: () {
                          cubit.playRadio(
                            '${radioInfo.moshaf[0].server}${cubit.suraIndex}.mp3',
                          );
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
                          cubit.skipNext();
                          cubit.playRadio(
                            '${radioInfo.moshaf[0].server}${cubit.suraIndex}.mp3',
                          );
                        },
                        child: Icon(Icons.skip_next_rounded, size: 32),
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
