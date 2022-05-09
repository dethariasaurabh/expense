enum ErrorType {
  emptyFieldError,
  invalidFieldError,
  none,
}
const String enUs = 'en_US';
const String hiIn = 'hi_IN';
RegExp userNameRegExp = RegExp(r'[a-zA-Z ]');

const String recordTypeField = 'type';
const String recordDateField = 'date';
const String recordTitleField = 'title';
const String recordAmountField = 'amount';
const String recordCategoryField = 'category';
