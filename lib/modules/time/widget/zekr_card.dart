import 'package:flutter/material.dart';
import 'package:islami/core/theme/app_colors.dart';
import 'package:islami/core/theme/app_text.dart';
import 'package:islami/modules/time/data/model/azkar_model.dart';

class ZekrCard extends StatefulWidget {
  const ZekrCard({super.key, required this.zekrInfo});
  final Zekr zekrInfo;
  @override
  State<ZekrCard> createState() => _ZekrCardState();
}

class _ZekrCardState extends State<ZekrCard> {
  late int count = widget.zekrInfo.count;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .all(12),
      width: .infinity,
      decoration: BoxDecoration(
        border: BoxBorder.all(color: AppColors.gold, width: 2),
        borderRadius: .circular(16),
      ),
      child: Column(
        textDirection: .rtl,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.zekrInfo.content,
            style: AppText.s20wB,
            textDirection: .rtl,
            textAlign: .center,
          ),
          Visibility(
            visible: widget.zekrInfo.description.isNotEmpty,
            child: Column(
              children: [
                Divider(),
                Text(
                  widget.zekrInfo.description,
                  style: AppText.s18wB,
                  textDirection: .rtl,
                  textAlign: .center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: .circular(8)),
              backgroundColor: AppColors.gold,
              foregroundColor: AppColors.black,
            ),

            onPressed: () {
              if (count > 1) {
                count--;
              } else {
                count = widget.zekrInfo.count;
              }

              setState(() {});
            },
            child: Center(
              child: Text(
                '$count',
                style: TextStyle(fontSize: 32, fontWeight: .w900),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
