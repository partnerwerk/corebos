<?php
/*+**********************************************************************************
 * The contents of this file are subject to the vtiger CRM Public License Version 1.1
 * ("License"); You may not use this file except in compliance with the License
 * The Original Code is:  vtiger CRM Open Source
 * The Initial Developer of the Original Code is vtiger.
 * Portions created by vtiger are Copyright (C) vtiger.
 * All Rights Reserved.
 ************************************************************************************/
include_once __DIR__ .'/Folder.php';

class MailManager_Model_DraftFolder extends MailManager_Model_Folder {

	public function hasPrevPage() {
		return ($this->mPageStart <= $this->mCount  && ($this->mPageCurrent > 0));
	}

	public function hasNextPage() {
		return ($this->mPageEnd < $this->mCount);
	}

	public function pageInfo() {
		$s = max(1, $this->mPageCurrent * $this->mPageLimit+1);
		$e = min($s+$this->mPageLimit-1, $this->mCount);
		$t = $this->mCount;
		return sprintf('%s - %s '.getTranslatedString('LBL_LIST_OF').' %s', $s, $e, $t);
	}
}
?>
