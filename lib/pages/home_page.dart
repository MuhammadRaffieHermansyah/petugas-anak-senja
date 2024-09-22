import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  bool isOffline = false;
  Set<Marker> _markers = {};
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  connectPusher() async {
    await pusher.init(
        apiKey: "26a15662666ddc9d24a5", cluster: "ap1", onEvent: onEvent);
    await pusher.subscribe(channelName: "LocationUpdate");
    await pusher.connect();
  }

  void onEvent(PusherEvent event) {
    Map<String, dynamic> data = json.decode(event.data);

    String latitude = data['data']['lat'];
    String longitude = data['data']['long'];

    double lat = double.parse(latitude);
    double long = double.parse(longitude);

    Marker marker = Marker(
      markerId: const MarkerId("1"),
      position: LatLng(lat, long),
    );

    setState(() {
      _markers = {marker};
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    connectPusher();
    isOffline = false;
    super.initState();
  }

  @override
  void dispose() {
    pusher.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            'Live Tracking',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            fortyFiveDegreeImageryEnabled: true,
            compassEnabled: true,
            trafficEnabled: true,
            tiltGesturesEnabled: true,
            rotateGesturesEnabled: true,
            mapToolbarEnabled: true,
            scrollGesturesEnabled: true,
            mapType: MapType.normal,
            onMapCreated: _onMapCreated,
            markers: _markers,
            initialCameraPosition: const CameraPosition(
              target: LatLng(-8.268689, 113.362703),
              zoom: 14.0,
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 10, top: 2, bottom: 10, right: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CircleAvatar(
                  minRadius: 25,
                  maxRadius: 25,
                  backgroundImage: AssetImage('assets/images/home.png'),
                  backgroundColor: Colors.grey,
                ),
                Container(
                  width: 110,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isOffline ? 'Lagi Offline' : 'Lagi Online',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (isOffline == false) {
                      setState(() {
                        isOffline = true;
                        pusher.disconnect();
                      });
                    } else {
                      setState(() {
                        isOffline = false;
                        connectPusher();
                      });
                    }
                  },
                  icon: isOffline
                      ? const Icon(
                          Icons.radio_button_checked,
                          size: 40,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.radio_button_checked,
                          size: 40,
                          color: Colors.green,
                        ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
