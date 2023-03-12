import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../utils/commonClass/CommonClass.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => AddressScreenState();
}

class AddressScreenState extends State<AddressScreen> {
  String stAddress = '';
  double? latitude;
  double? longitude;

  bool isCurrentLocationClicked = false;

  ///TextEditingController
  TextEditingController stateController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController isoCodeController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<Marker> customMarkers = [];

  BitmapDescriptor? myIcon;
  GoogleMapController? mapController; //controller for Google map
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = LatLng(30.955021, 75.8479783);

  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(10, 10)),
            ("${icon}location.png"))
        .then((onValue) {
      myIcon = onValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: num0,
          backgroundColor: Colors.white,
          toolbarHeight: size.height * numD040,
          bottom: PreferredSize(
            preferredSize: Size(size.height * num0, size.height * numD055),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  ("${image}map.png"),
                  height: size.height * numD05,
                ),
                SizedBox(
                  width: size.width * numD02,
                ),
                Text(
                  'Pick location',
                  style: TextStyle(
                    fontFamily: 'comfortaa',
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                    fontSize: size.width * numD045,
                  ),
                )
              ],
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(
              left: size.height * numD01,
              right: size.height * numD01,
              top: size.height * numD01),
          child: SingleChildScrollView(child: addressWidget(size)),
        ));
  }

  Widget addressWidget(size) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      isCurrentLocationClicked = true;
                    });
                    getUserCurrentLocation().then((value) async {
                      debugPrint(
                          "onTapLocation : ${value.latitude} ${value.longitude}");

                      ///changeDataIntoDouble
                      double latDouble =
                          double.parse(value.latitude.toString());
                      double longDouble =
                          double.parse(value.longitude.toString());
                      List<Placemark> placemarks =
                          await placemarkFromCoordinates(latDouble, longDouble);

                      var first = placemarks.first;
                      stAddress = first.street.toString();
                      pinCodeController.text = first.postalCode.toString();
                      cityController.text = first.locality.toString();
                      stateController.text =
                          first.administrativeArea.toString();
                      isoCodeController.text = first.isoCountryCode.toString();
                      countryController.text = first.country.toString();
                      addressController.text =
                          "${first.street},${first.subLocality} ${first.locality},${first.administrativeArea},${first.postalCode}";

                      isCurrentLocationClicked = false;

                      latitude = value.latitude;
                      longitude = value.longitude;

                      debugPrint("postalCode= latitude =>$latitude");
                      debugPrint("postalCode==>${first.postalCode}");
                      debugPrint("adminArea==>${first.administrativeArea}");
                      debugPrint(
                          "subAdminArea==>${first.subAdministrativeArea}");
                      debugPrint("address===>$first");

                      // marker added for current users location
                      _markers.add(
                        Marker(
                          markerId: const MarkerId("myPosition"),
                          flat: true,
                          position: LatLng(value.latitude, value.longitude),
                          infoWindow: InfoWindow(
                            title: stAddress,
                          ),
                          icon: myIcon!,
                        ),
                      );
                      // specified current users location
                      CameraPosition cameraPosition = CameraPosition(
                        target: LatLng(value.latitude, value.longitude),
                        zoom: 14,
                      );

                      final GoogleMapController controller =
                          await _controller.future;
                      controller.animateCamera(
                          CameraUpdate.newCameraPosition(cameraPosition));
                      setState(() {});
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.my_location_sharp,
                        color: Colors.pink,
                      ),
                      SizedBox(
                        width: size.width * numD02,
                      ),
                      Text(
                        "Pin your location",
                        style: TextStyle(
                          color: Colors.pink,
                          fontFamily: 'comfortaa',
                          fontSize: size.width * numD035,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Expanded(child: Container()),
                      isCurrentLocationClicked
                          ? Image.asset(
                              ("${image}way.gif"),
                              height: size.height * numD05,
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
            ],
          ),

          ///Google Map
          SizedBox(
            height: size.height * numD30,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(size.width * numD02),
              child: GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  setState(() {
                    mapController = controller;
                    _controller.complete(controller);
                  });
                },
                zoomControlsEnabled: false,
                initialCameraPosition: const CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
                mapType: MapType.normal,
                markers: _markers,
                onCameraMove: _onCameraMove,
                onTap: (value) async {
                  LatLng newLatLong = LatLng(value.latitude, value.longitude);
                  debugPrint(
                      "onTapLocation:${value.latitude} ${value.longitude}");

                  ///changeDataIntoDouble
                  double latDouble = double.parse(value.latitude.toString());
                  double longDouble = double.parse(value.longitude.toString());
                  List<Placemark> placeMarks =
                      await placemarkFromCoordinates(latDouble, longDouble);

                  setState(() {
                    latitude = value.latitude;
                    longitude = value.longitude;
                    var first = placeMarks.first;
                    debugPrint("first:$first");
                    stAddress =
                        "${first.street},${first.subLocality} ${first.locality},${first.administrativeArea},${first.postalCode}";
                    pinCodeController.text = first.postalCode.toString();
                    cityController.text = first.locality.toString();
                    stateController.text = first.administrativeArea.toString();
                    addressController.text =
                        "${first.street},${first.subLocality} ${first.locality},${first.administrativeArea},${first.postalCode}";
                    isoCodeController.text = first.isoCountryCode.toString();
                    countryController.text = first.country.toString();

                    debugPrint("postalCode:${first.postalCode}");
                    debugPrint("adminArea: ${first.administrativeArea}");
                    debugPrint("subAdminArea: ${first.subAdministrativeArea}");

                    mapController?.animateCamera(CameraUpdate.newCameraPosition(
                        CameraPosition(target: newLatLong, zoom: 13)
                        //17 is new zoom level
                        ));
                    if (_markers.isNotEmpty) {
                      _markers.removeWhere((element) =>
                          element.markerId == const MarkerId("myPosition"));
                    }
                    _markers.add(Marker(
                      markerId: const MarkerId("myPosition"),
                      flat: true,
                      position: LatLng(value.latitude, value.longitude),
                      infoWindow: InfoWindow(
                        title: stAddress,
                      ),
                      icon: myIcon!,
                    ));
                  });
                },
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * numD025,
              ),
              commonText(text: 'Pincode'),
              commonTextEditForm(
                  size: size,
                  controller: pinCodeController,
                  hintText: 'Enter pincode',
                  validation: 'required'),
              SizedBox(
                height: size.height * numD025,
              ),
              commonText(text: 'State'),
              commonTextEditForm(
                  size: size,
                  controller: stateController,
                  hintText: 'Please enter state',
                  validation: 'Please enter state'),
              SizedBox(
                height: size.height * numD025,
              ),
              commonText(text: 'City'),
              commonTextEditForm(
                  size: size,
                  controller: cityController,
                  hintText: 'Please enter city',
                  validation: 'Please enter city'),
              SizedBox(
                height: size.height * numD025,
              ),
              commonText(text: 'ISO Country Code'),
              commonTextEditForm(
                  size: size,
                  controller: isoCodeController,
                  hintText: 'ISO Country Code',
                  validation: 'required'),
              SizedBox(
                height: size.height * numD025,
              ),
              commonText(text: 'Country'),
              commonTextEditForm(
                  size: size,
                  controller: countryController,
                  hintText: 'Country',
                  validation: 'required'),
              SizedBox(
                height: size.height * numD025,
              ),
              commonText(text: 'Address'),
              commonTextEditForm(
                  size: size,
                  controller: addressController,
                  hintText: 'Please enter address',
                  validation: 'Please enter address'),
              SizedBox(
                height: size.height * numD025,
              ),
              /*  commonButton(
                  func: () {
                    if (formKey.currentState!.validate()) {
                      callUpdateProfileApi();
                    }
                  },
                  buttonName: changeText,
                  buttonColor: themeColor,
                  buttonColorValue: true,
                  borderSide: false,
                  textColor: whiteColor),*/
              SizedBox(
                height: size.height * numD025,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onCameraMove(CameraPosition position) {}

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      debugPrint("ERROR:$error");
    });
    return await Geolocator.getCurrentPosition();
  }
}
