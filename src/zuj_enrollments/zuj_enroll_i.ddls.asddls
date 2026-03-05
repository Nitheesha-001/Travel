@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface Entity for Enrollment'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZUJ_ENROLL_I
  as select from zuj_enroll
  composition [0..*] of ZUJ_SHIPPING_I as _Ship
{
  key enroll_uuid           as EnrollUuid,
      bpnumber              as Bpnumber,
      serial                as Serial,
      model                 as Model,
      brrefresh             as Brrefresh,
      country               as Country,
      createdon             as Createdon,
      cancelledon           as Cancelledon,
      status                as Status,
      suspendstart          as Suspendstart,
      suspendend            as Suspendend,
      @Semantics.user.createdBy: true
      local_created_by      as LocalCreatedBy,

      @Semantics.systemDateTime.createdAt: true
      local_created_at      as LocalCreatedAt,

      @Semantics.user.lastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,

      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,

      _Ship // Make association public
}
