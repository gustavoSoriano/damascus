<%-- <dmsc:root  templateName="Portlet_XXXXWEB_view.jsp.ftl" /> --%>
<%-- <dmsc:sync id="head-common" > --%>
<#include "./valuables.ftl">
<#assign createPath = "${webModulePath}/src/main/resources/META-INF/resources/${snakecaseModel}/view.jsp">
<#assign skipTemplate = !generateWeb>
<%-- </dmsc:sync> --%>
<%@ include file="./init.jsp" %>

<%
String iconChecked = "checked";
String iconUnchecked = "unchecked";
SimpleDateFormat dateFormat = new SimpleDateFormat(dateFormatVal);
SimpleDateFormat dateTimeFormat = new SimpleDateFormat(datetimeFormatVal);

<#list application.fields as field >
	<#if field.validation?? && field.validation.className??>
		<#assign capFirstValidationModel = "${field.validation.className?cap_first}">
		<#assign uncapFirstValidationModel = "${field.validation.className?uncap_first}">
		<#assign uppercaseValidationModel = "${field.validation.className?upper_case}">
${capFirstValidationModel}LocalService ${uncapFirstValidationModel}LocalService = (${capFirstValidationModel}LocalService) request
.getAttribute(${capFirstModel}WebKeys.${uppercaseValidationModel}_LOCAL_SERVICE);
	</#if>
</#list>

${capFirstModel}DisplayContext ${uncapFirstModel}DisplayContext = (${capFirstModel}DisplayContext)request.getAttribute(${capFirstModel}WebKeys.${uppercaseModel}_DISPLAY_CONTEXT);

String displayStyle = ${uncapFirstModel}DisplayContext.getDisplayStyle();
SearchContainer entriesSearchContainer = ${uncapFirstModel}DisplayContext.getSearchContainer();

PortletURL portletURL = entriesSearchContainer.getIteratorURL();

${capFirstModel}ManagementToolbarDisplayContext ${uncapFirstModel}ManagementToolbarDisplayContext = new ${capFirstModel}ManagementToolbarDisplayContext(liferayPortletRequest, liferayPortletResponse, request, entriesSearchContainer, trashHelper, displayStyle);
%>

<clay:management-toolbar
	actionDropdownItems="<%= ${uncapFirstModel}ManagementToolbarDisplayContext.getActionDropdownItems() %>"
	clearResultsURL="<%= ${uncapFirstModel}ManagementToolbarDisplayContext.getSearchActionURL() %>"
	componentId="${uncapFirstModel}ManagementToolbar"
	creationMenu="<%= ${uncapFirstModel}ManagementToolbarDisplayContext.getCreationMenu() %>"
	disabled="<%= ${uncapFirstModel}ManagementToolbarDisplayContext.isDisabled() %>"
	filterDropdownItems="<%= ${uncapFirstModel}ManagementToolbarDisplayContext.getFilterDropdownItems() %>"
	itemsTotal="<%= ${uncapFirstModel}ManagementToolbarDisplayContext.getItemsTotal() %>"
	searchActionURL="<%= ${uncapFirstModel}ManagementToolbarDisplayContext.getSearchActionURL() %>"
	searchContainerId="${uncapFirstModel}"
	searchFormName="fm"
	showSearch="true"
	sortingOrder="<%= ${uncapFirstModel}ManagementToolbarDisplayContext.getOrderByType() %>"
	sortingURL="<%= ${uncapFirstModel}ManagementToolbarDisplayContext.getSortingURL() %>"
/>

