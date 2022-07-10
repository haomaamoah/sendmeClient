import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../model/const.dart';

class AnimatedRiderLogo extends StatefulWidget{
  AnimatedRiderLogo({Key? key}) : super(key: key);

  @override
  State<AnimatedRiderLogo> createState() => _AnimatedRiderLogoState();
}

class _AnimatedRiderLogoState extends State<AnimatedRiderLogo> with TickerProviderStateMixin{
  double breathingValue = 0;
  late AnimationController breathingController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    breathingController = AnimationController(vsync: this,duration: Duration(seconds: 1));
    breathingController
      ..addStatusListener((status) {
        switch (status){
          case AnimationStatus.dismissed:
            breathingController.forward();
            break;
          case AnimationStatus.completed:
            breathingController.reverse();
            break;
          case AnimationStatus.forward: break;
          case AnimationStatus.reverse: break;
        }
      })
      ..addStatusListener((status)=>setState(()=>breathingValue = breathingController.value));
    breathingController.forward();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    breathingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double riderImageSize = MediaQuery.of(context).size.width*0.6 - 10 * breathingValue;


    return AnimatedContainer(
      width: riderImageSize,
      height: riderImageSize,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(Constants.imageIndex["riderSplash"] as String)
          )
      ), duration: Duration(seconds: 1),
    );
  }
}



class RotatingDeliveryOptionIcon extends HookWidget {
  late final String image, subtitle;late final Color color;
  RotatingDeliveryOptionIcon({Key? key, required String image, required String subtitle, required Color color}){
    this.image = image; this.subtitle = subtitle; this.color = color;
  }


  @override
  Widget build(BuildContext context) {
    AnimationController rotationController = useAnimationController(duration: Duration(seconds: 10));
    rotationController.repeat();
    return Column(
      children: [
        Stack(
          children: [
            AnimatedBuilder(
              animation: rotationController,
              builder: (BuildContext context,widget)=> Transform.rotate(angle: rotationController.value*60,child: widget,),
              child: Align(
                alignment:Alignment.center,
                child: ClipOval(
                  child: Container(
                    height: 70,width: 70,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: <Color>[
                              color,
                              Colors.white
                            ])
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                  alignment: Alignment.center,
                  child: Container(
                      height: 60,width:60,
                      child: ClipOval(
                        child: Image.asset(image,fit: BoxFit.contain,),
                      )
                  )
              ),
            )
          ],
        ),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'narrowmedium',
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

