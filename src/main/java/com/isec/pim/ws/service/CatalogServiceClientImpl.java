package com.isec.pim.ws.service;

import com.google.gson.internal.StringMap;
import java.io.PrintStream;
import java.util.*;
import javax.xml.soap.*;
import javax.xml.soap.Text;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;

import org.springframework.stereotype.Service;
import org.w3c.dom.*;
import org.w3c.dom.Node;

@Service("catalogServiceClient")
public class CatalogServiceClientImpl implements CatalogServiceClient
{

    private static final String WS_GB_SOAPENV_NS_URI = "http://schemas.xmlsoap.org/soap/envelope/";
    private static final String WS_GB_SOAPENC_NS_URI = "http://schemas.xmlsoap.org/soap/encoding/";
    private static final String WS_GB_XSD_NS_URI = "http://www.w3.org/2001/XMLSchema";
    private static final String WS_GB_XSI_NS_URI = "http://www.w3.org/2001/XMLSchema-instance";
    private static final String WS_GB_WCF_NS_PREFIX = "_wcf";
    private static final String WS_GB_WCF_NS_URL = "http://www.ibm.com/xmlns/prod/commerce/9/foundation";
    private static final String WS_GB_OAGIS_NS_PREFIX = "oa";
    private static final String WS_GB_OAGIS_NS_URL = "http://www.openapplications.org/oagis/9";
    private static final String WS_GB_VERSION_ID_ATTR_NM = "versionID";
    private static final String WS_GB_VERSION_ID_ATTR_VAL = "6.0.0.4";
    private static final String WS_SECU_PREFIX = "wsse";
    private static final String WS_SECU_NS_URI = "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd";
    private static final String WS_SECU_PASSWD_TYPE = "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText";
    private static final String WS_SECU_ACC_ID = "wcsadmin";
    private static final String WS_SECU_ACC_PWD = "admin1234";
    private static final String WS_CATALOG_ENDPOINT = "http://localhost/webapp/wcs/component/catalog/services/CatalogServices";
    private static final String WS_CATALOG_NS_PREFIX = "_cat";
    private static final String WS_CATALOG_NS_URI = "http://www.ibm.com/xmlns/prod/commerce/9/catalog";
    private static final String WS_CATALOG_BOD_PROCESS_CATALOGENTRY = "ProcessCatalogEntry";
    private static final String WS_CATALOG_BOD_CHANGE_CATALOGENTRY = "ChangeCatalogEntry";
    private static final String WS_CATALOG_BOD_GET_CATALOGENTRY = "GetCatalogEntry";

    
    public Map prcessCatalogEntry(HashMap paramMap)
    {
        Map resMap = new HashMap();
        SOAPConnection soapConnection = null;
        SOAPMessage soapRequest = null;
        SOAPMessage soapResponse = null;
        
        try
        {
            SOAPConnectionFactory soapConnectionFactory = SOAPConnectionFactory.newInstance();
            soapConnection = soapConnectionFactory.createConnection();
            
            soapRequest = createProcessCatalogEntryReqSOAP(paramMap);
            soapResponse = soapConnection.call(soapRequest, WS_CATALOG_ENDPOINT);
            
            List dataList = parseCatEntResSOAP(soapResponse);
            
            printSOAPResponse(soapResponse);
            
            resMap.put("dataList", dataList);
            soapConnection.close();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return resMap;
    }

    public Map changeCatalogEntry(HashMap paramMap)
    {
        return null;
    }

    public Map getCatalogEntry(HashMap paramMap)
    {
        Map resMap = new HashMap();
        SOAPConnection soapConnection = null;
        SOAPMessage soapRequest = null;
        SOAPMessage soapResponse = null;
        try
        {
            SOAPConnectionFactory soapConnectionFactory = SOAPConnectionFactory.newInstance();
            soapConnection = soapConnectionFactory.createConnection();
            
            soapRequest = createGetCatalogEntryReqSOAP(paramMap);
            soapResponse = soapConnection.call(soapRequest, WS_CATALOG_ENDPOINT);
            
            
            List dataList = parseCatEntResSOAP(soapResponse);
            
            printSOAPResponse(soapResponse);
            
            resMap.put("dataList", dataList);
            soapConnection.close();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return resMap;
    }

    
    
    private SOAPMessage createProcessCatalogEntryReqSOAP(HashMap reqParamMap)
        throws Exception
    {
        
    	String storeId = (String)reqParamMap.get("STORE_ID");
        String catalogId = (String)reqParamMap.get("CATALOG_ID");
        String masterCatalog = (String)reqParamMap.get("MASTER_CATALOG");
        String reqXPath = (String)reqParamMap.get("REQ_XPATH");
        
        
        
        StringMap catEntObj = (StringMap)reqParamMap.get("CATENTRY");
        
        
        
        MessageFactory messageFactory = MessageFactory.newInstance();
        SOAPMessage soapMessage = messageFactory.createMessage();
        SOAPPart soapPart = soapMessage.getSOAPPart();
       
        
        SOAPEnvelope envelope = soapPart.getEnvelope();
        envelope.addNamespaceDeclaration("soapenc", WS_GB_SOAPENC_NS_URI);
        envelope.addNamespaceDeclaration("soapenv", WS_GB_SOAPENV_NS_URI);
        envelope.addNamespaceDeclaration("xsd", WS_GB_XSD_NS_URI);
        envelope.addNamespaceDeclaration("xsi", WS_GB_XSI_NS_URI);
        
        // SOAP Hearder Setting
        SOAPHeader header = envelope.getHeader();
        header.addNamespaceDeclaration("soapenv", WS_GB_SOAPENV_NS_URI);
        SOAPElement hd_secu = header.addChildElement("Security", WS_SECU_PREFIX, WS_SECU_NS_URI);
        hd_secu.setAttribute("soapenv:mustUnderstand", "1");
        SOAPElement hd_userToken = hd_secu.addChildElement("UsernameToken", WS_SECU_PREFIX);
        SOAPElement hd_userName = hd_userToken.addChildElement("Username", WS_SECU_PREFIX);
        hd_userName.addTextNode(WS_SECU_ACC_ID);
        SOAPElement hd_userPasswd = hd_userToken.addChildElement("Password", WS_SECU_PREFIX);
        hd_userPasswd.setAttribute("Type", WS_SECU_PASSWD_TYPE);
        hd_userPasswd.addTextNode(WS_SECU_ACC_PWD);
        
        
        // SOAP Body Setting
        SOAPBody soapBody = envelope.getBody();
        SOAPElement soapBodyElem = soapBody.addChildElement(WS_CATALOG_BOD_PROCESS_CATALOGENTRY, WS_CATALOG_NS_PREFIX, WS_CATALOG_NS_URI);
        soapBodyElem.addNamespaceDeclaration("xsi", WS_GB_XSI_NS_URI);
        soapBodyElem.addNamespaceDeclaration(WS_GB_WCF_NS_PREFIX, WS_GB_WCF_NS_URL);
        soapBodyElem.addNamespaceDeclaration(WS_GB_OAGIS_NS_PREFIX, WS_GB_OAGIS_NS_URL);
        soapBodyElem.setAttribute(WS_GB_VERSION_ID_ATTR_NM, WS_GB_VERSION_ID_ATTR_VAL);
        
        
        SOAPElement elemApp = soapBodyElem.addChildElement("ApplicationArea", WS_GB_OAGIS_NS_PREFIX);
        elemApp.setAttribute("xsi:type", "_wcf:ApplicationAreaType");
        SOAPElement elemApp1 = elemApp.addChildElement("CreationDateTime", WS_GB_OAGIS_NS_PREFIX);
        elemApp1.addTextNode("2008-07-28T11:07:02.859Z");
        SOAPElement elemApp2 = elemApp.addChildElement("BODID", WS_GB_OAGIS_NS_PREFIX);
        elemApp2.addTextNode("d516fe00-5cb6-11dd-84f7-81ad488de083");
        SOAPElement elemApp3 = elemApp.addChildElement("BusinessContext", WS_GB_WCF_NS_PREFIX);
        SOAPElement elemApp31 = elemApp3.addChildElement("ContextData", WS_GB_WCF_NS_PREFIX);
        elemApp31.setAttribute("name", "storeId");
        elemApp31.addTextNode(storeId);
        SOAPElement elemApp32 = elemApp3.addChildElement("ContextData", WS_GB_WCF_NS_PREFIX);
        elemApp32.setAttribute("name", "masterCatalog");
        elemApp32.addTextNode(masterCatalog);
        SOAPElement elemApp33 = elemApp3.addChildElement("ContextData", WS_GB_WCF_NS_PREFIX);
        elemApp33.setAttribute("name", "catalogId");
        elemApp33.addTextNode(catalogId);
        
        SOAPElement elemData = soapBodyElem.addChildElement("DataArea", WS_CATALOG_NS_PREFIX);
        SOAPElement elemDataGet = elemData.addChildElement("Process", WS_GB_OAGIS_NS_PREFIX);
        SOAPElement elemDataGet1 = elemDataGet.addChildElement("ActionCriteria", WS_GB_OAGIS_NS_PREFIX);
        SOAPElement elemDataGet1_1 = elemDataGet1.addChildElement("ActionExpression", WS_GB_OAGIS_NS_PREFIX);
        elemDataGet1_1.setAttribute("actionCode", "Create");
        elemDataGet1_1.setAttribute("expressionLanguage", "_wcf:XPath");
        elemDataGet1_1.addTextNode(reqXPath);
        
        
        
        SOAPElement elemCatEnt = elemData.addChildElement("CatalogEntry", WS_CATALOG_NS_PREFIX);
        elemCatEnt.setAttribute("catalogEntryTypeCode", "ProductBean");
        elemCatEnt.setAttribute("displaySequence", "0.0");
        String ownerID = (String)catEntObj.get("ownerID");
        String PartNumber = (String)catEntObj.get("PartNumber");
        SOAPElement elemDataGet2_1 = elemCatEnt.addChildElement("CatalogEntryIdentifier", WS_CATALOG_NS_PREFIX);
        SOAPElement elemDataGet2_2 = elemDataGet2_1.addChildElement("ExternalIdentifier", WS_GB_WCF_NS_PREFIX);
        elemDataGet2_2.setAttribute("ownerID", ownerID);
        SOAPElement elemDataGet2_3 = elemDataGet2_2.addChildElement("PartNumber", WS_GB_WCF_NS_PREFIX);
        elemDataGet2_3.addTextNode(PartNumber);
        
        
        
        
        ArrayList descList = (ArrayList)catEntObj.get("Description");
        for(int i = 0; i < descList.size(); i++)
        {
            Map descObj = (Map)descList.get(i);
            
            String language = (String)descObj.get("language");
            String Name = (String)descObj.get("Name");
            String Thumbnail = (String)descObj.get("Thumbnail");
            String FullImage = (String)descObj.get("FullImage");
            String ShortDescription = (String)descObj.get("ShortDescription");
            String LongDescription = (String)descObj.get("LongDescription");
            String Keyword = (String)descObj.get("Keyword");
            SOAPElement elemCatEnt_Desc = elemCatEnt.addChildElement("Description", WS_CATALOG_NS_PREFIX);
            elemCatEnt_Desc.setAttribute("language", language);
            elemCatEnt_Desc.addChildElement("Name", WS_CATALOG_NS_PREFIX).addTextNode(Name);
            elemCatEnt_Desc.addChildElement("Thumbnail", WS_CATALOG_NS_PREFIX).addTextNode(Thumbnail);
            elemCatEnt_Desc.addChildElement("FullImage", WS_CATALOG_NS_PREFIX).addTextNode(FullImage);
            elemCatEnt_Desc.addChildElement("ShortDescription", WS_CATALOG_NS_PREFIX).addTextNode(ShortDescription);
            elemCatEnt_Desc.addChildElement("LongDescription", WS_CATALOG_NS_PREFIX).addTextNode(LongDescription);
            elemCatEnt_Desc.addChildElement("Keyword", WS_CATALOG_NS_PREFIX).addTextNode(Keyword);
            SOAPElement elemCatEnt_Desc_Attr1 = elemCatEnt_Desc.addChildElement("Attributes", WS_CATALOG_NS_PREFIX);
            elemCatEnt_Desc_Attr1.setAttribute("name", "published");
            elemCatEnt_Desc_Attr1.addTextNode("1");
            SOAPElement elemCatEnt_Desc_Attr2 = elemCatEnt_Desc.addChildElement("Attributes", WS_CATALOG_NS_PREFIX);
            elemCatEnt_Desc_Attr2.setAttribute("name", "available");
            elemCatEnt_Desc_Attr2.addTextNode("1");
            SOAPElement elemCatEnt_Desc_Attr3 = elemCatEnt_Desc.addChildElement("Attributes", WS_CATALOG_NS_PREFIX);
            elemCatEnt_Desc_Attr3.setAttribute("name", "auxDescription2");
            elemCatEnt_Desc_Attr3.addTextNode("images/Brake_Pad1-45.jpg");
        }

        SOAPElement elemCatEnt_Attr1 = elemCatEnt.addChildElement("CatalogEntryAttributes", WS_CATALOG_NS_PREFIX);
        SOAPElement elemCatEnt_Attr1_1 = elemCatEnt_Attr1.addChildElement("Attributes", WS_CATALOG_NS_PREFIX);
        elemCatEnt_Attr1_1.addChildElement("Name", WS_CATALOG_NS_PREFIX).addTextNode("manufacturerPartNumber");
        elemCatEnt_Attr1_1.addChildElement("StringValue", WS_CATALOG_NS_PREFIX).addChildElement("Value", WS_CATALOG_NS_PREFIX).addTextNode("12345");
        SOAPElement elemCatEnt_Attr1_2 = elemCatEnt_Attr1.addChildElement("Attributes", WS_CATALOG_NS_PREFIX);
        elemCatEnt_Attr1_2.addChildElement("Name", WS_CATALOG_NS_PREFIX).addTextNode("manufacturer");
        elemCatEnt_Attr1_2.addChildElement("StringValue", WS_CATALOG_NS_PREFIX).addChildElement("Value", WS_CATALOG_NS_PREFIX).addTextNode("manufacturer");
        SOAPElement elemCatEnt_Attr1_3 = elemCatEnt_Attr1.addChildElement("Attributes", WS_CATALOG_NS_PREFIX);
        elemCatEnt_Attr1_3.addChildElement("Name", WS_CATALOG_NS_PREFIX).addTextNode("url");
        elemCatEnt_Attr1_3.addChildElement("StringValue", WS_CATALOG_NS_PREFIX).addChildElement("Value", WS_CATALOG_NS_PREFIX).addTextNode("http://www.naver.com");
        SOAPElement elemCatEnt_Attr1_4 = elemCatEnt_Attr1.addChildElement("Attributes", WS_CATALOG_NS_PREFIX);
        elemCatEnt_Attr1_4.addChildElement("Name", WS_CATALOG_NS_PREFIX).addTextNode("buyable");
        elemCatEnt_Attr1_4.addChildElement("StringValue", WS_CATALOG_NS_PREFIX).addChildElement("Value", WS_CATALOG_NS_PREFIX).addTextNode("1");
        SOAPElement elemCatEnt_Attr1_5 = elemCatEnt_Attr1.addChildElement("Attributes", WS_CATALOG_NS_PREFIX);
        elemCatEnt_Attr1_5.addChildElement("Name", WS_CATALOG_NS_PREFIX).addTextNode("onSpecial");
        elemCatEnt_Attr1_5.addChildElement("StringValue", WS_CATALOG_NS_PREFIX).addChildElement("Value", WS_CATALOG_NS_PREFIX).addTextNode("1");
        SOAPElement elemCatEnt_Attr1_6 = elemCatEnt_Attr1.addChildElement("Attributes", WS_CATALOG_NS_PREFIX);
        elemCatEnt_Attr1_6.addChildElement("Name", WS_CATALOG_NS_PREFIX).addTextNode("onAuction");
        elemCatEnt_Attr1_6.addChildElement("StringValue", WS_CATALOG_NS_PREFIX).addChildElement("Value", WS_CATALOG_NS_PREFIX).addTextNode("1");
        SOAPElement elemCatEnt_Attr1_7 = elemCatEnt_Attr1.addChildElement("Attributes", WS_CATALOG_NS_PREFIX);
        elemCatEnt_Attr1_7.addChildElement("Name", WS_CATALOG_NS_PREFIX).addTextNode("startDate");
        elemCatEnt_Attr1_7.addChildElement("StringValue", WS_CATALOG_NS_PREFIX).addChildElement("Value", WS_CATALOG_NS_PREFIX).addTextNode("2013-01-01T00:00:00.001Z");
        SOAPElement elemCatEnt_Attr1_8 = elemCatEnt_Attr1.addChildElement("Attributes", WS_CATALOG_NS_PREFIX);
        elemCatEnt_Attr1_8.addChildElement("Name", WS_CATALOG_NS_PREFIX).addTextNode("endDate");
        elemCatEnt_Attr1_8.addChildElement("StringValue", WS_CATALOG_NS_PREFIX).addChildElement("Value", WS_CATALOG_NS_PREFIX).addTextNode("2013-12-01T00:00:00.001Z");
        SOAPElement elemCatEnt_Attr2 = elemCatEnt_Attr1.addChildElement("Attributes", WS_CATALOG_NS_PREFIX);
        elemCatEnt_Attr2.setAttribute("displaySequence", "1.0");
        elemCatEnt_Attr2.setAttribute("usage", "Descriptive");
        elemCatEnt_Attr2.setAttribute("language", "-1");
        elemCatEnt_Attr2.addChildElement("Name", WS_CATALOG_NS_PREFIX).addTextNode("Eval1");
        elemCatEnt_Attr2.addChildElement("Description", WS_CATALOG_NS_PREFIX).addTextNode("nice1");
        elemCatEnt_Attr2.addChildElement("AttributeDataType", WS_CATALOG_NS_PREFIX).addTextNode("String");
        elemCatEnt_Attr2.addChildElement("Value", WS_CATALOG_NS_PREFIX).addTextNode("Eval1");
        elemCatEnt_Attr2.addChildElement("StringValue", WS_CATALOG_NS_PREFIX).addChildElement("Value", WS_CATALOG_NS_PREFIX).addTextNode("nice1");
        SOAPElement elemCatEnt_Attr2_Ext2 = elemCatEnt_Attr2.addChildElement("ExtendedData", WS_CATALOG_NS_PREFIX);
        elemCatEnt_Attr2_Ext2.setAttribute("name", "SecondaryDescription");
        elemCatEnt_Attr2_Ext2.addTextNode("nice nice1");
        SOAPElement elemCatEnt_Attr2_Ext3 = elemCatEnt_Attr2.addChildElement("ExtendedData", WS_CATALOG_NS_PREFIX);
        elemCatEnt_Attr2_Ext3.setAttribute("name", "Field1");
        elemCatEnt_Attr2_Ext3.addTextNode("f1");
        SOAPElement elemCatEnt_Attr2_Ext4 = elemCatEnt_Attr2.addChildElement("ExtendedData", WS_CATALOG_NS_PREFIX);
        elemCatEnt_Attr2_Ext4.setAttribute("name", "DisplayGroupName");
        elemCatEnt_Attr2_Ext4.addTextNode("furn");
        SOAPElement elemCatEnt_Attr2_Ext5 = elemCatEnt_Attr2.addChildElement("ExtendedData", WS_CATALOG_NS_PREFIX);
        elemCatEnt_Attr2_Ext5.setAttribute("name", "Footnote");
        elemCatEnt_Attr2_Ext5.addTextNode("Pfn");
        SOAPElement elemCatEnt_Attr3 = elemCatEnt_Attr1.addChildElement("Attributes", WS_CATALOG_NS_PREFIX);
        elemCatEnt_Attr3.setAttribute("displaySequence", "1.0");
        elemCatEnt_Attr3.setAttribute("usage", "Defining");
        elemCatEnt_Attr3.setAttribute("language", "-1");
        elemCatEnt_Attr3.addChildElement("Name", WS_CATALOG_NS_PREFIX).addTextNode("LengthP");
        elemCatEnt_Attr3.addChildElement("Description", WS_CATALOG_NS_PREFIX).addTextNode("LengthP");
        elemCatEnt_Attr3.addChildElement("AttributeDataType", WS_CATALOG_NS_PREFIX).addTextNode("Integer");
        elemCatEnt_Attr3.addChildElement("Value", WS_CATALOG_NS_PREFIX).addTextNode("12");
        elemCatEnt_Attr3.addChildElement("IntegerValue", WS_CATALOG_NS_PREFIX).addChildElement("Value", WS_CATALOG_NS_PREFIX).addTextNode("12");
        SOAPElement elemCatEnt_PCatGrp = elemCatEnt.addChildElement("ParentCatalogGroupIdentifier", WS_CATALOG_NS_PREFIX);
        elemCatEnt_PCatGrp.addChildElement("UniqueID", WS_GB_WCF_NS_PREFIX).addTextNode("10008");
        MimeHeaders headers = soapMessage.getMimeHeaders();
        headers.addHeader("SOAPAction", "http://www.ibm.com/xmlns/prod/commerce/9/catalog ");
        soapMessage.saveChanges();
        System.out.print("Request SOAP Message = ");
        soapMessage.writeTo(System.out);
        System.out.println();
        return soapMessage;
    }

    private SOAPMessage createGetCatalogEntryReqSOAP(HashMap reqParamMap)
        throws Exception
    {
        String reqXPath = (String)reqParamMap.get("REQ_XPATH");
        String storeId = (String)reqParamMap.get("STORE_ID");
        String catalogId = (String)reqParamMap.get("CATALOG_ID");
        MessageFactory messageFactory = MessageFactory.newInstance();
        SOAPMessage soapMessage = messageFactory.createMessage();
        SOAPPart soapPart = soapMessage.getSOAPPart();
        SOAPEnvelope envelope = soapPart.getEnvelope();
        
        envelope.addNamespaceDeclaration("soapenc", WS_GB_SOAPENC_NS_URI);
        envelope.addNamespaceDeclaration("soapenv", WS_GB_SOAPENV_NS_URI);
        
        envelope.addNamespaceDeclaration("xsd", WS_GB_XSD_NS_URI);
        envelope.addNamespaceDeclaration("xsi", WS_GB_XSI_NS_URI);
        SOAPHeader header = envelope.getHeader();
        header.addNamespaceDeclaration("soapenv", WS_GB_SOAPENV_NS_URI);
        SOAPElement hd_secu = header.addChildElement("Security", WS_SECU_PREFIX, WS_SECU_NS_URI);
        hd_secu.setAttribute("soapenv:mustUnderstand", "1");
        SOAPElement hd_userToken = hd_secu.addChildElement("UsernameToken", WS_SECU_PREFIX);
        SOAPElement hd_userName = hd_userToken.addChildElement("Username", WS_SECU_PREFIX);
        hd_userName.addTextNode(WS_SECU_ACC_ID);
        SOAPElement hd_userPasswd = hd_userToken.addChildElement("Password", WS_SECU_PREFIX);
        hd_userPasswd.setAttribute("Type", WS_SECU_PASSWD_TYPE);
        hd_userPasswd.addTextNode(WS_SECU_ACC_PWD);
        SOAPBody soapBody = envelope.getBody();
        SOAPElement soapBodyElem = soapBody.addChildElement(WS_CATALOG_BOD_GET_CATALOGENTRY, WS_CATALOG_NS_PREFIX, WS_CATALOG_NS_URI);
        soapBodyElem.addNamespaceDeclaration("xsi", WS_GB_XSI_NS_URI);
        soapBodyElem.addNamespaceDeclaration(WS_GB_WCF_NS_PREFIX, WS_GB_WCF_NS_URL);
        soapBodyElem.addNamespaceDeclaration(WS_GB_OAGIS_NS_PREFIX, WS_GB_OAGIS_NS_URL);
        soapBodyElem.setAttribute(WS_GB_VERSION_ID_ATTR_NM, WS_GB_VERSION_ID_ATTR_VAL);
        SOAPElement elemApp = soapBodyElem.addChildElement("ApplicationArea", WS_GB_OAGIS_NS_PREFIX);
        elemApp.setAttribute("xsi:type", "_wcf:ApplicationAreaType");
        SOAPElement elemApp1 = elemApp.addChildElement("CreationDateTime", WS_GB_OAGIS_NS_PREFIX);
        elemApp1.addTextNode("2008-07-28T11:07:02.859Z");
        SOAPElement elemApp2 = elemApp.addChildElement("BODID", WS_GB_OAGIS_NS_PREFIX);
        elemApp2.addTextNode("d516fe00-5cb6-11dd-84f7-81ad488de083");
        SOAPElement elemApp3 = elemApp.addChildElement("BusinessContext", WS_GB_WCF_NS_PREFIX);
        SOAPElement elemApp31 = elemApp3.addChildElement("ContextData", WS_GB_WCF_NS_PREFIX);
        elemApp31.setAttribute("name", "storeId");
        elemApp31.addTextNode(storeId);
        SOAPElement elemApp32 = elemApp3.addChildElement("ContextData", WS_GB_WCF_NS_PREFIX);
        elemApp32.setAttribute("name", "catalogId");
        elemApp32.addTextNode(catalogId);
        SOAPElement elemData = soapBodyElem.addChildElement("DataArea", WS_CATALOG_NS_PREFIX);
        SOAPElement elemDataGet = elemData.addChildElement("Get", WS_GB_OAGIS_NS_PREFIX);
        SOAPElement elemDataGet1 = elemDataGet.addChildElement("Expression", WS_GB_OAGIS_NS_PREFIX);
        elemDataGet1.setAttribute("expressionLanguage", "_wcf:XPath");
        elemDataGet1.addTextNode(reqXPath);
        MimeHeaders headers = soapMessage.getMimeHeaders();
        headers.addHeader("SOAPAction", "http://www.ibm.com/xmlns/prod/commerce/9/cataloggetCatalogEntryByParentCatalogGroupId ");
        soapMessage.saveChanges();
        System.out.print("Request SOAP Message = ");
        soapMessage.writeTo(System.out);
        System.out.println();
        return soapMessage;
    }

    private Map getRecordSetInfo(SOAPMessage soapResponse, Boolean isPaging)
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

    private ArrayList parseCatEntResSOAP(SOAPMessage soapResponse)
    {
        ArrayList catentryList = new ArrayList();
        Map catentryMap = null;
        Map catentAttrMap = null;
        try
        {
            SOAPBody resBody = soapResponse.getSOAPBody();
            NodeList catentNodeList = resBody.getElementsByTagNameNS(WS_CATALOG_NS_URI, "CatalogEntry");
            NodeList catentIdenNodeList = resBody.getElementsByTagNameNS(WS_CATALOG_NS_URI, "CatalogEntryIdentifier");
            NodeList catentAttrNodeList = resBody.getElementsByTagNameNS(WS_CATALOG_NS_URI, "CatalogEntryAttributes");
            NodeList prntGrpIdenNodeList = resBody.getElementsByTagNameNS(WS_CATALOG_NS_URI, "ParentCatalogGroupIdentifier");
            NodeList listPriceNodeList = resBody.getElementsByTagNameNS(WS_CATALOG_NS_URI, "ListPrice");
            NodeList priceListNodeList = resBody.getElementsByTagNameNS(WS_CATALOG_NS_URI, "Price");
            NodeList prntEntIdenNodeList = resBody.getElementsByTagNameNS(WS_CATALOG_NS_URI, "ParentCatalogEntryIdentifier");
            NodeList fulFillPropNodeList = resBody.getElementsByTagNameNS(WS_CATALOG_NS_URI, "FulfillmentProperties");
            NodeList attchRefNodeList = resBody.getElementsByTagNameNS(WS_CATALOG_NS_URI, "AttachmentReference");
            NodeList navRelNodeList = resBody.getElementsByTagNameNS(WS_CATALOG_NS_URI, "NavigationRelationship");
            NodeList associNodeList = resBody.getElementsByTagNameNS(WS_CATALOG_NS_URI, "Association");
            NodeList kitCompNodeList = resBody.getElementsByTagNameNS(WS_CATALOG_NS_URI, "KitComponent");
            NodeList seoPropNodeList = resBody.getElementsByTagNameNS(WS_CATALOG_NS_URI, "SEOProperties");
            NodeList seoUrlNodeList = resBody.getElementsByTagNameNS(WS_CATALOG_NS_URI, "SEOURL");
            for(int i = 0; i < catentNodeList.getLength(); i++)
            {
                Node cateNode = catentNodeList.item(i);
                catentryMap = new HashMap();
                catentAttrMap = new HashMap();
                List catentDescList = new ArrayList();
                List catentAttrList = new ArrayList();
                catentryMap.put("catalogEntryTypeCode", cateNode.getAttributes().getNamedItem("catalogEntryTypeCode").getNodeValue());
                if(cateNode.getAttributes().getNamedItem("navigationPath") != null)
                {
                    catentryMap.put("navigationPath", cateNode.getAttributes().getNamedItem("navigationPath").getNodeValue());
                } else
                {
                    catentryMap.put("navigationPath", "");
                }
                if(cateNode.getAttributes().getNamedItem("displaySequence") != null)
                {
                    catentryMap.put("displaySequence", cateNode.getAttributes().getNamedItem("displaySequence").getNodeValue());
                } else
                {
                    catentryMap.put("displaySequence", "");
                }
                catentryMap = getChildElementList(catentryMap, catentIdenNodeList.item(i).getChildNodes());
                NodeList descList = ((SOAPElement)cateNode).getElementsByTagNameNS(WS_CATALOG_NS_URI, "Description");
                for(int j = 0; j < descList.getLength(); j++)
                {
                    catentAttrMap = new HashMap();
                    Node descAttrNode = descList.item(j);
                    getChildElementList(catentAttrMap, descAttrNode.getChildNodes());
                    NodeList attrList = ((SOAPElement)descAttrNode).getElementsByTagNameNS(WS_CATALOG_NS_URI, "Attributes");
                    for(int k = 0; k < attrList.getLength(); k++)
                    {
                        Node attrNode = attrList.item(k);
                        catentAttrMap.put(attrNode.getAttributes().getNamedItem("name").getNodeValue(), attrNode.getTextContent());
                    }

                    catentDescList.add(catentAttrMap);
                }

                catentryMap.put("DESCRIPTION", catentDescList);
                if(catentAttrNodeList.getLength() > 0)
                {
                    Node attrNode = catentAttrNodeList.item(i);
                    NodeList attrList = ((SOAPElement)attrNode).getElementsByTagNameNS(WS_CATALOG_NS_URI, "Attributes");
                    for(int k = 0; k < attrList.getLength(); k++)
                    {
                        catentAttrMap = new HashMap();
                        catentAttrList.add(getChildElementList(catentAttrMap, attrList.item(k).getChildNodes()));
                    }

                }
                catentryMap.put("ATTRIBUTE", catentAttrList);
                if(listPriceNodeList.getLength() > 0)
                {
                    catentAttrMap = new HashMap();
                    catentryMap.put("LISTPRICE", getChildElementList(catentAttrMap, listPriceNodeList.item(i).getChildNodes()));
                } else
                {
                    catentryMap.put("LISTPRICE", null);
                }
                if(prntGrpIdenNodeList.getLength() > 0)
                {
                    catentAttrMap = new HashMap();
                    catentryMap.put("PARENTGRPINFO", getChildElementList(catentAttrMap, prntGrpIdenNodeList.item(i).getChildNodes()));
                } else
                {
                    catentryMap.put("PARENTGRPINFO", null);
                }
                catentryList.add(catentryMap);
            }

        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return catentryList;
    }

    private static Map getChildElementList(Map catentAttrMap, NodeList nodeList)
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
                        catentAttrMap.put(attrName.getLocalName(), attVal);
                    }
                }

                getChildElementList(catentAttrMap, element.getChildNodes());
            } else
            {
                text = (Text)node;
                String content = text.getValue();
                if(!"".equals(content.trim()))
                {
                    catentAttrMap.put(text.getParentElement().getLocalName(), content);
                }
            }
        }

        return catentAttrMap;
    }

    private static void printSOAPResponse(SOAPMessage soapResponse)
        throws Exception
    {
        TransformerFactory transformerFactory = TransformerFactory.newInstance();
        Transformer transformer = transformerFactory.newTransformer();
        javax.xml.transform.Source sourceContent = soapResponse.getSOAPPart().getContent();
        System.out.print("\nResponse SOAP Message = ");
        StreamResult result = new StreamResult(System.out);
        transformer.transform(sourceContent, result);
    }
}
