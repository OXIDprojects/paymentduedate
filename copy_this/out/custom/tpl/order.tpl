[{assign var="template_title" value="ORDER_COMPLETEORDER"|oxmultilangassign}]
[{include file="_header.tpl" title=$template_title location=$template_title}]

<!-- ordering steps -->
[{include file="inc/steps_item.tpl" highlight=4}]

  <div class="box notice">
    <b class="fs10 def_color_1">[{ oxmultilang ident="ORDER_VERIFYYOURINPUT" }]</b>
  </div>

[{ if $oView->isConfirmAGBActive() && $oView->isConfirmAGBError() == 1 }]
    <div class="errorbox">[{ oxmultilang ident="ORDER_READANDCONFIRMTERMS" }]</div>
[{/if}]

[{ if !$oxcmp_basket->getProductsCount()  }]
  <div class="msg">[{ oxmultilang ident="ORDER_BASKETEMPTY" }]</div>
[{else}]
[{assign var="currency" value=$oView->getActCurrency() }]

  [{if $oView->isLowOrderPrice()}]
      <div class="bar prevnext order">
        <div class="minorderprice">[{ oxmultilang ident="BASKET_MINORDERPRICE" }] [{ $oView->getMinOrderPrice() }] [{ $currency->sign }]</div>
      </div>
  [{else}]
    [{if $oView->showOrderButtonOnTop()}]
      <div class="bar prevnext terms">
        <form action="[{ $oViewConf->getSslSelfLink() }]" method="post">
          <div>
              [{ $oViewConf->getHiddenSid() }]
              [{ $oViewConf->getNavFormParams() }]
              <input type="hidden" name="cl" value="order">
              <input type="hidden" name="fnc" value="[{$oView->getExecuteFnc()}]">
              <input type="hidden" name="challenge" value="[{$challenge}]">
              <div class="right arrowright">
                  <input id="test_OrderSubmitTop" type="submit" value="[{ oxmultilang ident="ORDER_SUBMITORDER" }]">
              </div>
              [{if $oView->isConfirmAGBActive() }]
                <div class="termsconfirm">
                    <input type="hidden" name="ord_agb" value="0">
                    <table>
                      <tr>
                        <td><input id="test_OrderConfirmAGBTop" type="checkbox" class="chk" name="ord_agb" value="1"></td>
                        <td>
                            [{assign var="oCont" value=$oView->getContentByIdent("oxagb") }]
                            [{ oxmultilang ident="ORDER_IAGREETOTERMS1" }] <a id="test_OrderOpenAGBTop" rel="nofollow" href="[{ $oCont->getLink() }]" onclick="window.open('[{ $oCont->getLink()|oxaddparams:"plain=1"}]', 'agb_popup', 'resizable=yes,status=no,scrollbars=yes,menubar=no,width=620,height=400');return false;">[{ oxmultilang ident="ORDER_IAGREETOTERMS2" }]</a> [{ oxmultilang ident="ORDER_IAGREETOTERMS3" }],&nbsp;
                            [{assign var="oCont" value=$oView->getContentByIdent("oxrightofwithdrawal") }]
                            [{ oxmultilang ident="ORDER_IAGREETORIGHTOFWITHDRAWAL1" }] <a id="test_OrderOpenWithdrawalTop" rel="nofollow" href="[{ $oCont->getLink() }]" onclick="window.open('[{ $oCont->getLink()|oxaddparams:"plain=1"}]', 'rightofwithdrawal_popup', 'resizable=yes,status=no,scrollbars=yes,menubar=no,width=620,height=400');return false;">[{ $oCont->oxcontents__oxtitle->value }]</a> [{ oxmultilang ident="ORDER_IAGREETORIGHTOFWITHDRAWAL3" }]
                        </td>
                      </tr>
                    </table>
                </div>
              [{/if}]
          </div>
        </form>
      </div>
    [{/if}]
  [{/if}]

  <!-- basket contents -->

  <table class="basket" width="569">

      <colgroup>
        <col width="7">
        <col width="70">
        <col width="124">
        <col width="85">
        <col width="75">
        <col width="55">
        <col width="40">
        <col width="78">
        <col width="7">
      </colgroup>

      <!-- basket header -->
      <thead>
        <tr>
            <th class="brd"><div class="brd_line">&nbsp;</div></th>
            <th>[{ oxmultilang ident="ORDER_ARTICLE" }]</th>
            <th></th>
            <th>[{if $oView->isWrapping() }][{ oxmultilang ident="ORDER_GIFTOPTION" }][{/if}]</th>
            <th class="ta_right">[{ oxmultilang ident="ORDER_UNITPRICE" }]</th>
            <th class="ta_right">[{ oxmultilang ident="ORDER_QUANTITY" }]</th>
            <th class="ta_right">[{ oxmultilang ident="ORDER_TAX" }]</th>
            <th class="ta_right">[{ oxmultilang ident="ORDER_TOTAL" }]</th>
            <th class="lastcol"></th>
        </tr>
      </thead>

      <!-- basket items -->
      [{assign var="basketitemlist" value=$oView->getBasketArticles() }]
      [{foreach key=basketindex from=$oxcmp_basket->getContents() item=basketitem name=testArt}]
      [{assign var="basketproduct" value=$basketitemlist.$basketindex }]
        <tr>
          <!-- product image -->
          <td class="brd"></td>
          <td>
              <a id="test_orderPic_[{ $basketproduct->oxarticles__oxid->value }]_[{$smarty.foreach.testArt.iteration}]" class="picture" href="[{ $basketproduct->getLink() }]">
                <img src="[{$basketproduct->getIconUrl()}]" alt="[{ $basketproduct->oxarticles__oxtitle->value|strip_tags }]">
              </a>
          </td>

          <!-- product title & number -->
          <td>

            <div class="art_title"><a id="test_orderUrl_[{ $basketproduct->oxarticles__oxid->value }]_[{$smarty.foreach.testArt.iteration}]" rel="nofollow" href="[{ $basketproduct->getLink() }]">[{ $basketproduct->oxarticles__oxtitle->value }][{if $basketproduct->oxarticles__oxvarselect->value }], [{ $basketproduct->oxarticles__oxvarselect->value }][{/if }]</a>[{if $basketitem->blSkipDiscounts }] <sup><a rel="nofollow" href="#SkipDiscounts_link" class="note">**</a></sup>[{/if}]</div>
            <div class="art_num" id="test_orderArtNo_[{ $basketproduct->oxarticles__oxid->value }]_[{$smarty.foreach.testArt.iteration}]">[{ oxmultilang ident="ORDER_ARTICLENOMBER" }] [{ $basketproduct->oxarticles__oxartnum->value }]</div>

            [{if $basketitem->isBundle() }]
            [{else}]
                [{foreach from=$basketitem->getChosenSelList() item=oList}]
                  [{ $oList->name }] : [{ $oList->value }]<br>
                [{/foreach}]
            [{/if}]

          </td>

          <!-- product quantity manager -->
          <td>
            [{if $oView->isWrapping() }]
              [{ if !$basketitem->getWrappingId() }]
                [{ oxmultilang ident="ORDER_NONE" }]<br />
              [{else}]
                [{assign var="oWrap" value=$basketitem->getWrapping() }]
                [{$oWrap->oxwrapping__oxname->value}]<br />
              [{/if}]
              <span class="wrapmod">
                  <a id="test_orderWrapp_[{ $basketproduct->oxarticles__oxid->value }]_[{$smarty.foreach.testArt.iteration}]" rel="nofollow" href="[{ oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=wrapping" params="aid="|cat:$basketitem->getProductId() }]" title="[{ oxmultilang ident="ORDER_MODIFYALT" }]">[{ oxmultilang ident="ORDER_MODIFY" }]</a>
              </span>
            [{/if}]
          </td>

          <!-- product price -->
          <td id="test_orderUnitPrice_[{ $basketproduct->oxarticles__oxid->value }]_[{$smarty.foreach.testArt.iteration}]" class="orderprice" align="right">
            [{if $basketitem->getFUnitPrice() }][{ $basketitem->getFUnitPrice() }]&nbsp;[{ $currency->sign}][{/if}]
          </td>

          <!-- product count -->
          <td id="test_orderUnitCount_[{ $basketproduct->oxarticles__oxid->value }]_[{$smarty.foreach.testArt.iteration}]" class="amount" align="right">
            [{if $basketitem->getdBundledAmount() > 0 && ($basketitem->isBundle() || $basketitem->isDiscountArticle()) }]
             <b class="note">+[{ $basketitem->getdBundledAmount() }]</b>
            [{else}]
             [{ $basketitem->getAmount() }]&nbsp;
            [{/if}]
          </td>

          <!-- product VAT percent -->
          <td id="test_orderUnitVat_[{ $basketproduct->oxarticles__oxid->value }]_[{$smarty.foreach.testArt.iteration}]" class="vat_order">
            [{ $basketitem->getVatPercent()}]%
          </td>

          <!-- product quantity * price -->
          <td id="test_orderTotalPrice_[{ $basketproduct->oxarticles__oxid->value }]_[{$smarty.foreach.testArt.iteration}]" align="right" class="totalprice">
            [{ $basketitem->getFTotalPrice() }]&nbsp;[{ $currency->sign}]
          </td>
          <td></td>
        </tr>

        [{foreach key=sVar from=$basketitem->getPersParams() item=aParam name=orderPersParam}]
          <tr>
            <td class="brd"></td>
            <td id="test_orderPersParam_[{ $basketproduct->oxarticles__oxid->value }]_[{$smarty.foreach.orderPersParam.iteration}]" colspan="7">[{$sVar}] : <input type="text" name="persparam[[{$sVar}]]" value="[{$aParam}]" readonly disabled></td>
            <td></td>
          </tr>
        [{/foreach}]

      [{foreach from=$Errors.basket item=oEr key=key name=orderErrors}]
       [{if $oEr->getErrorClassType() == 'oxOutOfStockException'}]
       <!-- display only the excpetions for the current article-->
           [{if $basketitem->sProduct == $oEr->getValue('productId') }]
           <tr>
             <td class="brd"></td>
             <td id="test_orderErrors_[{ $basketproduct->oxarticles__oxid->value }]_[{$smarty.foreach.orderErrors.iteration}]" colspan="7"><span class="err">[{ $oEr->getOxMessage() }] [{ $oEr->getValue('remainingAmount') }]</span></td>
             <td></td>
           </tr>
           [{/if}]
        [{/if}]
        [{/foreach}]

        <tr class="bsk_sep">
          <td class="brd"></td>
          <td colspan="7" class="line"></td>
          <td></td>
        </tr>
      <!--  basket items end  -->
      [{/foreach}]


      [{assign var="oCard" value=$oxcmp_basket->getCard() }]
      [{ if $oCard }]
        <tr class="sumrow">
          <td class="brd"></td>
          <td id="test_orderCardTitle" colspan="3"><b class="fs10">[{ oxmultilang ident="ORDER_GREETINGCARD" }] "[{ $oCard->oxwrapping__oxname->value }]"</b></td>
          <td id="test_orderCardPrice" align="right" class="orderprice">[{ $oCard->getFPrice() }]&nbsp;[{ $currency->sign }]</td>
          <td class="font10"></td>
          <td id="test_orderCardTotalPrice" align="right" class="orderprice">[{ $oCard->getFPrice() }]&nbsp;[{ $currency->sign }]</td>
          <td></td>
          <td></td>
        </tr>
        <tr class="sumrow">
          <td class="brd"></td>
          <td colspan="3"><b class="fs10">[{ oxmultilang ident="ORDER_YOURMESSAGE" }]</b></td>
          <td colspan="4"></td>
          <td></td>
        </tr>
        <tr class="sumrow">
          <td class="brd"></td>
          <td colspan="3"><div id="test_orderCardText" class="fs10">[{ $oxcmp_basket->getCardMessage()|nl2br }]</div></td>
          <td colspan="4"></td>
          <td></td>
        </tr>
        <tr class="bsk_sep">
          <td class="brd"></td>
          <td colspan="7" class="line"></td>
          <td></td>
        </tr>
      [{/if}]

      [{if !$oxcmp_basket->getDiscounts() }]
          <tr class="sumrow">
              <td class="brd"></td>
              <td colspan="6" class="sumdesc">[{ oxmultilang ident="ORDER_TOTALNET" }]</td>
              <td id="test_orderNetPrice" align="right">[{ $oxcmp_basket->getProductsNetPrice() }]&nbsp;[{ $currency->sign}]</td>
              <td></td>
          </tr>

          [{foreach from=$oxcmp_basket->getProductVats() item=VATitem key=key}]
            <tr class="sumrow">
              <td class="brd"></td>
              <td colspan="6" class="sumdesc">[{ oxmultilang ident="ORDER_PLUSTAX1" }] [{ $key }][{ oxmultilang ident="ORDER_PLUSTAX2" }]</td>
              <td id="test_orderVat_[{ $key }]" align="right">[{ $VATitem }]&nbsp;[{ $currency->sign}]</td>
              <td></td>
            </tr>
          [{/foreach}]
      [{/if}]
      <tr class="sumrow">
        <td class="brd"></td>
        <td colspan="6" class="sumdesc">[{ oxmultilang ident="ORDER_TOTALGROSS" }]</td>
        <td id="test_orderGrossPrice" align="right">[{ $oxcmp_basket->getFProductsPrice() }]&nbsp;[{ $currency->sign}]</td>
        <td></td>
      </tr>

      [{ if $oxcmp_basket->getDiscounts() }]
        <tr class="bsk_sep">
          <td class="brd"></td>
          <td colspan="7" class="line"></td>
          <td></td>
        </tr>
        [{foreach from=$oxcmp_basket->getDiscounts() item=oDiscount name=orderDiscounts}]
        <tr class="sumrow">
          <td class="brd"></td>
          <td id="test_orderDiscountTitle_[{$smarty.foreach.orderDiscounts.iteration}]" colspan="6" class="sumdesc discount">
            <b class="fs11">[{if $oDiscount->dDiscount < 0 }][{ oxmultilang ident="ORDER_CHARGE" }][{else}][{ oxmultilang ident="ORDER_DISCOUNT" }][{/if}] </b>
            [{ $oDiscount->sDiscount }]:
          </td>
          <td id="test_orderDiscount_[{$smarty.foreach.orderDiscounts.iteration}]" align="right">
            [{if $oDiscount->dDiscount < 0 }][{ $oDiscount->fDiscount|replace:"-":"" }][{else}]-[{ $oDiscount->fDiscount }][{/if}]&nbsp;[{ $currency->sign}]
          </td>
          <td></td>
        </tr>
        [{/foreach}]
        <tr class="sumrow">
          <td class="brd"></td>
          <td colspan="6" class="sumdesc">[{ oxmultilang ident="ORDER_TOTALNET" }]</td>
          <td id="test_orderNetPrice" align="right">[{ $oxcmp_basket->getProductsNetPrice() }]&nbsp;[{ $currency->sign}]</td>
          <td></td>
        </tr>

        [{foreach from=$oxcmp_basket->getProductVats() item=VATitem key=key name=orderVats}]
        <tr class="sumrow">
          <td class="brd"></td>
          <td colspan="6" class="sumdesc">[{ oxmultilang ident="ORDER_PLUSTAX1" }] [{ $key }][{ oxmultilang ident="ORDER_PLUSTAX2" }]</td>
          <td id="test_orderVat_[{ $key }]" align="right">[{ $VATitem }]&nbsp;[{ $currency->sign}]</td>
          <td></td>
        </tr>
        [{/foreach}]
      [{/if}]

      [{if $oxcmp_basket->getVoucherDiscValue() }]
        <tr class="bsk_sep">
          <td class="brd"></td>
          <td colspan="7" class="line"></td>
          <td></td>
        </tr>
        [{foreach from=$oxcmp_basket->getVouchers() item=sVoucher key=key name=orderVouchers}]
          <tr>
            <td class="brd"></td>
            <td id="test_orderVoucherNr_[{$smarty.foreach.orderVouchers.iteration}]" colspan="6" class="sumdesc coupon">
              <b class="fs11">&nbsp;&nbsp;[{ oxmultilang ident="ORDER_COUPON" }]</b>
              [{ oxmultilang ident="ORDER_NOMBER" }] [{ $sVoucher->sVoucherNr }]):
            </td>
            <td id="test_orderVoucher_[{$smarty.foreach.orderVouchers.iteration}]" align="right">-[{ $sVoucher->fVoucherdiscount }]&nbsp;[{ $currency->sign}]</td>
            <td></td>
          </tr>
        [{/foreach }]
      [{/if}]
        <tr class="bsk_sep">
          <td class="brd"></td>
          <td colspan="7" class="line"></td>
          <td></td>
        </tr>

        <tr class="sumrow">
          <td class="brd"></td>
          <td colspan="6" class="sumdesc">[{if $oxcmp_basket->getDelCostVat() }][{ oxmultilang ident="ORDER_SHIPPINGNET" }][{else}][{ oxmultilang ident="ORDER_SHIPPINGGROSS1" }][{/if}]</td>
          <td id="test_orderShippingNet" align="right">[{ $oxcmp_basket->getDelCostNet() }]&nbsp;[{ $currency->sign}]</td>
          <td></td>
        </tr>
      [{if $oxcmp_basket->getDelCostVat()}]
        <tr class="sumrow">
          <td class="brd"></td>
          <td colspan="6" class="sumdesc">[{ oxmultilang ident="ORDER_PLUSSHIPPINGTAX1" }] [{ $oxcmp_basket->getDelCostVatPercent() }][{ oxmultilang ident="ORDER_PLUSSHIPPINGTAX2" }]</td>
          <td id="test_orderShippingVat" align="right">[{ $oxcmp_basket->getDelCostVat() }]&nbsp;[{ $currency->sign}]</td>
          <td></td>
        </tr>
      [{/if}]

      [{ if $oxcmp_basket->getPaymentCosts() }]
        <tr class="sumrow">
          <td class="brd"></td>
          <td colspan="6" class="sumdesc">[{if $oxcmp_basket->getPaymentCosts() >= 0 }][{ oxmultilang ident="ORDER_PAYMENT1" }][{else}][{ oxmultilang ident="ORDER_PAYMENT2" }][{/if}] [{ oxmultilang ident="ORDER_PAYMENT3" }]</td>
          <td id="test_orderPaymentNet" align="right">[{ $oxcmp_basket->getPayCostNet() }]&nbsp;[{ $currency->sign}]</td>
          <td></td>
        </tr>
        [{ if $oxcmp_basket->getPayCostVat() }]
          <tr class="sumrow">
            <td class="brd"></td>
            <td colspan="6" class="sumdesc">[{ oxmultilang ident="ORDER_PAYMENTCHARGETAX1" }] [{ $oxcmp_basket->getPayCostVatPercent()}][{ oxmultilang ident="ORDER_PAYMENTCHARGETAX2" }]</td>
            <td id="test_orderPaymentVat" align="right">[{ $oxcmp_basket->getPayCostVat() }]&nbsp;[{ $currency->sign}]</td>
            <td></td>
          </tr>
        [{/if}]
      [{/if}]
      [{ if $oxcmp_basket->getWrappCostNet() }]
          <tr class="sumrow">
            <td class="brd"></td>
            <td colspan="6" class="sumdesc">[{if $oxcmp_basket->getWrappCostVat() }][{ oxmultilang ident="ORDER_WRAPPINGNET" }][{else}][{ oxmultilang ident="ORDER_WRAPPINGGROSS1" }][{/if}]</td>
            <td id="test_orderWrappNet" align="right">[{ $oxcmp_basket->getWrappCostNet() }] [{ $currency->sign}]</td>
            <td></td>
          </tr>
        [{if $oxcmp_basket->getWrappCostVat() }]
          <tr class="sumrow">
            <td class="brd"></td>
            <td colspan="6" class="sumdesc">[{ oxmultilang ident="ORDER_WRAPPINGTAX1" }] [{ $oxcmp_basket->getWrappCostVatPercent() }][{ oxmultilang ident="ORDER_WRAPPINGTAX2" }]</td>
            <td id="test_orderWrappVat" align="right">[{ $oxcmp_basket->getWrappCostVat() }] [{ $currency->sign}]</td>
            <td></td>
          </tr>
        [{/if}]

      [{/if}]
        <tr class="bsk_sep">
          <td class="brd"></td>
          <td colspan="7" class="line"></td>
          <td></td>
        </tr>
      <tr class="sumrow total">
        <td class="brd"></td>
        <td colspan="6" class="sumdesc"><b>[{ oxmultilang ident="ORDER_GRANDTOTAL" }]</b></td>
        <td id="test_orderGrandTotal" align="right"><b>[{ $oxcmp_basket->getFPrice() }]&nbsp;[{ $currency->sign}]</b></td>
        <td></td>
      </tr>
      <tr class="bsk_sep">
        <td class="brd"></td>
        <td colspan="7" class="bigline"></td>
        <td></td>
      </tr>
	  <tr class="sumrow">
	    <td class="brd"></td>
		<td colspan="7">[{foreach from=$oxcmp_basket->aPaymentId4Allowance item=sPaymentAllowanceActive}][{if $sPaymentAllowanceActive == $oxcmp_basket->getPaymentId() && $oxcmp_basket->dPaymentAllowanceSum !== 0 }][{ oxmultilang ident="ORDER_ALLOWANCE1"}][{$oxcmp_basket->sAllowanceDate}][{ oxmultilang ident="ORDER_ALLOWANCE2"}][{ $oxcmp_basket->fPaymentAllowanceSum }][{ $currency->sign}][{ oxmultilang ident="ORDER_ALLOWANCE3"}][{$oxcmp_basket->fAllowancePrice}][{ $currency->sign}])[{/if}][{/foreach}]</td>
	  </tr>

      [{if $oxcmp_basket->hasSkipedDiscount() }]
        <tr class="sumrow">
          <td class="brd"></td>
          <td colspan="7"><span id="SkipDiscounts_link"><span class="note">**</span> [{ oxmultilang ident="ORDER_DISCOUNTS_NOT_APPLIED_FOR_ARTICLES" }]</span></td>
          <td></td>
        </tr>
      [{/if}]

      <tr class="sumrow">
        <td colspan="9" class="brd bottrow"></td>
      </tr>
    </table>


    [{ if $oxcmp_basket->getVouchers()}]
      <strong class="boxhead">[{ oxmultilang ident="ORDER_USEDCOUPONS" }]</strong>
      <div class="box info">
       [{foreach from=$Errors.basket item=oEr key=key }]
        [{if $oEr->getErrorClassType() == 'oxVoucherException'}]
           <span class="err">[{ oxmultilang ident="BASKET_COUPONNOTACCEPTED1" }] [{ $oEr->getValue('voucherNr') }] [{ oxmultilang ident="BASKET_COUPONNOTACCEPTED2" }]</span><br>
           <span class="err">[{ oxmultilang ident="BASKET_REASON" }]</span>
           <span class="err">[{ $oEr->getOxMessage() }]</span><br>
         [{/if}]
        [{/foreach}]
        [{foreach from=$oxcmp_basket->getVouchers() item=sVoucher key=key name=aVouchers}]
          <span id="test_orderVouchersUsed_[{$smarty.foreach.aVouchers.iteration}]">[{ $sVoucher->sVoucherNr }]</span><br>
        [{/foreach }]
      </div>
    [{/if}]

    <strong class="boxhead">[{ oxmultilang ident="ORDER_SEND" }]</strong>
    <div class="box info">

      <dl id="test_orderBillAdress" class="orderinfocol">
        <dt>[{ oxmultilang ident="ORDER_BILLINGADDRESS" }]</dt>
        <dd>
            <form action="[{ $oViewConf->getSslSelfLink() }]" method="post">
              <div>
                  [{ $oViewConf->getHiddenSid() }]
                  <input type="hidden" name="cl" value="user">
                  <input type="hidden" name="fnc" value="">
                  <span class="btn"><input id="test_orderChangeBillAdress" type="submit" value="[{ oxmultilang ident="ORDER_MODIFYADDRESS2" }]" class="btn"></span>
              </div>
            </form>
            <br>
            [{ oxmultilang ident="ORDER_EMAIL" }]&nbsp;[{ $oxcmp_user->oxuser__oxusername->value }]<br>
            [{ $oxcmp_user->oxuser__oxcompany->value }]&nbsp;<br>

            [{assign var=_sal value=$oxcmp_user->oxuser__oxsal->value}]
            [{oxmultilang ident="SALUTATION_$_sal" noerror="yes" alternative=$_sal }]&nbsp;[{ $oxcmp_user->oxuser__oxfname->value }]&nbsp;[{ $oxcmp_user->oxuser__oxlname->value }]<br>
            [{ $oxcmp_user->oxuser__oxaddinfo->value }]<br>
            [{ $oxcmp_user->oxuser__oxstreet->value }]&nbsp;[{ $oxcmp_user->oxuser__oxstreetnr->value }]<br>
            [{ $oxcmp_user->oxuser__oxzip->value }]&nbsp;[{ $oxcmp_user->oxuser__oxcity->value }]<br>
            [{ $oxcmp_user->oxuser__oxcountry->value }]<br><br>
            [{ oxmultilang ident="ORDER_PHONE" }] [{ $oxcmp_user->oxuser__oxfon->value }]&nbsp;<br>
        </dd>
      </dl>

      <dl id="test_orderShipAdress" class="orderinfocol">
        <dt>[{ oxmultilang ident="ORDER_SHIPPINGADDRESS" }]</dt>
        <dd>
            <form action="[{ $oViewConf->getSslSelfLink() }]" method="post">
              <div>
                  [{ $oViewConf->getHiddenSid() }]
                  <input type="hidden" name="cl" value="user">
                  <input type="hidden" name="fnc" value="">
                  <span class="btn"><input id="test_orderChangeShipAdress" type="submit" value="[{ oxmultilang ident="ORDER_MODIFYADDRESS2" }]" class="btn"></span>
              </div>
            </form>
            <br>
            [{assign var="oDelAdress" value=$oView->getDelAddress() }]
            [{if $oDelAdress }]
              <br>
              [{ $oDelAdress->oxaddress__oxcompany->value }]&nbsp;<br>
              [{assign var=_sal value=$oDelAdress->oxaddress__oxsal->value}]
              [{oxmultilang ident="SALUTATION_$_sal" noerror="yes" alternative=$_sal }]&nbsp;[{ $oDelAdress->oxaddress__oxfname->value }]&nbsp;[{ $oDelAdress->oxaddress__oxlname->value }]<br>
              [{ $oDelAdress->oxaddress__oxaddinfo->value }]<br>
              [{ $oDelAdress->oxaddress__oxstreet->value }]&nbsp;[{ $oDelAdress->oxaddress__oxstreetnr->value }]<br>
              [{ $oDelAdress->oxaddress__oxzip->value }]&nbsp;[{ $oDelAdress->oxaddress__oxcity->value }]<br>
              [{ $oDelAdress->oxaddress__oxcountry->value }]<br><br>
              [{ oxmultilang ident="ORDER_PHONE2" }] [{ $oDelAdress->oxaddress__oxfon->value }]&nbsp;<br>
            [{/if}]
        </dd>
      </dl>

      <br class="clear_left">

      <div class="dot_sep"></div>
        <b>[{ oxmultilang ident="ORDER_WHATIWANTEDTOSAY" }]</b>
      <div class="dot_sep"></div>
      [{ $oView->getOrderRemark() }]

    </div>

    <strong id="test_ShipPaymentHeader" class="boxhead">[{ oxmultilang ident="ORDER_SHIPPINGANDPAYMENT" }]</strong>
    <div class="box info">

      <dl class="orderinfocol">
        <dt>[{ oxmultilang ident="ORDER_SHIPPINGCARRIER" }]</dt>
        <dd>
            <form action="[{ $oViewConf->getSslSelfLink() }]" method="post">
              <div  id="test_orderShipping">
                  [{ $oViewConf->getHiddenSid() }]
                  <input type="hidden" name="cl" value="payment">
                  <input type="hidden" name="fnc" value="">
                  [{assign var="oShipSet" value=$oView->getShipSet() }]
                  [{ $oShipSet->oxdeliveryset__oxtitle->value }]&nbsp;<span class="btn"><input id="test_orderChangeShipping" type="submit" value="[{ oxmultilang ident="ORDER_MODIFY3" }]" class="btn"></span>
              </div>
            </form>
        </dd>
      </dl>

      <dl class="orderinfocol">
        <dt>[{ oxmultilang ident="ORDER_PAYMENTMETHOD" }]</dt>
        <dd>
            <form action="[{ $oViewConf->getSslSelfLink() }]" method="post">
              <div  id="test_orderPayment">
                  [{ $oViewConf->getHiddenSid() }]
                  <input type="hidden" name="cl" value="payment">
                  <input type="hidden" name="fnc" value="">
                  [{assign var="payment" value=$oView->getPayment() }]
                  [{ $payment->oxpayments__oxdesc->value }]&nbsp;<span class="btn"><input id="test_orderChangePayment" type="submit" value="[{ oxmultilang ident="ORDER_MODIFY2" }]" class="btn"></span>
              </div>
            </form>
        </dd>
      </dl>

    </div>


    <strong id="test_WithdrawalHeader" class="boxhead">[{ oxmultilang ident="ORDER_RIGHTOFWITHDRAWAL" }]</strong>
    <div class="box info">

        <p id="test_WithdrawalText">
          [{ oxmultilang ident="ORDER_RIGHTOFWITHDRAWAL_TEXT" }]
          [{ $oxcmp_shop->oxshops__oxcompany->value }], [{ $oxcmp_shop->oxshops__oxstreet->value }], [{ $oxcmp_shop->oxshops__oxzip->value }] [{$oxcmp_shop->oxshops__oxcity->value }], [{ $oxcmp_shop->oxshops__oxcountry->value }].
          <br /><br />
        </p>

        <p>
          [{assign var="oCont" value=$oView->getContentByIdent("oxrightofwithdrawal") }]
          [{ oxmultilang ident="ORDER_RIGHTOFWITHDRAWAL_MOREINFO1" }] <a id="test_OpenWithdrawal" rel="nofollow" href="[{ $oCont->getLink() }]" class="fontunderline">[{ $oCont->oxcontents__oxtitle->value }]</a>.
        </p>

    </div>


        [{if $oView->isLowOrderPrice() }]
          <div class="bar prevnext order">
            <div class="minorderprice">[{ oxmultilang ident="BASKET_MINORDERPRICE" }] [{ $oView->getMinOrderPrice() }] [{ $currency->sign }]</div>
          </div>
        [{else}]
          <div class="bar prevnext terms">
            <form action="[{ $oViewConf->getSslSelfLink() }]" method="post">
              <div>
                  [{ $oViewConf->getHiddenSid() }]
                  [{ $oViewConf->getNavFormParams() }]
                  <input type="hidden" name="cl" value="order">
                  <input type="hidden" name="fnc" value="[{$oView->getExecuteFnc()}]">
                  <input type="hidden" name="challenge" value="[{$challenge}]">

                  <div class="right arrowright">
                      <input id="test_OrderSubmitBottom" type="submit" value="[{ oxmultilang ident="ORDER_SUBMITORDER" }]">
                  </div>

                  [{if $oView->isConfirmAGBActive()}]
                    <div class="termsconfirm">
                        <input type="hidden" name="ord_agb" value="0">
                        <table>
                          <tr>
                            <td><input id="test_OrderConfirmAGBBottom" type="checkbox" class="chk" name="ord_agb" value="1"></td>
                            <td>
                                [{assign var="oCont" value=$oView->getContentByIdent("oxagb") }]
                                [{ oxmultilang ident="ORDER_IAGREETOTERMS1" }] <a id="test_OrderOpenAGBBottom" rel="nofollow" href="[{ $oCont->getLink() }]" onclick="window.open('[{ $oCont->getLink()|oxaddparams:"plain=1"}]', 'agb_popup', 'resizable=yes,status=no,scrollbars=yes,menubar=no,width=620,height=400');return false;" class="fontunderline">[{ oxmultilang ident="ORDER_IAGREETOTERMS2" }]</a> [{ oxmultilang ident="ORDER_IAGREETOTERMS3" }],&nbsp;
                                [{assign var="oCont" value=$oView->getContentByIdent("oxrightofwithdrawal") }]
                                [{ oxmultilang ident="ORDER_IAGREETORIGHTOFWITHDRAWAL1" }] <a id="test_OrderOpenWithdrawalBottom" rel="nofollow" href="[{ $oCont->getLink() }]" onclick="window.open('[{ $oCont->getLink()|oxaddparams:"plain=1"}]', 'rightofwithdrawal_popup', 'resizable=yes,status=no,scrollbars=yes,menubar=no,width=620,height=400');return false;">[{ $oCont->oxcontents__oxtitle->value }]</a> [{ oxmultilang ident="ORDER_IAGREETORIGHTOFWITHDRAWAL3" }]
                            </td>
                          </tr>
                        </table>
                    </div>
                  [{/if}]

              </div>
            </form>
          </div>
        [{/if}]

    &nbsp;
    <br><br><br>

[{/if}]

[{ insert name="oxid_tracker" title=$template_title }]
[{include file="_footer.tpl"}]
