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
            printSOAPResponse(soapRequest);
            
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

    
    
    private SOAPMessage createProcessCatalogEntryReqSOAP(HashMap reqParamMap) throws Exception
    {
        
    	String storeId = (String)reqParamMap.get("STORE_ID");
        String catalogId = (String)reqParamMap.get("CATALOG_ID");
        String masterCatalog = (String)reqParamMap.get("MASTER_CATALOG");
        
        
        String actionCode = (String)reqParamMap.get("ACTION_CODE");
        String reqXPath = (String)reqParamMap.get("REQ_XPATH");
        
        
        MessageFactory messageFactory = MessageFactory.newInstance();
        SOAPMessage soapMessage = messageFactory.createMessage();
        SOAPPart soapPart = soapMessage.getSOAPPart();
       
        // SOAP Root Tag Setting
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
        //elemDataGet1_1.setAttribute("actionCode", actionCode);
        elemDataGet1_1.setAttribute("actionCode", actionCode);
        
        elemDataGet1_1.setAttribute("expressionLanguage", "_wcf:XPath");
        elemDataGet1_1.addTextNode(reqXPath);
        
        /**
         * ------------------------------ CatalogEntry Node 생성 시작 ---------------------------------------
         */
        // CatalogEntry - Type, DisplaySequence
        StringMap catEntObj = (StringMap)reqParamMap.get("CATENTRY");
        
        SOAPElement elemCatEnt = elemData.addChildElement("CatalogEntry", WS_CATALOG_NS_PREFIX);
        
        // CatalogEntryType 정의- PRODUCT: ProductBean, SKU: ItemBean
        String catEntType = (String)catEntObj.get("catEntType");
        
        elemCatEnt.setAttribute("catalogEntryTypeCode", catEntType);
        elemCatEnt.setAttribute("displaySequence", "0.0");
        
        // CatalogEntry - ownerID, PartNumber, Parent CatalogGroup ID
        String ownerID = (String)catEntObj.get("ownerID");
        String PartNumber = (String)catEntObj.get("PartNumber");
        String pCatGrpId = (String)catEntObj.get("pCatGrpId");
        
        SOAPElement elemDataGet2_1 = elemCatEnt.addChildElement("CatalogEntryIdentifier", WS_CATALOG_NS_PREFIX);
        SOAPElement elemDataGet2_2 = elemDataGet2_1.addChildElement("ExternalIdentifier", WS_GB_WCF_NS_PREFIX);
        elemDataGet2_2.setAttribute("ownerID", ownerID);
        SOAPElement elemDataGet2_3 = elemDataGet2_2.addChildElement("PartNumber", WS_GB_WCF_NS_PREFIX);
        elemDataGet2_3.addTextNode(PartNumber);
        
        SOAPElement elemCatEnt_PCatGrp = elemCatEnt.addChildElement("ParentCatalogGroupIdentifier", WS_CATALOG_NS_PREFIX);
        elemCatEnt_PCatGrp.addChildElement("UniqueID", WS_GB_WCF_NS_PREFIX).addTextNode(pCatGrpId);
        
        /**
         * ------------------------------ ParentCatalogEntryIdentifier Node 생성 시작 ---------------------------------------
         * SKU 생성을 위한 노드(ItemBean일 경우)
         */
        if("ItemBean일".equals(catEntType)){
        	SOAPElement elemPrntCateEntIden = elemCatEnt.addChildElement("ParentCatalogEntryIdentifier", WS_CATALOG_NS_PREFIX);
            elemPrntCateEntIden.addChildElement("UniqueID", WS_GB_WCF_NS_PREFIX).addTextNode("18305");
        }
        /**
         * ------------------------------ ParentCatalogEntryIdentifier Node 생성 종료 ---------------------------------------
         */
        
        /**
         * ------------------------------ Description Node 생성 시작 ---------------------------------------
         */
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
            
            /**
             * 	Description[0]/Attributes/auxDescription1
				Description[0]/Attributes/auxDescription2
				Description[0]/Attributes/available
				Description[0]/Attributes/published
				Description[0]/Attributes/availabilityDate
             */
            ArrayList descAttrList = (ArrayList)descObj.get("Attributes");
            
            for(int attCnt=0; attCnt<descAttrList.size(); attCnt++){
            	
            	Map descAttrObj = (Map)descAttrList.get(attCnt);
            	
            	System.out.println("Name: "+descAttrObj.get("Name"));
            	System.out.println("Value: "+descAttrObj.get("Value"));
            	
            	SOAPElement elemCatEnt_Desc_Attr1 = elemCatEnt_Desc.addChildElement("Attributes", WS_CATALOG_NS_PREFIX);
                elemCatEnt_Desc_Attr1.setAttribute("name", (String)descAttrObj.get("Name"));
                elemCatEnt_Desc_Attr1.addTextNode((String)descAttrObj.get("Value"));
            }
          
        }
        /**
         * ------------------------------ Description Node 생성 종료 ---------------------------------------
         */
        
        
        /**
         * ------------------------------ CatalogEntryAttributes Node 생성 시작 ---------------------------------------
         */
        SOAPElement elemCatEnt_Attr = elemCatEnt.addChildElement("CatalogEntryAttributes", WS_CATALOG_NS_PREFIX);
        
        /**
         * Classic Attribute 
         * 
	        CatalogEntryAttributes/Attributes[n]/Name/manufacturerPartNumber CatalogEntryAttributes/Attributes[n]/StringValue/Value	CATENTRY.MFPARTNUMBER
	        CatalogEntryAttributes/Attributes[n]/Name/manufacturer CatalogEntryAttributes/Attributes[n]/StringValue/Value	CATENTRY.MFNAME
	        CatalogEntryAttributes/Attributes[n]/Name/url CatalogEntryAttributes/Attributes[n]/StringValue/Value			CATENTRY.URL
	        CatalogEntryAttributes/Attributes[n]/Name/field1 CatalogEntryAttributes/Attributes[n]/StringValue/Value			CATENTRY.FIELD1
	        CatalogEntryAttributes/Attributes[n]/Name/field2 CatalogEntryAttributes/Attributes[n]/StringValue/Value			CATENTRY.FIELD2
	        CatalogEntryAttributes/Attributes[n]/Name/field3 CatalogEntryAttributes/Attributes[n]/StringValue/Value			CATENTRY.FIELD3
	        CatalogEntryAttributes/Attributes[n]/Name/field4 CatalogEntryAttributes/Attributes[n]/StringValue/Value			CATENTRY.FIELD4
	        CatalogEntryAttributes/Attributes[n]/Name/field5 CatalogEntryAttributes/Attributes[n]/StringValue/Value			CATENTRY.FIELD5
	        CatalogEntryAttributes/Attributes[n]/Name/onSpecial CatalogEntryAttributes/Attributes[n]/StringValue/Value		CATENTRY.ONSPECIAL		// 0, 1
	        CatalogEntryAttributes/Attributes[n]/Name/onAuction CatalogEntryAttributes/Attributes[n]/StringValue/Value		CATENTRY.ONAUCTION		// 0, 1
	        CatalogEntryAttributes/Attributes[n]/Name/buyable CatalogEntryAttributes/Attributes[n]/StringValue/Value		CATENTRY.BUYABLE		// 0, 1
	        CatalogEntryAttributes/Attributes[n]/Name/startDate CatalogEntryAttributes/Attributes[n]/StringValue/Value		CATENTRY.STARTDATE		// 2013-01-01T00:00:00.001Z
	        CatalogEntryAttributes/Attributes[n]/Name/endDate CatalogEntryAttributes/Attributes[n]/StringValue/Value		CATENTRY.ENDDATE		// 2013-01-01T00:00:00.001Z
		**/
        ArrayList catEntAttrList = (ArrayList)catEntObj.get("CatalogEntryAttributes");
        for(int attrCnt = 0; attrCnt < catEntAttrList.size(); attrCnt++)
        {
            Map catEntAttrObj = (Map)catEntAttrList.get(attrCnt);
            
            SOAPElement elemCatEnt_Attr_ch = elemCatEnt_Attr.addChildElement("Attributes", WS_CATALOG_NS_PREFIX);
            elemCatEnt_Attr_ch.addChildElement("Name", WS_CATALOG_NS_PREFIX).addTextNode((String)catEntAttrObj.get("Name"));
            elemCatEnt_Attr_ch.addChildElement("StringValue", WS_CATALOG_NS_PREFIX)
            						.addChildElement("Value", WS_CATALOG_NS_PREFIX).addTextNode((String)catEntAttrObj.get("Value"));
        }
        
        /*         
         * Descriptive Attributes
         */
        if( catEntObj.containsKey("DescriptiveAttributes") ){
        	ArrayList descriptiveAttrList = (ArrayList)catEntObj.get("DescriptiveAttributes");
            genCatEntAtttributeNode(elemCatEnt_Attr, descriptiveAttrList, "Descriptive");
        }
                
        /*         
         * Defining Attributes
         */
        if( catEntObj.containsKey("DefiningAttributes") ){
        	ArrayList definingAttrList = (ArrayList)catEntObj.get("DefiningAttributes");
            genCatEntAtttributeNode(elemCatEnt_Attr, definingAttrList, "Defining");
        }
        /**
         * ------------------------------ CatalogEntryAttributes Node 생성 종료 ---------------------------------------
         */
        
        
        /**
         * ------------------------------ ListPrice Node 생성 종료 ---------------------------------------
         */
        if( catEntObj.containsKey("ListPrice") ){
        	
        	/*
        	<_cat:ListPrice>
        	  <_wcf:Price currency="USD">200.00</_wcf:Price> 
        	</_cat:ListPrice>
        	*/
        	Map listPriceMap = (Map)catEntObj.get("ListPrice");
        	
        	SOAPElement elemListPrice = elemCatEnt.addChildElement("ListPrice", WS_CATALOG_NS_PREFIX);
        	SOAPElement elemListPrice1 = elemListPrice.addChildElement("Price", WS_GB_WCF_NS_PREFIX);
        				elemListPrice1.setAttribute("currency", (String)listPriceMap.get("currency"));
        				elemListPrice1.addTextNode((String)listPriceMap.get("price"));
        }
        /**
         * ------------------------------ ListPrice Node 생성 종료 ---------------------------------------
         */
        
        
        
        
        /**
         * ------------------------------ CatalogEntry Node 생성 종료 ---------------------------------------
         */
        
        MimeHeaders headers = soapMessage.getMimeHeaders();
        headers.addHeader("SOAPAction", "http://www.ibm.com/xmlns/prod/commerce/9/catalog ");
        soapMessage.saveChanges();
        
        // System.out.print("Request SOAP Message = ");
        // soapMessage.writeTo(System.out);
        // System.out.println();
        
        
        return soapMessage;
    }
    
    
    
    
    
    
    
    /**
     * CatalogEntry의 Defining/Descriptive Attribute Node 생성
     * 
     * @param catEntAttr CatalogEntry Attribute Root Node
     * @param attList	Defining/Descriptive Attribute 데이타 객체
     * @param usage   	Attribute Type ( 1 - Defining, 2 - Descriptive )
     * @return
     */
    private SOAPElement genCatEntAtttributeNode(SOAPElement catEntAttr, ArrayList attList, String usage) throws Exception{
    	
    	/**
         * CatalogEntry - CatalogEntryAttributes - Descriptive / Defining 속성
         * 
         	CatalogEntryAttributes/Attributes[0]/AttributeDataType	ATTRIBUTE.ATTRTYPE_ID
			CatalogEntryAttributes/Attributes[0]/Name	ATTRIBUTE.NAME
			CatalogEntryAttributes/Attributes[0](@displaySequence)	ATTRIBUTE.SEQUENCE
			CatalogEntryAttributes/Attributes[0]/Description	ATTRIBUTE.DESCRIPTION
			CatalogEntryAttributes/Attributes[0]/Value	ATTRVALUE.NAME 
			CatalogEntryAttributes/Attributes[0]/StringValue/Value	ATTRVALUE.STRINGVALUE
			CatalogEntryAttributes/Attributes[0]/ExtendedValue/AttachmentID	ATTRVALUE.ATTACHMENT_ID
         * 
		**/
    	for(int i = 0; i < attList.size(); i++)
        {
            Map descAttrObj = (Map)attList.get(i);
            
            String displaySequence = (String)descAttrObj.get("displaySequence");
            String language = (String)descAttrObj.get("language");
            String Name = (String)descAttrObj.get("Name");
            String Description = (String)descAttrObj.get("Description");
            String AttributeDataType = (String)descAttrObj.get("AttributeDataType");
            String Value = (String)descAttrObj.get("Value");
            String TypeValue = (String)descAttrObj.get("TypeValue");
            
            SOAPElement descAttrNode = catEntAttr.addChildElement("Attributes", WS_CATALOG_NS_PREFIX);
            descAttrNode.setAttribute("displaySequence", displaySequence);									// ATTRIBUTE.SEQUENCE
            descAttrNode.setAttribute("usage", usage);														// ATTRIBUTE.USAGE ( 1-'Defining',2-'Descriptive' )
            descAttrNode.setAttribute("language", language);												// ATTRIBUTE.LANGUAGE_ID
            descAttrNode.addChildElement("Name", WS_CATALOG_NS_PREFIX).addTextNode(Name);					// ATTRIBUTE.NAME
            descAttrNode.addChildElement("Description", WS_CATALOG_NS_PREFIX).addTextNode(Description);		// ATTRIBUTE.DESCRIPTION
            descAttrNode.addChildElement("AttributeDataType", WS_CATALOG_NS_PREFIX).addTextNode(AttributeDataType);	// ATTRIBUTE.ATTRTYPE_ID (String-Text, Integer-Whole Number, Float-Decimal Number)
            
            // Descriptive Attribute
            /*
                <_cat:Value identifier="1000000000000000009" storeID="10101">30</_cat:Value> 
				<_cat:IntegerValue>
					<_cat:Value>30</_cat:Value> 
				</_cat:IntegerValue>

             */
            if("Descriptive".equals(usage)){
            	 descAttrNode.addChildElement("Value", WS_CATALOG_NS_PREFIX).addTextNode(Value);			// ATTRVALUE.NAME
                 descAttrNode.addChildElement(AttributeDataType+"Value", WS_CATALOG_NS_PREFIX)		
                 					.addChildElement("Value", WS_CATALOG_NS_PREFIX)
                 						.addTextNode(TypeValue);											// ATTRVALUE.StringValue, ATTRVALUE.IntegerValue, ATTRVALUE.FloatValue
            }
           
            // Only Defining Attribute
            /*
	      	  <_cat:AllowedValue displaySequence="1.0" identifier="1000000000000000001" storeID="10101">
	      	  	<_cat:Value>Big(F)</_cat:Value> 
	      	  	<_cat:StringValue>
	      	  		<_cat:Value>Big(F)</_cat:Value> 
	      	  	</_cat:StringValue>
	      	  </_cat:AllowedValue>
	          */
            if("Defining".equals(usage)){
            	
            	ArrayList allowedValueList = (ArrayList)descAttrObj.get("AllowedValue");
            	for(int attrCnt = 0; attrCnt < allowedValueList.size(); attrCnt++)
                {
                	Map allowedValue = (Map)allowedValueList.get(attrCnt);
                	
                	SOAPElement allowValNode = descAttrNode.addChildElement("AllowedValue", WS_CATALOG_NS_PREFIX);
                	allowValNode.setAttribute("displaySequence", (String)allowedValue.get("displaySequence"));
                	
                	allowValNode.addChildElement("Value", WS_CATALOG_NS_PREFIX).addTextNode((String)allowedValue.get("Value"));
                	allowValNode.addChildElement(AttributeDataType+"Value", WS_CATALOG_NS_PREFIX)		
                    					.addChildElement("Value", WS_CATALOG_NS_PREFIX)
                    						.addTextNode((String)allowedValue.get("Value"));
                } // End for
            } // End if
            
            
            /**
             * 	CatalogEntryAttributes/Attributes[0]/ExtendedData/SecondaryDescription	ATTRIBUTE.DESCRIPTION2
				CatalogEntryAttributes/Attributes[0]/ExtendedData/DisplayGroupName	ATTRIBUTE.GROUPNAME
				CatalogEntryAttributes/Attributes[0]/ExtendedData/Field1	ATTRIBUTE.FIELD1
				CatalogEntryAttributes/Attributes[0]/ExtendedData/Footnote	ATTRIBUTE.NOTEINFO
				
	            CatalogEntryAttributes/Attributes[0]/AttributeValue/ExtendedValue/Image1	ATTRVALUE.IMAGE1
				CatalogEntryAttributes/Attributes[0]/AttributeValue/ExtendedValue/Image2	ATTRVALUE.IMAGE2
				CatalogEntryAttributes/Attributes[0]/AttributeValue/ExtendedValue/Field1	ATTRVALUE.FIELD1
				CatalogEntryAttributes/Attributes[0]/AttributeValue/ExtendedValue/Field2	ATTRVALUE.FIELD2
				CatalogEntryAttributes/Attributes[0]/AttributeValue/ExtendedValue/Field3	ATTRVALUE.FIELD3
				CatalogEntryAttributes/Attributes[0]/AttributeValue/ExtendedValue/UnitOfMeasure	ATTRVALUE.QTYUNIT_ID
             */
            ArrayList extDataList = (ArrayList)descAttrObj.get("ExtendedData");
            for(int extCnt = 0; extCnt < extDataList.size(); extCnt++)
            {
            	Map extDataObj = (Map)extDataList.get(extCnt);
            	
            	SOAPElement extDataNode = descAttrNode.addChildElement("ExtendedData", WS_CATALOG_NS_PREFIX);
            	extDataNode.setAttribute("name", (String)extDataObj.get("Name"));
            	extDataNode.addTextNode((String)extDataObj.get("Value"));
            }
        
        }
    	
    	return catEntAttr;
    	
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

    private Map getChildElementList(Map catentAttrMap, NodeList nodeList)
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
