@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking refrence Details'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_BOOK_M_RAP
  as select from zrap_book_m
  association        to parent ZI_TRAVEL_M_RAP   as _Travel     on $projection.TravelId = _Travel.TravelId
  composition [0..*] of ZI_BOOKSUPPL_M_RAP       as _Bookingsuppl

  association [1..1] to /DMO/I_Carrier           as _Carrier    on $projection.CarrierId = _Carrier.AirlineID
  association [1..1] to /DMO/I_Customer          as _Customer   on $projection.CustomerId = _Customer.CustomerID
  association [1..1] to /DMO/I_Connection        as _Connection on $projection.ConnectionId = _Connection.ConnectionID
  association [1..1] to /DMO/I_Booking_Status_VH as _BookStatus on $projection.BookingStatus = _BookStatus.BookingStatus

{
  key travel_id       as TravelId,
  key booking_id      as BookingId,
      booking_date    as BookingDate,
      customer_id     as CustomerId,
      carrier_id      as CarrierId,
      connection_id   as ConnectionId,
      flight_date     as FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      flight_price    as FlightPrice,
      currency_code   as CurrencyCode,
      booking_status  as BookingStatus,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      last_changed_at as LastChangedAt,

      _Carrier,
      _Customer,
      _Connection,
      _BookStatus,
      _Travel,
      _Bookingsuppl

}
where
      travel_id    is not initial
  and booking_id   is not initial
  and booking_date is not initial
