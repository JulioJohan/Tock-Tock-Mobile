import 'package:image_picker/image_picker.dart';
import 'package:toktok/presentation/widgets/shared/services/camera_gallery_service.dart';

class CameraGaleryServiceImpl extends CameraGalleryService {
  final ImagePicker imagePicker = ImagePicker();

  @override
  Future<String?> selectVideo() async {
    final XFile? cameraVideo = await imagePicker.pickVideo(
        source: ImageSource.gallery, preferredCameraDevice: CameraDevice.rear);
    if (cameraVideo == null) return null;
    // print(cameraVideo.bytes)
    print('Tenemos un video ${cameraVideo.path}');
    return cameraVideo.path;
  }

  @override
  Future<String?> takeVideo() async {
    final XFile? cameraVideo = await imagePicker.pickVideo(
        source: ImageSource.camera, preferredCameraDevice: CameraDevice.rear);
    if (cameraVideo == null) return null;
    print('Tenemos un video ${cameraVideo.path}');
    return cameraVideo.path;
  }
}
