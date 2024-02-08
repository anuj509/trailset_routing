import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parsel_web_optimize/mvp/src/home/model/job_model.dart';
import 'package:parsel_web_optimize/mvp/src/home/provider/home_provider.dart';
import 'package:parsel_web_optimize/utils/utils.dart';

class SelectedVehicleView extends StatelessWidget {
  const SelectedVehicleView(
      {super.key, required this.homeProvider, required this.jobModel});

  final HomeProvider homeProvider;
  final JobModel jobModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              width: 0.5, color: VariableUtilities.theme.color94A0C5),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisSize:
                MainAxisSize.min, // Ensure the row is as small as possible
            children: [
              SvgPicture.asset(
                AssetUtils.smallTruckSvgIcon,
                height: 10,
                width: 21,
              ),
              const SizedBox(width: 5),
              Text(
                jobModel.vehicleName,
                style: FontUtilities.h14(
                  fontColor: VariableUtilities.theme.color292D32,
                ),
              ),
              (jobModel.vehicleQty - 1 != 0)
                  ? Row(
                      children: [
                        const SizedBox(width: 2),
                        Text(
                          '+ ${jobModel.vehicleQty - 1}',
                          style: FontUtilities.h14(
                            fontWeight: FWT.semiBold,
                            fontColor: VariableUtilities.theme.color292D32,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(width: 5),
              InkWell(
                onTap: () async {
                  await homeProvider.removeItemFromSelectedVehicleList(
                      id: jobModel.id, vehicleId: jobModel.vehicleId);
                },
                child: SvgPicture.asset(
                  AssetUtils.cancelSvgIcon,
                  height: 18,
                  width: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
