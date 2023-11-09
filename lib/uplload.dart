import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import './size.dart';
import 'package:geolocator/geolocator.dart';

class ImagePickerWidget extends StatefulWidget {
  final data;
  const ImagePickerWidget({super.key, this.data});
  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  Future<void> getLocation() async {
    await Geolocator.requestPermission();
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      setState(() {
        latController.text = position.latitude.toString();
        lngController.text = position.longitude.toString();
      });
    } catch (e) {
      print(e.toString());
    }
  }

  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  List<String> listBase64Images = [];
  final List<Widget> _imageList = [];

  Future<void> selectImages() async {
    try {
      final List<XFile> selectedImages = await imagePicker.pickMultiImage();
      if (selectedImages.isNotEmpty) {
        if (selectedImages.length > 230) {
          print("Sorry only 4");
        } else {
          imageFileList!.addAll(selectedImages);
        }
      }

      setState(() {
        for (var file in imageFileList!) {
          setState(() {
            _imageList.add(imageWidget(file.path));
            file.readAsBytes().then((value) {
              String img64 = base64Encode(value);
              setState(() {
                listBase64Images.add("data:image/png;base64,$img64");
              });
            });
          });
        }
      });
    } catch (ex) {
      print("Format non supporte$ex");
    }
  }

  // Future<void> loadAssets() async {
  //   List<Asset> resultList = <Asset>[];
  //   try {
  //     resultList = await MultiImagePicker.pickImages(
  //       maxImages: 220,
  //       enableCamera: true,
  //       selectedAssets: selectedImages,
  //       cupertinoOptions: const CupertinoOptions(takePhotoIcon: "chat"),
  //       materialOptions: const MaterialOptions(
  //         actionBarTitle: "Sélectionner les fichier",
  //       ),
  //     );
  //     convertImagesToBytes(resultList);
  //   } on NoImagesSelectedException catch (e) {
  //   // Handle when the user canceled the selection
  //   print(e.message);
  // } on Exception catch (e) {
  //   // Handle other exceptions
  //   print(e.toString());
  // }

  //   setState(() {
  //     selectedImages = resultList;
  //   });
  // }

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  TextEditingController latController = TextEditingController();
  TextEditingController lngController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  imageWidget(file) {
    return GestureDetector(
      // onTap: () => goTox(
      //     context, const ProductsAdd(), ViewImage(path: file, type: "file")),
      child: Container(
        height: fullWidth(context) * 0.2,
        width: fullWidth(context) * 0.2,
        color: const Color.fromARGB(255, 192, 191, 183),
        child: Image.file(File(file)),
      ),
    );
  }

  bool isload = false;
  TextEditingController bureaudevote = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.all(10),
        height: fullHeight(context),
        width: fullWidth(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              "Coordonnées Géographiques",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
            input(context, latController, "Latitude", fullWidth(context)),
            input(context, lngController, "Longitude", fullWidth(context)),
            GestureDetector(
              onTap: () {
                if (latController.text != "") {
                  if (lngController.text != "") {
                    goUrl(
                        "https://www.google.com/maps?q=${double.parse(latController.text)},${double.parse(latController.text)}");
                  }
                }
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 231, 230, 230)),
                child: const Icon(
                  CupertinoIcons.map_fill,
                  color: Colors.grey,
                ),
              ),
            ),
            input(context, addressController, "Adresse complète",
                fullWidth(context)),
            inputDescription(context, descriptionController, "Description",
                fullWidth(context)),

            Container(
              width: fullWidth(context),
              padding: const EdgeInsets.only(top: 25, bottom: 25, left: 10),
              child: const Text(
                "Informations du candidat",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      print("object");
                      // if (imageFileList!.isNotEmpty) {
                      selectImages();
                      // }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 231, 230, 230)),
                      child: Icon(
                        CupertinoIcons.photo_fill_on_rectangle_fill,
                        color: mainColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // input(context, bureaudevote, "Code Bureau de vote",
            //     fullWidth(context)),
            const SizedBox(
              height: 30,
            ),
            const Row(
              children: [],
            ),
            if (listBase64Images.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isload = true;
                    });

                    // upload(
                    //         listBase64Images,
                    //         bureaudevote.text,
                    //         widget.data['code_cv'],
                    //         widget.data['cv'],
                    //         widget.data['type'])
                    //     .then((status) {
                    //   setState(() {
                    //     isload = false;
                    //   });
                    //   if (status == 200) {
                    //     // messageSuccess(
                    //     //     context, "Images téléchargées avec succès...");
                    //   }
                    // });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isload == true
                          ? const SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 1,
                              ),
                            )
                          : const Icon(CupertinoIcons.arrow_up_doc),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text("Envoyer les donnees")
                    ],
                  ),
                ),
              ),
            Expanded(
              child: Wrap(
                clipBehavior: Clip.none,
                spacing: 12.0,
                runSpacing: 7.0,
                children: _imageList,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
