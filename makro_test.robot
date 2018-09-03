*** Settings ***
Library    Selenium2Library
Resource      makro_test_keyword.robot


*** Test Cases ***
Open makro website and go to main page
    Open makro website
    Register new member
