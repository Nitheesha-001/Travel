@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Customer Value Help'
@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZUJ_Customer_VH as select from /DMO/I_Customer_StdVH
{
    key CustomerID,
    FirstName,
    LastName,
    Title,
    Street,
    PostalCode,
    City,
    CountryCode,
    CountryCodeText,
    PhoneNumber,
    EMailAddress
}
