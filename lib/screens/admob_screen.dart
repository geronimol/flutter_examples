import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../constants.dart';
import '../utils/ad_helper.dart';

class AdmobScreen extends StatelessWidget {
  const AdmobScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admob'),),
      body: SafeArea(
          child: defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS
              ? const AdmobWidget()
              : const Center(child: Text('Admob can only run on Android or iOS platforms.')),
      ),
    );
  }
}

class AdmobWidget extends StatefulWidget {
  const AdmobWidget({Key? key}) : super(key: key);

  @override
  State<AdmobWidget> createState() => _AdmobWidgetState();
}

class _AdmobWidgetState extends State<AdmobWidget> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    loadBanner();
    super.initState();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  loadBanner() async {
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
      child: Column(
        children: [
          if (_bannerAd != null)
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd!),
              ),
            ),
        ],
      ),
    );
  }
}

