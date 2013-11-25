<% 
	String reqUrl = request.getRequestURI().toLowerCase();
	String menuId = "";
	
	System.out.println("reqUrl"+reqUrl);
	
	if(reqUrl.indexOf("/user/") != -1 ){
		menuId = "grid-menu";
	}else if(reqUrl.indexOf("/ws/") != -1 ){
		menuId = "ws-menu";
	}else if(reqUrl.indexOf("/dext5/") != -1 ){
		menuId = "editor-menu";
	}else if(reqUrl.indexOf("/payment/") != -1 ){
		menuId = "payment-menu";
	}else if(reqUrl.substring(reqUrl.lastIndexOf("/")+1).equals("index.do")
			|| reqUrl.substring(reqUrl.lastIndexOf("/")+1).equals("") ){
		menuId = "dashboard";
	}
%>
<div class="sidebar-nav">
    <a href="/index.do" class="nav-header" ><i class="icon-dashboard"></i>Dashboard</a>

    
    <a href="#ws-menu" class="nav-header collapsed" data-toggle="collapse"><i class="icon-exclamation-sign"></i>WebService Sample<i class="icon-chevron-up"></i></a>
    <ul id="ws-menu" class="nav nav-list collapse">
      <li><a href="/ws/CatEntRegister.do">Register CateEntry</a></li>
      <li><a href="/ws/getCatEntByPCatGrpId.do">Inquiry CateEntryList</a></li>
    </ul>
    
    <a href="#editor-menu" class="nav-header collapsed" data-toggle="collapse"><i class="icon-exclamation-sign"></i>WebEditor Sample<i class="icon-chevron-up"></i></a>
    <ul id="editor-menu" class="nav nav-list collapse">
      <li><a href="/dext5/index.do">DEXT5 Editor Sample</a></li>
    </ul>
    
    <a href="#grid-menu" class="nav-header collapsed" data-toggle="collapse"><i class="icon-briefcase"></i>Grid Sample<i class="icon-chevron-up"></i></a>
    <ul id="grid-menu" class="nav nav-list collapse">
      <!-- <li><a href="/user/status.do">User Status</a></li> -->
	  <li><a href="/user/status2.do">jqGrid Sample</a></li>
	  <li><a href="#">Kendo UI Sample</a></li>
    </ul>
	
    <!-- <a href="#visitor-menu" class="nav-header collapsed" data-toggle="collapse"><i class="icon-legal"></i>Visitor Information<i class="icon-chevron-up"></i></a>
    <ul id="visitor-menu" class="nav nav-list collapse">
      <li><a href="#">Visitor Status</a></li>
   <li><a href="#">Inflow Status</a></li>
   <li><a href="#">Non-connected<br>members</a></li>
    </ul>
    
    <a href="#payment-menu" class="nav-header collapsed" data-toggle="collapse"><i class="icon-legal"></i>Payment Information<i class="icon-chevron-up"></i></a>
    <ul id="payment-menu" class="nav nav-list collapse">
      <li><a href="#">Payment Status</a></li>
    </ul>
	 -->
	 
    <a href="#" class="nav-header" ><i class="icon-question-sign"></i>Help</a>
    <a href="#" class="nav-header" ><i class="icon-comment"></i>Faq</a>
</div>


<script type="text/javascript">
	$(document).ready(function(){
		
		$('ul#<%=menuId%>').addClass('in');
		$('#<%=menuId%> > li > a[href$="<%=reqUrl.substring(reqUrl.lastIndexOf("/")).replace(".jsp",".do")%>"]').css('fontWeight', 'bold');
	});
</script>