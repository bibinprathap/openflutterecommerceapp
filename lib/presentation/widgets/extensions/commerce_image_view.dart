import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:openflutterecommerce/data/model/commerce_image.dart';

extension View on CommerceImage {
  ImageProvider getView() {
    if (isLocal) {
      return AssetImage(
        address,
      );
    } else {
      String BASE64_STRING = address.replaceAll('data:image/jpeg;base64,', '');
      Uint8List bytes = address.indexOf('data:image/jpeg;base64,') > -1
          ? base64Decode(BASE64_STRING)
          : null;
      final ImageProvider image =
          address.indexOf('data:image/jpeg;base64,') > -1
              ? MemoryImage(bytes)
              : NetworkImage(
                  address,
                );
      return image;
    }
  }
}
