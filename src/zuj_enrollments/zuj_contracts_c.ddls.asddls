@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root Consumption entity for Contracts'
@Metadata.ignorePropagatedAnnotations: true
@UI.headerInfo: {
  typeName: 'Enrollment',
  typeNamePlural: 'Enrollments'}

define root view entity ZUJ_CONTRACTS_C
  provider contract transactional_query
  as projection on ZUJ_CONTRACTS_I

{
      @UI.lineItem: [{ position: 10 , label: 'BPNumber' }]
  key BPNumber,
      @UI.lineItem: [{ position: 20 , label: 'Model' }]
  key ModelNumber,
      @UI.lineItem: [{ position: 30 , label: 'Serial' }]
  key SerialNumber,
      @UI.lineItem: [{ position: 40 , label: 'EnrolledOn' }]
      EnrolledOn,
      @UI.lineItem: [{ position: 50 , label: 'CancelledOn' }]
      CancelledOn,
      @UI.hidden: true
      StatusText,
      @UI.lineItem: [{ position: 60 , label: 'status' }]
      status,
      @UI.lineItem: [{ position: 70 , label: 'SuspendStartDate' }]
      SuspendStartDate,
      @UI.lineItem: [{ position: 80 , label: 'SuspendEndDate' }]
      SuspendEndDate,
      @UI.lineItem: [{ position: 90 , label: 'street1' }]
      street1,
      @UI.hidden: true
      street2,
      @UI.lineItem: [{ position: 100 , label: 'city' }]
      city,
      @UI.lineItem: [{ position: 110 , label: 'state' }]
      state,
      @UI.lineItem: [{ position: 120 , label: 'country' }]
      country,
      @UI.lineItem: [{ position: 130 , label: 'zipcode' }]
      zipcode
}
