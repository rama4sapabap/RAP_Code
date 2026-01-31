@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Supplement Projection'
//@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true

define view entity ZC_BOOKSUPPL_M_RAP
  as projection on ZI_BOOKSUPPL_M_RAP
{


  key TravelId,

  key BookingId,

  key BookingSupplementId,

      @ObjectModel.text.element: [ 'SupplemenDesc']
      SupplementId,
      _SupplementText.Description as SupplemenDesc : localized,
      @Semantics.amount.currencyCode: 'CurrencyCode'

      Price,

      CurrencyCode,
      @UI.hidden: true
      LastChangedAt,
      /* Associations */
      _Booking : redirected to parent ZC_BOOK_M_RAP,
      _Supplement,
      _SupplementText,
      _Travel  : redirected to ZC_TRAVEL_M_RAP
}
