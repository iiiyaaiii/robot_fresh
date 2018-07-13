*** Settings ***
Suite Setup
Suite Teardown		Close All Browsers
Library				Selenium2Library
Resource			variable.robot


*** Keywords ***
Login to shop
  Open Browser    ${URL}        Chrome
  Maximize Browser Window
  Input Text        ${css_username}       ${username}
  Input Text        ${css_password}       ${password}
  Click Element     ${login_btn}
  Sleep  10s

Access add product page
  Go To    ${add_product_url}
  Sleep  5s
  Element Should Be Visible     ${css_form_create}

Select product category
  Select From List        ${css_select_category1}        ${category1}
  Wait Until Element Is Visible     ${css_select_category2}       10s
  Select From List        ${css_select_category2}        ${category2}
  Wait Until Element Is Visible     ${css_select_category3}       10s
  Select From List        ${css_select_category3}        ${category3}


Input product name    [Arguments]       ${name}
  Input Text        ${css_product_nameTH}       ${name}

Input product detail    [Arguments]       ${detail}
  Click Element     ${css_product_detail_field}
  Sleep  5s
  Input Text        ${css_product_detail_field}       ${detail}

Input product unit    [Arguments]       ${unit}
  Input Text        ${css_product_unit}         ${unit}

Input product sku   [Arguments]       ${sku}
  Input Text        ${css_product_sku}          ${sku}

Input product weight   [Arguments]       ${weight}
  Input Text        ${css_product_weight}       ${weight}

Input product price   [Arguments]       ${price}
  Input Text        ${css_product_price}           ${price}

Input product compare price   [Arguments]       ${compare_price}
  Input Text        ${css_product_compare_price}       ${compare_price}

Input product width   [Arguments]       ${width}
  Input Text        ${css_product_d_width}           ${width}

Input product length   [Arguments]       ${length}
  Input Text        ${css_product_d_length}          ${length}

Input product height   [Arguments]       ${height}
  Input Text        ${css_product_d_height}          ${height}


Upload file product picture       [Arguments]       ${picture_name}
  Click Element     ${css_upload_pic_btn}
  Sleep  5s
  Choose File       ${input_file}         ${picture_path}${picture_name}
  Sleep  3s
  Click Button      ${save_pic_btn}
  Sleep  3s

Create Products        [Arguments]       ${amount}
  ${i} =  Set Variable		${1}
	:FOR  ${index}  IN RANGE  ${amount}
  \  Log To Console         Adding product# ${i}
	\  Select product category
  \  Input product name        ${product_nameTH${i}}
  \  Input product detail      ${product_detailTH${i}}
  \  Input product unit        ${product_unit${i}}
  \  Input product sku         ${product_sku${i}}
  \  Input product weight      ${product_weight${i}}
  \  Input product price       ${product_price${i}}
  \  Input product compare price      ${product_compare_price${i}}
  \  Input product width      ${product_d_width${i}}
  \  Input product length     ${product_d_length${i}}
  \  Input product height     ${product_d_height${i}}
  \  Upload file product picture    ${product_pic${i}}
  \  Click Element    ${save_and_addbtn}
  \  ${i} =  Set Variable		${i+1}
  \  Run Keyword If 				${i} > ${amount} 			Exit For Loop


*** Test Cases ***
Create products successful
  Login to shop
  Sleep  5s
  Access add product page
  Create Products     5
