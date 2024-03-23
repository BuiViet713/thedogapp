import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:thedogapi/Cofig/assets.dart';
import 'package:thedogapi/Cofig/shared/render_assets.dart';
import 'package:thedogapi/core/utls/helper_functions/functions.dart';

class ImageLoader extends StatelessWidget {
  final double? width;
  final double? height;
  const ImageLoader({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!, // Light gray
      highlightColor: Colors.grey[100]!, // Even lighter gray
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.grey[300], // The shimmer color
        ),
      ),
    );
  }
}

//genral loader

class PawsWidgetLoader extends StatelessWidget {
  const PawsWidgetLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DogWidgetsRenderLottie(
          lottiePath: loaderLottie,
          isContinous: true,
        ),
        addVerticalSpacing(15),
        const Text("Loading....Please wait"),
      ],
    );
  }
}
//error widget

class PawsWidgetErrorWidget extends StatelessWidget {
  const PawsWidgetErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const DogWidgetsRenderLottie(
      lottiePath: errorLottie,
      isContinous: true,
    );
  }
}
