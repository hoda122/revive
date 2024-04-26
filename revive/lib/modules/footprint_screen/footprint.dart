import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revive/modules/FactoryFootprint/cubit.dart';
import 'package:revive/modules/FactoryFootprint/state.dart';
import 'package:revive/modules/footprint_screen/questions.dart';
import 'package:revive/shared/component/component.dart';
import 'package:revive/shared/network/local/shared_pref.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Footprint extends StatelessWidget {
  const Footprint({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CarbonFactoryCubit()
        ..carbonFactory(
          factSize: sharedPref.getData(key: "factSize"),
          numPeople: sharedPref.getData(key: "numPeople"),
          electricityCons: sharedPref.getData(key: "electricityCons"),
          cleanEnergy: sharedPref.getData(key: "cleanEnergy"),
          numCars: sharedPref.getData(key: "numCars"),
          localProduct: sharedPref.getData(key: "localProducts"),
          buyEnvComp: sharedPref.getData(key: "buyEnv"),
          handleWaste: sharedPref.getData(key: "handleWaste"),
          heating: sharedPref.getData(key: "heating"),
        ),
      child: BlocConsumer<CarbonFactoryCubit, CarbonFactoryStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return state is carbonFactorySuccessState
              ? SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 17,
                      right: 12,
                      left: 12,
                      bottom: 17,
                    ),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(38, 41, 37, 0.29),
                                blurRadius: 15,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.only(
                            top: 20,
                            right: 10,
                            left: 10,
                            bottom: 5,
                          ),
                          child: SfRadialGauge(
                            axes: <RadialAxis>[
                              RadialAxis(
                                minimum: -1500,
                                maximum: 1500,
                                interval: 500,
                                annotations: [
                                  GaugeAnnotation(
                                    widget: Text(
                                      state.carbonFactoryModel.pythonOutput
                                          .toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color:
                                            500 > 0 ? Colors.green : Colors.red,
                                      ),
                                    ),
                                    positionFactor: .5,
                                    angle: 90,
                                  ),
                                ],
                                pointers: <GaugePointer>[
                                  NeedlePointer(
                                    value: double.tryParse(state
                                                .carbonFactoryModel
                                                .pythonOutput!)! !=
                                            null
                                        ? double.tryParse(state
                                            .carbonFactoryModel.pythonOutput!)!
                                        : 0,
                                    enableAnimation: true,
                                  ),
                                ],
                                ranges: [
                                  GaugeRange(
                                    startValue: 0,
                                    endValue: 1500,
                                    color: Colors.green,
                                  ),
                                  GaugeRange(
                                    startValue: 0,
                                    endValue: -500,
                                    color: Colors.orange,
                                  ),
                                  GaugeRange(
                                    startValue: -500,
                                    endValue: -1500,
                                    color: Colors.red,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          height: 50,
                          width: 300,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(106, 192, 66, 1),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(38, 41, 37, 0.29),
                                blurRadius: 15,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              navigate(context, Questions());
                            },
                            child: Text(
                              // "${getLang(context, "calculate")}",
                              "Calculate",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 180,
                                child: Image.asset(
                                  "assets/images/happyEarth.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(38, 41, 37, 0.29),
                                      blurRadius: 1,
                                      offset: Offset(0, 1),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.only(
                                    top: 18, left: 10, right: 10, bottom: 10),
                                child: Text(
                                  "Well done ! You are offsetting 500 kgCO2",
                                  style: TextStyle(
                                    fontFamily: "Body",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                  color: Colors.green,
                ));
        },
      ),
    );
  }
}