<#if advancedSearch>
<liferay-ui:panel-container cssClass="container-fluid-1280" extended="<%= false %>" persistState="<%= true %>" markupView="lexicon">
<liferay-ui:panel title="Advance Search" markupView="lexicon" collapsible="<%= true %>" extended="<%= false %>" iconCssClass="icon-plus-sign" id="advanceSearchPanel" persistState="<%= true %>">
	<style>
		#advanceSearchPanel {
			margin-bottom: 4px;
		}
		#advanceSearchPanel .col-md-6 {
			padding-right: 10px;
			padding-left: 7px;
		}
		#advanceSearchPanel .field-range {
			padding-right: 7px;
			padding-left: 7px;
		}
    </style>
	<aui:form action="<%=portletURL.toString()%>" name="advanceSearchForm">
		<aui:container fluid="false">
			<#-- ---------------- -->
			<#-- field loop start -->
			<#-- ---------------- -->
			<#assign dateExist = false>
			<#assign counter = 1>
			<#list application.fields as field >
				<#if
					field.type?string == "com.liferay.damascus.cli.json.fields.Long"     		||
					field.type?string == "com.liferay.damascus.cli.json.fields.Double"   		||
					field.type?string == "com.liferay.damascus.cli.json.fields.Integer"			||
					field.type?string == "com.liferay.damascus.cli.json.fields.Date"     		||
					field.type?string == "com.liferay.damascus.cli.json.fields.DateTime"		||
					field.type?string == "com.liferay.damascus.cli.json.fields.Varchar"  		||
					field.type?string == "com.liferay.damascus.cli.json.fields.RichText" 		||
					field.type?string == "com.liferay.damascus.cli.json.fields.Text"
					>

					<#if counter % 2 != 0>
						<aui:row>
					</#if>
					
					<#if
						field.type?string == "com.liferay.damascus.cli.json.fields.Long"     		||
						field.type?string == "com.liferay.damascus.cli.json.fields.Double"   		||
						field.type?string == "com.liferay.damascus.cli.json.fields.Integer"
						>
						<aui:col span="6" cssClass="field-range">
						<aui:input name="search${field.name?cap_first}Start" label="search${field.name?cap_first}Range" type="text"
							inlineField="true" ignoreRequestValue="true">
							<aui:validator name="number" />
						</aui:input>
						<div class="form-group form-group-inline">
							<label class="form-control" style="border-bottom: 0px; display: table-cell; vertical-align: middle;">
								<%= LanguageUtil.get(request, "until") %>
							</label>
						</div>
						<aui:input name="search${field.name?cap_first}End" label="" inlineLabel="true" inlineField="true" type="text" ignoreRequestValue="true">
							<aui:validator name="number" />
						</aui:input>
						</aui:col>
					</#if>
					<#if
						field.type?string == "com.liferay.damascus.cli.json.fields.Varchar"  		||
						field.type?string == "com.liferay.damascus.cli.json.fields.RichText" 		||
						field.type?string == "com.liferay.damascus.cli.json.fields.Text"
						>
						<aui:col span="6">
						<aui:input  name="search${field.name?cap_first}" type="text" ignoreRequestValue="true"/>
						</aui:col>
					</#if>

					<#if
						field.type?string == "com.liferay.damascus.cli.json.fields.Date"     ||
						field.type?string == "com.liferay.damascus.cli.json.fields.DateTime"
						>
						<#assign dateExist = true>
						<aui:col span="6" cssClass="field-range">
						<aui:input name="search${field.name?cap_first}Start" label="search${field.name?cap_first}Range" cssClass="date" type="text"
							placeholder="<%= dateFormatVal %>" inlineField="true" ignoreRequestValue="true" >
							<aui:validator name="date" />
						</aui:input>
						<div class="form-group form-group-inline">
							<label class="form-control" style="border-bottom: 0px; display: table-cell; vertical-align: middle;">
								<%= LanguageUtil.get(request, "until") %>
							</label>
						</div>
						<aui:input name="search${field.name?cap_first}End" label="" inlineLabel="true" inlineField="true"
							cssClass="date" type="text" placeholder="<%= dateFormatVal %>" ignoreRequestValue="true">
							<aui:validator name="date" />
						</aui:input>
						</aui:col>
					</#if>
					
					<#if counter % 2 == 0 || field?is_last>
						</aui:row>
					</#if>
					<#assign counter += 1>
				</#if>
				<#if
					field.type?string == "com.liferay.damascus.cli.json.fields.Boolean"  		||
					field.type?string == "com.liferay.damascus.cli.json.fields.DocumentLibrary"
				>
					<#if field?is_last && counter % 2 == 0>
						</aui:row>
					</#if>
				</#if>
			</#list>
			<#-- ---------------- -->
			<#-- field loop ends  -->
			<#-- ---------------- -->

			<#if dateExist>
				<aui:script>
				    AUI().use(
				        'aui-datepicker',
				        function(A) {
				            new A.DatePicker({
				                trigger: '.date',
				                mask: '<%= datePickerFormatVal %>',
				                popover: {
				                    zIndex: 1000
				                }
				            });
				        }
				    );
				</aui:script>
			</#if>
			<style>.center-text { text-align: center; }</style>
			<aui:button-row id="searchButton" cssClass="center-text">
				<aui:button name="searchSubmit" type="submit" value="search" />
				<aui:button name="searchReset" type="cancel" value="reset"
					onClick='<%= portletDisplay.getNamespace() + "resetAdvanceSearch()" %>'>
					<aui:script>
						function <portlet:namespace />resetAdvanceSearch() {
							 AUI().use(
						        'aui-base',
						        function(A) {
						            A.all('#<portlet:namespace />advanceSearchForm input').val('');
						        }
						    );							
						}
					</aui:script>
				</aui:button>
			</aui:button-row>
		</aui:container>
	</aui:form>
