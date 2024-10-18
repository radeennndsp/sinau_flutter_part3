import 'package:buget_app/pages/home_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(238, 249, 254, 255),
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Positioned(
                  top: 40,
                  left: 0,
                  right: 0,
                  child: Image.asset('assets/l-splash.png')),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding: const EdgeInsets.all(15),
                    height: MediaQuery.of(context).size.height * 0.4,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        const SizedBox(height: 65),
                        Image.asset('assets/acx.png'),
                        const SizedBox(height: 15),
                        Text(
                          'Management Expenses',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Selamat datang di aplikasi \n pengelolaan anggaran pribadi',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                            );
                          },
                          child: Container(
                            height: 70,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: const Color(0XFF34B6FF),
                                gradient: LinearGradient(colors: [
                                  Color(0XFF2A93BF),
                                  Color(0XFF38C5FF),
                                ])),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text(
                                  'Use my wallet',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Image.asset('assets/Wallet.png')
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15)
                ],
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 100,
                child: Image.asset(
                  'assets/bg-splash.png',
                  fit: BoxFit.contain,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
