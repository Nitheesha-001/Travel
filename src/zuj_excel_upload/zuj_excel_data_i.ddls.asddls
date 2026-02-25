@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface Entity for Excel Data'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
serviceQuality: #X,
sizeCategory: #S,
dataClass: #MIXED
}
define view entity ZUJ_EXCEL_DATA_I
  as select from zuj_excel_data
//  association [0..1] to ZUJ_EXCEL_DATA_I as _XLUser on  $projection.EndUser = _XLUser.EndUser
//                                                  and $projection.FileId  = _XLUser.FileId
    association to parent ZUJ_EXCEL_USER_I as _XLUser on  $projection.EndUser = _XLUser.EndUser
                                                      and $projection.FileId  = _XLUser.FileId
{
  key end_user        as EndUser,
  key file_id         as FileId,
  key line_id         as Line_Id,
  key line_no         as Line_No,
      po_number       as PoNumber,
      po_item         as PoItem,
      gr_quantity     as GrQuantity,
      unit_of_measure as UnitOfMeasure,
      site_id         as SiteId,
      header_text     as HeaderText,

      _XLUser // Association
}
