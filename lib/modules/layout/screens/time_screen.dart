import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami/core/app_image/app_image.dart';
import 'package:islami/core/theme/app_colors.dart';
import 'package:islami/core/theme/app_text.dart';
import 'package:islami/modules/layout/manager/time_cubit.dart';
import 'package:islami/modules/layout/manager/time_state.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TimeScreen extends StatelessWidget {
  const TimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TimeCubit>(
      create: (context) => TimeCubit()..getTime(),

      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(AppImage.timeBg)),
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              end: .bottomCenter,
              colors: [AppColors.black.withValues(alpha: 0.7), AppColors.black],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Image.asset(AppImage.homeLogo, width: 300),
                  const SizedBox(height: 18),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xff856B3F),
                      borderRadius: .circular(40),
                    ),
                    child: Container(
                      width: .infinity,

                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppImage.timeRect),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: BlocBuilder<TimeCubit, TimeState>(
                        builder: (context, state) {
                          final cubit = context.read<TimeCubit>();

                          if (state is TimeErrorState) {
                            return Center(
                              child: Text(state.message, style: AppText.s24wB),
                            );
                          }

                          final isLoading = state is TimeLoadingState;
                          final data = state is TimeSuccessState
                              ? cubit.allData
                              : null;

                          return Skeletonizer(
                            enabled: isLoading,
                            effect: ShimmerEffect(
                              baseColor: const Color(0xff3A3025),
                              highlightColor: const Color(0xff856B3F),
                              duration: const Duration(milliseconds: 1500),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          data?.greg ?? '16 Jul\n2024',
                                          style: AppText.s16wB.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          children: [
                                            Text(
                                              'Pray Time',
                                              style: AppText.s20wB.copyWith(
                                                color: AppColors.black,
                                              ),
                                            ),
                                            Text(
                                              data?.weekday ?? 'Monday',
                                              style: AppText.s20wB.copyWith(
                                                color: AppColors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          '09 Muh\n1446',
                                          textAlign: TextAlign.right,
                                          style: AppText.s16wB.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 28,
                                  ),
                                  child: CarouselSlider.builder(
                                    itemCount: data?.listSalah.length ?? 5,
                                    itemBuilder: (context, index, realIndex) {
                                      final prayer = data?.listSalah[index];

                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 16,
                                        ),
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Color(0xff202020),
                                              Color(0xffB19768),
                                            ],
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              prayer?.name ?? 'Fajr',
                                              style: AppText.s16wB.copyWith(
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              prayer?.time ?? '05:30',
                                              style: AppText.s36wB,
                                            ),
                                            Text(
                                              prayer?.pmAm ?? 'AM',
                                              style: AppText.s16wB.copyWith(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    options: CarouselOptions(
                                      aspectRatio: 5 / 2,
                                      viewportFraction: 0.33,
                                      initialPage: 0,
                                      enableInfiniteScroll: true,
                                      enlargeCenterPage: true,
                                      enlargeFactor: 0.19,
                                    ),
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Next Pray - 02:32',
                                      style: AppText.s16wB,
                                    ),
                                    const Icon(Icons.volume_up_rounded),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        'Azkar',
                        style: AppText.s18wB.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: .symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.gold, width: 2),
                            borderRadius: .circular(20),
                          ),
                          child: Column(
                            children: [
                              Image.asset(AppImage.eveningAzkar),
                              const SizedBox(height: 8),
                              Text('Evening Azkar', style: AppText.s20wB),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: .symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.gold, width: 2),
                            borderRadius: .circular(20),
                          ),
                          child: Column(
                            children: [
                              Image.asset(AppImage.morningAzkar),
                              const SizedBox(height: 8),
                              Text('Morning Azkar', style: AppText.s20wB),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
