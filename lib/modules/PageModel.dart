import 'package:flutter/material.dart';

class PageModel {
  late String _title;
  late String _description;
  late IconData _icon;
  late String _image;

  PageModel(this._title, this._description, this._icon, this._image);

  String get image => _image;

  IconData get icon => _icon;

  String get description => _description;

  String get title => _title;
}
