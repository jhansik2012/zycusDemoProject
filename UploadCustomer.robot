*** Settings ***
Library  Collections
Library  OperatingSystem
Library  RequestsLibrary
Library     WebServiceLib

*** Keywords ***

Customer OnBoaring
    [arguments]  ${r}
    run keyword if  '${TESTCASE_NAME${r}}' == 'Upload_Customer'  Upload Customer by Create Multi Part

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
