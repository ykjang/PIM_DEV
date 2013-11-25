<%@ page contentType="text/html;charset=utf-8"%>
<%@ include file="config.jsp" %>
<%@ page import="java.sql.*"%>
<%
	int seq = 0;
	if(request.getParameter("seq") != null){
		seq = Integer.parseInt(request.getParameter("seq"));
	}
	
	String scontents = "";
	
	String qry = "SELECT UE_CONTENTS FROM UT_EDITOR WHERE UE_SEQ = ?";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try
	{
		Class.forName(DV_G_JDBC_DRIVER_NAME);		
		conn = DriverManager.getConnection(DV_G_DB_URL, DV_G_DB_USER, DV_G_DB_PWD);
		
		pstmt = conn.prepareStatement(qry);
		pstmt.clearParameters();
		pstmt.setInt(1, seq);
	
		rs = pstmt.executeQuery();
		
		if(rs.next())
		{
			scontents = rs.getString("UE_CONTENTS");
		}
	}
	catch(Exception e)
	{
		out.println(e.toString());
	}
%>
<%=scontents%>