</liferay-ui:panel>
</liferay-ui:panel-container>
</#if>

<portlet:actionURL name="/${lowercaseModel}/crud" var="restoreTrashEntriesURL">
	<portlet:param name="<%= Constants.CMD %>" value="<%= Constants.RESTORE %>" />
</portlet:actionURL>

<liferay-trash:undo
	portletURL="<%= restoreTrashEntriesURL %>"
/>

<div class="container-fluid container-fluid-max-xl main-content-body">
	<aui:form action="<%= portletURL.toString() %>" method="get" name="fm">
		<aui:input name="<%= Constants.CMD %>" type="hidden" />
		<aui:input name="redirect" type="hidden" value="<%= portletURL.toString() %>" />
		<aui:input name="deleteEntryIds" type="hidden" />
		<aui:input name="selectAll" type="hidden" value="<%= false %>" />

		<liferay-ui:search-container
			emptyResultsMessage="no-record-was-found"
			id="${uncapFirstModel}"
			rowChecker="<%= new EmptyOnClickRowChecker(renderResponse) %>"
			searchContainer="<%= entriesSearchContainer %>"
		>
			<liferay-ui:search-container-row
				className="${packageName}.model.${capFirstModel}"
				escapedModel="<%= true %>"
				keyProperty="${lowercaseModel}Id"
				modelVar="${uncapFirstModel}"
			>
