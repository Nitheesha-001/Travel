@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption Entity for Shipping'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZUJ_SHIPPING_C
  as projection on ZUJ_SHIPPING_I
{
  key ShippingUuid,
      EnrollUuid,
      Serial,
      Addrnumber,
      Bpnumber,
      Model,
      Active,
      LocalLastChangedAt,
      /* Associations */
      _Addr: redirected to composition child ZUJ_ADDRESS_C,
      _Enroll: redirected to parent ZUJ_ENROLL_C
}
