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

Create Customer
    [Tags]  Create Customer  regression  errorCode2000
    get rest   Create Customer

Create Customer with invalid parameters
    [Tags]  Create Customer  regression  errorCode1001
    get rest   Create CustomerInvalidParameter

Create Customer with bad request
    [Tags]  Create Customer  regression  errorCode400

*** Test Cases ***
Dummy Test case
    log     welcome to test cases execution