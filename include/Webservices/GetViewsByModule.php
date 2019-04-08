<?php
/*************************************************************************************************
 * Copyright 2019 JPL TSolucio, S.L.  --  This file is a part of coreBOS.
* You can copy, adapt and distribute the work under the "Attribution-NonCommercial-ShareAlike"
* Vizsage Public License (the "License"). You may not use this file except in compliance with the
* License. Roughly speaking, non-commercial users may share and modify this code, but must give credit
* and share improvements. However, for proper details please read the full License, available at
* http://vizsage.com/license/Vizsage-License-BY-NC-SA.html and the handy reference for understanding
* the full license at http://vizsage.com/license/Vizsage-Deed-BY-NC-SA.html. Unless required by
* applicable law or agreed to in writing, any software distributed under the License is distributed
* on an  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and limitations under the
* License terms of Creative Commons Attribution-NonCommercial-ShareAlike 3.0 (the License).
*************************************************************************************************/
require_once 'modules/cbCVManagement/cbCVManagement.php';

function getViewsByModule($module, $user) {
	$types = vtws_listtypes(null, $user);
	if (!in_array($module, $types['types'])) {
		throw new WebServiceException(WebServiceErrorCode::$ACCESSDENIED, 'Permission to perform the operation is denied');
	}
	$focus = CRMEntity::getInstance($module);
	$linkfields=array($focus->list_link_field);
	if ($module=='Contacts' || $module=='Leads') {
		$linkfields=array('firstname', 'lastname');
	}
	$rdo = cbCVManagement::getAllViews($module, $user->id);
	$viewinfo = cbws_getViewsInformation($rdo, $module);
	return array(
		'filters' => $viewinfo,
		'linkfields' => $linkfields,
	);
}

/** get information about the list of given views
 * @param $viewids :: array Integer
 * @return array view information
 */
function cbws_getViewsInformation($viewids, $module) {
	global $adb, $current_user, $app_strings;
	$dft = cbCVManagement::getDefaultView($module);
	$customView = new CustomView($module);
	$ssql = 'select vtiger_customview.* from vtiger_customview where vtiger_customview.cvid=?';
	$filters = array();
	foreach ($viewids as $viewid) {
		$result = $adb->pquery($ssql, array($viewid));
		$cvrow = $adb->fetch_array($result);
		if ($cvrow['viewname'] == 'All') {
			$cvrow['viewname'] = $app_strings['COMBO_ALL'];
		}
		$filter = array(
			'name' => $cvrow['viewname'],
			'status' => $cvrow['status'],
		);
		$viewname = $cvrow['viewname'];
		//$advft_criteria = json_encode($customView->getAdvFilterByCvid($cvrow['cvid']));
		$advft_criteria = $customView->getAdvFilterByCvid($cvrow['cvid']);
		$advft = array();
		$groupnum = 1;
		foreach ($advft_criteria as $groupinfo) {
			if ($groupnum==1) {
				$groupcolumns = $groupinfo['columns'];
				foreach ($groupcolumns as $columnindex => $columninfo) {
					$columnname = $columninfo['columnname'];
					$comparator = $columninfo['comparator'];
					$value = $columninfo['value'];
					$columncondition = $columninfo['column_condition'];

					$columns = explode(":", $columnname);
					$name = $columns[1];

					$advft[$columnindex]['columname'] = $name;
					$advft[$columnindex]['comparator'] = $comparator;
					if ($value == 'yes') {
						$advft[$columnindex]['value'] = 1;
					} elseif ($value == 'no') {
						$advft[$columnindex]['value'] = 0;
					} else {
						$advft[$columnindex]['value'] = $value;
					}
					$advft[$columnindex]['column_condition'] = $columncondition;
				}
				$groupnum++;
			}
		}
		$advft_criteria = json_encode($advft);
		$filter['advcriteria'] = $advft_criteria;
		$filter['stdcriteria'] = $customView->getCVStdFilterSQL($cvrow['cvid']);
		$filter['default'] = ($dft==$cvrow['cvid']);
		$filters[$cvrow['cvid']] = $filter;
	}
	return $filters;
}
?>
