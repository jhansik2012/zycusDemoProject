*** Settings ***
Library     WebServiceLib
Library    DateTime

*** Variables ***
${TIME}   2018-10-09T16:10:10.111+05:30

${Create Customer2000}    Create_Customer
${Create Customer1001}    Create_Customer_inval_parameters
${Create Customer400}     Create_Customer_bad_request

*** Keywords ***

Customer OnBoaring
    [arguments]  ${r}
    run keyword if  '${TESTCASE_NAME${r}}' == '${Create Customer2000}'  Create Customer
    #run keyword if  '${TESTCASE_NAME${r}}' == '${Create Customer1001}'  Create Customer with invalid parameters
    #run keyword if  '${TESTCASE_NAME${r}}' == '${Create Customer400}'  Create Customer with bad request
    run keyword if  '${TESTCASE_NAME${r}}' == 'Upload_Customer'  Upload Customer by Create Multi Part
    run keyword if  '${TESTCASE_NAME${r}}' == '${GetConfigFiles2000}'  Get Config Files

Create Customer
    [Tags]  Create Customer  regression  errorCode2000
    get rest   Create Customer

Create Customer with invalid parameters
    [Tags]  Create Customer  regression  errorCode1001
    get rest   Create CustomerInvalidParameter

Create Customer with bad request
    [Tags]  Create Customer  regression  errorCode400


Upload Customer by Create Multi Part
  [Arguments]  ${addTo}  ${partName}  ${filePath}  ${contentType}=${None}  ${content}=${None}
  &{headers}=  Create Dictionary  user=scott  password=tiger
  ${response}=  RequestsLibrary.Get Request  host  /api/login  ${headers}

  &{fileParts}=  Create Dictionary
  ${fileData}=  Run Keyword If  '''${content}''' != '''${None}'''  Set Variable  ${content}
  ...            ELSE  Get Binary File  ${filePath}
  ${fileDir}  ${fileName}=  Split Path  ${filePath}
  ${partData}=  Create List  ${fileName}  ${fileData}  ${contentType}
  Set To Dictionary  ${addTo}  ${partName}=${partData}
  ${response}=  RequestsLibrary.Post Request  host  /api/contentimport  files=${fileParts}  headers=${headers}
  Log  ${response.status_code}
  Log  ${response.json()}

Get Config Files
    [Tags]  GetConfigFiles  regression  errorCode2000
    get rest   GetConfigFiles

Get Config Files with invalid parameters
    [Tags]  GetConfigFiles  regression  errorCode1001
    get rest   GetConfigFilesInvalidParameter

Get Config Files with bad request
    [Tags]  GetConfigFiles  regression  errorCode400
    get rest   GetConfigFilesBadRequest


*** Test Cases ***
Dummy Test case
    log     welcome to test cases execution