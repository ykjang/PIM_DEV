<%@ page contentType="text/html;charset=utf-8"%>
<%@ include file="config.jsp" %>
<%@ page import="java.sql.*"%>
<%
	int seq = 0;
	if(request.getParameter("seq") != null){
		seq = Integer.parseInt(request.getParameter("seq"));
	}
	
	String stitle = "";
	String scontents = "";
	String sname = "";
	
	String qry = "SELECT UE_TITLE, UE_CONTENTS, UE_USR_NM  FROM UT_EDITOR WHERE UE_SEQ = ?";
	
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
			stitle = rs.getString("UE_TITLE");
			scontents = rs.getString("UE_CONTENTS");
			scontents = scontents.trim();
			scontents = scontents.replace( "\"", "&quot;");
			sname = rs.getString("UE_USR_NM");
		}
	}
	catch(Exception e)
	{
		out.println(e.toString());
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>URIA Editor Standard Edition</title>
    <link rel="stylesheet" href="/dext5_sample.css" type="text/css" />
    <script type="text/javascript" src="/dext5/js/dext5editor.js"></script>
    <script type="text/javascript" src="/common.js"></script>
    <script language="javascript" type="text/javascript">
        function fSubmit() {
            if (!chkInputData('tbTitle', "제목을 입력하십시오.")) { return; }
            if (!chkInputData('tbPwd', "비밀번호를 입력하십시오.")) { return; }

            var sBodyValue = DEXT5.getHtmlValueEx();
            if (DEXT5.isEmpty() == true) {
                alert("내용 없음.");
                return;
            }

            document.frmData.hidContents.value = sBodyValue;

            var str = formData2QueryString(window.document.frmData);
            xmlhttpPost("/dext5/db_task.do", str, "result");
        }

        function result(p_rtn) {
            if (p_rtn == "") {
            	fList();
            } else if (p_rtn == "-1") {
                alert("비밀번호가 틀렸습니다. 다시 입력해주십시오.");
                $("tbPwd").focus();
            } else {
                alert(p_rtn);
            }
        }
        
        function fList() {
        	window.self.location.href = "/dext5/index.do";
        }

        function dext_editor_loaded_event(_dext) {
            var html = document.getElementById('hidContents');
            DEXT5.setHtmlValueEx(html.value);
        }
    </script>
</head>
<body>
    <form name="frmData" runat="server">
    <input type="hidden" name="hidContents" id="hidContents" value="<%=scontents%>"/>
    <input type="hidden" id="hidSeq" name="hidSeq" value="<%=seq%>" />
    <input type="hidden" id="hidMod" name="hidMod" value="mod" />
    <div id="idContent" style="display: none;" runat="server"></div>
    <div class="wrapper">
        <div class="lyBackground">
            <div class="lyTop" align="center">
                <div class="lyGuid" align="right">
                    <a href="javascript:fProductH()"><img src="/images/bt_info01.gif" border="0" alt="제품 사이트 방문하기" style="margin-right:8px;" /></a>
                </div>
            </div>
        </div>
        <div class="lyMain">
            <div class="main">
                <div class="mainFrame">
                    <div class="mainFrameM">
                        <div class="mainTitle">DEXT5 Editor 체험하기</div>
                        <div class="mainText" style="height: 70px;">
                            HTML5 기반의 DEXT5 Editor
                            <br />
                            어떠한 브라우저에서도 사용 가능하며, Active-X를 설치하지 않아도 사용할 수 있어 더욱 간편합니다.<br />
                        </div>
                        <div style="position: relative; width: 98%; margin-left: 8px; background-color: #FFFFFF">
                            <div align="left" style="float: left; height: 30px; width: 100px; display: inline; padding-left: 15px; padding-top: 10px;">
                                <a href="javascript:fList()">
                                    <img src="/images/bt_list.gif" border="0" width="60" height="23" alt="목록" />
                                </a>
                            </div>
                            <div align="right" style="float: right; height: 30px; width: 400px; display: inline; padding-right: 15px; padding-top: 10px;">
                                <a href="javascript:fSubmit()">
                                    <img src="/images/bt_06.gif" width="60" height="23" border="0" alt="확인" />
                                </a> 
                            </div>
                            <div align="center" style="width: 100%; float: left;">
                                <table style="width: 780px; background-color: #bcc4d2" border="0" cellpadding="1" cellspacing="0">
                                    <tr>
                                        <td>
                                            <table width="100%" border="0" cellpadding="5" cellspacing="1">
                                                <tr>
                                                    <td style="width: 85px; background-color: #eff1f4; text-align: center">
                                                        <b>제 목</b>
                                                    </td>
                                                    <td colspan="3" style="background-color: #FFFFFF" align="left">
                                                    	<input type="text" id="tbTitle" name="tbTitle" style="width:490px;" class="input2" value="<%=stitle%>"/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 85px; background-color: #eff1f4; text-align: center">
                                                        <b>작성자</b>
                                                    </td>
                                                    <td style="width: 120px; background-color: #FFFFFF" align="left">
                                                    	<input type="text" id="tbName" name="tbName" style="width:126px;" class="input2" value="<%=sname%>"/>
                                                    </td>
                                                    <td style="width: 85px; background-color: #eff1f4; text-align: center">
                                                        <b>비밀번호</b>
                                                    </td>
                                                    <td style="width: *; background-color: #FFFFFF" align="left">
                                                    	<input type="text" id="tbPwd" name="tbPwd" style="width:80px;" class="input2"/>
                                                        &nbsp;&nbsp;※글 최초 등록 시에 입력했던 비밀번호를 입력하십시오.
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4" style="background-color: #ffffff">
                                                        <!--에디터 영역-->
                                                        <script type="text/javascript">
                                                            //DEXT5.config.Height = "";
                                                            //DEXT5.config.Widht = "";
                                                            //DEXT5.config.SkinName = "";
                                                            //DEXT5.config.InitXml = "";   // ex)  DEXT5.config.InitXml = "dext_editor_mobile.xml"; //config 폴더 안의 파일 이름만 지정

                                                            var editor1 = new Dext5editor("editor1");
                                                        </script>
                                                        <!--에디터 영역-->
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div align="left" style="float: left; height: 30px; width: 100px; display: inline; padding-left: 15px; padding-top: 10px;">
                                <a href="javascript:fList()">
                                    <img src="/images/bt_list.gif" border="0" width="60" height="23" alt="목록" />
                                </a>
                            </div>
                            <div align="right" style="float: right; height: 40px; padding-right: 15px; padding-top: 10px;">
                                <a href="javascript:fSubmit()">
                                    <img src="/images/bt_06.gif" width="60" height="23" border="0" alt="확인" />
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="lyBackground">
            <div class="lyBottom" align="center"></div>
        </div>
    </div>
    </form>
</body>
</html>
