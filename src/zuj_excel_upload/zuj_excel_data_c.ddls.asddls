@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption Entity for Data'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZUJ_EXCEL_DATA_C
  as projection on ZUJ_EXCEL_DATA_I
{
  key EndUser,
  key FileId,
  key Line_Id,
  key Line_No,
      PoNumber,
      PoItem,
      GrQuantity,
      UnitOfMeasure,
      SiteId,
      HeaderText,
      /* Associations */
      _XLUser : redirected to parent ZUJ_EXCEL_USER_C
}
