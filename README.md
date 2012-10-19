paymentduedate
==============

configure the due date for payment and add a cash discount on different payment methods to the checkout process and the order confirmation e-mail. The invoicePDF and the admin panel (order management) do not display any information.

Originally registered: 2010-03-23 by OXIDlab on former OXIDforge.

----------------------
ALLOWANCE MODULE

-For all editions of OXID eShop (CE/PE/EE)
-Developed with OXID eShop EE 4.2.0_23610 
-Tested with OXID eShop 4.2.0_23610 EE and CE

Install:
-copy the folders from "copy_this" to the shop root directory.
-change your custom template path to "/custom" or copy
 all files from "copy_this/out/custom/tpl" in your custom
 template directory.
-Customize your config.inc.php (see sample_config.inc.php)
-Customize your cust_lang.php (see sample_cust_lang.php)
-Add module in OXID eShop Admin.
 "payment => allowance/allowancepayment"
 "order => allowance/allowanceorder"

==========================ATTENTION==========================
Depending on your path to custom templates (sCustomTheme in
config.inc.php), former changes maybe overwritten.
=============================================================

=============HowTo Customize your config.inc.php=============
-------------------------Description-------------------------
$this->aAllowance[ShopID] =
array ([value:double],[valuetype(%/absolute):string],
[creditperiod in days:integer], array([PaymentIDs:string]))

ShopID-Path = [Shop Database] -> oxshops -> OXID
Use "1" for OXID eShop PE/CE.

PaymentID-Path = Database -> oxpayments -> OXID  

---------------------------Example---------------------------
2% allowance for shop 1 if customer pays during 14 days via 
invoice or prepayment

$this->aAllowance[1] = 
array(2.0,'%',14, array ( 'oxidpayadvance', 'oxidinvoice'))
=============================================================

Have fun!
