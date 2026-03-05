@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root Interface Entity for Contracts'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZUJ_CONTRACTS_I
  as select from zuj_contracts as E
    inner join   zuj_ship      as S    on  E.bpnumber = S.bpnumber
                                       and E.model    = S.model
                                       and E.serial   = S.serial
    inner join   zuj_addr      as addr on S.addrnumber = addr.addrnumber
{
  key E.bpnumber      as BPNumber,
  key E.model         as ModelNumber,
  key E.serial        as SerialNumber,

      E.createdon     as EnrolledOn,
      E.cancelledon   as CancelledOn,

case E.status
     when 'A' then 'Active'
     when 'D' then 'Cancelled'
     when 'S' then 'Suspended'
end as StatusText,
      E.status,

      E.suspend_start as SuspendStartDate,
      E.suspend_end   as SuspendEndDate,

      addr.street1,
      addr.street2,
      addr.city,
      addr.state,
      addr.country,
      addr.zipcode
}










// composition of target_data_source_name as _association_name
//{
//  key bpnumber      as Bpnumber,
//  key model         as Model,
//  key serial        as Serial,
//      country       as Country,
//      createdon     as Createdon,
//      cancelledon   as Cancelledon,
//      status        as Status,
//      suspend_start as SuspendStart,
//      suspend_end   as SuspendEnd
//      //_association_name // Make association public
//}
