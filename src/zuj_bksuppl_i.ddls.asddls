@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Supply Infr View'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #BASIC
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZUJ_BKSUPPL_I
  as select from zuj_bksuppl
  
  association to parent ZUJ_BOOKING_I as _Booking on $projection.BookingUuid = _Booking.BookingUuid
  
  
  association[1] to  ZUJ_TRAVEL_I as _Travel on $projection.TravelUuid = _Travel.TravelUuid
{
  key booksuppl_uuid        as BooksupplUuid,
      root_uuid             as TravelUuid,
      parent_uuid           as BookingUuid,
      booking_supplement_id as BookingSupplementId,
      supplement_id         as SupplementId,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      price                 as Price,
      currency_code         as CurrencyCode,
      local_last_changed_at as LocalLastChangedAt,
      
      _Booking,
      _Travel
}
