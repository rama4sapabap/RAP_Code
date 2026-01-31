@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Projection View'
//@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_BOOK_M_RAP
  as projection on ZI_BOOK_M_RAP
{

  key TravelId,

  key BookingId,

      BookingDate,

      @ObjectModel.text.element: [ 'CustomerName' ]
      CustomerId,
      _Customer.LastName     as CustomerName,

      @ObjectModel.text.element: [ 'CarrierName' ]

      CarrierId,
      _Carrier.Name          as CarrierName,

      ConnectionId,

      FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'


      FlightPrice,

      CurrencyCode,

      @ObjectModel.text.element: [ 'Bookstatustext' ]

      BookingStatus,
      _BookStatus._Text.Text as Bookstatustext : localized,
        LastChangedAt,
        
      /* Associations */
      _Bookingsuppl : redirected to composition child ZC_BOOKSUPPL_M_RAP,

      _BookStatus,
      _Carrier,
      _Connection,
      _Customer,
      _Travel       : redirected to parent ZC_TRAVEL_M_RAP
}
