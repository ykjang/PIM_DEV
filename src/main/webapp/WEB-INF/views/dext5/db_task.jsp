<%@ page contentType="text/html;charset=utf-8"%><%@ include file="config.jsp" %><%@ page import="java.sql.*"%><%
	request.setCharacterEncoding("utf-8");

	String smod = request.getParameter("hidMod");
	
	int seq = 0;
	if(request.getParameter("hidSeq") != null){
		seq = Integer.parseInt(request.getParameter("hidSeq"));
	}
	
	String title = request.getParameter("tbTitle");
	String contents = request.getParameter("hidContents");
	String pwd = request.getParameter("tbPwd");
	String ue_usr_nm = request.getParameter("tbName");

	String result = "";
	
	String qry = "";
	if (smod.equals("reg")) {
		qry = "INSERT INTO UT_EDITOR (UE_TITLE, UE_CONTENTS, UE_CREATE_DT, UE_VIEW_CNT, UE_PWD, UE_USR_NM) VALUES (?, ?, now(), 0, ?, ?)";
	} else if (smod.equals("mod")) {
		qry = "UPDATE UT_EDITOR SET UE_TITLE = ?, UE_CONTENTS = ? WHERE UE_SEQ = ? AND UE_PWD = ?";
	} else if (smod.equals("del")) {
		qry = "DELETE FROM UT_EDITOR WHERE UE_SEQ = ? AND UE_PWD = ?";
	}
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	int resultCount = 0;
	
	try
	{
		Class.forName(DV_G_JDBC_DRIVER_NAME);		
		conn = DriverManager.getConnection(DV_G_DB_URL, DV_G_DB_USER, DV_G_DB_PWD);
		
		pstmt = conn.prepareStatement(qry);
		pstmt.clearParameters();
		if (smod.equals("reg")) {
			pstmt.setString(1, title);
			pstmt.setString(2, contents);
			pstmt.setString(3, pwd);
			pstmt.setString(4, ue_usr_nm);
		} else if (smod.equals("mod")) {
			pstmt.setString(1, title);
			pstmt.setString(2, contents);
			pstmt.setInt(3, seq);
			pstmt.setString(4, pwd);
		} else if (smod.equals("del")) {
			pstmt.setInt(1, seq);
			pstmt.setString(2, pwd);
		}

		resultCount = pstmt.executeUpdate();

		if(resultCount == 0) {
			result = "-1";
		}
	}
	catch (Exception e)
	{
		out.println("Error." + e.toString());
	}
	finally
	{
		if(pstmt != null)try{pstmt.close();}catch(SQLException ex){}
		if(conn != null) try { conn.close(); } catch(Exception e) {}
	}
%><%=result%>