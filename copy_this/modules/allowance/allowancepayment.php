<?php
/**
 * This module extends "_setDeprecatedValues"-function from payment.php. 
 * It gets the "Allowance-Configuration" from "config.inc.php" and calculate
 * allowancesum for every "oxpayment" 
*/
class allowancePayment extends allowancePayment_parent
{
    protected function _setDeprecatedValues( & $aPaymentList, $oBasket = null )
    {
        if ( is_array($aPaymentList) ) {
            $oLang = oxLang::getInstance();
            foreach ( $aPaymentList as $oPayment ) {
                $oPrice = $oPayment->getPaymentPrice( $oBasket );
				$oPayment->dAddPaymentSum = $oPrice->getBruttoPrice();
                $oPayment->fAddPaymentSum = $oLang->formatCurrency( $oPayment->dAddPaymentSum, $oBasket->getBasketCurrency() );
                $oPayment->aDynValues     = $oPayment->getDynValues();
                if ( $oPayment->oxpayments__oxchecked->value ) {
                    $this->_sCheckedId = $oPayment->getId();
				}
				
					
				//Allowance	
				//Get configurationarray from config.inc.php, depending on version
				if ($edition == 'EE' ) {
			        $oPayment->sShopID = oxSession::getVar( "actshop");
			    } else {
			        $oPayment->sShopID = 1;
			    }
					
				$oPayment->aAllowance = $this->getConfig()->getConfigParam( 'aAllowance');
				$oPayment->sAllowanceType = $oPayment->aAllowance[$oPayment->sShopID][1];
				$oPayment->aPaymentId4Allowance = $oPayment->aAllowance[$oPayment->sShopID][3];
				
				//Define allowancesum, depending on allowancetype(percental or absolute)
				if ($oPayment->sAllowanceType == '%') {
				    $oPayment->dAddAllowanceSum = ($oPayment->aAllowance[$oPayment->sShopID][0]/100)*($oBasket->ddeliverycost+$oBasket->dproductsprice+$oPrice->getBruttoPrice());
					$oPayment->fAddAllowanceSum = $oLang->formatCurrency( $oPayment->dAddAllowanceSum, $oBasket->getBasketCurrency() );
				} else if ($oPayment->sAllowanceType == 'abs'){
				    $oPayment->dAddAllowanceSum = $oPayment->aAllowance[$oPayment->sShopID][0];
					$oPayment->fAddAllowanceSum = $oLang->formatCurrency( $oPayment->dAddAllowanceSum, $oBasket->getBasketCurrency() );
				} else {
				    $oPayment->fAddAllowanceSum = '0';
				}
				
				//Prepare calculated data for next step(order)
				$aPaymentAllowanceSums[$oPayment->oxpayments__oxid->value] = array ($oPayment->dAddAllowanceSum, round($oBasket->ddeliverycost+$oBasket->dproductsprice+$oPrice->getBruttoPrice(),2)-round($oPayment->dAddAllowanceSum,2)) ;
				oxSession::setVar( 'aPaymentAllowanceSums', $aPaymentAllowanceSums );
                
            }
        }
    }
}