@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption Entity for Address'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZUJ_ADDRESS_C
  as projection on ZUJ_ADDRESS_I
{
  key AddrnumberUuid,
      EnrollUuid,
      ShippingUuid,
      Addrnumber,
      Street1,
      Street2,
      City,
      State,
      Country,
      Zipcode,
      LocalLastChangedAt,
      /* Associations */
      _Enroll:redirected to ZUJ_ENROLL_C,
      _Ship:redirected to parent ZUJ_SHIPPING_C
}
