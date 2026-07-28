import 'package:flutter/material.dart';

import '../../config/asset_config.dart';
import '../../services/storage_service.dart';



class BackgroundSettingPage extends StatefulWidget {


  const BackgroundSettingPage({
    super.key,
  });



  @override
  State<BackgroundSettingPage> createState() =>
      _BackgroundSettingPageState();


}







class _BackgroundSettingPageState
    extends State<BackgroundSettingPage> {



  String selectedBackground =
      "default";





  @override
  void initState(){

    super.initState();

    loadBackground();

  }







  Future<void> loadBackground() async {


    selectedBackground =
        await StorageService.getBackground();


    setState(() {});


  }








  Future<void> chooseBackground(
      String value
      ) async {



    await StorageService.saveBackground(
      value,
    );



    setState(() {

      selectedBackground =
          value;

    });



    ScaffoldMessenger.of(context)
        .showSnackBar(


      const SnackBar(

        content:
        Text(
          "Background berhasil diubah",
        ),

      ),


    );



  }









  Widget backgroundCard({

    required String title,

    required String asset,

    required String value,


  }){


    bool active =
        selectedBackground == value;



    return GestureDetector(


      onTap: (){

        chooseBackground(
          value,
        );

      },



      child: Card(



        elevation:
        active ? 8 : 2,



        child: Column(



          children: [



            Expanded(



              child:
              Image.asset(

                asset,

                width:
                double.infinity,


                fit:
                BoxFit.cover,


              ),

            ),





            Padding(



              padding:
              const EdgeInsets.all(12),



              child:
              Row(



                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,



                children: [



                  Text(

                    title,

                    style:
                    const TextStyle(

                      fontSize:18,

                      fontWeight:
                      FontWeight.bold,

                    ),

                  ),




                  if(active)

                    const Icon(

                      Icons.check_circle,

                      color:
                      Colors.green,

                    ),



                ],


              ),


            ),



          ],


        ),


      ),


    );


  }










  @override
  Widget build(BuildContext context) {


    return Scaffold(



      appBar:
      AppBar(


        title:
        const Text(
          "Background",
        ),


        centerTitle:
        true,


      ),





      body:
      Padding(



        padding:
        const EdgeInsets.all(15),



        child:
        ListView(



          children: [



            const Text(


              "Pilih tampilan aplikasi",

              style:
              TextStyle(

                fontSize:20,

                fontWeight:
                FontWeight.bold,

              ),

            ),





            const SizedBox(
              height:20,
            ),






            SizedBox(


              height:
              180,



              child:
              backgroundCard(



                title:
                "Langit",



                asset:
                AssetConfig.onboardingSky,



                value:
                "sky",



              ),

            ),






            SizedBox(


              height:
              180,


              child:
              backgroundCard(



                title:
                "Padang Rumput",



                asset:
                AssetConfig.onboardingGrass,



                value:
                "grass",


              ),



            ),







            SizedBox(


              height:
              180,


              child:
              backgroundCard(



                title:
                "Angkasa",



                asset:
                AssetConfig.onboardingSpace,



                value:
                "space",


              ),



            ),




          ],


        ),



      ),



    );


  }


}