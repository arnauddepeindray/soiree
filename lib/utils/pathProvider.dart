import 'package:path_provider/path_provider.dart';

Future<String> getlocalPath () async{
  final directory = await getTemporaryDirectory();

  return directory.path;
}