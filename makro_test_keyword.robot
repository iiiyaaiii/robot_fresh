*** Keywords ***
Open makro website
    Open Browser      https://www.makroclick.com/th       chrome

Register new member
    Click Element           ${css_registermenu}
    Location Should Be      https://www.makroclick.com/th/members/register
    Input Text              ${input_email}       ${user_email}
