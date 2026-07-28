import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/asset_config.dart';
import '../../services/storage_service.dart';
import '../home/home_page.dart';



class OnboardingPage extends StatefulWidget {

  const OnboardingPage({
    super.key,
  });


  @override
  State<OnboardingPage> createState() =>
      _OnboardingPageState();

}





class _OnboardingPageState
    extends State<OnboardingPage> {


  final PageController controller =
      PageController();


  int currentPage = 0;



  final List<Map<String,String>> pages = [


    {

      "image":
      AssetConfig.onboardingSky,


      "title":
      "Selamat Datang",


      "desc":
      "Mulai perjalananmu mengatur waktu bersama PROKELOM.",

    },



    {

      "image":
      AssetConfig.onboardingGrass,


      "title":
      "Susun Harimu",


      "desc":
      "Buat jadwal, simpan rencana, dan jangan lewatkan momen penting.",

    },



    {

      "image":
      AssetConfig.onboardingSpace,


      "title":
      "Reminder Pintar",


      "desc":
      "Alarm dan kalender dalam satu tempat.",

    },


  ];







  Future<void> finish() async {


    await StorageService.completeOnboarding();


    if(!mounted)return;



    Navigator.pushReplacement(

      context,

      MaterialPageRoute(

        builder: (_) =>
        const HomePage(),

      ),

    );


  }








  @override
  Widget build(BuildContext context) {


    return Scaffold(


      body: Stack(


        children: [



          PageView.builder(


            controller:
            controller,


            itemCount:
            pages.length,



            onPageChanged:
                (index){


              setState(() {

                currentPage =
                    index;

              });


            },



            itemBuilder:
                (context,index){



              final data =
              pages[index];



              return Stack(



                fit:
                StackFit.expand,



                children: [



                  Image.asset(



                    data["image"]!,


                    fit:
                    BoxFit.cover,


                  ),




                  Container(



                    color:
                    Colors.black45,



                  ),






                  Padding(



                    padding:
                    const EdgeInsets.all(30),



                    child:
                    Column(



                      mainAxisAlignment:
                      MainAxisAlignment.center,



                      children: [





                        const Spacer(),







                        Text(



                          data["title"]!,



                          textAlign:
                          TextAlign.center,



                          style:
                          GoogleFonts.cinzelDecorative(



                            color:
                            Colors.white,



                            fontSize:
                            38,



                            fontWeight:
                            FontWeight.bold,



                            letterSpacing:
                            2,



                            shadows: const [



                              Shadow(



                                blurRadius:
                                8,



                                color:
                                Colors.black87,



                                offset:
                                Offset(2,2),



                              ),



                            ],



                          ),



                        ),







                        const SizedBox(
                          height:20,
                        ),







                        Text(



                          data["desc"]!,



                          textAlign:
                          TextAlign.center,



                          style:
                          GoogleFonts.ebGaramond(



                            color:
                            Colors.white,



                            fontSize:
                            22,



                            fontWeight:
                            FontWeight.w500,



                            height:
                            1.5,



                            shadows: const [



                              Shadow(



                                blurRadius:
                                6,



                                color:
                                Colors.black87,



                                offset:
                                Offset(1,2),



                              ),



                            ],



                          ),



                        ),






                        const Spacer(),



                      ],



                    ),



                  ),


                ],



              );


            },


          ),








          Positioned(


            top:
            45,


            right:
            20,



            child:
            TextButton(



              onPressed:
              finish,



              child:
              Text(



                "SKIP",



                style:
                GoogleFonts.cinzel(



                  color:
                  Colors.white,



                  fontWeight:
                  FontWeight.bold,



                  fontSize:
                  16,



                ),



              ),



            ),


          ),







          Positioned(



            bottom:
            35,



            left:
            30,



            right:
            30,



            child:
            Column(



              children: [





                Row(



                  mainAxisAlignment:
                  MainAxisAlignment.center,



                  children:
                  List.generate(



                    pages.length,



                        (index){



                      return AnimatedContainer(



                        duration:
                        const Duration(
                          milliseconds:300,
                        ),



                        margin:
                        const EdgeInsets.all(4),



                        width:
                        currentPage == index
                            ? 30
                            : 8,



                        height:
                        8,



                        decoration:
                        BoxDecoration(



                          color:
                          Colors.white,



                          borderRadius:
                          BorderRadius.circular(
                            20,
                          ),



                        ),



                      );


                    },


                  ),



                ),






                const SizedBox(
                  height:20,
                ),








                SizedBox(



                  width:
                  double.infinity,



                  height:
                  55,



                  child:
                  ElevatedButton(



                    onPressed: (){



                      if(currentPage <
                          pages.length - 1){



                        controller.nextPage(



                          duration:
                          const Duration(
                            milliseconds:400,
                          ),



                          curve:
                          Curves.ease,



                        );


                      }

                      else{


                        finish();


                      }


                    },



                    child:
                    Text(



                      currentPage ==
                          pages.length - 1

                          ?

                      "MULAI"

                          :

                      "LANJUT",



                      style:
                      GoogleFonts.cinzel(



                        fontWeight:
                        FontWeight.bold,



                        fontSize:
                        17,



                      ),



                    ),



                  ),



                ),



              ],



            ),



          ),



        ],



      ),


    );


  }


}