import 'package:flutter/material.dart';

import '../../model/const.dart';

AnimatedContainer animatedRiderLogo ({required double animatedRiderSize,required double riderImageSize}){
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



Column rotatingDeliveryOption({required String image,required String subtitle,required AnimationController controller,required Color color}){

  return Column(
    children: [
      Stack(
        children: [
          AnimatedBuilder(
            animation: controller,
            builder: (BuildContext context,widget)=> Transform.rotate(angle: controller.value*60,child: widget,),
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
