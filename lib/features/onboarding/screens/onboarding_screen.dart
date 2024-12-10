import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "title": "Selamat Datang Di Aplikasi Mahasiswa Takumi",
      "subtitle": "Aplikasi untuk mengatur kegiatan mahasiswa",
      "image": "assets/images/page1.png",
    },
    {
      "title": "Atur Jadwalmu Dengan Mudah",
      "subtitle":
          "Buat, kelola, dan pantau jadwal akademik serta target belajarmu dengan fitur yang intuitif",
      "image": "assets/images/page2.png",
    },
    {
      "title": "Bangun Koneksi Mahasiswa",
      "subtitle":
          "Bergabung dalam forum diskusi, berbagi ide, dan kolaborasi bersama rekan mahasiswa",
      "image": "assets/images/page3.png",
    },
  ];

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);
    // ignore: use_build_context_synchronously
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    final bool isLastPage = _currentPage == _onboardingData.length - 1;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Color(0xFF1B1B1B)),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 40.0, right: 20.0),
                child: TextButton(
                  onPressed: _completeOnboarding,
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemCount: _onboardingData.length,
                  itemBuilder: (context, index) {
                    final data = _onboardingData[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data["title"]!,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            data["subtitle"]!,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 30),
                          Flexible(
                            flex: 2,
                            child: Image.asset(
                              data["image"]!,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            SmoothPageIndicator(
              controller: _pageController,
              count: _onboardingData.length,
              effect: const WormEffect(
                activeDotColor: Colors.white,
                dotColor: Colors.white54,
                dotHeight: 8,
                dotWidth: 8,
                spacing: 12,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (isLastPage) {
                          _completeOnboarding();
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF40919E),
                        elevation: 5,
                        shadowColor: Colors.black26,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.all(16),
                      ),
                      child: Text(
                        isLastPage ? "Get Started" : "Next",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
