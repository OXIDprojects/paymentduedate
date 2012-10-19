<?php
/**
 * This Software is the property of OXID eSales and is protected
 * by copyright law - it is NOT Freeware.
 *
 * Any unauthorized use of this software without a valid license key
 * is a violation of the license agreement and will be prosecuted by
 * civil and criminal law.
 *
 * @link http://www.oxid-esales.com
 * @package main
 * @copyright (C) OXID eSales AG 2003-2009
 * @version OXID eShop EE
 */

    /** @name database information */
        $this->dbType = 'mysql';
        $this->dbHost = 'localhost'; // database host name
        $this->dbName = 'skontoee'; // database name
        $this->dbUser = 'root'; // database user name
        $this->dbPwd  = 'root'; // database user password
        $this->sShopURL     = 'http://192.168.211.129/skontoee';
        $this->sSSLShopURL  = null;
        $this->sAdminSSLURL = null;
        $this->sShopDir     = '/htdocs/testshops/skontoee';
        $this->sCompileDir  = '/htdocs/testshops/skontoee/tmp';

    // Template theme name, a directory in out/ folder containing all needed resources
    $this->sTheme = 'basic';

    // Custom  theme, a directory in out/ folder containing only modified template files
    $this->sCustomTheme = '/custom';

    // Uncoment only for former (pre version 4) template compatibility
    // $this->blFormerTplSupport = true;
    // $this->blFixedWidthLayout = true;

    // UTF-8 mode in shop 0 - off, 1 - on
    $this->iUtfMode  = '0';

    // File type whitelist for file upload
    $this->aAllowedUploadTypes = array('jpg', 'gif', 'png', 'pdf', 'mp3', 'avi', 'mpg', 'mpeg', 'doc', 'xls', 'ppt');

    // timezone information
    date_default_timezone_set('Europe/Berlin');

    // Search engine friendly URL processor
    // After changing this value, you should rename oxid.php file as well
    // Always leave .php extension here unless you know what you are doing
    $this->sOXIDPHP = "oxid.php";

    //  enable debug mode for template development or bugfixing
    // -1 = Logger Messages internal use only
    //  0 = off
    //  1 = smarty
    //  2 = SQL
    //  3 = SQL + smarty
    //  4 = SQL + smarty + shoptemplate data
    //  5 = Delivery Cost calculation info
    //  6 = SMTP Debug Messages
    //  7 = oxDbDebug SQL parser
    $this->iDebug = 0;

    // Log all modifications performed in Admin
    $this->blLogChangesInAdmin = false;

    // Force admin email
    $this->sAdminEmail = '';

    // in case session must be started on first user page visit (not only on
    // session required action) set this option value 1
    $this->blForceSessionStart = false;

    // Use browser cookies to store session id (no sid parameter in URL)
    $this->blSessionUseCookies = true;

    // The domain that the cookie is available: array( _SHOP_ID_ => _DOMAIN_ );
    // check setcookie() documentation for more details @php.net
    $this->aCookieDomains = null;

    // The path on the server in which the cookie will be available on: array( _SHOP_ID_ => _PATH_ );
    // check setcookie() documentation for more details @php.net
    $this->aCookiePaths = null;

    // uncomment the following line if you want to leave euro sign unchanged in output
    // by default is set to convert euro sign symbol to html entity
    // $this->blSkipEuroReplace = true;

        //Time limit in ms to be notified about slow queries
        $this->iDebugSlowQueryTime = 20;

        // enables Rights and Roles engine
        // 0 - off,
        // 1 - only in admin,
        // 2 - only in shop,
        // 3 - both
        $this->blUseRightsRoles = 3;


        //define oxarticles fields which could be edited individually in subshops
        //do not forget to add these fields to oxfield2shop table
        //note the field names are case sensitive here
        $this->aMultishopArticleFields = array("OXPRICE", "OXPRICEA", "OXPRICEB", "OXPRICEC");


        //Show "Update Views" button in admin
        $this->blShowUpdateViews = true;

        // If default 30 seconds is not enougth
        // @set_time_limit(3000);

    // List of all Search-Engine Robots
    $this->aRobots = array(
                        'googlebot',
                        'ultraseek',
                        'crawl',
                        'spider',
                        'fireball',
                        'robot',
                        'spider',
                        'robot',
                        'slurp',
                        'fast',
                        'altavista',
                        'teoma',
                        );

    // Deactivate Static URL's for these Robots
    $this->aRobotsExcept = array();
	
    // Allowance-Configuration
	//----Description-----------------------------------------------------------------------
	// $this->aAllowance[ShopID] =
	// array ([value],[valuetype(%/absolute)],[creditperiod in days], array([PaymentIDs]))
	// ShopID-Path = [Shop Database] -> oxshops -> OXID
	// Use "1" for OXID eShop PE/CE.
	// PaymentID-Path = Database -> oxpayments -> OXID	
    //----Example---------------------------------------------------------------------------	
    // 2% allowance for shop 1 if customer pays during 14 days via invoice or prepayment
	// $this->aAllowance[1] = array(2.0,'%',14, array ( 'oxidpayadvance', 'oxidinvoice'))
	
	$this->aAllowance[1] = array(2,'%',14, array ( 'oxidpayadvance'));
	    
	    