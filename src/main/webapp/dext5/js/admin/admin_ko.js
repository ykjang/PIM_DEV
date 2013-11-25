﻿/**************************************************************************************************
* File			:	admin_ko.js
* Function		:	관리자 시스템 전체페이지에 적용되는 한글 language 
* author		:	Dext5 Editor 개발팀
* Created		:	2013.09.13
* Copyright(c) 2013 by DEVPIA Corp. All Rights Reserved.
*
* Version           WRITER           DATE                  description
* -------- ---------------------   --------    ---------------------------------- 
*   1.0     Dext5 Editor 개발팀   2013.09.13    최초작성                   
*
****************************************************************************************************/

var dext5_admin_lang =
{
	top_menu:
    {
        "m_file": "파일",
        "m_edit": "편집",
        "m_view": "보기",
        "m_insert": "삽입",
        "m_form": "서식",
        "m_table": "표",
        "m_tool": "도구",
        "m_help": "도움말"
    },
	top_menu_value:
	["m_file","m_edit","m_view","m_insert","m_form","m_table","m_tool","m_help"],
	top_menu_text:
	["파일","편집","보기","삽입","서식","표","도구","도움말"],
	tool_bar:
	{
		"separator": "| 구분선",
	    "grid": "그리드 배경",
	    "select_all": "전체선택",
	    "align_left": "왼쪽 정렬",
	    "align_center": "가운데 정렬",
	    "align_right": "오른쪽 정렬",
	    "align_full": "양쪽 정렬",
	    "new": "새 문서",
	    "save": "저장",
	    "print": "인쇄",
	    "bold": "굵게",
	    "italic": "이탤릭",
	    "underline": "밑줄",
	    "strike_through": "취소선",
	    "superscript": "위 첨자",
	    "subscript": "아래 첨자",
	    "remove_format": "서식 지우기",
	    "copy": "복사",
	    "cut": "잘라내기",
	    "paste": "붙여넣기",
	    "doc_bg_image": "문서 배경 이미지",
	    "font_color": "글자색",
	    "font_bg_color": "글자 배경색",
	    "line_height": "줄간격",
	    "list_bullets": "글머리 기호",
	    "list_number": "글머리 번호",
	    "indent": "들여쓰기",
	    "outdent": "내어쓰기",
	    "undo": "되돌리기",
	    "redo": "다시 실행",
	    "image_create": "이미지",
	    "flash_create": "Flash",
	    "media_create": "영상",
	    "symbol": "특수기호",
	    "emoticon": "이모티콘",
	    "horizontal_line": "수평선",
	    "iframe_create": "Iframe",
	    "hyperlink_create": "하이퍼링크",
	    "bookmark": "책갈피",
	    "find": "찾기",
	    "replace": "바꾸기",
	    "full_screen": "전체화면",
	    "table_insert": "표 삽입",
	    "table_property": "표 속성",
	    "table_delete": "표 삭제",
	    "insert_column_left": "열 삽입(왼쪽)",
	    "insert_column_right": "열 삽입(오른쪽)",
	    "insert_row_up": "행 삽입(위)",
	    "insert_row_down": "행 삽입(아래)",
	    "delete_column": "열 삭제",
	    "delete_row": "행 삭제",
	    "merge_cell": "셀 합치기",
	    "split_cell": "셀 나누기",
	    "table_same_width": "행 너비 동일하게",
	    "table_same_height": "열 높이 동일하게",
	    "formatting": "서식",
	    "font_family": "글꼴",
	    "font_size": "글자크기",
	    "setting": "환경설정"
	},
	tool_bar_value:
	["separator","grid","select_all","align_left","align_center","align_right","align_full",
	 "new","save","print","bold","italic","underline","strike_through","superscript","subscript",
	 "remove_format","copy","cut","paste","doc_bg_image","font_color",
	 "font_bg_color","line_height","list_bullets","list_number","indent","outdent","undo","redo",
	 "image_create","flash_create","media_create","symbol","emoticon","horizontal_line","iframe_create",
	 "hyperlink_create","bookmark","find","replace","full_screen",
	 "table_insert", "table_property","table_delete", "insert_column_left", "insert_column_right",
	 "insert_row_up","insert_row_down","delete_column","delete_row","merge_cell","split_cell",
	 "table_same_width","table_same_height","formatting","font_family","font_size","setting"],
	tool_bar_text:
	["| 구분선","그리드 배경","전체선택","왼쪽 정렬","가운데 정렬","오른쪽 정렬","양쪽 정렬",
     "새 문서","저장","인쇄","굵게","이탤릭","밑줄","취소선","위 첨자","아래 첨자",
     "서식 지우기","복사","잘라내기","붙여넣기","문서 배경 이미지","글자색",
     "글자 배경색","줄간격","글머리 기호","글머리 번호","들여쓰기","내어쓰기","되돌리기","다시 실행",
     "이미지","Flash","영상","특수기호","이모티콘","수평선","Iframe",
     "하이퍼링크","책갈피","찾기","바꾸기","전체화면",
     "표 삽입","표 속성","표 삭제","열 삽입(왼쪽)","열 삽입(오른쪽)",
     "행 삽입(위)","행 삽입(아래)","열 삭제","행 삭제","셀 합치기","셀 나누기",
     "행 너비 동일하게","열 높이 동일하게","서식","글꼴","글자크기","환경설정"],
    status_bar:
    {
    	"design": "디자인(필수)",
    	"source": "HTML",
    	"preview": "미리보기",
    	"text": "TEXT"
    },
    status_bar_value:
 	["design","source","preview","text"],
 	status_bar_text:
 	["디자인(필수)","HTML","미리보기","TEXT"],
 	remove_item:
	{
        "separator": "|구분선",
	    "grid": "그리드 배경",
	    "select_all": "전체선택",
        "align" : "수평 정렬",
	    "align_left": "왼쪽 정렬",
	    "align_center": "가운데 정렬",
	    "align_right": "오른쪽 정렬",
	    "align_full": "양쪽 정렬",
	    "align_vertical": "수직 정렬",
	    "valign_up": "위쪽",
	    "valign_center": "가운데",
	    "valign_baseline": "기준선",
        "valign_bottom" : "아래쪽",
	    "new": "새 문서",
	    "template": "템플릿",
	    "save": "저장",
	    "print": "인쇄",
	    "bold": "굵게",
	    "italic": "이탤릭",
	    "underline": "밑줄",
	    "strike_through": "취소선",
	    "superscript": "위 첨자",
	    "subscript": "아래 첨자",
	    "remove_format": "서식 지우기",
	    "copy": "복사",
	    "cut": "잘라내기",
	    "paste": "붙여넣기",
	    "doc_bg_image": "문서 배경 이미지",
	    "font_color": "글자색",
	    "font_bg_color": "글자 배경색",
	    "line_height": "줄간격",
	    "list_bullets": "글머리 기호",
	    "list_number": "글머리 번호",
	    "indent": "들여쓰기",
	    "outdent": "내어쓰기",
	    "undo": "되돌리기",
	    "redo": "다시 실행",
        "entity" : "개체",
	    "image_create": "이미지",
	    "flash_create": "Flash",
	    "media_create": "영상",
	    "symbol": "특수기호",
	    "emoticon": "이모티콘",
	    "horizontal_line": "수평선",
        "insert_link_media": "외부 동영상 공유",
	    "iframe_create": "Iframe",
	    "hyperlink_create": "하이퍼링크",
	    "bookmark": "책갈피",
	    "find": "찾기",
	    "replace": "바꾸기",
        "tool_replace" : "대/소문자 바꾸기",
	    "full_screen": "전체화면",
	    "table_insert": "표 삽입",
        "detail_table_insert": "새 표...",
	    "table_property": "표 속성",
	    "cell_property": "셀 속성",
	    "row_property": "가로줄 속성...",
        "column_property" : "세로줄 속성...",
	    "table_delete": "표 삭제",
	    "table_row_clone": "가로줄 복제",
	    "table_select": "선택",
	    "table_select_cell": "셀 선택",
	    "table_select_row": "가로줄 선택",
	    "table_select_column": "세로줄 선택",
	    "table_select_all": "전체 선택",
	    "table_tool": "표 도구",
        "convert_table_to_text": "표 텍스트로 변환",
        "cell_size": "셀 크기 조정",
	    "insert_row_column": "가로줄/세로줄 삽입...",
	    "insert_row": "가로줄 삽입",
	    "insert_column": "세로줄 삽입",
	    "insert_column_left": "열 삽입(왼쪽)",
	    "insert_column_right": "열 삽입(오른쪽)",
	    "insert_row_up": "행 삽입(위)",
	    "insert_row_down": "행 삽입(아래)",
	    "delete_column": "열 삭제",
	    "delete_row": "행 삭제",
	    "merge_cell": "셀 합치기",
	    "split_cell": "셀 나누기",
	    "table_same_width": "행 너비 동일하게",
	    "table_same_height": "열 높이 동일하게",
	    "table_same_widthheight": "모든 너비/높이 같게",
	    "formatting": "서식",
	    "font_family": "글꼴",
	    "font_size": "글자크기",
	    "source": "HTML",
	    "preview": "미리보기",
	    "text": "TEXT",
	    "setting": "환경설정"
	},
	remove_item_value:
	["separator", "grid", "select_all", "align", "align_left", "align_center", "align_right", "align_full", 
     "align_vertical", "valign_up", "valign_center", "valign_baseline", "valign_bottom",
	 "new", "template", "save", "print", "bold", "italic", "underline", "strike_through", "superscript", "subscript",
	 "remove_format","copy","cut","paste","doc_bg_image","font_color",
	 "font_bg_color","line_height","list_bullets","list_number","indent","outdent","undo","redo","entity",
	 "image_create", "flash_create", "media_create", "symbol", "emoticon", "horizontal_line", "insert_link_media", "iframe_create",
	 "hyperlink_create", "bookmark", "find", "replace", "tool_replace", "full_screen", "table_insert", "detail_table_insert",
	 "table_property", "cell_property", "row_property", "column_property", "table_delete", "table_row_clone", "table_select", "table_select_cell", "table_select_row", 
     "table_select_column", "table_select_all", "table_tool", "convert_table_to_text", "cell_size", "insert_row_column", "insert_row", "insert_column", 
     "insert_column_left", "insert_column_right", "insert_row_up","insert_row_down","delete_column","delete_row","merge_cell","split_cell",
	 "table_same_width","table_same_height","table_same_widthheight","formatting","font_family","font_size",
	 "source","preview","text","setting"],
	remove_item_text:
	["|구분선", "그리드 배경", "전체선택", "수평 정렬", "왼쪽 정렬", "가운데 정렬", "오른쪽 정렬", "양쪽 정렬", 
     "수직 정렬", "위쪽", "가운데", "기준선", "아래쪽",
     "새 문서","템플릿","저장","인쇄","굵게","이탤릭","밑줄","취소선","위 첨자","아래 첨자",
     "서식 지우기", "복사", "잘라내기", "붙여넣기", "문서 배경 이미지", "글자색",
     "글자 배경색","줄간격","글머리 기호","글머리 번호","들여쓰기","내어쓰기","되돌리기","다시 실행","개체",
     "이미지","Flash","영상","특수기호","이모티콘","수평선","외부 동영상 공유","Iframe",
     "하이퍼링크", "책갈피", "찾기", "바꾸기", "대/소문자 바꾸기", "전체화면", "표 삽입", "새 표...",
     "표 속성", "셀 속성", "가로줄 속성...", "세로줄 속성...", "표 삭제", "가로줄 복제", "선택", "셀 선택", "가로줄 선택", 
     "세로줄 선택", "셀 전체선택", "표 도구", "표 텍스트로 변환", "셀 크기 조정", "가로줄/세로줄 삽입...", "가로줄 삽입", "세로줄 삽입", 
     "열 삽입(왼쪽)", "열 삽입(오른쪽)", "행 삽입(위)","행 삽입(아래)","열 삭제","행 삭제","셀 합치기","셀 나누기",
     "행 너비 동일하게","열 높이 동일하게", "모든 너비/높이 같게", "서식","글꼴","글자크기",
     "HTML","미리보기","TEXT","환경설정"],
    font_family:
    ["굴림", "굴림체", "궁서", "궁서체", "돋움", "돋움체", "맑은 고딕", "바탕", "바탕체", "새굴림", "안상수2006가는", "안상수2006굵은", "안상수2006중간",
    "한양해서", "한컴돋움", "한컴바탕", "한컴바탕확장", "휴먼둥근헤드라인", "휴먼매직체", "휴먼모음T", "휴먼아미체", "휴먼엑스포", "휴먼옛체", "휴먼편지체",
    "HY강B", "HY강M", "HY견고딕", "HY견명조", "HY궁서", "HY궁서B", "HY그래픽", "HY그래픽M", "HY나무B", "HY나무L", "HY나무M", "HY동녘B", "HY동녘M",
    "HY목각파임B", "HY목판L", "HY바다L", "HY바다M", "HY백송B", "HY산B", "HY센스L", "HY수평선B", "HY수평선M", "HY신명조", "HY얕은샘물M", "HY엽서L",
    "HY엽서M", "HY울릉도B", "HY울릉도M", "HY중고딕", "HY크리스탈M", "HY태백B", "HY헤드라인M", "Agency FB", "Algerian", "Andalus", "Angsana New",
    "AngsanaUPC", "Arabic Typesetting", "Arial", "Arial Black", "Arial Narrow", "Arial Rounded MT Bold", "Arial Unicode MS", "Baskerville Old Face",
    "Bauhaus 93", "Bell MT", "Berlin Sans FB", "Bernard MT Condensed", "Blackadder ITC", "Bodoni MT", "Bodoni MT Black", "Bodoni MT Condensed",
    "Bodoni MT Poster Compressed", "Book Antiqua", "Bookman Old Style", "Bookshelf Symbol 7", "Bradley Hand ITC", "Britannic Bold", "Broadway",
    "Browallia New", "BrowalliaUPC", "Calibri", "Californian FB", "Calisto MT", "Cambria", "Cambria Math", "Candara", "Castellar", "Centaur",
    "Century", "Century Gothic", "Century Schoolbook", "Chiller", "Colonna MT", "Comic Sans MS", "Consolas", "Constantia", "Cooper Black",
    "Copperplate Gothic Bold", "Copperplate Gothic Light", "Corbel", "Cordia New", "CordiaUPC", "Courier New", "Curlz MT", "DaunPenh", "David",
    "DFKai-SB", "DilleniaUPC", "DokChampa", "Edwardian Script ITC", "Elephant", "Engravers MT", "Eras Bold ITC", "Eras Demi ITC", "Eras Light ITC",
    "Eras Medium ITC", "Estrangelo Edessa", "EucrosiaUPC", "Euphemia", "FangSong", "Felix Titling", "Footlight MT Light", "Forte", "Franklin Gothic Book",
    "Franklin Gothic Demi", "Franklin Gothic Demi Cond", "Franklin Gothic Heavy", "Franklin Gothic Medium", "Franklin Gothic Medium Cond", "FrankRuehl",
    "FreesiaUPC", "Freestyle Script", "French Script MT", "Garamond", "Gautami", "Georgia", "Gigi", "Gill Sans MT", "Gill Sans MT Condensed",
    "Gill Sans MT Ext Condensed Bold", "Gill Sans Ultra Bold", "Gill Sans Ultra Bold Condensed", "Gisha", "Gloucester MT Extra Condensed",
    "Goudy Old Style", "Goudy Stout", "Haettenschweiler", "Harrington", "High Tower Text", "HyhwpEQ", "Impact", "Imprint MT Shadow", "Informal Roman",
    "IrisUPC", "Iskoola Pota", "JasmineUPC", "Jokerman", "Juice ITC", "KaiTi", "Kalinga", "Kartika", "KodchiangUPC", "Kristen ITC", "Kunstler Script",
    "Latha", "Leelawadee", "Levenim MT", "LilyUPC", "Lucida Bright", "Lucida Calligraphy", "Lucida Console", "Lucida Fax", "Lucida Handwriting", "Lucida Sans",
    "Lucida Sans Typewriter", "Lucida Sans Unicode", "Maiandra GD", "Mangal", "Marlett", "Matura MT Script Capitals", "Meiryo", "Microsoft Himalaya",
    "Microsoft JhengHei", "Microsoft Sans Serif", "Microsoft Uighur", "Microsoft YaHei", "Microsoft Yi Baiti", "MingLiU", "MingLiU-ExtB", "MingLiU_HKSCS",
    "MingLiU_HKSCS-ExtB", "Miriam", "Miriam Fixed", "Mistral", "Modern No. 20", "Mongolian Baiti", "MoolBoran", "MS Gothic", "MS Mincho", "MS Outlook",
    "MS PGothic", "MS PMincho", "MS Reference Sans Serif", "MS Reference Specialty", "MS UI Gothic", "MT Extra", "MV Boli", "Narkisim", "Niagara Engraved",
     "Niagara Solid", "Nina", "NSimSun", "Nyala", "OCR A Extended", "Old English Text MT", "Onyx", "Palatino Linotype", "Papyrus", "Parchment", "Perpetua",
     "Perpetua Titling MT", "Plantagenet Cherokee", "Playbill", "PMingLiU", "PMingLiU-ExtB", "Poor Richard", "Pristina", "Raavi", "Rage Italic", "Ravie",
     "Rockwell", "Rockwell Condensed", "Rockwell Extra Bold", "Rod", "Script MT Bold", "Segoe Condensed", "Segoe Print", "Segoe Script", "Segoe UI",
     "Showcard Gothic", "Shruti", "SimHei", "Simplified Arabic", "Simplified Arabic Fixed", "SimSun", "SimSun-ExtB", "Snap ITC", "Stencil", "Sylfaen",
     "Symbol", "Tahoma", "Tempus Sans ITC", "TeXplus EX", "TeXplus MI", "TeXplus RM", "TeXplus SY", "Times New Roman", "Traditional Arabic", "Trebuchet MS",
     "Tunga", "Tw Cen MT", "Tw Cen MT Condensed", "Tw Cen MT Condensed Extra Bold", "Verdana", "Viner Hand ITC", "Vladimir Script", "Vrinda", "Webdings", 
     "Wide Latin", "Wingdings", "Wingdings 2", "Wingdings 3"],
    skinname_value:
    ["#ced9e7","#ecc891","#808080","#cfc58b","#dfdfdf","#c9e880",
     "#ffbd56","#f1c8f1","#b5a2da","#f96c55","#f4ed74","#c8c7c1"],
    skinname_text:
    ["Blue","Brown","Darkgray","Gold","Gray","Green",
     "Orange","Pink","Purple","Red","Yellow","Silver"],
    enter_tag:["br","p"],
    shift_enter_tag:["br","p"],
    grid_color_value:
    ["#000000","#808080","#d3d3d3","#8b0000","#ff0000","#ff7f50",
     "#ffa07a","#ffdab9","#ffe4c4","#d2b48c","#f5deb3","#daa520",
     "#ffd700","#eee8aa","#adff2f","#90ee90","#008000","#00ff00",
     "#7fffd4","#00ffff","#00ced1","#87ceeb","#4682b4","#6495ed",
     "#4169e1","#0000ff","#9370db","#8a2be2","#800080","#ff00ff",
     "#ff1493","#ffc0cb"],
    grid_color_text:
    ["Black","Gray","Light Gray","Dark Red","Red","Coral",
     "Light Salmon","Peach Puff","Bisque","Tan","Wheat","Goldenrod",
     "Gold","Pale Goldenrod","Green Yellow","Light Green","Green","Lime",
     "Aqua marine","Cyan","Dark Turquoise","Sky Blue","Steel Blue","Cornflower Blue",
     "Royal Blue","Blue","Medium Purple","Blue Violet","Purple","Magenta",
     "Deep Pink","Pink"],
    grid_spans:
    ["8","12","16","24","32","50","64","100"],
    encoding_text:
    ["사용자 정의","한국어(EUC)","한국어(완성형)","유니코드(UTF-8)","OEM 영어","OEM 카릴 자모","T.61","US ASCII",
     "일본어(JIS)","일본어(EUC)","일본어(Shift-JIS)","중국어 간체(GB18030)","중국어 간체(GB2312)","중국어 간체(HZ)","중국어 번체(BIG5)",
     "아랍어(ASMO 708)","아랍어(DOS)","아랍어(ISO)","아랍어(Windows)","발트어(ISO)","발트어(Windows)",
     "서유럽어(ISO)","서유럽어(Windows)","중앙 유럽어(DOS)","중앙 유럽어(ISO)","중앙 유럽어(Windows)",
     "키릴자모(DOS)","키릴자모(ISO)","키릴자모(KOI8-R)","키릴자모(KOI8-u)","키릴자모(Windows)","그리스어(ISO)","그리스어(Windows)",
     "히브리어(DOS)","히브리어(ISO-Logical)","히브리어(ISO-Visual)","히브리어(Windows)","태국어(Windows)",
     "터키어(ISO)","터키어(Windows)","베트남어(Windows)"],
    encoding_value:
    ["x-user-defined","euc-kr","ks_c_5601-1987","utf-8","IBM437","IBM855","x-cp20261","us-ascii",
     "iso-2022-jp","euc-jp","shift_jis","GB18030","gb2312","hz-gb-2312","big5",
     "asmo-708","dos-720","iso-8859-6","windows-1256","iso-8859-4","windows-1257",
     "iso-8859-1","windows-1252","ibm852","iso-8859-2","windows-1250",
     "cp866","iso-8859-5","koi8-r","koi8-u","windows-1251","iso-8859-7","windows-1253",
     "dos-862","iso-8859-8-i","iso-8859-8","windows-1255","windows-874",
     "iso-8859-9","windows-1254","windows-1258"],
    doctype_value:
    ["None","HTML 5","XHTML 1.1","XHTML 1.0 Transitional","XHTML 1.0 Strict","XHTML 1.0 Frameset",
     "HTML 4.01 Transitional","HTML 4.01 Strict","HTML 4.01 Frameset","HTML 3.2","HTML 2.0"],
    doctype_text:
    ["","HTML 5","XHTML 1.1","XHTML 1.0 Transitional","XHTML 1.0 Strict","XHTML 1.0 Frameset",
     "HTML 4.01 Transitional","HTML 4.01 Strict","HTML 4.01 Frameset","HTML 3.2","HTML 2.0"],
    doc_lang:
    ["","af","ar","bg","bn","bs","ca","cs","cy","da","de","el","en","en-au","en-ca","en-gb","eo",
     "es","et","eu","fa","fl","fo","fr","fr-ca","gl","gu","he","hi","hr","hu","is","it","ja","ka","km",
     "ko","ku","lt","lv","mk","mn","ms","nb","nl","no","pl","pt","pt-br","ro","ru","sk","sl","sq",
     "sr","sr-latn","sv","th","tr","ug","uk","vi","zh"],
    accessibility_value:
    ["0","1","2"],
    accessibility_text:
    ["기본:웹 접근성 설정을 하지 않습니다.","1단계:웹 접근성을 준수하지 않은 경우 해당 사항을 알려준 후 계속 진행합니다.","2단계:웹 접근성을 반드시 준수하여 작성할 수 있도록 합니다."],
    topmenu_value:
    ["0","1"],
    topmenu_text:
    ["상단메뉴 보이기","상단메뉴 숨기기"],
    toolbar_value:
    ["0","1","2","3"],
    toolbar_text:
    ["1번,2번 툴바 모두 보이기","1번 툴바 숨기기","2번 툴바 숨기기","1번,2번 툴바 모두 숨기기"],
    statusbar_value:
    ["0","1"],
    statusbar_text:
    ["상태바 보이기","상태바 숨기기"],
    showdialog_pos_value:
    ["0","1"],
    showdialog_pos_text:
    ["(메인)프레임창 중앙","작성화면에 맞춤"],
    develop_langage:
    ["NET","JSP","PHP"],
    save_foldername_rule:
    ["/","YYYY/","YYYY/MM/","YYYY/MM/DD/"],
    save_filename_rule:
    ["","GUID","DATETIME"],
    image_convert_format:
    ["","jpg"],
    plugin_use_value:
    ["0", "1"],
    plugin_use_text:
    ["사용안함", "사용함"],
    license_url_desc1: "기본값은 dext5 폴더 아래 plugin 폴더 입니다.",
    license_url_desc2: "http://를 포함한 경로를 입력해야 합니다. 예) http://www.dext5.com/dext5/plugin/",
    upload_url_desc1: "기본값은 dext5 폴더 아래 handler 폴더 입니다.",
    upload_url_desc2: "상대 및 절대경로, http://를 포함한 경로 모두 가능합니다. 예) 상대경로: test/handler, 절대경로: /dext5editor/dext5/test/handler",
    save_path_desc1: "기본값은 dext5 폴더 아래 dext5data 폴더 입니다.",
    save_path_desc2: "상대 및 절대경로 입력 가능합니다. 예) 상대경로: test/data, 절대경로: /test/data"
};