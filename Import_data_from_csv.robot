*** Settings ***
Library           Collections
Library           ExcelLibrary
Library           Selenium2Library
Suite Teardown		Close All Browsers

*** Variables ***

*** Test Cases ***
Open csv file and input data
    Open Excel   C:\\Users\\MP1CCTG4\\Documents\\Fresh_project\\fresh_robot\\MAKRO_products.xlsx
    ${data} =     Get Column Values    MAKRO_products      1
    Log To Console    ${data}
