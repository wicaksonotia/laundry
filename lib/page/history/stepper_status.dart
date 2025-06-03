import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:laundry/controllers/history_controller.dart';
import 'package:laundry/utils/colors.dart';
import 'package:laundry/utils/sizes.dart';

class StepperStatus extends StatefulWidget {
  final dynamic transaction;
  final HistoryController historyController;
  const StepperStatus({
    super.key,
    required this.transaction,
    required this.historyController,
  });

  @override
  State<StepperStatus> createState() => _StepperStatusState();
}

class _StepperStatusState extends State<StepperStatus> {
  final List<String> steps = ['Antri', 'Proses', 'Selesai', 'Diambil'];
  late int initialStep = 0;

  @override
  void initState() {
    super.initState();
    initialStep = 0;
    if (widget.transaction.delivering == true) {
      initialStep = 3;
    } else if (widget.transaction.completed == true) {
      initialStep = 2;
    } else if (widget.transaction.washing == true) {
      initialStep = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            'Status',
            style: TextStyle(
              fontSize: MySizes.fontSizeMd,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        EasyStepper(
          padding: EdgeInsets.zero,
          activeStep: initialStep,
          lineStyle: const LineStyle(
            lineLength: 50,
            lineType: LineType.normal,
            lineThickness: 2,
            lineSpace: 1,
            lineWidth: 10,
            unreachedLineType: LineType.dashed,
            defaultLineColor: MyColors.primary,
            unreachedLineColor: MyColors.notionBgBlue,
          ),
          showLoadingAnimation: false,
          stepShape: StepShape.rRectangle,
          stepBorderRadius: 10,
          borderThickness: 2,
          stepRadius: 20,
          internalPadding: 0,
          showStepBorder: true,
          activeStepBackgroundColor: MyColors.primary,
          activeStepBorderColor: MyColors.primary,
          activeStepTextColor: Colors.white,

          finishedStepTextColor: Colors.white,
          finishedStepBorderColor: MyColors.primary,
          finishedStepBackgroundColor: MyColors.notionBgBlue,
          steps: [
            ...steps.asMap().entries.map((entry) {
              String label = entry.value;
              return EasyStep(
                customStep: InkWell(
                  onTap: () {
                    setState(() {
                      if (entry.key > initialStep) {
                        initialStep = entry.key;
                        widget.historyController.updateStatus(
                          widget.transaction.id,
                          initialStep,
                        );
                        widget.historyController.fetchData();
                      }
                    });
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      child: Text(
                        '${entry.key + 1}',
                        style: TextStyle(
                          color:
                              initialStep == entry.key
                                  ? Colors.white
                                  : Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                customTitle: Text(label, textAlign: TextAlign.center),
              );
            }),
          ],
        ),
      ],
    );
  }
}
