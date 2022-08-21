import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MaskFormatter {
  static MaskTextInputFormatter getDateMaskFormatter() {
    MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
        mask: '##/##/####',
        filter: { "#": RegExp(r'[0-9]') },
        type: MaskAutoCompletionType.lazy
    );
    return maskFormatter;
  }
}