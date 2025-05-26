import 'package:flutter/material.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:laundry/utils/colors.dart';

class StepperPage extends StatefulWidget {
  final int activeStep;
  const StepperPage({super.key, required this.activeStep});

  @override
  State<StepperPage> createState() => _StepperPageState();
}

class _StepperPageState extends State<StepperPage> {
  @override
  Widget build(BuildContext context) {
    return EasyStepper(
      padding: EdgeInsets.zero,
      activeStep: widget.activeStep,
      lineStyle: const LineStyle(
        lineLength: 55,
        lineType: LineType.normal,
        lineThickness: 2,
        lineSpace: 1,
        lineWidth: 10,
        unreachedLineType: LineType.dashed,
        defaultLineColor: MyColors.primary,
        unreachedLineColor: MyColors.notionBgBlue,
      ),
      activeStepTextColor: Colors.black87,
      finishedStepTextColor: MyColors.primary,
      internalPadding: 0,
      showLoadingAnimation: false,
      stepRadius: 10,
      showStepBorder: false,
      steps: [
        EasyStep(
          customStep: CircleAvatar(
            child: CircleAvatar(
              backgroundColor:
                  widget.activeStep == 0 ? Colors.red : MyColors.notionBgBlue,
            ),
          ),
          title: 'Menunggu',
        ),
        EasyStep(
          customStep: GestureDetector(
            onTap: () {
              print('tap');
            },
            child: CircleAvatar(
              child: CircleAvatar(
                backgroundColor:
                    widget.activeStep == 1 ? Colors.red : MyColors.notionBgBlue,
              ),
            ),
          ),
          title: 'Cuci',
          topTitle: true,
        ),
        EasyStep(
          customStep: CircleAvatar(
            child: CircleAvatar(
              backgroundColor:
                  widget.activeStep == 2 ? Colors.red : MyColors.notionBgBlue,
            ),
          ),
          title: 'Pengeringan',
        ),
        EasyStep(
          customStep: CircleAvatar(
            child: CircleAvatar(
              backgroundColor:
                  widget.activeStep == 3 ? Colors.red : MyColors.notionBgBlue,
            ),
          ),
          title: 'Setrika',
          topTitle: true,
        ),
        EasyStep(
          customStep: CircleAvatar(
            child: CircleAvatar(
              backgroundColor:
                  widget.activeStep == 4 ? Colors.red : MyColors.notionBgBlue,
            ),
          ),
          title: 'Selesai',
          topTitle: true,
        ),
      ],
    );
  }
}
