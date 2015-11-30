<?php
/**
 * @package     Engine_Core
 * @version     $Id: index.php 9764 2012-08-17 00:04:31Z matthew $
 * @copyright   Copyright (c) 2008 Webligo Developments
 * @license     http://www.socialengine.com/license/
 */

// Check version
if( version_compare(phpversion(), '5.2.11', '<') ) {
  printf('PHP 5.2.11 is required, you have %s', phpversion());
  exit(1);
}

// Constants
define('_ENGINE_R_BASE', dirname($_SERVER['SCRIPT_NAME']));
define('_ENGINE_R_FILE', $_SERVER['SCRIPT_NAME']);
define('_ENGINE_R_REL', 'application');
define('_ENGINE_R_TARG', 'index.php');

// Check if this might be the trial
$tmp = @file_get_contents("application/libraries/Engine/Api.php");
if( false !== strpos($tmp, "ionCube") ) {
  // Check trial/ioncube
  if( function_exists("get_loaded_extensions") &&
      !in_array("ionCube Loader", get_loaded_extensions()) ) {
    // Redirect to the ionCube loader wizard?
    echo '<html>
  <body>
    The ionCube loader has not been installed. Click
    <a href="ioncube/loader-wizard.php">here</a>
    for help installing it, or contact your hosting provider. Please return 
    to this page once complete.
  </body>
</html>';
    exit(1);
  }

  // Check for license file
  if( !file_exists("license.txt") ) {
    echo '<html>
  <body>
    The license file could not be found.
  </body>
</html>';
    exit(1);
  }

  // Should we check for expired license?
  $seOnExpiredLicense = true;
  function seOnExpiredLicense() {
    global $seOnExpiredLicense;
    if( $seOnExpiredLicense ) {
      ob_end_clean();
      echo '<html>
  <body>
    Your trial license key has expired or is invalid. If 
    you\'ve already purchased SocialEngine, please see 
    <a href="http://support.socialengine.com/questions/148/Upgrading-Your-Trial-to-a-Fully-Licensed-Installation">this</a>
    KB article. Otherwise, please purchase a license <a href="http://www.socialengine.com/buy-social-engine">here</a>.
  </body>
</html>';
      exit(1);
    }
  }
  register_shutdown_function("seOnExpiredLicense");
  ob_start();
  include_once "application/libraries/Engine/Exception.php";
  ob_end_clean();
  $seOnExpiredLicense = false;
}

// Main
include dirname(__FILE__) . DIRECTORY_SEPARATOR
  . _ENGINE_R_REL . DIRECTORY_SEPARATOR
  . _ENGINE_R_TARG;
