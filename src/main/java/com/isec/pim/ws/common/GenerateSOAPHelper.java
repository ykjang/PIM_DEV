package com.isec.pim.ws.common;

import java.io.StringReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.soap.MessageFactory;
import javax.xml.soap.Name;
import javax.xml.soap.SOAPBody;
import javax.xml.soap.SOAPConnection;
import javax.xml.soap.SOAPConnectionFactory;
import javax.xml.soap.SOAPElement;
import javax.xml.soap.SOAPEnvelope;
import javax.xml.soap.SOAPHeader;
import javax.xml.soap.SOAPMessage;
import javax.xml.soap.SOAPPart;
import javax.xml.soap.Text;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMResult;
import javax.xml.transform.stream.StreamResult;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Document;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import com.google.gson.internal.StringMap;

public class GenerateSOAPHelper {

	
    public static final String WS_GB_SOAPENV_NS_URI = "http://schemas.xmlsoap.org/soap/envelope/";
    public static final String WS_GB_SOAPENC_NS_URI = "http://schemas.xmlsoap.org/soap/encoding/";
    public static final String WS_GB_XSD_NS_URI = "http://www.w3.org/2001/XMLSchema";
    public static final String WS_GB_XSI_NS_URI = "http://www.w3.org/2001/XMLSchema-instance";
    public static final String WS_GB_WCF_NS_PREFIX = "_wcf";
    public static final String WS_GB_WCF_NS_URL = "http://www.ibm.com/xmlns/prod/commerce/9/foundation";
    public static final String WS_GB_OAGIS_NS_PREFIX = "oa";
    public static final String WS_GB_OAGIS_NS_URL = "http://www.openapplications.org/oagis/9";
    public static final String WS_GB_VERSION_ID_ATTR_NM = "versionID";
    public static final String WS_GB_VERSION_ID_ATTR_VAL = "6.0.0.4";
    
