import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soiree/style/colors.dart';

import 'package:soiree/widget/stepper/stepper.dart' as CustomStepper;

/**
 *  WIDGET Pour la création de multistep form
 */
class StepperBuilder extends StatefulWidget {
  final Function? onSubmit;
  final List<GlobalKey<FormState>> listStepKey;
  final List<Map<String, Widget>> listSteps;
  const StepperBuilder(
      {super.key,
      this.onSubmit,
      required this.listStepKey,
      required this.listSteps});

  @override
  StepperBuilderState createState() {
    return StepperBuilderState();
  }
}

class StepperBuilderState extends State<StepperBuilder> {
  int _currentStep = 0;
  List<bool> _hasStepError = [];
  @override
  void initState() {
    //Création de la liste d'erreur pour chaque step
    _hasStepError = List.generate(widget.listStepKey.length, (index) => false);
    super.initState();
  }

  // Retourne l'état du step en cours
  CustomStepper.StepState getStateOfStep(int step) {
    CustomStepper.StepState current = CustomStepper.StepState.disabled;
    if (_currentStep >= step && !_hasStepError[step]) {
      current = CustomStepper.StepState.complete;
    }

    if (_hasStepError[step]) {
      current = CustomStepper.StepState.error;
    }

    return current;
  }

  void validateStep() {
    if (_currentStep >= 0 &&
        widget.listStepKey[_currentStep].currentState!.validate()) {
      needSubmit();
    } else {
      setState(() {
        _hasStepError[_currentStep] = true;
      });
    }
  }

  void needSubmit() {
    if (isLastStep()) {
      widget.onSubmit!();
    } else {
      setState(() {
        _hasStepError[_currentStep] = false;
        _currentStep += 1;
      });
    }
  }

  bool isLastStep() {
    return _currentStep == widget.listStepKey.length - 1;
  }

  List<CustomStepper.Step> buildSteps() {
    List<CustomStepper.Step> steps = widget.listSteps.map((e) {
      return CustomStepper.Step(
          title: Text(e.keys.first),
          isActive: _currentStep >= 0,
          state: getStateOfStep(widget.listSteps.indexOf(e)),
          content: Container(
            child: e.values.first,
          ));
    }).toList();

    return steps;
  }

  @override
  Widget build(BuildContext context) {
    const OutlinedBorder buttonShape = RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)));
    const EdgeInsets buttonPadding = EdgeInsets.symmetric(horizontal: 25.0);

    return Theme(
      data: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: primaryColor,
              )),
      child: Container(
        height: 500,
        child: CustomStepper.Stepper(
            currentStep: _currentStep,
            type: CustomStepper.StepperType.horizontal,
            physics: ScrollPhysics(),
            onStepCancel: () {
              if (_currentStep > 0) {
                setState(() {
                  _currentStep -= 1;
                });
              }
            },
            onStepContinue: validateStep,
            //Mise à jour de l'état courant
            onStepTapped: (int index) {
              setState(() {
                _currentStep = index;
              });
            },
            controlsBuilder:
                (BuildContext context, CustomStepper.ControlsDetails details) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: 0,
                    height: 60,
                  ),
                  _currentStep != 0
                      ? Flexible(
                          child: TextButton(
                          onPressed: details.onStepCancel,
                          child: Flexible(
                              child: const Text('Précédent',
                                  style: TextStyle(color: primaryTextColor))),
                        ))
                      : Ink(),
                  Flexible(
                      child: TextButton(
                    onPressed: details.onStepContinue,
                    style: ButtonStyle(
                      backgroundColor: !isLastStep()
                          ? MaterialStateProperty.all<Color>(primaryColor)
                          : MaterialStateProperty.all<Color>(Colors.green),
                      padding:
                          const MaterialStatePropertyAll<EdgeInsetsGeometry>(
                              buttonPadding),
                      shape: const MaterialStatePropertyAll<OutlinedBorder>(
                          buttonShape),
                    ),
                    child: !isLastStep()
                        ? const Text(
                            'Suivant',
                            style: TextStyle(color: Colors.white),
                          )
                        : Flexible(
                            child: const Text('Créer votre évènement',
                                style: TextStyle(color: Colors.white))),
                  )),
                ],
              );
            },
            steps: buildSteps()),
      ),
    );
  }
}
