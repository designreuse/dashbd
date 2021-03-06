<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Schedule Mgmt</title>
    <link href="../resourcesRenew/css/bootstrap.min.css" rel="stylesheet">
    <link href="../resourcesRenew/css/style.css" rel="stylesheet">
    <link href="../resourcesRenew/css/animate.css" rel="stylesheet">
    <link href="../resourcesRenew/css/plugins/toastr/toastr.min.css" rel="stylesheet">
    <link href="../resourcesRenew/css/plugins/footable/footable.core.css" rel="stylesheet">
    <link href="../resourcesRenew/css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
    <link href="../resourcesRenew/css/custom.css" rel="stylesheet">
    <link href="../resourcesRenew/font-awesome/css/font-awesome.css" rel="stylesheet">
    <!-- Mainly scripts -->
	<script src="../resourcesRenew/js/jquery-2.1.1.js"></script>
	<script src="../resourcesRenew/js/jquery.form.js"></script>
	<script src="../resourcesRenew/js/bootstrap.min.js"></script>
	<script src="../resourcesRenew/js/plugins/metisMenu/jquery.metisMenu.js"></script>
	<script src="../resourcesRenew/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
	
	<!-- FooTable -->
	<script src="../resourcesRenew/js/plugins/footable/footable.all.min.js"></script>
	
	<!-- Custom and plugin javascript -->
	<script src="../resourcesRenew/js/plugins/pace/pace.min.js"></script>
	<script src="../resourcesRenew/js/inspinia.js"></script>
	<script src="../resourcesRenew/app-js/apps/common.js"></script>

	
	<!-- Page-Level Scripts -->
	<script>
	$(document).ready(function() {
		$("#serviceType").on("change", function() {
			if ( $(this).val() == "FileDownload" ) {
				//filedownload
				$("#bcType_fileDownload").show();
				$("#bcType_serviceClass").hide();
				$("#bcType_streaming").hide();
				$("#bcType_streaming2").hide();
			}else{
				$("#bcType_fileDownload").hide();
				$("#bcType_serviceClass").show();
				$("#bcType_streaming").show();
				$("#bcType_streaming2").show();
			}
		});
		
		
		$("#btnCancel").click(function() {
			var tmpServiceAreaId = $("#serviceAreaId").val();
			var searchDate = $("#searchDate").val();
			location.href = "schdMgmtDetail.do?serviceAreaId=" + tmpServiceAreaId + "&searchDate="+searchDate;
		});
		
		$("#btnDelete").click(function() {
			if (!confirm("It will be deleted. do you want this??"))
				return;
			var tmpServiceAreaId = $("#serviceAreaId").val();
			var searchDate = $("#searchDate").val();
			
			var param = {
					id : $("#id").val(),
					BCID : $("#BCID").val()
				};
			$.ajax({
				type : "POST",
				url : "delSchedule.do",
				data : param,
				dataType : "json",
				success : function( data ) {
					outMsgForAjax(data);
					location.href = "schdMgmtDetail.do?serviceAreaId=" + tmpServiceAreaId + "&searchDate="+searchDate;
				},
				error : function(request, status, error) {
					alert("request=" +request +",status=" + status + ",error=" + error);
				}
			});
		});
		
		$("#frmScheduleReg").ajaxForm({
			dataType : "json",
			beforeSubmit : function(data, frm, opt) {
				
				if (!confirm('are you sure?')) {
					return false;
				}
				
			},
			success : function(result) {
				outMsgForAjax(result);
				var tmpServiceAreaId = $("#serviceAreaId").val();
				var searchDate = $("#searchDate").val();
				location.href = "schdMgmtDetail.do?serviceAreaId=" + tmpServiceAreaId + "&searchDate="+searchDate;
			},
			error : function(request, status, error) {
				alert("request=" +request +",status=" + status + ",error=" + error);
			}
		});
	});
	

	
	function validation( from ) {
		var $form = from;
		var retFlag = true;
		console.log('here0');
		$form.find("input").each(function(idx) {
			if (retFlag && $(this).attr("required")) {
				console.log('here1');
				if ($(this).val() == '') {
					console.log('here2');
					alert($(this).attr("alt") + '필수항목 입니다.');
					retFlag = false;
					
				}
			}
		});
		return retFlag;
	}

