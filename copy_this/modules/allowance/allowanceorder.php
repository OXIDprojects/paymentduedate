<?php
/**
 * This module extends "getPayment"-function from order.php. 
 * Getsets the individual sums from "allowancepayment.php"
 * and creditperiod from config.inc.php.
 * Calculate last day of payday.
 * allowancesum for every "oxpayment" 
*/
class allowanceOrder extends allowanceOrder_parent
{
    public function getPayment()
    {
        if ( $this->_oPayment === null ) {
            $this->_oPayment = false;
			$oLang = oxLang::getInstance();
			$oBasket = $this->getSession()->getBasket();
			$oUser = $this->getUser();
			
            // payment is set ?
            $sPaymentid = $oBasket->getPaymentId();
            $aDynvalue  = oxConfig::getParameter( 'dynvalue' );
            $oPayment   = oxNew( 'oxpayment' );

            //getting basket price form payment
            $dBasketPrice = $oBasket->getPriceForPayment();

            if ( $sPaymentid && $oPayment->load( $sPaymentid ) &&
                $oPayment->isValidPayment( $aDynvalue, $this->getConfig()->getShopId(), $oUser, $dBasketPrice, oxConfig::getParameter( 'sShipSet' ) ) ) {
                $this->_oPayment = $oPayment;
				
			
			//Allowance
			//Get configuration and calculate payday
			if ($edition == 'EE' ) {
			    $oBasket->sShopID = oxSession::getVar( "actshop");
			} else {
			    $oBasket->sShopID = 1;
			}
			$oBasket->aAllowance = $this->getConfig()->getConfigParam( 'aAllowance');			
			$oBasket->aPaymentId4Allowance = $oBasket->aAllowance[$oBasket->sShopID][3];
			$oBasket->sAllowanceDate = date("d.m.Y",strtotime(date("d.m.Y",time()))+($oBasket->aAllowance[$oBasket->sShopID][2])*86400);
			$oBasket->dTest = $oBasket->oxshops__oxedition->value;			
			
			$oBasket->sAllowanceType = $oBasket->aAllowance[$oBasket->sShopID][1];	
			$oBasket->aPaymentAllowanceSums = oxSession::getVar('aPaymentAllowanceSums');
			
			// Get remaining amount (finalprice - allowancesum)
			if ($oBasket->aPaymentAllowanceSums[$oBasket->getPaymentId()][0]) {
                $oBasket->dPaymentAllowanceSum = round($oBasket->aPaymentAllowanceSums[$oBasket->getPaymentId()][0],2); 
				$oBasket->dAllowancePrice = round($oBasket->aPaymentAddSums[$oBasket->getPaymentId()][1],2); 
			} else {
			    $oBasket->dPaymentAllowanceSum = 0;
                $oBasket->dAllowancePrice = 0;
			}
            $oBasket->fPaymentAllowanceSum = $oLang->formatCurrency( $oBasket->dPaymentAllowanceSum, $oBasket->getBasketCurrency() );				
			$oBasket->fAllowancePrice = oxLang::getInstance()->formatCurrency( $oBasket->dAllowancePrice , $oBasket->getBasketCurrency() ) ;
            
            }
        }
        return $this->_oPayment;
    }
}
	
 