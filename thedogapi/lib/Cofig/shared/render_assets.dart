import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class DogWidgetsRenderSvg extends StatelessWidget {
  final String svgPath;
  final Color? color;
  final double? height;

  const DogWidgetsRenderSvg(
      {super.key, required this.svgPath, this.color, this.height});

  @override
  Widget build(BuildContext context) {
    if (color == null) {
      return SvgPicture.asset(
        svgPath,
      );
    } else {
      return SvgPicture.asset(
        svgPath,

        // ignore: deprecated_member_use
        color: color,
      );
    }
  }
}

//image path

class DogWidgetsRenderAssetImage extends StatelessWidget {
  final String imagePath;
  final BoxFit? fit;
  final double? width;
  final double? height;

  const DogWidgetsRenderAssetImage(
      {super.key, required this.imagePath, this.fit, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    if (width != null && height != null) {
      return Image.asset(
        imagePath,
        fit: fit ?? BoxFit.cover,
      );
    } else {
      return Image.asset(
        imagePath,
        fit: fit ?? BoxFit.cover,
        width: width,
        height: height,
      );
    }
  }
}

//write an extension of the add function in the List class that also adds to the list
//render lottie files
class DogWidgetsRenderLottie extends StatefulWidget {
  final String lottiePath;
  final bool isContinous;
  final double? width;
  final double? height;
  const DogWidgetsRenderLottie(
      {super.key,
      required this.lottiePath,
      this.isContinous = false,
      this.width,
      this.height});

  @override
  State<DogWidgetsRenderLottie> createState() =>
      _DogWidgetsRenderLottieState();
}

class _DogWidgetsRenderLottieState extends State<DogWidgetsRenderLottie>
    with TickerProviderStateMixin {
  late AnimationController _lottieController;

  @override
  void initState() {
    super.initState();

    _lottieController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _lottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(widget.lottiePath,
        controller: _lottieController,
        repeat: widget.isContinous,
        reverse: widget.isContinous,
        width: widget.width,
        height: widget.height,
        animate: widget.isContinous, onLoaded: (composition) {
      _lottieController.duration = composition.duration;
      _lottieController.forward();
      _lottieController.addStatusListener((status) async {
        if (status == AnimationStatus.completed) {
          if (widget.isContinous == true) {
            _lottieController.repeat();
          }
        }
      });
    });
  }
}
