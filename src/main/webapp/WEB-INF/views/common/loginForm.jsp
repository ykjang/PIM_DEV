<%@ page contentType="text/html;charset=utf-8" session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/html4/loose.dtd"> 


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<html> 
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Contact</title>
</head>
<body> 
<body>
	<h2>Use Service Layer & DAO Layer</h2>
 	<!-- form method는 지정하지 않을 경우 post로 전송됨  -->
	<form:form id="loginForm" action="loginProc.do" method="post">
		<div>
			ID : <input id="userId" name="userId" type="text"/><br />
			PASSWORD : <input id="userPwd" name="userPwd" type="password"/>
			<input id="sendReq" type="submit" value="SEND" /><br/>
		</div>
	</form:form>
	
</body>
</html>
