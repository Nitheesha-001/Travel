@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Consumption Entity'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@VDM.viewType: #CONSUMPTION
define view entity ZUJ_BOOKING_C as projection on ZUJ_BOOKING_I
{
    key BookingUuid,
    TravelUuid,
    BookingId,
    BookingDate,
    CustomerId,
    CarrierId,
    ConnectionId,
    FlightDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    FlightPrice,
    CurrencyCode,
    BookingStatus,
    LocalLastChangedAt,
    /* Associations */
    _BookingSupplement:redirected to composition child ZUJ_BOOKSUPPLY_C,
    _Travel:redirected to parent ZUJ_TRAVEL_C
}
