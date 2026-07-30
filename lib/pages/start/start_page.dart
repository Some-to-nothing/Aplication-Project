import 'package:flutter/material.dart';

import '../../services/storage_service.dart';

import '../home/home_page.dart';
import '../onboarding/onboarding_page.dart';


class StartPage extends StatelessWidget {

  const StartPage({
    super.key,
  });


  @override
  Widget build(BuildContext context) {

    return FutureBuilder(

      future:
      StorageService.isOnboardingDone(),

      builder:
          (context, snapshot) {

        if (!snapshot.hasData) {

          return const Scaffold(

            body:
            Center(

              child:
              CircularProgressIndicator(),

            ),

          );

        }


        if (snapshot.data == true) {

          return const HomePage();

        }


        return const OnboardingPage();

      },

    );

  }

}