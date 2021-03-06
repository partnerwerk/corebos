{*<!--
/*********************************************************************************
  ** The contents of this file are subject to the vtiger CRM Public License Version 1.0
   * ("License"); You may not use this file except in compliance with the License
   * The Original Code is:  vtiger CRM Open Source
   * The Initial Developer of the Original Code is vtiger.
   * Portions created by vtiger are Copyright (C) vtiger.
   * All Rights Reserved.
 ********************************************************************************/
-->*}

{include file='SetMenu.tpl'}
<section role="dialog" tabindex="-1" class="slds-fade-in-open slds-modal_large slds-app-launcher" aria-labelledby="header43">
<div class="slds-modal__container slds-p-around_none">
<table align="center" border="0" cellpadding="0" cellspacing="0" width="98%">
<tbody><tr>
	<td class="showPanelBg" style="padding: 10px;" valign="top" width="100%">
<form action="index.php" method="post" name="new" id="form" onsubmit="VtigerJS_DialogBox.block();">
<input type="hidden" name="module" value="Users">
<input type="hidden" name="mode" value="create">
<input type="hidden" name="action" value="CreateProfile">
<input type="hidden" name="parenttab" value="Settings">

<br>
	<div align=center>

				<!-- DISPLAY -->
				<table border=0 cellspacing=0 cellpadding=5 width=100% class="settingsSelUITopLine">
				<tr>
					<td width=50 rowspan=2 valign=top class="cblds-p_none"><img src="{'ico-profile.gif'|@vtiger_imageurl:$THEME}" alt="{$MOD.LBL_PROFILES}" width="48" height="48" border=0 title="{$MOD.LBL_PROFILES}"></td>
					<td class=heading2 valign=bottom><b><a href="index.php?module=Settings&action=index&parenttab=Settings">{'LBL_SETTINGS'|@getTranslatedString}</a> > {$MOD.LBL_PROFILES} </b></td>
				</tr>
				<tr>
					<td valign=top class="small cblds-p-v_none">{$MOD.LBL_PROFILE_DESCRIPTION}</td>
				</tr>
				</table>

				<table border=0 cellspacing=0 cellpadding=10 width=100% >
				<tr>
				<td valign=top>
					<table border=0 cellspacing=0 cellpadding=5 width=100% class="tableHeading">
					<tr>
						<td class="big"><strong>{$MOD.LBL_PROFILES_LIST}</strong></td>
						<td class="small cblds-t-align_right" align=right>{$CMOD.LBL_TOTAL} {$COUNT} {$MOD.LBL_PROFILES} </td>
					</tr>
					</table>

					<table border=0 cellspacing=0 cellpadding=5 width=100% class="listTableTopButtons">
					<tr>
						<td class="small cblds-t-align_right" align=right><input type="submit" value="{$CMOD.LBL_NEW_PROFILE}" title="{$CMOD.LBL_NEW_PROFILE}" class="crmButton create small"></td>
					</tr>
					</table>

					<table border=0 cellspacing=0 cellpadding=5 width=100% class="listTable">
					<tr>
						<td class="colHeader small cblds-p-v_medium" valign=top width=2%>{$LIST_HEADER.0}</td>
						<td class="colHeader small cblds-p-v_medium" valign=top width=8%>{$LIST_HEADER.1}</td>
						<td class="colHeader small cblds-p-v_medium" valign=top width=30%>{$LIST_HEADER.2} </td>
						<td class="colHeader small cblds-p-v_medium" valign=top width=60%>{$LIST_HEADER.3}</td>
					</tr>
					{foreach name=profilelist item=listvalues from=$LIST_ENTRIES}
					<tr>
						<td class="listTableRow small" valign=top>{$smarty.foreach.profilelist.iteration}</td>
						<td class="listTableRow small" valign=top nowrap>
							<a href="index.php?module=Settings&action=profilePrivileges&return_action=ListProfiles&parenttab=Settings&mode=edit&profileid={$listvalues.profileid}"><img src="{'editfield.gif'|@vtiger_imageurl:$THEME}" alt="{$APP.LBL_EDIT}" title="{$APP.LBL_EDIT}" border="0" align="absmiddle"></a>
							{if $listvalues.del_permission eq 'yes'}
								&nbsp;|&nbsp;
								<a href="javascript:;"><img src="{'delete.gif'|@vtiger_imageurl:$THEME}" border="0" height="15" width="15" onclick="DeleteProfile(this,'{$listvalues.profileid}')" align="absmiddle" title="{$APP.LBL_DELETE_BUTTON}"></a>
							{/if}
						</td>
						<td class="listTableRow small" valign=top><a href="index.php?module=Settings&action=profilePrivileges&mode=view&parenttab=Settings&profileid={$listvalues.profileid}"><b>{$listvalues.profilename}</b></a></td>
						<td class="listTableRow small" valign=top>{$listvalues.description}</td>
					  </tr>
					{/foreach}
					</table>
				</td>
				</tr>
				</table>
			</td>
			</tr>
			</table>
		</td>
	</tr>
	</table>
	</div>
</td>
</form>
</tr>
</tbody>
</table>
<div id="tempdiv" style="display:block;position:absolute;left:350px;top:200px;"></div>
</div>
</section>
<script>
function DeleteProfile(obj,profileid)
{ldelim}
		document.getElementById("status").style.display="inline";
		jQuery.ajax({ldelim}
				method:"POST",
				url:'index.php?module=Users&action=UsersAjax&file=ProfileDeleteStep1&profileid='+profileid,
		{rdelim}).done(function(response) {ldelim}
					document.getElementById("status").style.display="none";
					document.getElementById("tempdiv").innerHTML=response;
					fnvshobj(obj,"tempdiv");
			{rdelim}
		);
{rdelim}
</script>
