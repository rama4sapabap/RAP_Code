@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Approver'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
@UI.headerInfo: {
    typeName: 'Booking',
    typeNamePlural: 'Bookings',
    title: {
        type: #STANDARD,
        label: 'Booking',
        value: 'BookingId'
            }

}
define view entity ZC_BOOK_APPR_M_RAP
  as projection on ZI_BOOK_M_RAP

{
      @UI.facet:  [{
                 id: 'Travel',
                 purpose: #STANDARD,
                 position: 10,
                 label: 'TRAVEL',
                 type: #IDENTIFICATION_REFERENCE

             },
              {
               id: 'Booking',
                 purpose: #STANDARD,
                 position: 20,
                 label: 'Booking',
                 type: #LINEITEM_REFERENCE,
                 targetElement: '_Bookingsuppl'
             }

             ]
      @UI: { lineItem: [{ position: 10 }],
         identification: [{ position: 10 }] }

      @Search.defaultSearchElement: true
  key TravelId,
      @UI: { lineItem: [{ position: 20 , importance: #HIGH } ],
                  identification: [{ position: 20 }] }
      @Search.defaultSearchElement: true
  key BookingId,
      @UI: { lineItem: [{ position: 30, importance: #HIGH }],
              identification: [{ position: 30 }] }
      BookingDate,
      @UI: { lineItem: [{ position: 40, importance: #HIGH }],
               identification: [{ position: 40 }]  }
      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition:[{
          entity: {
              name: '/DMO/I_Customer',
              element: 'CustomerID'
          }
          } ]
      @ObjectModel.text.element: [ 'CustomerName' ]
      CustomerId,
      _Customer.LastName     as CustomerName,
      @UI: { lineItem: [{ position: 50 , importance: #HIGH }],
          identification: [{ position: 50 }] }
      @Consumption.valueHelpDefinition:[{
          entity: {
              name: '/DMO/I_Carrier',
              element: 'AirlineID'
          }
          } ]
      @ObjectModel.text.element: [ 'CarrierName' ]
      CarrierId,
      _Carrier.Name          as CarrierName,
      @UI: { lineItem: [{ position: 60, importance: #HIGH  }],
              identification: [{ position: 60 }] }
      @Consumption.valueHelpDefinition:[{
          entity: {
              name: '/DMO/I_Flight',
              element: 'ConnectionID'
          },

          additionalBinding: [{
               element: 'ConnectionId',
               localElement: 'ConnectionID' },
               {
               element: 'AirlineID',
               localElement: 'CarrierId' },
               {
               element: 'CurrencyCode',
               localElement: 'CurrencyCode' },
               {
               element: 'Price',
               localElement: 'FlightPrice' }
               ]

          } ]
      ConnectionId,
      @UI: { lineItem: [{ position:70 , importance: #HIGH }],
          identification: [{ position: 70 }] }
      @Consumption.valueHelpDefinition:[{
          entity: {
              name: '/DMO/I_Flight',
              element: 'FlightDate'
          },

          additionalBinding: [{
               element: 'FlightDate',
               localElement: 'FlightDate' },
               {
               element: 'AirlineID',
               localElement: 'CarrierId' },
               {
               element: 'CurrencyCode',
               localElement: 'CurrencyCode' },
               {
               element: 'Price',
               localElement: 'FlightPrice' }
               ]

          } ]
      FlightDate,
      @UI: { lineItem: [{ position: 80 , importance: #HIGH }],
          identification: [{ position: 80 }] }
      @Semantics.amount.currencyCode: 'CurrencyCode'
      FlightPrice,
      @UI: { lineItem: [{ position: 90 , importance: #HIGH }],
          identification: [{ position: 90 }] }
      @Consumption.valueHelpDefinition:[{
          entity: {
              name: 'I_Currency',
              element: 'Currency'
          }
          } ]
      CurrencyCode,
      @UI: { lineItem: [{ position: 100 , importance: #HIGH }],
          identification: [{ position: 100 }],
          textArrangement: #TEXT_ONLY }

      @Consumption.valueHelpDefinition:[{
          entity: {
              name: '/DMO/I_Booking_Status_VH',
              element: 'BookingStatus'
          }
          } ]
      @ObjectModel.text.element: [ 'Bookstatustext' ]
      BookingStatus,
      _BookStatus._Text.Text as Bookstatustext : localized,
      LastChangedAt,
      /* Associations */
      _Bookingsuppl,
      _BookStatus,
      _Carrier,
      _Connection,
      _Customer,
      _Travel : redirected to parent ZC_APPROVER_M_RAP
}
