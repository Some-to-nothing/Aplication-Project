import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../start/start_page.dart';



class WelcomePage extends StatefulWidget {

  const WelcomePage({
    super.key,
  });


  @override
  State<WelcomePage> createState() =>
      _WelcomePageState();

}






class _WelcomePageState
    extends State<WelcomePage>
    with SingleTickerProviderStateMixin {



  late AnimationController controller;

  late Animation<double> fadeAnimation;

  late Animation<double> scaleAnimation;





  @override
  void initState() {

    super.initState();



    controller = AnimationController(

      duration:
      const Duration(seconds: 2),

      vsync:
      this,

    );



    fadeAnimation = Tween<double>(

      begin:
      0,

      end:
      1,

    ).animate(

      CurvedAnimation(

        parent:
        controller,

        curve:
        Curves.easeIn,

      ),

    );





    scaleAnimation = Tween<double>(

      begin:
      0.7,

      end:
      1,

    ).animate(

      CurvedAnimation(

        parent:
        controller,

        curve:
        Curves.easeOutBack,

      ),

    );




    controller.forward();



    Timer(

      const Duration(
        seconds:3,
      ),

      () {


        if(!mounted) return;



        Navigator.pushReplacement(

          context,

          MaterialPageRoute(

            builder: (_)=>

            const StartPage(),

          ),

        );


      },

    );


  }







  @override
  void dispose() {

    controller.dispose();

    super.dispose();

  }








  @override
  Widget build(BuildContext context) {


    return Scaffold(


      backgroundColor:
      Colors.black,



      body:

      Center(


        child:

        FadeTransition(


          opacity:
          fadeAnimation,



          child:

          ScaleTransition(


            scale:
            scaleAnimation,



            child:

            Column(


              mainAxisAlignment:
              MainAxisAlignment.center,



              children: [





                Image.asset(

                  "assets/images/logo/remindus_logo.jpeg",

                  width:
                  150,

                  height:
                  150,

                ),





                const SizedBox(

                  height:35,

                ),






                Text(


                  "Welcome to RemindUs",



                  textAlign:
                  TextAlign.center,



                  style:

                  GoogleFonts.cinzelDecorative(



                    color:
                    Colors.white,



                    fontSize:
                    32,



                    fontWeight:
                    FontWeight.bold,



                    letterSpacing:
                    2,



                  ),


                ),






                const SizedBox(

                  height:15,

                ),






                Text(


                  "Never Miss What Matters",



                  style:

                  GoogleFonts.ebGaramond(



                    color:
                    Colors.white70,



                    fontSize:
                    22,



                  ),



                ),







                const SizedBox(

                  height:8,

                ),






                Text(


                  "Smart Reminder for Your Daily Life",



                  style:

                  GoogleFonts.ebGaramond(



                    color:
                    Colors.white54,



                    fontSize:
                    18,



                  ),



                ),







                const SizedBox(

                  height:50,

                ),







                Text(


                  "© RemindUs\nSoftware Engineering (RPL) XII",



                  textAlign:
                  TextAlign.center,



                  style:

                  const TextStyle(



                    color:
                    Colors.white38,



                    fontSize:
                    13,



                  ),



                ),




              ],


            ),


          ),


        ),


      ),


    );


  }


}