<%-- <dmsc:sync id="view-search-rows" > --%>
			<#-- ---------------- -->
			<#-- field loop start -->
			<#-- ---------------- -->
			<#list application.fields as field >
				<#-- ---------------- -->
				<#--     Long         -->
				<#--     Varchar      -->
				<#--     Boolean      -->
				<#--     Double       -->
				<#-- Document Library -->
				<#--     Integer      -->
				<#-- ---------------- -->
					<#if
					field.type?string == "com.liferay.damascus.cli.json.fields.Long"     		||
					field.type?string == "com.liferay.damascus.cli.json.fields.Varchar"  		||
					field.type?string == "com.liferay.damascus.cli.json.fields.Boolean"  		||
					field.type?string == "com.liferay.damascus.cli.json.fields.Double"   		||
					field.type?string == "com.liferay.damascus.cli.json.fields.DocumentLibrary" ||
					field.type?string == "com.liferay.damascus.cli.json.fields.Integer"
					>
						<#if field.validation?? && field.validation.className??>
							<#assign capFirstValidationModel = "${field.validation.className?cap_first}">
							<#assign uncapFirstValidationModel = "${field.validation.className?uncap_first}">

							<#assign fieldName = "PrimaryKey">
							<#if field.validation.fieldName??>
								<#assign fieldName = "${field.validation.fieldName?cap_first}">
							</#if>

							<#assign orderByField = "PrimaryKey">
							<#if field.validation.orderByField??>
								<#assign orderByField = "${field.validation.orderByField?cap_first}">
							</#if>
				<%
				String ${field.name}Text = "";
				try {
					${capFirstValidationModel} ${uncapFirstValidationModel} = ${uncapFirstValidationModel}LocalService.get${capFirstValidationModel}(GetterUtil.getLong(${uncapFirstModel}.get${field.name?cap_first}()));
					${field.name}Text = ${uncapFirstValidationModel}.get${orderByField}();
				} catch(Exception e) {}
				%>
				<liferay-ui:search-container-column-text name="${field.name?cap_first}"
														 align="center" value="<%= ${field.name}Text %>" />
						<#else>
				<liferay-ui:search-container-column-text
					align="left"
					name="${field.name?cap_first}"
					orderable="true"
					orderableProperty="${field.name}"
					property="${field.name}"
				/>
						</#if>
					</#if>
				<#-- ---------------- -->
				<#--     Date         -->
				<#--     DateTime     -->
				<#-- ---------------- -->
					<#if
					field.type?string == "com.liferay.damascus.cli.json.fields.Date"     ||
					field.type?string == "com.liferay.damascus.cli.json.fields.DateTime"
					>
				<liferay-ui:search-container-column-text
					name="${field.name?cap_first}"
					value="<%= dateFormat.format(${uncapFirstModel}.get${field.name?cap_first}()) %>"
					orderable="true"
					orderableProperty="${field.name}"
					align="left"
				/>
					</#if>

				<#-- ---------------- -->
				<#--     RichText     -->
				<#--       Text       -->
				<#-- ---------------- -->
					<#if
					field.type?string == "com.liferay.damascus.cli.json.fields.RichText" ||
					field.type?string == "com.liferay.damascus.cli.json.fields.Text"
					>
				<liferay-ui:search-container-column-text name="${field.name?cap_first}"
														 align="center">
					<%
					String ${field.name}Icon = iconUnchecked;
					String ${field.name} = ${uncapFirstModel}.get${field.name?cap_first}();
					if (!${field.name}.equals("")) {
						${field.name}Icon= iconChecked;
					}
					%>
					<liferay-ui:icon image="<%= ${field.name}Icon %>" />
				</liferay-ui:search-container-column-text>
					</#if>
			</#list>
			<#-- ---------------- -->
			<#-- field loop ends  -->
			<#-- ---------------- -->
<%-- </dmsc:sync> --%>
				<liferay-ui:search-container-column-jsp
					align="right"
					path="/${snakecaseModel}/edit_actions.jsp"
				/>
			</liferay-ui:search-container-row>

			<liferay-ui:search-iterator displayStyle="list" markupView="lexicon" />
		</liferay-ui:search-container>
	</aui:form>
</div>

<aui:script>
	function <portlet:namespace />deleteEntries() {
		if (<%=trashHelper.isTrashEnabled(scopeGroupId) %> || confirm('<%=UnicodeLanguageUtil.get(request, "are-you-sure-you-want-to-delete-the-selected-entries") %>')) {
			var form = AUI.$(document.<portlet:namespace />fm);

			form.attr('method', 'post');
			form.fm('<%=Constants.CMD%>').val('<%=trashHelper.isTrashEnabled(scopeGroupId) ? Constants.MOVE_TO_TRASH : Constants.DELETE%>');
			form.fm('deleteEntryIds').val(Liferay.Util.listCheckedExcept(form, '<portlet:namespace />allRowIds'));

			submitForm(form, '<portlet:actionURL name="/${lowercaseModel}/crud" />');
		}
	}
</aui:script>
