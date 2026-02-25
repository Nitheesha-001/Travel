@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel Consumption Entity'
@Metadata.allowExtensions: true
@VDM.viewType: #CONSUMPTION
define root view entity ZUJ_TRAVEL_C 
provider contract transactional_query as projection on ZUJ_TRAVEL_I
{
    key TravelUuid,
    TravelId,
    @Consumption.filter: { selectionType: #RANGE }
    AgencyId,
    CustomerId,
    BeginDate,
    EndDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    BookingFee,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    TotalPrice,
    CurrencyCode,
    Description,
    OverallStatus,
    LocalCreatedBy,
    LocalCreatedAt,
    LocalLastChangedBy,
    LocalLastChangedAt,
    LastChangedAt,
    /* Associations */
    _Booking:redirected to composition child ZUJ_BOOKING_C
}
