*** Settings ***
Library     WebServiceLib
Library    DateTime

*** Variables ***
${TIME}   2018-10-09T16:10:10.111+05:30

${GetConfigFiles2000}    Get_Config_Files
${GetConfigFiles1001}    Get_Config_Files_inval_parameters
${GetConfigFiles400}     Get_Config_Files_bad_request

*** Keywords ***

Customer OnBoaring
    [arguments]  ${r}
    run keyword if  '${TESTCASE_NAME${r}}' == '${GetConfigFiles2000}'  Get Config Files
 #   run keyword if  '${TESTCASE_NAME${r}}' == '${GetConfigFiles1001}'  Get Config Files with invalid parameters
 #   run keyword if  '${TESTCASE_NAME${r}}' == '${GetConfigFiles400}'  Get Config Files with bad request

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