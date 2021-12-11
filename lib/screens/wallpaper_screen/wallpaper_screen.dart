import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:wallpapernest/configurations/config.dart';
import 'package:wallpapernest/models/wallpaper.dart';
import 'package:wallpapernest/models/wallpaper_arguments.dart';
import 'package:wallpapernest/screens/widgets/back_btn_appbar.dart';

import 'package:wallpapernest/screens/widgets/placeholder_toast.dart';

class WallpaperScreen extends StatefulWidget {
  const WallpaperScreen({Key? key}) : super(key: key);

  static const routeName = '/wallpaper_screen';

  @override
  _WallpaperScreenState createState() => _WallpaperScreenState();
}

class _WallpaperScreenState extends State<WallpaperScreen> {

  bool fullVisible = false;
  String filePath = '';

  Widget moreBtn(var h,var w){
    return GestureDetector(
      onTap: (){
        setState(() {
          fullVisible = !fullVisible;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: h*0.015,horizontal: w*0.1),
        decoration: BoxDecoration(
          boxShadow: shadowList,
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Text('More',style: TextStyle(fontSize: 18,fontFamily: fontExtraBold,color: primaryBlue),),
      ),
    );
  }
  
  Widget downloadApplyBtn(var h,var w,Color bg,Color color,String val,double hPadding){
    return Container(
        padding: EdgeInsets.symmetric(horizontal: hPadding,vertical: h*0.02),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: primaryBlue),
          color: bg,
        ),
        child: Text(val,style: TextStyle(color: color,fontSize: 16,fontFamily: fontBold),),
    );
  }

  void setAsWallPaper(){

  }

  Widget infoContainer(Wallpaper wallpaper,var h,var w){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: w*0.05,vertical: h*0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Text(wallpaper.title[0].toUpperCase()+wallpaper.title.substring(1),style: TextStyle(fontFamily: fontExtraBold,fontSize: 24,color: primaryBlue),),
            SizedBox(height: h*0.02,),
            Text(wallpaper.description[0].toUpperCase()+wallpaper.description.substring(1),style: TextStyle(fontFamily: fontSemiBold,fontSize: 18,color: Colors.grey[500]),softWrap: true,),
            SizedBox(height: h*0.02,),
            Text(wallpaper.userName,style: TextStyle(fontFamily: fontSemiBold,fontSize: 16,color: primaryBlue)),
            Text(wallpaper.date,style: TextStyle(fontFamily: fontSemiBold,fontSize: 14,color: primaryGrey,fontStyle: FontStyle.italic)),
            SizedBox(height: h*0.02,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(onTap: ()async{

                },child: downloadApplyBtn(h, w, Colors.white, primaryBlue, 'Download',w*0.1)),
                GestureDetector(onTap: (){

                },child: downloadApplyBtn(h, w, primaryBlue,Colors.white, 'Apply',w*0.15)),
              ],
            )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    final args = ModalRoute.of(context)!.settings.arguments as WallpaperArguments;
    final Wallpaper wallpaper =args.wallpaper;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //   // height: h,
                    //   decoration: const BoxDecoration(
                    //     color: Colors.transparent,
                    //     borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
                    //   ),
                    //   child: Hero(
                    //     tag: wallpaper.imageURL,
                    //     child: Image.network(wallpaper.regularImageURL,fit: BoxFit.fill,)
                    //   ),
                    // ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      height: fullVisible==true?h*0.7:h,
                      width: w,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15)),
                        child: Hero(
                          tag: wallpaper.imageURL,
                          child: Image.network(wallpaper.regularImageURL,fit: BoxFit.fill,)
                      ),),
                    ),
                    Visibility(visible: fullVisible,child: infoContainer(wallpaper, h, w)),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: w*0.03,),
                    child: BackBtnAppBar(goBack: (){
                      Navigator.pop(context);
                    }),
                  ),
                  const Spacer(),
                  Visibility(visible: !fullVisible,child: moreBtn(h,w)),
                  SizedBox(height: h*0.1,),
                ],
              )
            ],
          ),
      ),
    );
  }
}
