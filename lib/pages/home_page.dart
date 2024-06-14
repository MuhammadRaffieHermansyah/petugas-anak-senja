import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tes/pages/contact_supir.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Stream<QuerySnapshot> angkot =
      FirebaseFirestore.instance.collection('angkot').snapshots();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  bool isOffline = false;
  final LatLng _center = const LatLng(-8.164878, 113.695402);
  Set<Marker> _markers = {};
  Position? _currentPosition;
  late Timer _timer;

  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  Stream<Position> positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
    accuracy: LocationAccuracy.bestForNavigation,
  ));

  Future<void> _startTracking() async {
    // Meminta izin akses lokasi
    bool serviceEnabled;
    LocationPermission permission;

    // Memeriksa apakah layanan lokasi diaktifkan
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Layanan lokasi tidak diaktifkan');
    }

    // Memeriksa izin lokasi
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Izin lokasi ditolak');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Izin lokasi ditolak secara permanen');
    }

    // Mengatur interval pengambilan lokasi dan pengiriman ke Firestore
    _timer = Timer.periodic(const Duration(seconds: 7), (timer) async {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      // log("Posisi Pindah!");
      // log("Latitude = ${position.latitude}");
      // log("Longitude = ${position.longitude}");
      final url = Uri.parse('http://172.16.11.93:8000/api/update-location');
      await http.post(url, body: {
        "latitude": position.latitude.toString(),
        "longitude": position.longitude.toString(),
      });
    });
  }

  void _updatePosition(Position position) async {
    positionStream.listen((Position? position) async {
      FirebaseFirestore.instance.collection('angkot').doc("1").update({
        'latitude': position?.latitude,
        'longitude': position?.longitude,
        'timestamp': FieldValue.serverTimestamp(),
      });
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  // _fetchLocations() async {
  //   FirebaseFirestore.instance
  //       .collection('angkot')
  //       .snapshots()
  //       .listen((snapshot) {
  //     Set<Marker> markers = snapshot.docs.map((doc) {
  //       var data = doc.data() as Map<String, dynamic>;
  //       return Marker(
  //         markerId: MarkerId(doc.id),
  //         position: LatLng(data['latitude'], data['longitude']),
  //         infoWindow: InfoWindow(
  //           title: data['namaAngkot'],
  //         ),
  //       );
  //     }).toSet();

  //     setState(() {
  //       _markers = markers;
  //     });
  //   });
  // }

  @override
  void initState() {
    isOffline = false;
    _startTracking();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            'Live Tracking',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            trafficEnabled: true,
            tiltGesturesEnabled: true,
            rotateGesturesEnabled: true,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapToolbarEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            onMapCreated: _onMapCreated,
            markers: _markers,
            initialCameraPosition: CameraPosition(target: _center, zoom: 18.0),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ContactSupir(),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 50),
                  padding: const EdgeInsets.all(12),
                  width: 240,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white),
                  child: const Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Profil Supir',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 13),
                          ),
                          Text(
                            '29 Des 2021 14:00',
                            style: TextStyle(
                              color: Colors.black38,
                              fontSize: 11,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 7),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/images/contact-sopir.png'),
                              ),
                              SizedBox(height: 3),
                              Text(
                                'Budi Suparno',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  '-6.098234098 106.09823409',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40)
            ],
          ),
        ],
      ),
    );
  }
}
