*** Settings ***
Library           Collections
Library           ExcelLibrary
Library           Selenium2Library
Resource          CreateExcelFile.py
Library           CreateExcelFile.ExcelUtility
Suite Teardown		Close All Browsers

*** Variables ***
${makro_url}        https://www.makroclick.com/th
${left_menu}        css=.box-categories-scroll
${css_productitem}        css=div.thumb-product img.img-responsive
${css_productname}        /div[1]/div[2]/div/div[1]/a
${css_productid}          /div[1]/div[2]/div/div[2]
${css_product_price}      /div[1]/div[2]/div/div[4]
${css_productpic}         /div[1]/div[1]/a/div/img
#Product Categories
${frozenfood}       //*[@id="home"]/div[2]/div[1]/div/div[1]/a[2]/div

*** Keywords ***
Go to Makro web page
    Open Browser        ${makro_url}      chrome
    Maximize Browser Window
    Go to product category          ${frozenfood}

Go to product category        [Arguments]         ${category}
    Wait Until Element Is Visible       ${left_menu}       20s
    Click Element           ${frozenfood}

Write products to excel file
    @{content}    Create List
    Append To List    ${content}      0    0    Product Name
    Append To List    ${content}      0    1    Product ID
    Append To List    ${content}      0    2    Price per Item
    Append To List    ${content}      0    3    Product Picture
    ${length} =    Get Element Count        ${css_productitem}
    Log To Console         ${length}
    ${i} =  Set Variable		${1}
  	:FOR  ${index}  IN RANGE  ${length}
    \  ${product_name} =      Get Text        //*[@id="product-layout-container"]/div[${i}]${css_productname}
    \  ${product_id} =        Get Text        //*[@id="product-layout-container"]/div[${i}]${css_productid}
    \  ${product_priceitem} =       Get Text        //*[@id="product-layout-container"]/div[${i}]${css_product_price}
    \  ${product_pic} =       Get Element Attribute         //*[@id="product-layout-container"]/div[${i}]${css_productpic}      src
    \  Append To List    ${content}    ${i}    0    ${product_name}
    \  Append To List    ${content}    ${i}    1      ${product_id}
    \  Append To List    ${content}    ${i}    2      ${product_priceitem}
    \  Append To List    ${content}    ${i}    3     ${product_pic}
    \  ${i} =  Set Variable		${i+1}
    \  Run Keyword If 				${i} > ${length} 			Exit For Loop
    Write To Excel File    MAKRO_products.xlsx    ${content}

*** Test Cases ***
Get Makro products and export to excel file
    Go to Makro web page
    Write products to excel file
