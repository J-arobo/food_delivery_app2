import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/icon_and_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  _FoodPageBodyState createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
   PageController pageController = PageController(viewportFraction: 0.85);
   var _currPageValue=0.0;
   double _scaleFactor=0.8;
   double _height=220;

   @override
   void initState(){
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue=  pageController.page!;
  
      });
    });
   }

   // disposing the page (when you leave the page it shouldnt be active)
   @override
   void dispose(){
    pageController.dispose();
   }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      child: PageView.builder(
        controller: pageController,
        itemCount: 5,
        itemBuilder: (context, position){
      return _buildPageItem(position);
        }),
    );
  }
      Widget _buildPageItem(int index){
        // using Matrix4 API from flutter (It has 3 coordinates: X,Y & Z)
        Matrix4 matrix = new Matrix4.identity();
        if(index==_currPageValue.floor()){
          var currScale = 1-(_currPageValue-index)*(1-_scaleFactor);
          var currTrans = _height*(1-currScale)/2;
          matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
        }else if(index == _currPageValue.floor()+1){
          var currScale = _scaleFactor+(_currPageValue-index+1)*(1-_scaleFactor);
          var currTrans = _height*(1-currScale)/2;
          matrix = Matrix4.diagonal3Values(1, currScale, 1);
          matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
        
        }else if(index == _currPageValue.floor()-1){
          var currScale = 1-(_currPageValue-index)*(1-_scaleFactor);
          var currTrans = _height*(1-currScale)/2;
          matrix = Matrix4.diagonal3Values(1, currScale, 1);
          matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
        
        }else{
          var currScale=0.8;
          matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height*(1-_scaleFactor)/2, 1);
        }
 
      return Transform(
        transform: matrix,
        child: Stack(
          children: [
            Container(
              height: 220,
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: index.isEven?Color(0xFF69c5df):Color(0xFF9294cc),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                           "assets/image/food1.png"
              )
            )
          ),
        ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 120,
                margin: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
      
                    ),
                    child: Container(
                      padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(text: "Chinese Side"),
                          SizedBox(
                            height: 10,),
                          Row(
                            children: [
                              Wrap(
                                children: List.generate(5, (index) => Icon(Icons.star, color:AppColors.mainColor, size: 15,)
                                ),
                              ),
                                 SizedBox(width: 10,),
                                 SmallText(text: "4.5"),
                                 SizedBox(width: 10,),
                                 SmallText(text: "1287"),
                                 SizedBox(width: 10,),
                                 SmallText(text: "comments")
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              IconandTextWidget(
                                icon: Icons.circle_sharp, 
                                text: "Normal",
                                iconColor: AppColors.iconColor1),
      
                              IconandTextWidget(
                                icon: Icons.location_on, 
                                text: "1.7km",
                                iconColor: AppColors.mainColor),
      
                              IconandTextWidget(
                                icon: Icons.access_time_rounded, 
                                text: "32min",
                                iconColor: AppColors.iconColor2)
                            ],)
                      ]),
                    )
                  ),
            )
          ],
        ),
      );
   }
}