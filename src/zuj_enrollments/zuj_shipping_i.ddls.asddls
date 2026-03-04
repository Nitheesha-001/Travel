@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface Entity for Shipping'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZUJ_SHIPPING_I
  as select from zuj_shipping
  composition [0..*] of ZUJ_ADDRESS_I as _Addr
  association to parent ZUJ_ENROLL_I  as _Enroll on $projection.EnrollUuid = _Enroll.EnrollUuid
{
  key shipping_uuid         as ShippingUuid,
      parent_uuid           as EnrollUuid,
      serial                as Serial,
      addrnumber            as Addrnumber,
      bpnumber              as Bpnumber,
      model                 as Model,
      active                as Active,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,

      _Addr,
      _Enroll
}
