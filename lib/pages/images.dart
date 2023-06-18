import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class ImagesPage extends StatefulWidget {
  const ImagesPage({super.key});

  @override
  State<ImagesPage> createState() => _ImagesPageState();
}

class _ImagesPageState extends State<ImagesPage> {
  File? _image;

  Future getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;

   // final imageTemporary = File(image.path);
    final imagePermanent = await saveFilePermanenetly(image.path);

    setState(() {
      _image = imagePermanent;
    });
  }

  Future <File> saveFilePermanenetly(String imagePath) async{
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    
    return File(imagePath).copy(image.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Center(child: Text('Pick an Image')),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 40),
            _image != null
                ? Image.file(
                    _image!,
                    width: 250,
                    height: 250,
                    fit: BoxFit.cover,
                  )
                : Image.network('https://picsum.photos/200?image=10',
                    scale: 0.7),
            const SizedBox(height: 40),
            CustomButton(
              title: 'Pick from Gallery',
              icon: Icons.image_outlined,
              onClick:() => getImage(ImageSource.gallery),
            ),
            CustomButton(
              title: 'Pick from Camera',
              icon: Icons.camera,
              onClick: () => getImage(ImageSource.camera),
            ),
          ],
        ),
      ),
    );
  }
}

Widget CustomButton(
    {required String title,
    required IconData icon,
    required VoidCallback onClick}) {
  return Container(
    width: 200,
    child: ElevatedButton(
      onPressed: onClick,
      child: Row(
        children: [Icon(icon), Text(title)],
      ),
    ),
  );
}
