@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface Entity for Address'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZUJ_ADDRESS_I
  as select from zuj_address
  association     to parent ZUJ_SHIPPING_I as _Ship   on $projection.ShippingUuid = _Ship.ShippingUuid


  association [1] to ZUJ_ENROLL_I          as _Enroll on $projection.EnrollUuid = _Enroll.EnrollUuid
{
  key addrnumber_uuid       as AddrnumberUuid,
      root_uuid             as EnrollUuid,
      parent_uuid           as ShippingUuid,
      addrnumber            as Addrnumber,
      street1               as Street1,
      street2               as Street2,
      city                  as City,
      state                 as State,
      country               as Country,
      zipcode               as Zipcode,
      local_last_changed_at as LocalLastChangedAt,

      _Ship,
      _Enroll
}