</script>
</head>
<body>
<div id="wrapper">

    <!-- sidebar -->
    <nav class="navbar-default navbar-static-side" role="navigation">
        <div class="sidebar-collapse">
            <ul class="nav metismenu" id="side-menu">
                <li class="nav-header">
                    <div class="dropdown profile-element">
                        Logo
                    </div>
                    <div class="logo-element">
                        logo
                    </div>
                </li>
                <li>
                    <a href="/dashbd/resources/user_mgmt.html"><i class="fa fa-user"></i> <span class="nav-label">User Mgmt</span></a>
                </li>
                <li>
                    <a href="#" onclick="return false;"><i class="fa fa-lock"></i> <span class="nav-label">Permission Mgmt</span></a>
                </li>
                <li>
                    <a href="/dashbd/resources/contents_mgmt.html"><i class="fa fa-file-text-o"></i> <span class="nav-label">Contents Mgmt</span></a>
                </li>
                <li>
                    <a href="#" onclick="return false;"><i class="fa fa-bullhorn"></i> <span class="nav-label">Operator Mgmt</span></a>
                </li>
                <li>
                    <a href="#" onclick="return false;"><i class="fa fa-flag"></i> <span class="nav-label">BM-SC Mgmt</span></a>
                </li>
                <li>
                    <a href="/dashbd/resources/service_area_mgmt.html"><i class="fa fa-globe"></i> <span class="nav-label">Service Area Mgmt</span></a>
                </li>
                <li class="landing_link">
                    <a href="schdMgmt.do"><i class="fa fa-calendar"></i> <span class="nav-label">Schedule Mgmt</span></a>
                </li>
            </ul>
        </div>
    </nav><!-- sidebar end -->

    <!-- content -->
    <div id="page-wrapper" class="gray-bg">

        <!-- content header -->
        <div class="row border-bottom">
            <nav class="navbar navbar-static-top white-bg" role="navigation" style="margin-bottom: 0">
                <div class="navbar-header">
                    <a class="navbar-minimalize minimalize-styl-2 btn btn-success " href="#"><i class="fa fa-bars"></i> </a>
                    <form role="search" class="navbar-form-custom" action="search_results.html">
                        <div class="form-group">
                            <input type="text" placeholder="Search" class="form-control" name="top-search" id="top-search">
                        </div>
                    </form>
                </div>
                <ul class="nav navbar-top-links navbar-right">
                    <li>
                        <a>
                        <i class="fa fa-user"></i>User Name
                        </a>
                    </li>
                    <li class="dropdown">
                        <ul class="dropdown-menu dropdown-alerts">
                            <li>
                                <a href="mailbox.html">
                                    <div>
                                        <i class="fa fa-envelope fa-fw"></i> You have 16 messages
                                        <span class="pull-right text-muted small">4 minutes ago</span>
                                    </div>
                                </a>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <a href="profile.html">
                                    <div>
                                        <i class="fa fa-twitter fa-fw"></i> 3 New Followers
                                        <span class="pull-right text-muted small">12 minutes ago</span>
                                    </div>
                                </a>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <a href="grid_options.html">
                                    <div>
                                        <i class="fa fa-upload fa-fw"></i> Server Rebooted
                                        <span class="pull-right text-muted small">4 minutes ago</span>
                                    </div>
                                </a>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <div class="text-center link-block">
                                    <a href="notifications.html">
                                        <strong>See All Alerts</strong>
                                        <i class="fa fa-angle-right"></i>
                                    </a>
                                </div>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="login.html">
                            <i class="fa fa-sign-out"></i> Log out
                        </a>
                    </li>
                </ul>
            </nav>
        </div><!-- content header end -->
        <!-- content body -->
        <div class="wrapper wrapper-content">
        <form class="form-horizontal" id="frmScheduleReg" name="frmScheduleReg" action="scheduleReg.do" method="post">
        <input type="hidden" id="id" name="id" value="${mapSchedule.id}">
        <input type="hidden" id="contentId" name="contentId" value="${mapSchedule.contentId}">
        <input type="hidden" id="BCID" name="BCID" value="${mapSchedule.BCID}">
        <input type="hidden" id="serviceAreaId" name="serviceAreaId" value="${mapSchedule.serviceAreaId}"/>
        <input type="hidden" id="searchDate" name="searchDate" value="${mapSchedule.searchDate}"/>
        <input type="hidden" id="serviceId" name="serviceId" value="${mapSchedule.serviceId}"/>
        
        
        
            <!-- Contents -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <h5>Schedule Mgmt</h5>
                            <div class="ibox-tools">
                                <a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                                <a class="close-link"><i class="fa fa-times"></i></a>
                            </div>
                        </div>
                        <div class="ibox-content">
                            <div class="row">
                                <div class="col-sm-3 m-b-sm">
                                <c:if test="${empty mapSchedule.BCID}">
					                <select class="input-sm form-control input-s-sm" id="serviceType" name="serviceType">
		                    	</c:if>
	                        	<c:if test="${not empty mapSchedule.BCID}">
	                        		<input type="hidden" id=serviceType" name="serviceType" value="${mapSchedule.service}">
	                        		<select class="input-sm form-control input-s-sm" disabled>            	
	                        	</c:if>
	                        	        <option value="fileDownload" <c:if test="${mapSchedule.service eq 'fileDownload'}"> selected</c:if>>File Download</option>
                                        <option value="streaming" <c:if test="${mapSchedule.service eq 'streaming'}">selected</c:if>>Streaming</option>
                                        <!-- 
                                        <option value="2">Carousel MultiMedia Files</option>
                                        <option value="3">Carousel Single File</option>
                                         -->
                                    </select>
                                </div>
                            </div>
                            <div class="hr-line-dashed"></div>
                            <div class="row">
                                <div class="col-md-12">
                                    
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Service Name</label>
                                            <div class="col-sm-9"><input type="text" class="form-control" id="name" name="name" alt='service name' value="${mapSchedule.service_name}"></div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Language</label>
                                            <div class="col-sm-9"><input type="text" class="form-control" id="serviceLanguage" name="serviceLanguage" value="${mapSchedule.language}" placeholder="en"></div>
                                        </div>
                                        
                                        
                                  <div id="bcType_serviceClass" <c:if test="${empty mapSchedule.service || mapSchedule.service == 'FileDownload'}">
                                  						style="display:none"</c:if>>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Service class</label>
                                            <div class="col-sm-9"><input type="text" class="form-control" id="serviceClass" name="serviceClass" alt='serviceClass' value="${mapSchedule.serviceClass}"></div>
                                        </div>
                                   </div>
                                        <div class="hr-line-dashed"></div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Transfer Config</label>
                                            <div class="col-sm-9">
                                                <h5>QoS</h5>
                                                <div class="well">
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label">GBR</label>
                                                        <div class="col-sm-9">
                                                        	<input type="text" class="form-control input-sm" id="GBR" name="GBR" required="required" value="${mapSchedule.GBR}"></div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label">QCI</label>
                                                        <div class="col-sm-9">
                                                        	<input type="text" class="form-control input-sm" id="QCI" name="QCI" required="required" value="${mapSchedule.QCI}"></div>
                                                    </div>
                                                   
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label">ARP</label>
                                                        <div class="col-sm-9">
                                                            <div class="well">
                                                                <div class="form-group">
                                                                    <label class="col-sm-6 col-md-4 control-label">ARP Level</label>
                                                                    <div class="col-sm-6 col-md-8">
                                                                    	<input type="text" class="form-control input-sm"  id="level" name="level" required="required" value="${mapSchedule.level}"></div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="col-sm-6 col-md-4 control-label">PreEmptionCapabiity</label>
                                                                    <div class="col-sm-6 col-md-8">
                                                                        <div class="swich">
                                                                            <div class="onoffswitch">
                                                                                <input type="checkbox" class="onoffswitch-checkbox"  id="preEmptionCapabiity" name="preEmptionCapabiity" <c:if test="${mapSchedule.preEmptionCapabiity == 'on'}">checked</c:if>>
                                                                                <label class="onoffswitch-label" for="preEmptionCapabiity">
                                                                                    <span class="onoffswitch-inner"></span>
                                                                                    <span class="onoffswitch-switch"></span>
                                                                                </label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="col-sm-6 col-md-4 control-label">PreEmptionVulnerability</label>
                                                                    <div class="col-sm-6 col-md-8">
                                                                        <div class="swich">
                                                                            <div class="onoffswitch">
                                                                                <input type="checkbox" class="onoffswitch-checkbox"  id="preEmptionVulnerability" name="preEmptionVulnerability" <c:if test="${mapSchedule.preEmptionVulnerability == 'on'}">checked</c:if>>
                                                                                <label class="onoffswitch-label" for="preEmptionVulnerability">
                                                                                    <span class="onoffswitch-inner"></span>
                                                                                    <span class="onoffswitch-switch"></span>
                                                                                </label>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <h5>FEC</h5>
                                                <div class="well">
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label">Type</label>
                                                        <div class="col-sm-9">
                                                            <select class="input form-control"  id="fecType" name="fecType">
                                                                <option value="NoFec">NoFec</option>
                                                                <option value="Streaming">Streaming</option>
                                                                <option value="Carousel MultiMedia Files">Carousel MultiMedia Files</option>
                                                                <option value="Carousel Single File">Carousel Single File</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label">Ratio</label>
                                                        <div class="col-sm-9"><input type="text" class="form-control input-sm"  id="fecRatio" name="fecRatio" value="${mapSchedule.fecRatio}"></div>
                                                    </div>
                                                    
                                                    <div class="form-group" id="bcType_streaming" <c:if test="${empty mapSchedule.service || mapSchedule.service == 'FileDownload'}">style="display:none"</c:if>>
                                                        <label class="col-sm-3 control-label">SegmentationAvailableOffset</label>
                                                        <div class="col-sm-9"><input type="text" class="form-control input-sm"  id="SegmentAvailableOffset" name="SegmentAvailableOffset" value="${mapSchedule.segmentAvailableOffset}"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="hr-line-dashed"></div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Service Area</label>
                                            <!-- 
                                            <div class="col-sm-3 m-b-sm"><button type="button" class="btn btn-success">Add Service Area</button></div>
                                             -->
                                            <div class="col-sm-9 col-sm-offset-3"><input type="text" class="form-control m-b-xs" id="said" name="said" value="${mapSchedule.serviceAreaId}"></div>
                                        </div>
                                        <div class="hr-line-dashed"></div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Schedule</label>
                                            <!-- 
                                             -->
                                            <div class="col-sm-3">
                                            	<button type="button" title="Create new cluster" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i> <span class="bold"></span></button>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-sm-9 col-sm-offset-3">
                                                <ul class="schedule-list">
                                                    <li>
                                                        <div class="well">
                                                            <div class="form-group">
                                                                <label class="col-sm-2 control-label">Start</label>
                                                                <div class="col-sm-4">
                                                                	<input type="text" class="form-control input-sm m-b-xs" id="schedule_start" name="schedule_start" value="${mapSchedule.start_date}"></div>
                                                                <label class="col-sm-2 control-label">Stop</label>
                                                                <div class="col-sm-4">
                                                                	<input type="text" class="form-control input-sm m-b-xs" id="schedule_stop" name="schedule_stop" value="${mapSchedule.end_date}"></div>
                                                            </div>
                                                            
                                                            
                                                            
                                                            <div id="bcType_fileDownload" <c:if test="${not empty mapSchedule.service && mapSchedule.service == 'Streaming'}"> style="display:none"</c:if>>
                                                                <div class="form-group">
	                                                                <label class="col-sm-2 control-label">Content</label>
	                                                                <!-- 
	                                                                 -->
	                                                                <div class="col-sm-9">
	                                                                	<button type="button"  title="Create new cluster" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i> <span class="bold"></span></button>
	                                                                </div>
	                                                            </div>
	                                                            <div class="form-group">
	                                                                <div class="col-sm-10 col-sm-offset-2">
	                                                                    <ul class="schedule-list">
	                                                                        <li>
	                                                                            <div class="well">
	                                                                                <div class="form-group">
	                                                                                    <label class="col-md-2 control-label">File URI</label>
	                                                                                    <div class="col-md-10"><input type="text" class="form-control input-sm m-b-xs" id="fileURI" name="fileURI" value="${mapSchedule.fileURI}"></div>
	                                                                                    <label class="col-md-2 control-label">Start</label>
	                                                                                    <div class="col-md-4">
	                                                                                    <c:if test="${empty mapSchedule.BCID}">
	                                                                                    	<input type="text" class="form-control input-sm m-b-sm" id="deliveryInfo_start" name="deliveryInfo_start" value="${mapSchedule.start_date}"></div>
	                                                                                    </c:if>
	                                                                                    <c:if test="${not empty mapSchedule.BCID}">
	                                                                                    	<input type="text" class="form-control input-sm m-b-sm" id="deliveryInfo_start" name="deliveryInfo_start" value="${mapSchedule.deliveryInfo_start}"></div>
	                                                                                    </c:if>
	                                                                                    	
	                                                                                    <label class="col-md-2 control-label">Stop</label>
	                                                                                    <div class="col-md-4">
	                                                                                    <c:if test="${empty mapSchedule.BCID}">
	                                                                                    	<input type="text" class="form-control input-sm m-b-sm" id="deliveryInfo_end" name="deliveryInfo_end" value="${mapSchedule.end_date}"></div>
	                                                                                    </c:if>
	                                                                                    <c:if test="${not empty mapSchedule.BCID}">
	                                                                                    	<input type="text" class="form-control input-sm m-b-sm" id="deliveryInfo_end" name="deliveryInfo_end" value="${mapSchedule.deliveryInfo_end}"></div>
	                                                                                    </c:if>
	                                                                                    <!-- 
	                                                                                    <div class="col-md-12 text-right"><button type="button" class="btn btn-danger btn-sm">Content Delete</button></div>
	                                                                                     -->
	                                                                                </div>
	                                                                            </div>
	                                                                        </li>
	                                                                    </ul>
	                                                                </div>
	                                                                <!-- 
	                                                                <div class="col-sm-12 text-right"><button type="button" class="btn btn-danger">Schedule Delete</button></div>
	                                                                 -->
	                                                            </div>
                                                            </div>
                                                            
                                                            
                                                        </div>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div id="bcType_streaming2" <c:if test="${empty mapSchedule.service || mapSchedule.service == 'FileDownload'}">style="display:none"</c:if>>
	                                       <div class="form-group">
                                            <label class="col-sm-3 control-label">ContentSet</label>
                                            <div class="col-sm-9">
                                               
                                                <div class="well">
                                                  
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label">mpd</label>
                                                        <div class="col-sm-9"><input type="text" class="form-control input-sm" id="mpdURI" name="mpdURI" value="${mapSchedule.mpdURI}"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        </div>
                                        <div class="hr-line-dashed"></div>
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label">Associated Delivery</label>
                                            <div class="col-sm-9">
                                                <div class="well">
                                                    <div class="form-group">
                                                        <label class="col-md-3 control-label">Post File Pepair</label>
                                                        <div class="col-md-9">
                                                            <div class="swich m-b-n">
                                                                <div class="onoffswitch">
                                                                    <input type="checkbox" checked class="onoffswitch-checkbox" id="postFileRepair" name="postFileRepair">
                                                                    <label class="onoffswitch-label" for="postFileRepair">
                                                                        <span class="onoffswitch-inner"></span>
                                                                        <span class="onoffswitch-switch"></span>
                                                                    </label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-md-3 control-label">Reception Report</label>
                                                        <div class="col-md-9">
                                                            <div class="swich m-b-n">
                                                                <div class="onoffswitch">
                                                                    <input type="checkbox" checked class="onoffswitch-checkbox" id="receptionReport" name="receptionReport">
                                                                    <label class="onoffswitch-label" for="receptionReport">
                                                                        <span class="onoffswitch-inner"></span>
                                                                        <span class="onoffswitch-switch"></span>
                                                                    </label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label">Report Type</label>
                                                        <div class="col-sm-9">
                                                            <select class="input input-sm form-control" id="reportType" name="reportType">
                                                                <option value="Rack">Rack</option>
                                                                <option value="StaR-all">StaR-all</option>
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label">Sample Percentage</label>
                                                        <div class="col-sm-9"><input type="text" class="form-control input-sm" id="samplePercentage" name="samplePercentage" value="${mapSchedule.samplePercentage}"></div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label">Offset Time</label>
                                                        <div class="col-sm-9"><input type="text" class="form-control input-sm" id="offsetTime" name="offsetTime" value="${mapSchedule.offsetTime}"></div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-sm-3 control-label">Random Time</label>
                                                        <div class="col-sm-9"><input type="text" class="form-control input-sm" id="randomTime" name="randomTime" value="${mapSchedule.randomTime}"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
				                        	<div class="col-sm-5"></div>
				                        	<div class="col-sm-">
					                        	<button class="col-sm-2 btn btn-success" type="submit" id="btnOK" style="margin-left:10px;margin-top:10px">
					                        	<c:if test="${empty mapSchedule.BCID}">
					                        	OK
					                        	</c:if>
					                        	<c:if test="${not empty mapSchedule.BCID}">
					                        	UPDATE            	
					                        	</c:if>            	
					                        	</button>
					                        	
					                        	<button class="col-sm-2 btn btn-success" type="button" id="btnDelete" name="btnDelete" style="margin-left:10px;margin-top:10px">Delete</button>
					                        	
					                        	<button class="col-sm-2 btn btn-success" type="button" id="btnCancel" name="btnCancel" style="margin-left:10px;margin-top:10px">Cancel</button>
				                        	</div>
									    </div>
                                    
                                </div>
                            </div>
                        </div>
                        
                    </div>
                </div>
            </div>
		</form>
        </div><!-- content body end -->
    </div><!-- content end -->

</div><!-- wrapper end -->


</body>
</html>
