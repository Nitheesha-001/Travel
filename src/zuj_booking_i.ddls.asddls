@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking intr view'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #BASIC
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZUJ_BOOKING_I
  as select from zuj_booking
  
  composition [0..*] of ZUJ_BKSUPPL_I as _BookingSupplement
  association to parent ZUJ_TRAVEL_I as _Travel on $projection.TravelUuid = _Travel.TravelUuid
  //association to parent ZUJ_TRAVEL_I as _Travel on $projection.ParentUuid = _Travel.TravelId
{
  key booking_uuid          as BookingUuid,
      parent_uuid           as TravelUuid,
      booking_id            as BookingId,
      booking_date          as BookingDate,
      customer_id           as CustomerId,
      carrier_id            as CarrierId,
      connection_id         as ConnectionId,
      flight_date           as FlightDate,
      @Semantics.amount.currencyCode: 'Currencycode'
      flight_price          as FlightPrice,
      currency_code         as CurrencyCode,
      booking_status        as BookingStatus,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,

      _Travel,
      _BookingSupplement
}
