@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface entity for User'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
serviceQuality: #X,
sizeCategory: #S,
dataClass: #MIXED
}
define root view entity ZUJ_EXCEL_USER_I
  as select from zuj_excel_user
  composition [0..*] of ZUJ_EXCEL_DATA_I as _XLData
{
  key end_user              as EndUser,
  key file_id               as FileId,
//   case $projection.FileStatus
//    when 'FAILED'         then 1   /* red    */
//    when 'PENDING'        then 2   /* yellow */
//    when 'FILE_SELECTED'  then 5   /* blue   */
//    when 'UPLOADED'       then 3   /* green  */
//    else 0                        /* gray   */
//  end as FileStatusCriticality,
      file_status           as FileStatus,
        @Semantics.largeObject: {
                       mimeType: 'Mimetype',
                       fileName: 'Filename',
                       contentDispositionPreference: #INLINE}
      attachment            as Attachment,
      @Semantics.mimeType: true
      mimetype              as Mimetype,
      filename              as Filename,
      @Semantics.user.createdBy: true
      local_created_by      as LocalCreatedBy,
      @Semantics.systemDateTime.createdAt: true
      local_created_at      as LocalCreatedAt,
      @Semantics.user.lastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,
      //      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,

      _XLData // Make association public
}
