@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption Entity for User'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZUJ_EXCEL_USER_C
  provider contract transactional_query
  as projection on ZUJ_EXCEL_USER_I
{
  key EndUser,
  key FileId,
      FileStatus,
      Attachment,
      @Semantics.largeObject: {
          mimeType: 'Mimetype',
          fileName: 'Filename',
          acceptableMimeTypes: [
              'application/vnd.ms-excel','application/vnd.openxmlformats-officedocument.spreadsheetml.sheet','text/csv' ],
          contentDispositionPreference: #INLINE}
      Mimetype,
      Filename,
      LocalCreatedBy,
      LocalCreatedAt,
      LocalLastChangedBy,
      LocalLastChangedAt,
      LastChangedAt,
      /* Associations */
      _XLData
}
