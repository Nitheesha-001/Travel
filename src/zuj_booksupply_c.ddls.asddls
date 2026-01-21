@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking supply Consumption Entity'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@VDM.viewType: #CONSUMPTION
define view entity ZUJ_BOOKSUPPLY_C as projection on ZUJ_BKSUPPL_I
{
    key BooksupplUuid,
    TravelUuid,
    BookingUuid,
    BookingSupplementId,    
    SupplementId,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    Price,
    CurrencyCode,
    LocalLastChangedAt,
    /* Associations */
    _Booking:redirected to parent ZUJ_BOOKING_C,
    _Travel:redirected to ZUJ_TRAVEL_C
}
