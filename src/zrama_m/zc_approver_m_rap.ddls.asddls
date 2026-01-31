@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Approver Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
@UI.headerInfo: {
    typeName: 'Travel',
    typeNamePlural: 'Travels',
     title: {
        type: #STANDARD,
        label: 'Travel',
        value: 'TravelId'
       }
}
define root view entity ZC_APPROVER_M_RAP
  provider contract transactional_query
  as projection on ZI_TRAVEL_M_RAP
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
              targetElement: '_Booking'
          }

          ]
      @UI: { lineItem: [ { position: 10 , importance: #HIGH } ],

             identification: [{ position: 10 }] }

      @Search.defaultSearchElement: true

  key TravelId,
      @UI: { lineItem: [{ position: 20, importance: #HIGH } ],
                  selectionField: [{ position: 20 }],
                  identification: [{ position: 20 }]
                                           }

      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition:[{
          entity: {
              name: '/DMO/I_AGENCY',
              element: 'AgencyID'
          }
          } ]
      @ObjectModel.text.element: [ 'AgencyName' ]
      AgencyId,
      _Agency.Name       as AgencyName,
      @UI: { lineItem: [{ position: 30 , importance: #HIGH } ],
         selectionField: [{ position: 20 }],
         identification: [{ position: 30 }]
      }
      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition:[{
         entity: {
             name: '/DMO/I_Customer',
             element: 'CustomerID'
         }
         } ]
      @ObjectModel.text.element: [ 'CustomerName' ]

      CustomerId,
      _Customer.LastName as CustomerName,
      @UI: { lineItem: [{ position: 40 }],
        identification: [{ position: 40 }]
        }
      BeginDate,
      @UI: { lineItem: [{ position: 50 }],
         identification: [{ position: 50 }]
         }

      EndDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      @UI.identification: [{ position: 60 }]
      BookingFee,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      @UI: { lineItem: [{ position: 60 }],
        identification: [{ position: 70 }]
      }
      TotalPrice,
      @UI: { lineItem: [{ position: 70 }],
         identification: [{ position: 80 }]
         }
      @Consumption.valueHelpDefinition:[{
         entity: {
             name: 'I_CURRENCY',
             element: 'Currency'
         }
         } ]

      CurrencyCode,

      @UI: { lineItem: [{ position:15, importance: #HIGH },
           { type: #FOR_ACTION, dataAction: 'acceptTravel', label:'AcceptTravel' },
           { type: #FOR_ACTION, dataAction: 'rejectTravel', label: 'RejectTravel' }],

          identification: [{ position: 15 },
                { type: #FOR_ACTION, dataAction: 'acceptTravel', label:'AcceptTravel' },
                 { type: #FOR_ACTION, dataAction: 'rejectTravel', label: 'RejectTravel' } ],
                 textArrangement: #TEXT_ONLY,
                selectionField: [{ position: 40 }]
       }
      @EndUserText.label: 'Overall Status'
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Consumption.valueHelpDefinition:[{
         entity: {
             name: '/DMO/I_OVERALL_STATUS_VH',
             element: 'OverallStatus'
         }
         }
      ]
      @ObjectModel.text.element: [ 'Overallstatustext' ]
      OverallStatus,
      _Status._Text.Text as Overallstatustext : localized,
      @UI: { lineItem: [{ position: 90 }],
          identification: [{ position: 90 }]
          }
      Description,
      @UI.hidden: true
      CreatedBy,
      @UI.hidden: true
      CreatedAt,
      @UI.hidden: true
      LastChangedBy,
      @UI.hidden: true
      LastChangedAt,
      /* Associations */
      _Agency,
      _Booking : redirected to composition child ZC_BOOK_APPR_M_RAP,
      _Currency,
      _Customer,
      _Status
}