    private static final String WS_SECU_PREFIX = "wsse";
    private static final String WS_SECU_NS_URI = "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd";
    private static final String WS_SECU_PASSWD_TYPE = "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText";
    private static final String WS_SECU_ACC_ID = "wcsadmin";
    private static final String WS_SECU_ACC_PWD = "admin1234";
    
    
    
    
    /**
     * SOAPCOnnection 객체의 인스턴스 생성 후 반환
     * @return soapConnection
     */
    public static SOAPConnection getSOAPConnnection(){
    	
    	SOAPConnection soapConnection = null;
    	
    	try{
    		SOAPConnectionFactory soapConnectionFactory = SOAPConnectionFactory.newInstance();
    		soapConnection = soapConnectionFactory.createConnection();
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	
    	return soapConnection;
    }
    
  
    
    public static SOAPMessage genSOAPEnvelopNode() throws Exception {
		
		MessageFactory messageFactory = MessageFactory.newInstance();
        SOAPMessage soapMessage = messageFactory.createMessage();
        SOAPPart soapPart = soapMessage.getSOAPPart();
       
        // SOAP Root  NameSpace Setting
        SOAPEnvelope envelope = soapPart.getEnvelope();
        envelope.addNamespaceDeclaration("soapenc", WS_GB_SOAPENC_NS_URI);
        envelope.addNamespaceDeclaration("soapenv", WS_GB_SOAPENV_NS_URI);
        envelope.addNamespaceDeclaration("xsd", WS_GB_XSD_NS_URI);
        envelope.addNamespaceDeclaration("xsi", WS_GB_XSI_NS_URI);
        
        return soapMessage;
	}
    
    /**
     * 1. 헤더 Node 생성 여부 
     *   - Security 정보 등록. 일반 조회서비스는 Header 생성 필요없음
     * 
     * @param envMsg SOAPEnvelope Message
     * @throws Exception
     */
    public static void genSOAPHeaderInfoNode(SOAPHeader header) throws Exception{
    	
    	// SOAP Hearder Setting
        header.addNamespaceDeclaration("soapenv", WS_GB_SOAPENV_NS_URI);
        SOAPElement hd_secu = header.addChildElement("Security", WS_SECU_PREFIX, WS_SECU_NS_URI);
    	hd_secu.setAttribute("soapenv:mustUnderstand", "1");
    	
    	SOAPElement hd_userToken = hd_secu.addChildElement("UsernameToken", WS_SECU_PREFIX);
    	SOAPElement hd_userName = hd_userToken.addChildElement("Username", WS_SECU_PREFIX);
		hd_userName.addTextNode(WS_SECU_ACC_ID);
		SOAPElement hd_userPasswd = hd_userToken.addChildElement("Password", WS_SECU_PREFIX);
		hd_userPasswd.setAttribute("Type", WS_SECU_PASSWD_TYPE);
		hd_userPasswd.addTextNode(WS_SECU_ACC_PWD);
    }
    
    
    /**
     * Body Node생성
     * <p>
     *  2.1. BOD NOD 생성<br>
     *       - ex) ProcessCatalogEntry, ChangeAttachment, GetCatalogEntry
     * </p>
     * <p> 
     *  2.1. ApplicationArea > ContextData 세팅<br>
     *       - 요청클라이언트에서 서비스 호출시 필요한 파라메터 값 등록 (n개)<br>
     *       - ex) store_id, catalog_id
     * </p>
     * <p>  
     *  2.2. DataArea Node정보 세팅<br>
     *       - actionType에 따른 노드 생성 ( Process/Change/Get ) <br>
     *       - actionCode, xPath (n개) 등록
     * </p>
     * <p>      
     *  2.3. DataType노드 생성<br>
     *       -ex) Attribute, Catalog, CatalogEntry, CatalogGroup, CatalogFilter
     * </p>
     * @param msg
     * @param dataParam
     * @throws Exception
     */
    public static SOAPElement genSOAPDataAreaInitNode(SOAPBody soapBody, Map dataParam) throws Exception{
    	
        // NsPrefix = "_cat";
        // NsUri = "http://www.ibm.com/xmlns/prod/commerce/9/catalog";
        // BODName = "ProcessCatalogEntry";
        
        String BODName = (String)dataParam.get("BOD_NAME");
        String NsPrefix = (String)dataParam.get("SVS_NS_PREFIX");
        String NsUri = (String)dataParam.get("SVS_NS_URI");	
        
        String actionType = (String)dataParam.get("ACTION_TYPE");	// Process/Change/Get
        String actionCode = (String)dataParam.get("ACTION_CODE");  	// Create/Delete...
        ArrayList reqXPathList = (ArrayList)dataParam.get("REQ_XPATH");
        
        
        SOAPElement soapBodyElem = soapBody.addChildElement(BODName, NsPrefix, NsUri);
        
        soapBodyElem.addNamespaceDeclaration("xsi", WS_GB_XSI_NS_URI);
        soapBodyElem.addNamespaceDeclaration(WS_GB_WCF_NS_PREFIX, WS_GB_WCF_NS_URL);
        soapBodyElem.addNamespaceDeclaration(WS_GB_OAGIS_NS_PREFIX, WS_GB_OAGIS_NS_URL);
        soapBodyElem.setAttribute(WS_GB_VERSION_ID_ATTR_NM, WS_GB_VERSION_ID_ATTR_VAL);
        
        
        SOAPElement elemApp = soapBodyElem.addChildElement("ApplicationArea", WS_GB_OAGIS_NS_PREFIX);
        elemApp.setAttribute("xsi:type", WS_GB_WCF_NS_PREFIX+":ApplicationAreaType");
        	
        // Optional Node
    	SOAPElement elemApp1 = elemApp.addChildElement("CreationDateTime", WS_GB_OAGIS_NS_PREFIX);
    	elemApp1.addTextNode("2008-07-28T11:07:02.859Z");
    	SOAPElement elemApp2 = elemApp.addChildElement("BODID", WS_GB_OAGIS_NS_PREFIX);
    	elemApp2.addTextNode("d516fe00-5cb6-11dd-84f7-81ad488de083");
        
    	
        SOAPElement elemApp3 = elemApp.addChildElement("BusinessContext", WS_GB_WCF_NS_PREFIX);
        ArrayList ctxDataList = (ArrayList)dataParam.get("ContextData");
        for(int i=0; i<ctxDataList.size(); i++){
        	Map ctxDataMap = (Map)ctxDataList.get(i);
        	
        	SOAPElement elemCtxData = elemApp3.addChildElement("ContextData", WS_GB_WCF_NS_PREFIX);
        	elemCtxData.setAttribute("name", (String)ctxDataMap.get("Name"));
        	elemCtxData.addTextNode((String)ctxDataMap.get("Value"));
        }
    	
	        
    	SOAPElement elemData = soapBodyElem.addChildElement("DataArea", NsPrefix);
    	
    	
    	
    	// 조회
    	if("Get".equals(actionType))
    	{
    		/**
        	 *  <oa:Get maxItem=''>
    			  <oa:ActionExpression expressionLanguage="_wcf:XPath">/CatalogEntry[1]</oa:ActionExpression> 
    			</oa:Get>
        	 */
    		SOAPElement elemDataGet = elemData.addChildElement(actionType, WS_GB_OAGIS_NS_PREFIX);
    		for(int i=0; i<reqXPathList.size(); i++)
    		{
    			 
            	SOAPElement elemAction = elemDataGet.addChildElement("Expression", WS_GB_OAGIS_NS_PREFIX);
            	elemAction.setAttribute("expressionLanguage", WS_GB_WCF_NS_PREFIX+":XPath");
            	elemAction.addTextNode((String)reqXPathList.get(i));
            }
    	}
    	else
    	{
    		/**
        	 * - <oa:Process>
    			- <oa:ActionCriteria>
    			  <oa:ActionExpression actionCode="Create" expressionLanguage="_wcf:XPath">/CatalogEntry[1]</oa:ActionExpression> 
    			  <oa:ActionExpression actionCode="Create" expressionLanguage="_wcf:XPath">/CatalogEntry[2]</oa:ActionExpression> 
    			  </oa:ActionCriteria>
    			  </oa:Process>
        	 */
    		
    		SOAPElement elemDataGet = elemData.addChildElement(actionType, WS_GB_OAGIS_NS_PREFIX);
        	SOAPElement elemDataGet1 = elemDataGet.addChildElement("ActionCriteria", WS_GB_OAGIS_NS_PREFIX);
        	
    	    for(int i=0; i<reqXPathList.size(); i++)
    	    {
            	
            	SOAPElement elemAction = elemDataGet1.addChildElement("ActionExpression", WS_GB_OAGIS_NS_PREFIX);
                //elemDataGet1_1.setAttribute("actionCode", actionCode);
            	elemAction.setAttribute("actionCode", actionCode);
            	elemAction.setAttribute("expressionLanguage", WS_GB_WCF_NS_PREFIX+":XPath");
            	elemAction.addTextNode((String)reqXPathList.get(i));
            }
    	}
    	
	    
	    return elemData;
    }
    
    
    
    /**
     * 해당 Node의 모든 하위 Attribute를 Map객체의 Key, Value로 변환 후 반환
     * 
     * 이 메서드는 일반적인 조회성 웹서비스의 결과 SOPA객체를 각 Node별로 Map 객체로 변환하는데
     * 사용되며, 변환된 Map객체는 클라이언트로 전달되어 JSON으로 최종변환후 화면에서 사용된다.
     * 
     * @param nodeMap
     * @param nodeList
     * @return
     */
    public static Map convertNodetoMap(Map nodeMap, NodeList nodeList)
    {
        for(int i = 0; i < nodeList.getLength(); i++)
        {
            Node node = nodeList.item(i);
            SOAPElement element = null;
            Text text = null;
            String attName = "";
            
            if(node instanceof SOAPElement)
            {
                element = (SOAPElement)node;
                Name name = element.getElementName();
                attName = name.getLocalName();
                for(Iterator attrs = element.getAllAttributes(); attrs.hasNext();)
                {
                    Name attrName = (Name)attrs.next();
                    String attVal = element.getAttributeValue(attrName);
                    if(attVal != null && attVal.length() > 0)
                    {
                    	nodeMap.put(attrName.getLocalName(), attVal);
                    }
                }

                convertNodetoMap(nodeMap, element.getChildNodes());
            } else
            {
                text = (Text)node;
                String content = text.getValue();
                if(!"".equals(content.trim()))
                {
                	nodeMap.put(text.getParentElement().getLocalName(), content);
                }
            }
        }

        return nodeMap;
    }
    
    /**
     * 조회 웹서비스 결과값의 RecordSet 정보를 Map객체로 저장/반환한다.
     *
     * recordSetCount
     * recordSetStartNumber
     * recordSetTotal
     * recordSetCompleteIndicator
     * recordSetReferenceId
     * recordSetCompleteIndicator
     * recordSetReferenceId
     * 
     * @param soapResponse
     * @return 
     */
    public Map getRecordSetInfo(SOAPMessage soapResponse)
    {
        Map resInfoMap = new HashMap();
        try
        {
            SOAPBody resBody = soapResponse.getSOAPBody();
            NodeList recordList = resBody.getElementsByTagName("oa:Show");
            Node recordNode = recordList.item(0);
            NamedNodeMap recordAttr = recordNode.getAttributes();
            int recordSetCount = 0;
            int recordSetStartNumber = 0;
            int recordSetTotal = 0;
            recordSetCount = Integer.parseInt(recordAttr.getNamedItem("recordSetCount").getNodeValue());
            recordSetStartNumber = Integer.parseInt(recordAttr.getNamedItem("recordSetStartNumber").getNodeValue());
            recordSetTotal = Integer.parseInt(recordAttr.getNamedItem("recordSetTotal").getNodeValue());
            
            resInfoMap.put("recordSetCount", Integer.valueOf(recordSetCount));
            resInfoMap.put("recordSetStartNumber", Integer.valueOf(recordSetStartNumber));
            resInfoMap.put("recordSetTotal", Integer.valueOf(recordSetTotal));
            
            String recordSetCompleteIndicator = "";
            String recordSetReferenceId = "";
            
            if(recordAttr.getNamedItem("recordSetCompleteIndicator") != null)
            {
                recordSetCompleteIndicator = recordAttr.getNamedItem("recordSetCompleteIndicator").getNodeValue();
            }
            
            if(recordAttr.getNamedItem("recordSetReferenceId") != null)
            {
                recordSetReferenceId = recordAttr.getNamedItem("recordSetReferenceId").getNodeValue();
            }
            
            resInfoMap.put("recordSetCompleteIndicator", recordSetCompleteIndicator);
            resInfoMap.put("recordSetReferenceId", recordSetReferenceId);
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return resInfoMap;
    }

    
    
    public static Map<String, String> getErrorMessageInfo(SOAPMessage soapResponse)
    {
        Map<String, String> resInfoMap = new HashMap<String, String>();
        try
        {
        	/*
        	// xpath 생성
            XPath xpath = XPathFactory.newInstance().newXPath();
        	
        	Source src = soapResponse.getSOAPPart().getContent();  
            TransformerFactory tf = TransformerFactory.newInstance();  
            Transformer transformer = tf.newTransformer();  
            DOMResult result = new DOMResult();  
            transformer.transform(src, result);
            
            String code = (String)xpath.evaluate("DataArea/Acknowledge/ResponseCriteria[1]/ChangeStatus/Code", (Document)result.getNode(), XPathConstants.STRING);
            System.out.println("[code]"+code);
            System.out.println("[code]"+code);
            System.out.println("[code]"+code);
            */
            
            SOAPBody resBody = soapResponse.getSOAPBody();
            NodeList recordList = resBody.getElementsByTagName("oa:ChangeStatus");
            if( recordList == null || recordList.getLength() == 0)
            {
            	return null;
            }
            
            // ERROR Message Setting ( 마지막 Node 값을 세팅 )
            Node recordNode = recordList.item(recordList.getLength()-1);
            convertNodetoMap(resInfoMap, recordNode.getChildNodes());
            
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return resInfoMap;
    }
    
	
    /**
     * 생성된 SOAP 메세지 콘솔에 출력
     * 
     * @param soapMsg
     * @throws Exception
     */
    public static void printSOAPResponse(SOAPMessage soapMsg) throws Exception{
    	
        TransformerFactory transformerFactory = TransformerFactory.newInstance();
        Transformer transformer = transformerFactory.newTransformer();
        
        javax.xml.transform.Source sourceContent = soapMsg.getSOAPPart().getContent();
        System.out.print("SOAP Message = \n");
        
        StreamResult result = new StreamResult(System.out);
        transformer.transform(sourceContent, result);
    }
}
