var G_IMAGE_ALLOW_EXT=["jpg","jpeg","png","gif","bmp"];
function dext_swf(b,a,c){var d;d=""+('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" width="300px" height="50px" id="'+a+'" >')+'<param name="allowScriptAccess" value="always" />';d+='<param name="movie" value="'+c+'" />';d+='<param name="loop" value="false" />';d+='<param name="quality" value="high" />';d+='<param name="wmode" value="window" />';d+='<embed src="'+c+'" loop="false" quality="high" wmode="window"  width="300px" height="50px" name="'+a+'"  allowScriptAccess="always"  type="application/x-shockwave-flash" />';
d+="</object>";b.innerHTML=d}var LayerFrame=top.DEXTDOC.getElementById("dext_frame_"+top.G_CURREDITOR.ID),LayerWin=LayerFrame.contentWindow,LayerDoc=LayerWin.document;
function dext_setting(){var b=document.getElementById("grid_color").style.backgroundColor,a=document.getElementById("grid_color_name").innerHTML,c=document.getElementById("lang").value,d=document.getElementById("grid_spans").value,e=document.getElementsByName("grid_form")[0].checked?"line":"dot",f=document.getElementById("page_title").value,g=document.getElementById("encoding").value,l=document.getElementById("doctype").value,m=document.getElementById("xhtml").checked?document.getElementById("xhtml").value:
"",h=LayerWin._dext_editor._config.accessibility;if("1"==h)""==f&&alert(LayerWin.dext5_lang.msg.alert_page_title_access1);else if("2"==h&&""==f){alert(LayerWin.dext5_lang.msg.alert_page_title_access2);document.getElementById("page_title").focus();return}dext_json={grid_color:b,grid_color_nm:a,grid_spans:d,grid_form:e,page_title:f,encoding:g,lang:c,doctype:l,xhtml:m};LayerWin.event_dext_setting(dext_json,window.frameElement.parentNode)}
function dext_horizontal_line(b,a){var c;if(!b){c=document.getElementById("width_1").value;var d=document.getElementById("height").value,e=document.getElementById("align").value,f=document.getElementById("hr_color").style.borderTopColor;c={width:c,height:d,align:e,color:f}}LayerWin.event_dext_horizontal_line(c,b,a,window.frameElement.parentNode)}
function loading_image_show(b){var a=document.getElementById("dext_loading"),c="";!1==b?(c="none",document.body.style.cursor="default"):document.body.style.cursor="wait";a&&(a.style.display=c)}
function dext_upload_image(){var b=document.dext_upload_form,a=document.getElementById("Filedata"),c=document.getElementById("img_web_url"),d=document.getElementById("link_url"),e=LayerWin.getElementsByClass("EdiTor_Popup_contents",document);if(/^\s\s*$/.exec(d.value)||""==d.value||top.DEXT5.util.checkUrl(d.value))if(a=document.getElementsByName("InputFlag")[0].checked?a.value:c.value,0<a.lastIndexOf(".")){c=LayerWin._dext_editor._config.accessibility;d=document.getElementById("img_alt").value;if("1"==
c)""==d&&alert(LayerWin.dext5_lang.msg.alert_image_alt_access1);else if("2"==c&&""==d){alert(LayerWin.dext5_lang.msg.alert_image_alt_access2);document.getElementById("img_alt").focus();return}for(var c=a.substring(a.lastIndexOf(".")+1).toLowerCase(),d=!1,e=G_IMAGE_ALLOW_EXT,f=0;f<e.length;f++)if(c==e[f]){d=!0;break}!0==d?document.getElementsByName("InputFlag")[0].checked?(document.getElementById("savefileext").value=c,document.getElementById("savefilename").value=Math.floor(99999*Math.random()).toString(),
document.getElementById("tosavepathurl").value=LayerWin._dext_editor._config.toSavePathURL,document.getElementById("savafoldernamerule").value=LayerWin._dext_editor._config.saveFolderNameRule,document.getElementById("savafilenamerule").value=LayerWin._dext_editor._config.saveFileNameRule,document.getElementById("image_convert_format").value=LayerWin._dext_editor._config.image_convert_format,document.getElementById("image_convert_width").value=LayerWin._dext_editor._config.image_convert_width,document.getElementById("image_convert_height").value=
LayerWin._dext_editor._config.image_convert_height,loading_image_show(!0),b.action=document.getElementById("upload_url").value,b.submit()):event_dext_image_upload_completed(a):alert(LayerWin.dext5_lang.msg.alert_exec_img)}else alert(LayerWin.dext5_lang.msg.alert_exec);else alert(LayerWin.dext5_lang.msg.alert_url),e[0].className="EdiTor_Popup_contents none",e[1].className="EdiTor_Popup_contents view",LayerWin.lastFocus(d)}
function event_dext_image_link(){var b=document.getElementById("img_web_url").value,a=document.getElementById("img_width").value,c=document.getElementById("img_height").value,d=document.getElementById("img_alt").value,e=document.getElementById("img_title").value,f=document.getElementById("img_v_space").value,g=document.getElementById("img_h_space").value,l=document.getElementById("img_align"),l=l.options[l.selectedIndex].value,m=document.getElementById("img_border").value,h=document.getElementById("link_url").value,
k=document.getElementById("link_title").value,n=document.getElementById("link_target").value;LayerWin.event_dext_image_upload("","","","0",b,0,0,d,"",{srcURL:b,width:a,height:c,title:e,alt:d,vspace:f,hspace:g,align:l,border:m,linkurl:h,linktitle:k,linktarget:n},window.frameElement.parentNode)}
function event_dext_image_upload_completed(b){loading_image_show(!1);if(4>b.length||"http"!=b.substring(0,4).toLowerCase())confirm(LayerWin.dext5_lang.msg.uploadFailed)&&alert(b);else{var a=document.getElementById("savefilename").value,c=document.getElementById("img_width").value,d=document.getElementById("img_height").value,e=document.getElementById("img_alt").value,f=document.getElementById("img_title").value,g=document.getElementById("img_v_space").value,l=document.getElementById("img_h_space").value,
m=document.getElementById("img_align"),m=m.options[m.selectedIndex].value,h=document.getElementById("img_border").value,k=document.getElementById("link_url").value,n=document.getElementById("link_title").value,p=document.getElementById("link_target").value,f={srcURL:b,width:c,height:d,title:f,alt:e,vspace:g,hspace:l,align:m,border:h,linkurl:k,linktitle:n,linktarget:p},k=""+("<img style='width:"+c+"px; height:"+d+"px;' ")+(" src='"+b+"'"),k=k+(" alt='"+e+"'");0<g.length&&!isNaN(g)&&(k+=" vspace='"+
g+"'");0<l.length&&!isNaN(l)&&(k+=" hspace='"+l+"'");0<m.length&&(k+=" align='"+m+"'");0<h.length&&!isNaN(h)&&(k+=" border='"+h+"'");k+=" />";LayerWin.event_dext_image_upload(a,"","","0",b,c,d,e,k,f,window.frameElement.parentNode)}}
function dext_upload_flash(){if(!0==document.getElementById("cb_tag_insert").checked){var b=document.getElementById("ta_flash_tag").value,a=document.createElement("div");a.innerHTML=b;a=a.getElementsByTagName("EMBED")[0];if(null==a)alert(LayerWin.dext5_lang.flash.invalid_tag);else{var b=null,c=a.getAttribute("scale")?a.getAttribute("scale"):"",d=a.getAttribute("allowScriptAccess")?a.getAttribute("allowScriptAccess"):"",e=a.getAttribute("quality")?a.getAttribute("quality"):"",f=a.getAttribute("align")?
a.getAttribute("align"):"",g,l,m,h;g=null==a.getAttribute("menu")||void 0==a.getAttribute("menu")?!0:!1==a.getAttribute("menu")||"false"==a.getAttribute("menu")?!1:!0;l=null==a.getAttribute("play")||void 0==a.getAttribute("play")?!0:!1==a.getAttribute("play")||"false"==a.getAttribute("play")?!1:!0;m=null==a.getAttribute("loop")||void 0==a.getAttribute("loop")?!0:!1==a.getAttribute("loop")||"false"==a.getAttribute("loop")?!1:!0;null==a.getAttribute("allowFullScreen")||void 0==a.getAttribute("allowFullScreen")?
h=!0:!1==a.getAttribute("allowFullScreen")||"false"==a.getAttribute("allowFullScreen")?_allowFullScreenu=!1:h=!0;var k=a.getAttribute("flashvars")?a.getAttribute("flashvars"):"";"embed"==a.tagName.toLowerCase()&&(b={type:"flash",src:a.src,width:0==LayerWin.parseIntOr0(a.style.width)?LayerWin.parseIntOr0(a.width):LayerWin.parseIntOr0(a.style.width),height:0==LayerWin.parseIntOr0(a.style.height)?LayerWin.parseIntOr0(a.height):LayerWin.parseIntOr0(a.style.height),hspace:LayerWin.parseIntOr0(a.getAttribute("hspace")),
vspace:LayerWin.parseIntOr0(a.getAttribute("vspace")),scale:c,allowScriptAccess:d,quality:e,align:f,menu:g,play:l,loop:m,allowFullScreen:h,flashvars:k},h=LayerWin.getLinkMediaType(b.src),0<h.length&&(b.type=h,b.type2="flash"));LayerWin.event_dext_media_upload("","","","","","",b,window.frameElement.parentNode)}}else if(h=document.dext_upload_form,b=document.getElementById("Filedata"),a=document.getElementById("web_url"),b=document.getElementsByName("InputFlag")[0].checked?b.value:a.value,0<b.lastIndexOf(".")){a=
b.substring(b.lastIndexOf(".")+1).toLowerCase();c=!1;d=["swf"];for(e=0;e<d.length;e++)if(a==d[e]){c=!0;break}!0==c?document.getElementsByName("InputFlag")[0].checked?(document.getElementById("savefileext").value=a,document.getElementById("savefilename").value=Math.floor(99999*Math.random()).toString(),document.getElementById("tosavepathurl").value=LayerWin._dext_editor._config.toSavePathURL,document.getElementById("savafoldernamerule").value=LayerWin._dext_editor._config.saveFolderNameRule,document.getElementById("savafilenamerule").value=
LayerWin._dext_editor._config.saveFileNameRule,loading_image_show(!0),h.action=document.getElementById("upload_url").value,h.submit()):event_dext_flash_upload_completed(b):alert(LayerWin.dext5_lang.msg.alert_exec_flash)}else alert(LayerWin.dext5_lang.msg.alert_exec)}
function dext_upload_flash_byFlash(){if(!0==document.getElementById("cb_tag_insert").checked){var b=document.getElementById("ta_flash_tag").value;parent.event_dext_media_upload("","","","","",b)}else{b=document.dext_upload_form;document.getElementById("Filedata");var a=document.getElementById("web_url"),a=document.getElementsByName("InputFlag")[0].checked?"dext.swf":a.value;if(0<a.lastIndexOf(".")){for(var c=a.substring(a.lastIndexOf(".")+1).toLowerCase(),d=!1,e=["swf"],f=0;f<e.length;f++)if(c==e[f]){d=
!0;break}!0==d?document.getElementsByName("InputFlag")[0].checked?(document.getElementById("savefileext").value=c,document.getElementById("savefilename").value=Math.floor(99999*Math.random()).toString(),document.getElementById("tosavepathurl").value=LayerWin._dext_editor._config.toSavePathURL,document.getElementById("savafoldernamerule").value=LayerWin._dext_editor._config.saveFolderNameRule,document.getElementById("savafilenamerule").value=LayerWin._dext_editor._config.saveFileNameRule,b.action=
document.getElementById("upload_url").value,document.getElementById("dext_flash_uploader").dext_upload()):event_dext_flash_upload_completed(a):alert(LayerWin.dext5_lang.msg.alert_exec_flash)}else alert(LayerWin.dext5_lang.msg.alert_exec)}}
function event_dext_flash_upload_completed(b){loading_image_show(!1);if(4>b.length||"http"!=b.substring(0,4).toLowerCase())confirm(LayerWin.dext5_lang.msg.uploadFailed)&&alert(b);else{var a=document.getElementById("savefilename").value,c=document.getElementById("flash_width").value,d=document.getElementById("flash_height").value,e=document.getElementById("flash_h_space").value,f=document.getElementById("flash_v_space").value,g=document.getElementById("flash_scale").value,l=document.getElementById("flash_allowScriptAccess").value,
m=document.getElementById("flash_quality").value,h=document.getElementById("flash_align").value,k=document.getElementById("flash_menu").checked,n=document.getElementById("flash_play").checked,p=document.getElementById("flash_loop").checked,r=document.getElementById("flash_allowFullScreen").checked,q=0==LayerWin.parseIntOr0(c)?"300":c,s=0==LayerWin.parseIntOr0(d)?"300":d,q={type:"flash",src:b,width:q,height:s,hspace:e,vspace:f,scale:g,allowScriptAccess:l,quality:m,align:h,menu:k,play:n,loop:p,allowFullScreen:r},
c=""+("<embed style='width:"+c+"px; height:"+d+"px;' src='"+b+"'");""!=e&&(c+="hspace='"+e+"px'");""!=f&&(c+="vspace='"+f+"px'");""!=g&&(c+="scale='"+g+"'");""!=l&&(c+="allowScriptAccess='"+l+"'");""!=m&&(c+="quality='"+m+"'");""!=h&&(c+="align='"+h+"'");!1==k&&(c+="menu='false'");!1==n&&(c+="play='false'");!1==p&&(c+="loop='false'");!1==r&&(c+="allowFullScreen='false'");c+="wmode=\"transparent\" pluginspage='http://www.macromedia.com/go/getflashplayer' type='application/x-shockwave-flash' />";LayerWin.event_dext_media_upload(a,
"","","",b,c,q,window.frameElement.parentNode)}}
function dext_upload_media(){var b=document.dext_upload_form,a=document.getElementById("Filedata"),c=document.getElementById("web_url"),a=document.getElementsByName("InputFlag")[0].checked?a.value:c.value;if(0<a.lastIndexOf(".")){for(var c=a.substring(a.lastIndexOf(".")+1).toLowerCase(),d=!1,e=["wmv","asf"],f=0;f<e.length;f++)if(c==e[f]){d=!0;break}!0==d?document.getElementsByName("InputFlag")[0].checked?(document.getElementById("savefileext").value=c,document.getElementById("savefilename").value=
Math.floor(99999*Math.random()).toString(),document.getElementById("tosavepathurl").value=LayerWin._dext_editor._config.toSavePathURL,document.getElementById("savafoldernamerule").value=LayerWin._dext_editor._config.saveFolderNameRule,document.getElementById("savafilenamerule").value=LayerWin._dext_editor._config.saveFileNameRule,loading_image_show(!0),b.action=document.getElementById("upload_url").value,b.submit()):event_dext_media_upload_completed(a):alert(LayerWin.dext5_lang.msg.alert_exec_media)}else alert(LayerWin.dext5_lang.msg.alert_exec)}
function event_dext_media_upload_completed(b){loading_image_show(!1);if(4>b.length||"http"!=b.substring(0,4).toLowerCase())confirm(LayerWin.dext5_lang.msg.uploadFailed)&&alert(b);else{var a=document.getElementById("savefilename").value,c=document.getElementById("media_width").value,d=document.getElementById("media_height").value,e=0==LayerWin.parseIntOr0(c)?"300":c,f=0==LayerWin.parseIntOr0(d)?"300":d,e={type:"media",src:b,width:e,height:f,autoStart:document.getElementById("cb_autostart").checked,
playCount:document.getElementById("cb_loop").checked,showTracker:document.getElementById("cb_tracker").checked,showStatusBar:document.getElementById("cb_status").checked,showControls:document.getElementById("cb_controls").checked,showAudioControls:document.getElementById("cb_volumn").checked,showDisplay:document.getElementById("cb_display").checked,showPositionControls:document.getElementById("cb_position").checked},f="",c=""+("<embed style='width:"+c+"px; height:"+d+"px;' ")+" type=application/x-mplayer2 ",
c=c+" pluginspage='http://www.microsoft.com/windows/windowsmedia/download/' ",c=c+(" src='"+b+"'"),f=!0==document.getElementById("cb_autostart").checked?"1":"0",c=c+(" AutoStart='"+f+"'"),f=!0==document.getElementById("cb_loop").checked?"-1":"1",c=c+(" PlayCount='"+f+"'"),f=!0==document.getElementById("cb_tracker").checked?"1":"0",c=c+(" ShowTracker='"+f+"'"),f=!0==document.getElementById("cb_status").checked?"1":"0",c=c+(" ShowStatusBar='"+f+"'"),f=!0==document.getElementById("cb_controls").checked?
"1":"0",c=c+(" ShowControls='"+f+"'"),f=!0==document.getElementById("cb_volumn").checked?"1":"0",c=c+(" ShowAudioControls='"+f+"'"),f=!0==document.getElementById("cb_display").checked?"1":"0",c=c+(" ShowDisplay='"+f+"'"),f=!0==document.getElementById("cb_position").checked?"1":"0",c=c+(" ShowPositionControls='"+f+"'"),c=c+" />";LayerWin.event_dext_media_upload(a,"","","0",b,c,e,window.frameElement.parentNode)}}
function dext_detail_table_upload_image(){var b=LayerWin._dext_editor._config.accessibility,a=document.getElementById("table_caption").value,c=document.getElementById("table_summary").value,d="N";!0==document.getElementById("scope").checked&&(d="Y");var e="N";!0==document.getElementById("t_scope").checked&&(e="Y");var f=document.getElementById("title_cell").value;if("1"==b)"3"!=g?(""==a&&alert(LayerWin.dext5_lang.msg.alert_table_caption_access1),""==c&&alert(LayerWin.dext5_lang.msg.alert_table_summary_access1),
"1"!=f&&"N"==d&&alert(LayerWin.dext5_lang.msg.alert_scope_access1)):"N"==e&&alert(LayerWin.dext5_lang.msg.alert_scope_access1);else if("2"==b)if("3"!=g){if(""==a){alert(LayerWin.dext5_lang.msg.alert_table_caption_access2);document.getElementById("table_caption").focus();return}if(""==c){alert(LayerWin.dext5_lang.msg.alert_table_summary_access2);document.getElementById("table_summary").focus();return}if("1"!=f&&"N"==d){alert(LayerWin.dext5_lang.msg.alert_scope_access2);document.getElementById("scope").focus();
return}}else if("N"==e){alert(LayerWin.dext5_lang.msg.alert_scope_access2);document.getElementById("t_scope").focus();return}var b=document.dext_upload_form,a=document.getElementById("Filedata"),g=document.getElementById("tab_value").value,a=a.value,c=a.lastIndexOf(".");if("3"!=g&&0<c){g=a.substring(a.lastIndexOf(".")+1).toLowerCase();a=!1;c=G_IMAGE_ALLOW_EXT;for(d=0;d<c.length;d++)if(g==c[d]){a=!0;break}!0==a?(document.getElementById("savefileext").value=g,document.getElementById("savefilename").value=
Math.floor(99999*Math.random()).toString(),document.getElementById("tosavepathurl").value=LayerWin._dext_editor._config.toSavePathURL,document.getElementById("savafoldernamerule").value=LayerWin._dext_editor._config.saveFolderNameRule,document.getElementById("savafilenamerule").value=LayerWin._dext_editor._config.saveFileNameRule,document.getElementById("image_convert_format").value=LayerWin._dext_editor._config.image_convert_format,document.getElementById("image_convert_width").value=LayerWin._dext_editor._config.image_convert_width,
document.getElementById("image_convert_height").value=LayerWin._dext_editor._config.image_convert_height,loading_image_show(!0),b.action=document.getElementById("upload_url").value,b.submit()):alert(LayerWin.dext5_lang.msg.alert_exec_img)}else""==a||"3"==g?event_dext_detail_table_completed(""):alert(LayerWin.dext5_lang.msg.alert_exec)}
function event_dext_detail_table_completed(b){loading_image_show(!1);var a=document.getElementById("tab_value").value,c=document.getElementById("width_line").value,d=document.getElementById("height_line").value,e=document.getElementById("width").value,f=document.getElementById("height").value,g="";!0==document.getElementById("table_edge_reduce").checked?g="Y":!1==document.getElementById("table_edge_reduce").checked&&(g="N");var l=document.getElementById("range").value,m=document.getElementById("edge_border").style.borderTop,
h=document.getElementById("edge_border").style.borderLeft,k=document.getElementById("edge_border").style.borderRight,n=document.getElementById("edge_border").style.borderBottom,p=document.getElementById("cell_gap").value,r=document.getElementById("cell_inside_margin").value,q=document.getElementById("table_caption").value,s=document.getElementById("table_summary").value,t=document.getElementById("add").value,v=document.getElementById("repeat").value,w=document.getElementById("horizontal").value,u=
document.getElementById("vertical").value,x=document.getElementById("background_color").style.backgroundColor,y="N";!0==document.getElementById("scope").checked&&(y="Y");var A=document.getElementById("title_cell").value,B=document.getElementById("t_width_line").value,C=document.getElementById("t_height_line").value,D=document.getElementById("t_width").value,E=document.getElementById("t_height").value,z="N";!0==document.getElementById("t_scope").checked&&(z="Y");var F=document.getElementById("templet").value;
LayerWin.event_dext_detail_table_insert(a,c,d,e,f,g,l,m,h,k,n,p,r,q,s,b,t,v,w,u,x,y,A,B,C,D,E,z,F,window.frameElement.parentNode)}
function dext_table_property_upload_image(){var b=LayerWin._dext_editor._config.accessibility,a=document.getElementById("table_caption").value,c=document.getElementById("table_summary").value,d="N";!0==document.getElementById("scope").checked&&(d="Y");var e=document.getElementById("title_cell").value;if("1"==b)""==a&&alert(LayerWin.dext5_lang.msg.alert_table_caption_access1),""==c&&alert(LayerWin.dext5_lang.msg.alert_table_summary_access1),"1"!=e&&"N"==d&&alert(LayerWin.dext5_lang.msg.alert_scope_access1);
else if("2"==b){if(""==a){alert(LayerWin.dext5_lang.msg.alert_table_caption_access2);document.getElementById("table_caption").focus();return}if(""==c){alert(LayerWin.dext5_lang.msg.alert_table_summary_access2);document.getElementById("table_summary").focus();return}if("1"!=e&&"N"==d){alert(LayerWin.dext5_lang.msg.alert_scope_access2);document.getElementById("scope").focus();return}}b=document.dext_upload_form;a=document.getElementById("Filedata").value;if(0<a.lastIndexOf(".")){a=a.substring(a.lastIndexOf(".")+
1).toLowerCase();c=!1;d=G_IMAGE_ALLOW_EXT;for(e=0;e<d.length;e++)if(a==d[e]){c=!0;break}!0==c?(document.getElementById("savefileext").value=a,document.getElementById("savefilename").value=Math.floor(99999*Math.random()).toString(),document.getElementById("tosavepathurl").value=LayerWin._dext_editor._config.toSavePathURL,document.getElementById("savafoldernamerule").value=LayerWin._dext_editor._config.saveFolderNameRule,document.getElementById("savafilenamerule").value=LayerWin._dext_editor._config.saveFileNameRule,
document.getElementById("image_convert_format").value=LayerWin._dext_editor._config.image_convert_format,document.getElementById("image_convert_width").value=LayerWin._dext_editor._config.image_convert_width,document.getElementById("image_convert_height").value=LayerWin._dext_editor._config.image_convert_height,loading_image_show(!0),b.action=document.getElementById("upload_url").value,b.submit()):alert(LayerWin.dext5_lang.msg.alert_exec_img)}else""==a?event_dext_table_property_completed(document.getElementById("image_url_value").value):
alert(LayerWin.dext5_lang.msg.alert_exec)}
function event_dext_table_property_completed(b){loading_image_show(!1);var a=document.getElementById("width").value,c=document.getElementById("height").value,d="";!0==document.getElementById("table_edge_reduce").checked?d="Y":!1==document.getElementById("table_edge_reduce").checked&&(d="N");var e=document.getElementById("range").value,f=document.getElementById("edge_border").style.borderTop,g=document.getElementById("edge_border").style.borderLeft,l=document.getElementById("edge_border").style.borderRight,m=
document.getElementById("edge_border").style.borderBottom,h=document.getElementById("cell_gap").value,k=document.getElementById("cell_inside_margin").value,n=document.getElementById("table_caption").value,p=document.getElementById("table_summary").value,r=document.getElementById("prev_background_remove").value,q=document.getElementById("add").value,s=document.getElementById("repeat").value,t=document.getElementById("horizontal").value,v=document.getElementById("vertical").value,w=document.getElementById("background_color").style.backgroundColor,
u="N";!0==document.getElementById("scope").checked&&(u="Y");var x=document.getElementById("title_cell").value;LayerWin.event_dext_table_property(a,c,d,e,f,g,l,m,h,k,n,p,r,b,q,s,t,v,w,u,x,window.frameElement.parentNode)}
function dext_cell_property_upload_image(){var b=LayerWin._dext_editor._config.accessibility,a="",a=!0==document.getElementById("title_cell").checked?"Y":"N",c="N";!0==document.getElementById("scope_row").checked&&(c="Y");var d="N";!0==document.getElementById("scope_col").checked&&(d="Y");if("1"==b)"Y"==a&&("N"==c&&"N"==d)&&alert(LayerWin.dext5_lang.msg.alert_scope_access1);else if("2"==b&&"Y"==a&&"N"==c&&"N"==d){alert(LayerWin.dext5_lang.msg.alert_scope_access2);document.getElementById("scope_row").focus();
return}b=document.dext_upload_form;a=document.getElementById("Filedata").value;if(0<a.lastIndexOf(".")){for(var a=a.substring(a.lastIndexOf(".")+1).toLowerCase(),c=!1,d=G_IMAGE_ALLOW_EXT,e=0;e<d.length;e++)if(a==d[e]){c=!0;break}!0==c?(document.getElementById("savefileext").value=a,document.getElementById("savefilename").value=Math.floor(99999*Math.random()).toString(),document.getElementById("tosavepathurl").value=LayerWin._dext_editor._config.toSavePathURL,document.getElementById("savafoldernamerule").value=
LayerWin._dext_editor._config.saveFolderNameRule,document.getElementById("savafilenamerule").value=LayerWin._dext_editor._config.saveFileNameRule,document.getElementById("image_convert_format").value=LayerWin._dext_editor._config.image_convert_format,document.getElementById("image_convert_width").value=LayerWin._dext_editor._config.image_convert_width,document.getElementById("image_convert_height").value=LayerWin._dext_editor._config.image_convert_height,loading_image_show(!0),b.action=document.getElementById("upload_url").value,
b.submit()):alert(LayerWin.dext5_lang.msg.alert_exec_img)}else""==a?event_dext_cell_property_completed(document.getElementById("image_url_value").value):alert(LayerWin.dext5_lang.msg.alert_exec)}
function event_dext_cell_property_completed(b){loading_image_show(!1);var a=document.getElementById("horizontal_align").value,c=document.getElementById("vertical_align").value,d="",d=!0==document.getElementById("title_cell").checked?"Y":"N",e="N";!0==document.getElementById("scope_row").checked&&(e="Y");var f="N";!0==document.getElementById("scope_col").checked&&(f="Y");var g="",g=!0==document.getElementById("nowrap").checked?"Y":"N",l=document.getElementById("edge_border").style.borderTop,m=document.getElementById("edge_border").style.borderLeft,
h=document.getElementById("edge_border").style.borderRight,k=document.getElementById("edge_border").style.borderBottom,n=document.getElementById("prev_background_remove").value,p=document.getElementById("add").value,r=document.getElementById("repeat").value,q=document.getElementById("horizontal").value,s=document.getElementById("vertical").value,t=document.getElementById("background_color").style.backgroundColor;LayerWin.event_dext_cell_property(a,c,d,e,f,g,l,m,h,k,n,b,p,r,q,s,t,window.frameElement.parentNode)}
function dext_dog_bg_img_upload_image(){var b=document.dext_upload_form,a=document.getElementById("Filedata").value;if(0<a.lastIndexOf(".")){for(var a=a.substring(a.lastIndexOf(".")+1).toLowerCase(),c=!1,d=G_IMAGE_ALLOW_EXT,e=0;e<d.length;e++)if(a==d[e]){c=!0;break}!0==c?(document.getElementById("savefileext").value=a,document.getElementById("savefilename").value=Math.floor(99999*Math.random()).toString(),document.getElementById("tosavepathurl").value=LayerWin._dext_editor._config.toSavePathURL,document.getElementById("savafoldernamerule").value=
LayerWin._dext_editor._config.saveFolderNameRule,document.getElementById("savafilenamerule").value=LayerWin._dext_editor._config.saveFileNameRule,document.getElementById("image_convert_format").value=LayerWin._dext_editor._config.image_convert_format,document.getElementById("image_convert_width").value=LayerWin._dext_editor._config.image_convert_width,document.getElementById("image_convert_height").value=LayerWin._dext_editor._config.image_convert_height,loading_image_show(!0),b.action=document.getElementById("upload_url").value,
b.submit()):alert(LayerWin.dext5_lang.msg.alert_exec_img)}else""==a?event_dext_dog_bg_img_completed(document.getElementById("image_url_value").value):alert(LayerWin.dext5_lang.msg.alert_exec)}
function event_dext_cell_border_completed(){var b=document.getElementById("edge_border").style.borderTop,a=document.getElementById("edge_border").style.borderLeft,c=document.getElementById("edge_border").style.borderRight,d=document.getElementById("edge_border").style.borderBottom;LayerWin.event_dext_cell_border(b,a,c,d,window.frameElement.parentNode)}
function event_dext_dog_bg_img_completed(b){loading_image_show(!1);var a=document.getElementById("prev_background_remove").value,c=document.getElementById("add").value,d=document.getElementById("repeat").value,e=document.getElementById("background_color").style.backgroundColor;LayerWin.event_dext_dog_bg_img_insert(a,b,c,d,e,window.frameElement.parentNode)}
function event_dext_find_completed(){var b=document.getElementById("search_contents").value,a=document.getElementsByName("search_option")[0].checked,c=document.getElementsByName("search_option")[1].checked,d=document.getElementsByName("search_option")[2].checked,e;!0==document.getElementsByName("search_direction")[0].checked?e=!1:!0==document.getElementsByName("search_direction")[1].checked&&(e=!0);LayerWin.event_dext_find(b,a,c,d,e,window.frameElement.parentNode)}
function event_dext_replace_completed(){var b=document.getElementById("search_contents").value,a=document.getElementById("replace_contents").value,c=document.getElementsByName("search_option")[0].checked,d=document.getElementsByName("search_option")[1].checked,e=document.getElementsByName("search_option")[2].checked,f;!0==document.getElementsByName("search_direction")[0].checked?f=!1:!0==document.getElementsByName("search_direction")[1].checked&&(f=!0);LayerWin.event_dext_replace(b,a,c,d,e,f,window.frameElement.parentNode)}
function event_dext_all_replace_completed(){var b=document.getElementById("search_contents").value,a=document.getElementById("replace_contents").value,c=document.getElementsByName("search_option")[0].checked,d=document.getElementsByName("search_option")[1].checked,e=document.getElementsByName("search_option")[2].checked,f;!0==document.getElementsByName("search_direction")[0].checked?f=!1:!0==document.getElementsByName("search_direction")[1].checked&&(f=!0);LayerWin.event_dext_all_replace(b,a,c,d,
e,f,window.frameElement.parentNode)}function event_dext_capital_small_letter_completed(){!0==document.getElementsByName("capital_small_letter")[0].checked?_capital_small_letter="LOWER":!0==document.getElementsByName("capital_small_letter")[1].checked?_capital_small_letter="UPPER":!0==document.getElementsByName("capital_small_letter")[2].checked&&(_capital_small_letter="FIRSTUPPER");LayerWin.event_dext_capital_small_letter(_capital_small_letter,window.frameElement.parentNode)}
function event_dext_emoticon_completed(b,a){LayerWin.event_dext_emoticon_insert({srcURL:b,width:"",height:"",title:a,alt:a,vspace:"",hspace:"",align_obj:"",align:"",border:"0",linkurl:""},window.frameElement.parentNode)}
function event_dext_insert_row_column_completed(){var b="",a="";!0==document.getElementById("row").checked?(b="R",!0==document.getElementById("up").checked?a="U":!0==document.getElementById("down").checked&&(a="D")):!0==document.getElementById("column").checked&&(b="C",!0==document.getElementById("right").checked?a="R":!0==document.getElementById("left").checked&&(a="L"));var c=document.getElementById("line_count").value;LayerWin.event_dext_insert_row_column(b,a,c,window.frameElement.parentNode)}
function event_dext_row_property_completed(){var b=document.getElementById("background_color").style.backgroundColor,a=document.getElementById("row_height").value,c=document.getElementById("horizontal_align").value,d=document.getElementById("vertical_align").value;LayerWin.event_dext_row_property(b,a,c,d,window.frameElement.parentNode)}
function event_dext_column_property_completed(){var b=document.getElementById("background_color").style.backgroundColor,a=document.getElementById("column_width").value,c=document.getElementById("horizontal_align").value,d=document.getElementById("vertical_align").value;LayerWin.event_dext_column_property(b,a,c,d,window.frameElement.parentNode)}
function dext_create_iframe(){if(top.DEXT5.util.checkUrl(document.getElementById("input_url").value)){var b=LayerWin._dext_editor._config.accessibility,a=document.getElementById("input_title").value;if("1"==b)""==a&&alert(LayerWin.dext5_lang.msg.alert_iframe_input_title_access1);else if("2"==b&&""==a){alert(LayerWin.dext5_lang.msg.alert_iframe_input_title_access2);document.getElementById("input_title").focus();return}a=document.getElementById("input_width").value;b=0==LayerWin.parseIntOr0(a)?"300":
a;a=document.getElementById("input_height").value;a=0==LayerWin.parseIntOr0(a)?"300":a;b={type:"iframe",src:document.getElementById("input_url").value,id:document.getElementById("input_id").value,name:document.getElementById("input_name").value,title:document.getElementById("input_title").value,width:b,height:a,align:document.getElementById("select_align").value,scrolling:document.getElementById("select_scroll").value,frameBorder:document.getElementById("input_border").checked};a=LayerWin.getLinkMediaType(b.src);
0<a.length&&(b.type=a,b.type2="iframe");LayerWin.event_dext_create_iframe(b,window.frameElement.parentNode)}else alert(LayerWin.dext5_lang.msg.alert_url),setCursorPos(document.getElementById("input_url"),!0,!1)}
function dext_create_hyperlink(){if("hyperlink"==document.getElementById("select_category").value){if(!top.DEXT5.util.checkUrl(document.getElementById("input_url").value)){alert(LayerWin.dext5_lang.msg.alert_url);setCursorPos(document.getElementById("input_url"),!0,!1);return}}else if("bookmark"==document.getElementById("select_category").value&&""==document.getElementById("select_bookmark").value){alert(LayerWin.dext5_lang.msg.alert_bookmark);setCursorPos(document.getElementById("select_bookmark"),
!0,!1);return}var b=LayerWin._dext_editor._config.accessibility,a=document.getElementById("input_text").value;if("1"==b)""==a&&alert(LayerWin.dext5_lang.msg.alert_hyperlink_input_text_access1);else if("2"==b&&""==a){alert(LayerWin.dext5_lang.msg.alert_hyperlink_input_text_access2);document.getElementById("input_text").focus();return}b={type:document.getElementById("select_category").value,url:document.getElementById("input_url").value,text:document.getElementById("input_text").value,title:document.getElementById("input_title").value,
target:document.getElementById("select_target").value,bookname:document.getElementById("select_bookmark").value};LayerWin.event_dext_create_hyperlink(b,window.frameElement.parentNode)}
function split_cell_ok(){var b=document.getElementById("input_row"),a=document.getElementById("input_column"),c=document.getElementsByName("radio_split")[0],d=document.getElementsByName("radio_split")[1];c.checked?a.value="0":d.checked&&(b.value="0");LayerWin.event_dext_split_cell(b.value,a.value,window.frameElement.parentNode)}function symbol_ok(){var b=document.getElementById("input_output");LayerWin.event_dext_symbol(b.value,window.frameElement.parentNode)}
function template_ok(){var b=document.getElementById("clicked_template");!1==top.DEXT5.isEmpty()?!0==confirm(LayerWin.dext5_lang.msg.newDocument)&&LayerWin.event_dext_template(b.value,window.frameElement.parentNode):LayerWin.event_dext_template(b.value,window.frameElement.parentNode)}
function dext_insert_link_media(){if(""==document.getElementById("ta_media_tag").value)alert(LayerWin.dext5_lang.insert_link_media.tag_null);else{var b="",a=document.getElementById("ta_media_tag").value,b=a.match(/(<[\s]*embed [^>]+>)/gi),a=a.match(/(<[\s]*iframe [^>]+>)/gi);if(b)b=b[0];else if(a)b=a[0];else{alert(LayerWin.dext5_lang.insert_link_media.invalid_tag);return}LayerWin.event_dext_insert_link_media(b,window.frameElement.parentNode)}}
function event_dext_horizontal_line_cancel(){LayerWin.event_dext_upload_cancel(window.frameElement.parentNode)}function event_dext_image_upload_cancel(){LayerWin.event_dext_upload_cancel(window.frameElement.parentNode)}function event_dext_bg_image_upload_cancel(){LayerWin.event_dext_upload_cancel(window.frameElement.parentNode)}function event_dext_flash_upload_cancel(){clearWindow(window);LayerWin.event_dext_upload_cancel(window.frameElement.parentNode)}
function event_dext_media_upload_cancel(){LayerWin.event_dext_upload_cancel(window.frameElement.parentNode)}function event_dext_table_cancel(){LayerWin.event_dext_upload_cancel(window.frameElement.parentNode)}function event_dext_doc_cancel(){LayerWin.event_dext_upload_cancel(window.frameElement.parentNode)}function event_dext_emoticon_cancel(){LayerWin.event_dext_upload_cancel(window.frameElement.parentNode)}
function event_dext_about_close(){LayerWin.event_dext_upload_cancel(window.frameElement.parentNode)}function event_dext_close(){LayerWin.event_dext_upload_cancel(window.frameElement.parentNode)}function clearWindow(b){b.document.open();b.document.write("<html><head></head><body></body></html>");b.document.close()}
function setCursorPos(b,a,c){null!=b&&void 0!=b&&setTimeout(function(){var d=b.value.length||0;try{if(0!=d&&!1!=a)if("setSelectionRange"in b)c?b.setSelectionRange(0,d):b.setSelectionRange(d,d);else if("createTextRange"in b){var e=b.createTextRange();c||e.moveStart("character",d);e.select()}b.focus()}catch(f){}},0)}
function event_tab(b,a){9==("which"in b?b.which:b.keyCode)&&"last"==(b.target?b.target:b.srcElement).getAttribute("last_cursor_obj")&&(setCursorPos(a,!0,!1),top.DEXT5.util.cancelEvent(b))};