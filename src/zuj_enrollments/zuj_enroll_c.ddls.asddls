@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption Entity for Enroll'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZUJ_ENROLL_C
  provider contract transactional_query
  as projection on ZUJ_ENROLL_I
{
  key EnrollUuid,
      Bpnumber,
      Serial,
      Model,
      Brrefresh,
      Country,
      Createdon,
      Cancelledon ,
      Status,
      Suspendstart,
      Suspendend,
      LocalCreatedBy,
      LocalCreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt,

      /* Associations */
      _Ship : redirected to composition child ZUJ_SHIPPING_C
}
