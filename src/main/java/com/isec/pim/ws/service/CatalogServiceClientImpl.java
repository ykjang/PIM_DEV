package com.isec.pim.ws.service;

import com.google.gson.internal.StringMap;
import com.isec.pim.ws.common.GenerateSOAPHelper;
import com.isec.pim.ws.controller.WebServiceController;
import com.isec.pim.ws.domain.AttrValue;
import com.isec.pim.ws.domain.Attribute;
import com.isec.pim.ws.domain.CatEntDesc;
import com.isec.pim.ws.domain.CatEntry;
import com.isec.pim.ws.domain.CatGroup;
import com.isec.pim.ws.domain.ListPrice;

import java.io.PrintStream;
import java.util.*;

import javax.xml.soap.*;
import javax.xml.soap.Text;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.w3c.dom.*;
import org.w3c.dom.Node;

@Service("catalogServiceClient")
public class CatalogServiceClientImpl implements CatalogServiceClient
{
	private static final Logger logger = LoggerFactory.getLogger(CatalogServiceClientImpl.class);
	
    private static final String WS_CATALOG_ENDPOINT = "http://192.168.2.116/webapp/wcs/component/catalog/services/CatalogServices";
    private static final String WS_CATALOG_NS_PREFIX = "_cat";
    private static final String WS_CATALOG_NS_URI = "http://www.ibm.com/xmlns/prod/commerce/9/catalog";
    
    private static final String WS_CATALOG_CATALOG_NAME = "Catalog";
    private static final String WS_CATALOG_CATALOGENTRY_NAME = "CatalogEntry";
    
        private static final String WS_CATALOG_BOD_PROCESS_CATALOGENTRY = "ProcessCatalogEntry";
    private static final String WS_CATALOG_BOD_CHANGE_CATALOGENTRY = "ChangeCatalogEntry";
    private static final String WS_CATALOG_BOD_GET_CATALOGENTRY = "GetCatalogEntry";
    
    private static final String WS_CATALOG_ACTION_PROCESS_TYPE = "Process";
    private static final String WS_CATALOG_ACTION_CHANGE_TYPE = "Change";
    private static final String WS_CATALOG_ACTION_GET_TYPE = "Get";
    
    
    /**
     * 
     */
    @Override
    public Map prcessCatalogEntry(Map paramMap)
    {
        Map resMap = new HashMap();
        SOAPConnection soapConnection = null;
        
        try
        {
            soapConnection = GenerateSOAPHelper.getSOAPConnnection();
            
            //---------- Request SOAP Message 공통부분
            SOAPMessage reqMsg = GenerateSOAPHelper.genSOAPEnvelopNode();
            GenerateSOAPHelper.genSOAPHeaderInfoNode(reqMsg.getSOAPHeader());
            
            paramMap.put("BOD_NAME", WS_CATALOG_BOD_PROCESS_CATALOGENTRY);	// ProcessCatalogEntry
            paramMap.put("ACTION_TYPE", WS_CATALOG_ACTION_PROCESS_TYPE);	// Process
            
            paramMap.put("SVS_NS_PREFIX", WS_CATALOG_NS_PREFIX);			// _cat
            paramMap.put("SVS_NS_URI", WS_CATALOG_NS_URI);                  // http://www.ibm.com/xmlns/prod/commerce/9/catalog
           
            SOAPElement elemData = GenerateSOAPHelper.genSOAPDataAreaInitNode(reqMsg.getSOAPBody(), paramMap);
            //---------- Request SOAP Message 공통부분
            
            
            // 1. 요청객체 생성 JAVA -> SOAP
            genReqSOAPCatEntProcess(elemData, paramMap);
            
            MimeHeaders headers = reqMsg.getMimeHeaders();
            headers.addHeader("SOAPAction", WS_CATALOG_NS_URI);
            reqMsg.saveChanges();
            GenerateSOAPHelper.printSOAPResponse(reqMsg);
            
            
            // 2. WebService 호출
            SOAPMessage resMsg = soapConnection.call(reqMsg, WS_CATALOG_ENDPOINT);
            GenerateSOAPHelper.printSOAPResponse(resMsg);
            
            // 3. WebService 에러처리
            Map<String, String> resultMessage = GenerateSOAPHelper.getErrorMessageInfo(resMsg);
            if( resultMessage != null ){
            	logger.info("[CODE]"+resultMessage.get("Code"));
                logger.info("[Description]"+resultMessage.get("Description"));
                logger.info("[ReasonCode]"+resultMessage.get("ReasonCode"));
                logger.info("[Reason]"+resultMessage.get("Reason"));
                
                resMap.put("result", "0");
                resMap.put("data", resultMessage);
                return resMap; 
            }
            
            // 3. 응답객체 생성 SOAP -> JAVA 
            List dataList = genResCatEntryAllList(resMsg);
            resMap.put("result", "1");
            resMap.put("data", dataList);
            
            
            soapConnection.close();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return resMap;
    }

    @Override
    public Map<String, SOAPMessage> changeCatalogEntry(Map<String, Object> paramMap)
    {
    	Map<String, SOAPMessage> resMap = new HashMap<String, SOAPMessage>();
        SOAPConnection soapConnection = null;
        
        
        try
        {
        	//---------- Request SOAP Message 공통부분
            soapConnection = GenerateSOAPHelper.getSOAPConnnection();
            
            SOAPMessage reqMsg = GenerateSOAPHelper.genSOAPEnvelopNode();
            GenerateSOAPHelper.genSOAPHeaderInfoNode(reqMsg.getSOAPHeader());
            
            paramMap.put("BOD_NAME", WS_CATALOG_BOD_CHANGE_CATALOGENTRY);	// ChangeCatalogEntry
            paramMap.put("ACTION_TYPE", WS_CATALOG_ACTION_CHANGE_TYPE);	    // Change
            paramMap.put("SVS_NS_PREFIX", WS_CATALOG_NS_PREFIX);			// _cat
            paramMap.put("SVS_NS_URI", WS_CATALOG_NS_URI);                  // http://www.ibm.com/xmlns/prod/commerce/9/catalog
            
            SOAPElement elemData = GenerateSOAPHelper.genSOAPDataAreaInitNode(reqMsg.getSOAPBody(), paramMap);
            //---------- Request SOAP Message 공통부분
            
            
            // 1. 요청객체 생성 JAVA -> SOAP
            genReqSOAPCatEntChange(elemData, paramMap);
            
            MimeHeaders headers = reqMsg.getMimeHeaders();
            headers.addHeader("SOAPAction", "http://www.ibm.com/xmlns/prod/commerce/9/catalog ");
            reqMsg.saveChanges();
            GenerateSOAPHelper.printSOAPResponse(reqMsg);
            
            // 2. WebService 호출
            SOAPMessage resMsg = soapConnection.call(reqMsg, WS_CATALOG_ENDPOINT);
            GenerateSOAPHelper.printSOAPResponse(resMsg);
            
            // 3. 반환객체 생성 JAVA -> SOAP
            //List dataList = genResCatEntryAllList(resMsg);
            resMap.put("result", resMsg);
            
            
            soapConnection.close();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return resMap;
    }

    @Override
    public Map getCatalogEntryAll(Map paramMap)
    {
    	Map<String, ArrayList<CatEntry>> resMap = new HashMap<String, ArrayList<CatEntry>>();
        SOAPConnection soapConnection = null;
        
        try
        {
        	//---------- Request SOAP Message 공통부분
            soapConnection = GenerateSOAPHelper.getSOAPConnnection();
            
            SOAPMessage reqMsg = GenerateSOAPHelper.genSOAPEnvelopNode();
            GenerateSOAPHelper.genSOAPHeaderInfoNode(reqMsg.getSOAPHeader());
            
            paramMap.put("BOD_NAME", WS_CATALOG_BOD_GET_CATALOGENTRY);		// GetCatalogEntry
            paramMap.put("ACTION_TYPE", WS_CATALOG_ACTION_GET_TYPE);	    // Get
            paramMap.put("SVS_NS_PREFIX", WS_CATALOG_NS_PREFIX);			// _cat
            paramMap.put("SVS_NS_URI", WS_CATALOG_NS_URI);                  // http://www.ibm.com/xmlns/prod/commerce/9/catalog
            //---------- Request SOAP Message 공통부분
            
            
            // 1. 요청객체 생성 JAVA -> SOAP
            SOAPElement elemData = GenerateSOAPHelper.genSOAPDataAreaInitNode(reqMsg.getSOAPBody(), paramMap);
            
            MimeHeaders headers = reqMsg.getMimeHeaders();
            headers.addHeader("SOAPAction", "http://www.ibm.com/xmlns/prod/commerce/9/catalog ");
            reqMsg.saveChanges();
            
            // 2. WebService 호출
            GenerateSOAPHelper.printSOAPResponse(reqMsg);
            SOAPMessage resMsg = soapConnection.call(reqMsg, WS_CATALOG_ENDPOINT);
            GenerateSOAPHelper.printSOAPResponse(resMsg);
            
            // 3. 반환객체 변환 SOAP -> JAVA
            ArrayList<CatEntry> dataList = genResCatEntryAllList(resMsg);
            
            resMap.put("dataList", dataList);
            
            soapConnection.close();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return resMap;
    }
    
    @Override
	public Map getCatalogEntryAttribute(Map paramMap) {
    	Map resMap = new HashMap();
        SOAPConnection soapConnection = null;
        
        try
        {
        	//---------- Request SOAP Message 공통부분
            soapConnection = GenerateSOAPHelper.getSOAPConnnection();
            
            SOAPMessage reqMsg = GenerateSOAPHelper.genSOAPEnvelopNode();
            GenerateSOAPHelper.genSOAPHeaderInfoNode(reqMsg.getSOAPHeader());
            
            paramMap.put("BOD_NAME", WS_CATALOG_BOD_GET_CATALOGENTRY);		// GetCatalogEntry
            paramMap.put("ACTION_TYPE", WS_CATALOG_ACTION_GET_TYPE);	    // Get
            paramMap.put("SVS_NS_PREFIX", WS_CATALOG_NS_PREFIX);			// _cat
            paramMap.put("SVS_NS_URI", WS_CATALOG_NS_URI);                  // http://www.ibm.com/xmlns/prod/commerce/9/catalog
            //---------- Request SOAP Message 공통부분
            
            
            // 1. 요청객체 생성 JAVA -> SOAP
            SOAPElement elemData = GenerateSOAPHelper.genSOAPDataAreaInitNode(reqMsg.getSOAPBody(), paramMap);
            
            MimeHeaders headers = reqMsg.getMimeHeaders();
            headers.addHeader("SOAPAction", "http://www.ibm.com/xmlns/prod/commerce/9/catalog ");
            reqMsg.saveChanges();
            
            // 2. WebService 호출
            GenerateSOAPHelper.printSOAPResponse(reqMsg);
            SOAPMessage resMsg = soapConnection.call(reqMsg, WS_CATALOG_ENDPOINT);
            GenerateSOAPHelper.printSOAPResponse(resMsg);
            
            // 3. 반환객체 변환 SOAP -> JAVA
            SOAPBody resBody = resMsg.getSOAPBody();
            NodeList catentAttrNodeList = resBody.getElementsByTagNameNS(WS_CATALOG_NS_URI, "CatalogEntryAttributes");
            
            resMap = genResCatEntryAttribute(catentAttrNodeList);
            
            soapConnection.close();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return resMap;
	}

	@Override
	public Map getCatalogEntryPrice(Map hashmap) {
		// TODO Auto-generated method stub
		return null;
	}

    
    private void genReqSOAPCatEntProcess(SOAPElement elemData, Map reqParamMap) throws Exception
    {
        
        /**
         * ------------------------------ CatalogEntry Node 생성 시작 ---------------------------------------
         */
        // CatalogEntry - Type, DisplaySequence
        StringMap catEntObj = (StringMap)reqParamMap.get("CATENTRY");
        
        SOAPElement elemCatEnt = elemData.addChildElement(WS_CATALOG_CATALOGENTRY_NAME, WS_CATALOG_NS_PREFIX);
        
        // CatalogEntryType 정의- PRODUCT: ProductBean, SKU: ItemBean
        String catEntType = (String)catEntObj.get("catEntType");
        
        elemCatEnt.setAttribute("catalogEntryTypeCode", catEntType);
        elemCatEnt.setAttribute("displaySequence", "0.0");
        
        // CatalogEntry - ownerID, PartNumber, Parent CatalogGroup ID
        String ownerID = (String)catEntObj.get("ownerID");
        String PartNumber = (String)catEntObj.get("PartNumber");
        String pCatGrpId = (String)catEntObj.get("pCatGrpId");
        String pCatEntId = (String)catEntObj.get("pCatEntId");
        
        SOAPElement elemDataGet2_1 = elemCatEnt.addChildElement("CatalogEntryIdentifier", WS_CATALOG_NS_PREFIX);
        SOAPElement elemDataGet2_2 = elemDataGet2_1.addChildElement("ExternalIdentifier", GenerateSOAPHelper.WS_GB_WCF_NS_PREFIX);
        elemDataGet2_2.setAttribute("ownerID", ownerID);
        SOAPElement elemDataGet2_3 = elemDataGet2_2.addChildElement("PartNumber", GenerateSOAPHelper.WS_GB_WCF_NS_PREFIX);
        elemDataGet2_3.addTextNode(PartNumber);
        
        SOAPElement elemCatEnt_PCatGrp = elemCatEnt.addChildElement("ParentCatalogGroupIdentifier", WS_CATALOG_NS_PREFIX);
        elemCatEnt_PCatGrp.addChildElement("UniqueID", GenerateSOAPHelper.WS_GB_WCF_NS_PREFIX).addTextNode(pCatGrpId);
        
        /**
         * ------------------------------ ParentCatalogEntryIdentifier Node 생성 시작 ---------------------------------------
         * SKU 생성을 위한 노드(ItemBean일 경우)
         */
        if("ItemBean".equals(catEntType)){
        	SOAPElement elemPrntCateEntIden = elemCatEnt.addChildElement("ParentCatalogEntryIdentifier", WS_CATALOG_NS_PREFIX);
            elemPrntCateEntIden.addChildElement("UniqueID", GenerateSOAPHelper.WS_GB_WCF_NS_PREFIX).addTextNode(pCatEntId);
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
            genReqSOAPCatEntAtttribute(elemCatEnt_Attr, descriptiveAttrList, "Descriptive", WS_CATALOG_ACTION_PROCESS_TYPE);
        }
                
        /*         
         * Defining Attributes
         */
        if( catEntObj.containsKey("DefiningAttributes") ){
        	ArrayList definingAttrList = (ArrayList)catEntObj.get("DefiningAttributes");
        	genReqSOAPCatEntAtttribute(elemCatEnt_Attr, definingAttrList, "Defining", WS_CATALOG_ACTION_PROCESS_TYPE);
        }
        /**
         * ------------------------------ CatalogEntryAttributes Node 생성 종료 ---------------------------------------
         */
        
        
        /**
         * ------------------------------ ListPrice Node 생성 종료 ---------------------------------------
         */
        if( catEntObj.containsKey("ListPrice") )
        {
        	
        	/*
        	<_cat:ListPrice>
        	  <_wcf:Price currency="USD">200.00</_wcf:Price> 
        	  <_wcf:AlternativeCurrencyPrice currency="CAD">12345</_wcf:AlternativeCurrencyPrice> 
  				<_wcf:AlternativeCurrencyPrice currency="JPY">67890</_wcf:AlternativeCurrencyPrice> 
        	</_cat:ListPrice>
        	*/
        	Map listPriceMap = (Map)catEntObj.get("ListPrice");
        	
        	// Default Price
        	SOAPElement elemListPrice = elemCatEnt.addChildElement("ListPrice", WS_CATALOG_NS_PREFIX);
        	SOAPElement elemListPrice1 = elemListPrice.addChildElement("Price", GenerateSOAPHelper.WS_GB_WCF_NS_PREFIX);
        				elemListPrice1.setAttribute("currency", (String)listPriceMap.get("currency"));
        				elemListPrice1.addTextNode((String)listPriceMap.get("price"));
			SOAPElement elemListPrice2 = elemListPrice.addChildElement("Quantity", GenerateSOAPHelper.WS_GB_WCF_NS_PREFIX);
						elemListPrice2.setAttribute("uom", "C62");
						elemListPrice2.addTextNode("1");
        				
        	// Alternative Currency Price
        	if( listPriceMap.containsKey("AlternativeCurrencyPrice") )
        	{
        		ArrayList AltPriceList = (ArrayList)listPriceMap.get("AlternativeCurrencyPrice");
        		for(int i = 0; i < AltPriceList.size(); i++)
                {
        			Map AltPriceMap = (Map)AltPriceList.get(i);
        			SOAPElement elemAltPrice = elemListPrice.addChildElement("AlternativeCurrencyPrice", GenerateSOAPHelper.WS_GB_WCF_NS_PREFIX);
        			elemAltPrice.setAttribute("currency", (String)AltPriceMap.get("currency"));
        			elemAltPrice.addTextNode((String)AltPriceMap.get("price"));
                }
        		
        	}
			
        }
        /**
         * ------------------------------ ListPrice Node 생성 종료 ---------------------------------------
         */
        
        /**
         * ------------------------------ Price Node 생성 시작 ---------------------------------------
         * 
        	<_cat:Price>
				- <_wcf:StandardPrice>
				- 	<_wcf:Price>
				  		<_wcf:Price currency="USD">26.75</_wcf:Price> 
				  	</_wcf:Price>
				  </_wcf:StandardPrice>
				- <_wcf:ContractPrice minimumQuantity="1.0">
				- 	<_wcf:Price>
				  		<_wcf:Price currency="USD">26.75</_wcf:Price> 
				  	</_wcf:Price>
				- 	<_wcf:ContractIdentifier>
				  		<_wcf:UniqueID>10001</_wcf:UniqueID> 
				- 		<_wcf:ExternalIdentifier majorVersionNumber="1" minorVersionNumber="0" origin="0" ownerID="7000000000000000002">
				  			<_wcf:Name>AdvancedB2BDirect Contract number 1234</_wcf:Name> 
				  		</_wcf:ExternalIdentifier>
				  	</_wcf:ContractIdentifier>
				  </_wcf:ContractPrice>
			  </_cat:Price>
         */
        
        /*if( catEntObj.containsKey("Price") ){
        	
        	Map priceMap = (Map)catEntObj.get("Price");
            SOAPElement elemPrice = elemCatEnt.addChildElement("Price", WS_CATALOG_NS_PREFIX);
            
            	
        	Map stdPriceMap = (Map)priceMap.get("StandardPrice");
        	
        	SOAPElement elemStdPricePrice = elemPrice.addChildElement("StandardPrice", GenerateSOAPHelper.WS_GB_WCF_NS_PREFIX);
        	elemStdPricePrice.setAttribute("minimumQuantity", "1");
        	SOAPElement elemStdPricePrice1 = elemStdPricePrice.addChildElement("Price", GenerateSOAPHelper.WS_GB_WCF_NS_PREFIX);
        	
        	SOAPElement elemStdPricePrice2 = elemStdPricePrice1.addChildElement("Price", GenerateSOAPHelper.WS_GB_WCF_NS_PREFIX);
        				elemStdPricePrice2.setAttribute("currency", "USD");
        				elemStdPricePrice2.addTextNode("11");
        	SOAPElement elemStdPricePrice3 = elemStdPricePrice1.addChildElement("Quantity", GenerateSOAPHelper.WS_GB_WCF_NS_PREFIX);
        	elemStdPricePrice3.setAttribute("uom", "C62");
        	elemStdPricePrice3.addTextNode("1");
        	
        	
        	SOAPElement elemContPricePrice = elemPrice.addChildElement("ContractPrice", GenerateSOAPHelper.WS_GB_WCF_NS_PREFIX);
        	elemContPricePrice.setAttribute("minimumQuantity", "1.0");
        	
        	SOAPElement elemContPricePrice1 = elemContPricePrice.addChildElement("Price", GenerateSOAPHelper.WS_GB_WCF_NS_PREFIX);
        	SOAPElement elemContPricePrice2 = elemContPricePrice1.addChildElement("Price", GenerateSOAPHelper.WS_GB_WCF_NS_PREFIX);
        	elemContPricePrice2.setAttribute("currency", (String)stdPriceMap.get("currency"));
        	elemContPricePrice2.addTextNode((String)stdPriceMap.get("price"));
        }*/
        
        /**
         * ------------------------------ Price Node 생성 종료 ---------------------------------------
         */
        /**
         * ------------------------------ CatalogEntry Node 생성 종료 ---------------------------------------
         */
    }
    
    private void genReqSOAPCatEntChange(SOAPElement elemData, Map reqParamMap) throws Exception
    {
        
    	String actionCode = (String)reqParamMap.get("ACTION_CODE");
    	
        /**
         * ------------------------------ CatalogEntry Node 생성 시작 ---------------------------------------
         */
        // CatalogEntry - Type, DisplaySequence
        StringMap catEntObj = (StringMap)reqParamMap.get("CATENTRY");
        SOAPElement elemCatEnt = elemData.addChildElement(WS_CATALOG_CATALOGENTRY_NAME, WS_CATALOG_NS_PREFIX);
        
        
        String catEntId = (String)catEntObj.get("CatEntId");
        SOAPElement elemDataGet2_1 = elemCatEnt.addChildElement("CatalogEntryIdentifier", WS_CATALOG_NS_PREFIX);
        elemDataGet2_1.addChildElement("UniqueID", GenerateSOAPHelper.WS_GB_WCF_NS_PREFIX).addTextNode(catEntId);
        
        /**
         * ------------------------------ Description Node 생성 시작 ---------------------------------------
         */
        if(catEntObj.containsKey("Description"))
        {
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
                
                if(catEntObj.containsKey("Attributes"))
                {
	                ArrayList descAttrList = (ArrayList)descObj.get("Attributes");
	                for(int attCnt=0; attCnt<descAttrList.size(); attCnt++)
	                {
	                	
	                	Map descAttrObj = (Map)descAttrList.get(attCnt);
	                	
	                	System.out.println("Name: "+descAttrObj.get("Name"));
	                	System.out.println("Value: "+descAttrObj.get("Value"));
	                	
	                	SOAPElement elemCatEnt_Desc_Attr1 = elemCatEnt_Desc.addChildElement("Attributes", WS_CATALOG_NS_PREFIX);
	                    elemCatEnt_Desc_Attr1.setAttribute("name", (String)descAttrObj.get("Name"));
	                    elemCatEnt_Desc_Attr1.addTextNode((String)descAttrObj.get("Value"));
	                }
                }
              
            } 
        } // End If (Description)
        /**
         * ------------------------------ Description Node 생성 종료 ---------------------------------------
         */
        
        
        /**
         * ------------------------------ CatalogEntryAttributes Node 생성 시작 ---------------------------------------
         */
        SOAPElement elemCatEnt_Attr = elemCatEnt.addChildElement("CatalogEntryAttributes", WS_CATALOG_NS_PREFIX);
        if(catEntObj.containsKey("CatalogEntryAttributes")){
            /**
             * Classic Attribute 
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
        } // End if (CatalogEntryAttributes)
            
    	
        /*         
         * Descriptive Attributes
         */
        if( catEntObj.containsKey("DescriptiveAttributes") ){
        	ArrayList descriptiveAttrList = (ArrayList)catEntObj.get("DescriptiveAttributes");
        	genReqSOAPCatEntAtttribute(elemCatEnt_Attr, descriptiveAttrList, "Descriptive", actionCode);
        }
                
        /*         
         * Defining Attributes
         */
        if( catEntObj.containsKey("DefiningAttributes") ){
        	ArrayList definingAttrList = (ArrayList)catEntObj.get("DefiningAttributes");
        	genReqSOAPCatEntAtttribute(elemCatEnt_Attr, definingAttrList, "Defining", actionCode);
        }
        /**
         * ------------------------------ CatalogEntryAttributes Node 생성 종료 ---------------------------------------
         */
        
        
        /**
         * ------------------------------ ListPrice Node 생성 시작 ---------------------------------------
         * 
         * <_wcf:AlternativeCurrencyPrice currency="CAD">12345</_wcf:AlternativeCurrencyPrice> 
  			<_wcf:AlternativeCurrencyPrice currency="JPY">67890</_wcf:AlternativeCurrencyPrice> 
         */
        if( catEntObj.containsKey("ListPrice") ){
        	
        	Map listPriceMap = (Map)catEntObj.get("ListPrice");
        	
        	SOAPElement elemListPrice = elemCatEnt.addChildElement("ListPrice", WS_CATALOG_NS_PREFIX);
        	
        	SOAPElement elemListPrice1 = elemListPrice.addChildElement("Price", GenerateSOAPHelper.WS_GB_WCF_NS_PREFIX);
        				elemListPrice1.setAttribute("currency", (String)listPriceMap.get("currency"));
        				elemListPrice1.addTextNode((String)listPriceMap.get("price"));
        	SOAPElement elemListPrice2 = elemListPrice.addChildElement("Quantity", GenerateSOAPHelper.WS_GB_WCF_NS_PREFIX);
        				elemListPrice2.addTextNode((String)listPriceMap.get("quantity"));
        				
			// Alternative Currency Price
        	if( listPriceMap.containsKey("AlternativeCurrencyPrice") )
        	{
        		ArrayList AltPriceList = (ArrayList)listPriceMap.get("AlternativeCurrencyPrice");
        		for(int i = 0; i < AltPriceList.size(); i++)
                {
        			Map AltPriceMap = (Map)AltPriceList.get(i);
        			SOAPElement elemAltPrice = elemListPrice.addChildElement("AlternativeCurrencyPrice", GenerateSOAPHelper.WS_GB_WCF_NS_PREFIX);
        			elemAltPrice.setAttribute("currency", (String)AltPriceMap.get("currency"));
        			elemAltPrice.addTextNode((String)AltPriceMap.get("price"));
                }
        		
        	}
        }
        /**
         * ------------------------------ ListPrice Node 생성 종료 ---------------------------------------
         */
        /**
         * ------------------------------ Price Node 생성 시작 ---------------------------------------
         * 
        	<_cat:Price>
				- <_wcf:StandardPrice>
				- 	<_wcf:Price>
				  		<_wcf:Price currency="USD">26.75</_wcf:Price> 
				  	</_wcf:Price>
				  </_wcf:StandardPrice>
				- <_wcf:ContractPrice minimumQuantity="1.0">
				- 	<_wcf:Price>
				  		<_wcf:Price currency="USD">26.75</_wcf:Price> 
				  	</_wcf:Price>
				- 	<_wcf:ContractIdentifier>
				  		<_wcf:UniqueID>10001</_wcf:UniqueID> 
				- 		<_wcf:ExternalIdentifier majorVersionNumber="1" minorVersionNumber="0" origin="0" ownerID="7000000000000000002">
				  			<_wcf:Name>AdvancedB2BDirect Contract number 1234</_wcf:Name> 
				  		</_wcf:ExternalIdentifier>
				  	</_wcf:ContractIdentifier>
				  </_wcf:ContractPrice>
			  </_cat:Price>
         */
        
        /*if( catEntObj.containsKey("Price") ){
        	
        	Map priceMap = (Map)catEntObj.get("Price");
            SOAPElement elemPrice = elemCatEnt.addChildElement("Price", WS_CATALOG_NS_PREFIX);
            
            	
        	Map stdPriceMap = (Map)priceMap.get("StandardPrice");
        	
        	SOAPElement elemStdPricePrice = elemPrice.addChildElement("StandardPrice", GenerateSOAPHelper.WS_GB_WCF_NS_PREFIX);
        	SOAPElement elemStdPricePrice1 = elemStdPricePrice.addChildElement("Price", GenerateSOAPHelper.WS_GB_WCF_NS_PREFIX);
        	SOAPElement elemStdPricePrice2 = elemStdPricePrice1.addChildElement("Price", GenerateSOAPHelper.WS_GB_WCF_NS_PREFIX);
        				elemStdPricePrice2.setAttribute("currency", (String)stdPriceMap.get("currency"));
        				elemStdPricePrice2.addTextNode((String)stdPriceMap.get("price"));
        	SOAPElement elemStdPricePrice3 = elemStdPricePrice1.addChildElement("Quantity", GenerateSOAPHelper.WS_GB_WCF_NS_PREFIX);
        	elemStdPricePrice3.addTextNode((String)stdPriceMap.get("quantity"));
        	
        	SOAPElement elemContPricePrice = elemPrice.addChildElement("ContractPrice", GenerateSOAPHelper.WS_GB_WCF_NS_PREFIX);
        	elemContPricePrice.setAttribute("minimumQuantity", "1.0");
        	
        	SOAPElement elemContPricePrice1 = elemContPricePrice.addChildElement("Price", GenerateSOAPHelper.WS_GB_WCF_NS_PREFIX);
        	SOAPElement elemContPricePrice2 = elemContPricePrice1.addChildElement("Price", GenerateSOAPHelper.WS_GB_WCF_NS_PREFIX);
        	elemContPricePrice2.setAttribute("currency", (String)stdPriceMap.get("currency"));
        	elemContPricePrice2.addTextNode((String)stdPriceMap.get("price"));
        }*/
        
        /**
         * ------------------------------ Price Node 생성 종료 ---------------------------------------
         */
        /**
         * ------------------------------ CatalogEntry Node 생성 종료 ---------------------------------------
         */
    }
    
    /**
     * CatalogEntry의 Defining/Descriptive Attribute Node 생성
     * 
     * @param catEntAttr CatalogEntry Attribute Root Node
     * @param attList	Defining/Descriptive Attribute 데이타 객체
     * @param usage   	Attribute Type ( 1 - Defining, 2 - Descriptive )
     * @param actionType Process/Change/Get
     * @return
     */
    private SOAPElement genReqSOAPCatEntAtttribute(SOAPElement catEntAttr, ArrayList attList, String usage, String actionCode) throws Exception{
    	
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
            
            SOAPElement descAttrNode = catEntAttr.addChildElement("Attributes", WS_CATALOG_NS_PREFIX);
            
            String displaySequence = (String)descAttrObj.get("displaySequence");
            String language = (String)descAttrObj.get("language");
            String AttributeDataType = (String)descAttrObj.get("AttributeDataType");
            
            descAttrNode.setAttribute("displaySequence", displaySequence);									// ATTRIBUTE.SEQUENCE
            descAttrNode.setAttribute("usage", usage);														// ATTRIBUTE.USAGE ( 1-'Defining',2-'Descriptive' )
            descAttrNode.setAttribute("language", language);													// ATTRIBUTE.LANGUAGE_ID
            descAttrNode.addChildElement("AttributeDataType", WS_CATALOG_NS_PREFIX).addTextNode(AttributeDataType);	// ATTRIBUTE.ATTRTYPE_ID (String-Text, Integer-Whole Number, Float-Decimal Number)
            
           
        	if( descAttrObj.containsKey("Name"))
        	{
        		descAttrNode.addChildElement("Name", WS_CATALOG_NS_PREFIX).addTextNode((String)descAttrObj.get("Name"));					// ATTRIBUTE.NAME
        	}
        	
        	if( descAttrObj.containsKey("Description"))
        	{
        		descAttrNode.addChildElement("Description", WS_CATALOG_NS_PREFIX).addTextNode((String)descAttrObj.get("Description"));					// ATTRIBUTE.NAME
        	}
            
        	if( descAttrObj.containsKey("Value"))
        	{
        		descAttrNode.addChildElement("Value", WS_CATALOG_NS_PREFIX).addTextNode((String)descAttrObj.get("Value"));			// ATTRVALUE.NAME
    	        descAttrNode.addChildElement(AttributeDataType+"Value", WS_CATALOG_NS_PREFIX)		
    	         					.addChildElement("Value", WS_CATALOG_NS_PREFIX)
    	         						.addTextNode((String)descAttrObj.get("TypeValue"));											// ATTRVALUE.StringValue, ATTRVALUE.IntegerValue, ATTRVALUE.FloatValue
        	}
        	
        	// ExtendedValue Node 생성
        	if(descAttrObj.containsKey("ExtendedValue")){
        		ArrayList extValueList = (ArrayList)descAttrObj.get("ExtendedValue");
                if(extValueList != null){
                	for(int eValCnt = 0; eValCnt < extValueList.size(); eValCnt++)
                    {
                    	Map extValObj = (Map)extValueList.get(eValCnt);
                    	
                    	SOAPElement extValNode = descAttrNode.addChildElement("ExtendedValue", WS_CATALOG_NS_PREFIX);
                    	extValNode.setAttribute("name", (String)extValObj.get("Name"));
                    	extValNode.addTextNode((String)extValObj.get("Value"));
                    }
                }
        	}
        	
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
            if(descAttrObj.containsKey("ExtendedData")){
            	ArrayList extDataList = (ArrayList)descAttrObj.get("ExtendedData");
                if(extDataList != null){
                	for(int extCnt = 0; extCnt < extDataList.size(); extCnt++)
                    {
                    	Map extDataObj = (Map)extDataList.get(extCnt);
                    	
                    	SOAPElement extDataNode = descAttrNode.addChildElement("ExtendedData", WS_CATALOG_NS_PREFIX);
                    	extDataNode.setAttribute("name", (String)extDataObj.get("Name"));
                    	extDataNode.addTextNode((String)extDataObj.get("Value"));
                    }
                }
            }
        	
            // Only Defining Attribute
            /*
             * <_cat:Attributes displaySequence="2.0" language="-1" usage="Defining">
		          <_cat:AttributeIdentifier>
		            <_wcf:UniqueID>19668</_wcf:UniqueID>
		          </_cat:AttributeIdentifier>
		          <_cat:Name>color</_cat:Name>
		          <_cat:Description>color</_cat:Description>
		          <_cat:AttributeDataType>String</_cat:AttributeDataType>
		          <_cat:ExtendedData name="attrId">19668</_cat:ExtendedData>
		          <_cat:Value identifier="red">red</_cat:Value>
		          <_cat:StringValue>
		            <_cat:Value>red</_cat:Value>
		          </_cat:StringValue>
		          <_cat:ExtendedValue name="DisplaySequence">0.0</_cat:ExtendedValue>
		        </_cat:Attributes>
		        
	      	  <_cat:AllowedValue displaySequence="1.0" identifier="1000000000000000001" storeID="10101">
	      	  	<_cat:Value>Big(F)</_cat:Value> 
	      	  	<_cat:StringValue>
	      	  		<_cat:Value>Big(F)</_cat:Value> 
	      	  	</_cat:StringValue>
	      	  	<_cat:ExtendedValue name="DisplaySequence">1.0</_cat:ExtendedValue>
	      	  </_cat:AllowedValue>
	          */
            if("Defining".equals(usage)){
            	 
            	SOAPElement attrIfValNode = descAttrNode.addChildElement("AttributeIdentifier", WS_CATALOG_NS_PREFIX);
            	attrIfValNode.addChildElement("UniqueID", GenerateSOAPHelper.WS_GB_WCF_NS_PREFIX).addTextNode("19662");
            	
            	if(descAttrObj.containsKey("AllowedValue")){
            		
            		ArrayList allowedValueList = (ArrayList)descAttrObj.get("AllowedValue");
                	for(int attrCnt = 0; attrCnt < allowedValueList.size(); attrCnt++)
                    {
                    	Map allowedValue = (Map)allowedValueList.get(attrCnt);
                    	
                    	SOAPElement allowValNode = descAttrNode.addChildElement("AllowedValue", WS_CATALOG_NS_PREFIX);
                    	allowValNode.setAttribute("displaySequence", (String)allowedValue.get("displaySequence"));
                    	allowValNode.addChildElement(AttributeDataType+"Value", WS_CATALOG_NS_PREFIX)		
                        					.addChildElement("Value", WS_CATALOG_NS_PREFIX)
                        						.addTextNode((String)allowedValue.get("Value"));
                    	
                    	// ExtendedValue Node 생성
                    	if(allowedValue.containsKey("ExtendedValue")){
                    		ArrayList extValueList = (ArrayList)allowedValue.get("ExtendedValue");
                            if(extValueList != null){
                            	for(int eValCnt = 0; eValCnt < extValueList.size(); eValCnt++)
                                {
                                	Map extValObj = (Map)extValueList.get(eValCnt);
                                	
                                	SOAPElement extValNode = allowValNode.addChildElement("ExtendedValue", WS_CATALOG_NS_PREFIX);
                                	extValNode.setAttribute("name", (String)extValObj.get("Name"));
                                	extValNode.addTextNode((String)extValObj.get("Value"));
                                }
                            }
                    	}
                    	
                    } // End for
            	} // End if
            	
            } // End if
            
        }
    	
    	return catEntAttr;
    	
    }
    
    
    /**
     * <p>
     * Catentry 전체속성값을 ArrayList로 변환 후  반환하는 메서드
     * - Catentry목록조회에 사용
     * </p>
     * 
     * @param soapResponse
     * @return
     */
    private ArrayList<CatEntry> genResCatEntryAllList(SOAPMessage soapResponse)
    {
        ArrayList catentryList = new ArrayList();
        
        CatEntry catEnt = null;
        CatEntDesc catEntDesc = null;
        
        try
        {
            SOAPBody resBody = soapResponse.getSOAPBody();
            NodeList catentNodeList = resBody.getElementsByTagNameNS(WS_CATALOG_NS_URI, "CatalogEntry");
            NodeList catentIdenNodeList = resBody.getElementsByTagNameNS(WS_CATALOG_NS_URI, "CatalogEntryIdentifier");
            NodeList catentAttrNodeList = resBody.getElementsByTagNameNS(WS_CATALOG_NS_URI, "CatalogEntryAttributes");
            NodeList prntGrpIdenNodeList = resBody.getElementsByTagNameNS(WS_CATALOG_NS_URI, "ParentCatalogGroupIdentifier");
            NodeList prntEntIdenNodeList = resBody.getElementsByTagNameNS(WS_CATALOG_NS_URI, "ParentCatalogEntryIdentifier");
            NodeList listPriceNodeList = resBody.getElementsByTagNameNS(WS_CATALOG_NS_URI, "ListPrice");
            NodeList priceListNodeList = resBody.getElementsByTagNameNS(WS_CATALOG_NS_URI, "Price");
            
            // 아래노드는 현재 사용하지 않음.
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
                
                ArrayList catentDescList = new ArrayList();
                ArrayList catentDecriptiveAttrList = new ArrayList();
                
                
                // 1. CatEntry의 필수정보 저장
                catEnt = new CatEntry();
                catEnt.setCatalogEntryTypeCode(cateNode.getAttributes().getNamedItem("catalogEntryTypeCode").getNodeValue());
                
                if(cateNode.getAttributes().getNamedItem("displaySequence") != null)
                {
                	catEnt.setDisplaySequence(cateNode.getAttributes().getNamedItem("displaySequence").getNodeValue());
                }
                if(cateNode.getAttributes().getNamedItem("navigationPath") != null)
                {
                	catEnt.setNavigationPath(cateNode.getAttributes().getNamedItem("navigationPath").getNodeValue());
                }
                
                
                Map<String, String> catMap = new HashMap<String, String>();
                GenerateSOAPHelper.convertNodetoMap(catMap, catentIdenNodeList.item(i).getChildNodes());
                catEnt.setOwnerID(catMap.get("ownerID"));
                catEnt.setUniqueID(catMap.get("UniqueID"));
                catEnt.setPartNumber(catMap.get("PartNumber"));
                
                // 2. Description 정보 저장
                NodeList descList = ((SOAPElement)cateNode).getElementsByTagNameNS(WS_CATALOG_NS_URI, "Description");
                for(int j = 0; j < descList.getLength(); j++)
                {
                	catEntDesc = new CatEntDesc();
                	
                    Map<String, String> catentAttrMap = new HashMap<String, String>();
                    Node descAttrNode = descList.item(j);
                    
                    // Description Node의 상위카테고리는 반드시 CatalogEntry여야 함
                    if(!"CatalogEntry".equals(descAttrNode.getParentNode().getLocalName())) continue;
                    
                	NodeList attrList = ((SOAPElement)descAttrNode).getElementsByTagNameNS(WS_CATALOG_NS_URI, "Attributes");
                	for(int k = attrList.getLength()-1; k >= 0; k--)
                    {
                        Node attrNode = attrList.item(k);
                        catentAttrMap.put(attrNode.getAttributes().getNamedItem("name").getNodeValue(), attrNode.getTextContent());
                        // 중복데이터 생성방지를 위해 Node제거
                        descAttrNode.removeChild(attrNode);
                    }
                    GenerateSOAPHelper.convertNodetoMap(catentAttrMap, descAttrNode.getChildNodes());
                    
                    catEntDesc.setAuxDescription1(catentAttrMap.get("auxDescription1"));
                    catEntDesc.setAuxDescription2(catentAttrMap.get("auxDescription2"));
                    catEntDesc.setAvailable(catentAttrMap.get("available"));
                    catEntDesc.setFullImage(catentAttrMap.get("FullImage"));
                    catEntDesc.setKeyword(catentAttrMap.get("Keyword"));
                    catEntDesc.setLanguage(catentAttrMap.get("Language"));
                    catEntDesc.setLongDescription(catentAttrMap.get("LongDescription"));
                    catEntDesc.setName(catentAttrMap.get("Name"));
                    catEntDesc.setPublished(catentAttrMap.get("published"));
                    catEntDesc.setShortDescription(catentAttrMap.get("ShortDescription"));
                    catEntDesc.setThumbnail(catentAttrMap.get("Thumbnail"));
                    
                    catentDescList.add(catEntDesc);
                }
                catEnt.setDescList(catentDescList);
                
                
                
                // 3. 속성 정보저장. ( Defining, Descriptive, Classic )
                if(catentAttrNodeList.getLength() > 0)
                {
                	 Map<String, ArrayList<Attribute>> catEntAttrMap = genResCatEntryAttribute(catentAttrNodeList);
                	
	            	 catEnt.setClssAttrList(catEntAttrMap.get("clssAttrList"));
	                 catEnt.setDefiAttrList(catEntAttrMap.get("defiAttrList"));
	                 catEnt.setDescAttrList(catEntAttrMap.get("descAttrList"));
                }
                
                
                // 4. 가격정보 제장
                /*
                 * <_cat:ListPrice>
			        <_wcf:Price currency="USD">14.99000</_wcf:Price>
			        <_wcf:AlternativeCurrencyPrice currency="CAD">14.99000</_wcf:AlternativeCurrencyPrice>
			        <_wcf:AlternativeCurrencyPrice currency="JPY">14.00000</_wcf:AlternativeCurrencyPrice>
			        <_wcf:AlternativeCurrencyPrice currency="KRW">14.00000</_wcf:AlternativeCurrencyPrice>
			      </_cat:ListPrice>
                 */
               
                if(listPriceNodeList.getLength() > 0)
                {
                	ListPrice listPrice = new ListPrice();
                	
                	SOAPElement priceEle = (SOAPElement)listPriceNodeList.item(i);
                	// Defalut Price
                	NodeList defPriceList = priceEle.getElementsByTagNameNS(GenerateSOAPHelper.WS_GB_WCF_NS_URL, "Price");
                	if(defPriceList.getLength() > 0)
                	{
                		listPrice.setCurrency(defPriceList.item(0).getAttributes().getNamedItem("currency").getNodeValue());
                		listPrice.setPrice(defPriceList.item(0).getTextContent());
                	}
                	
                	// Alternative Price List
                	ArrayList<ListPrice> altPrcList = new ArrayList<ListPrice>();
                    
                	NodeList altPriceList = priceEle.getElementsByTagNameNS(GenerateSOAPHelper.WS_GB_WCF_NS_URL, "AlternativeCurrencyPrice");
                	for(int k = 0; k < altPriceList.getLength(); k++)
                    {
                        Node altPriceNode = altPriceList.item(k);
                        
                        ListPrice altListPrice = new ListPrice();
                        altListPrice.setCurrency(altPriceNode.getAttributes().getNamedItem("currency").getNodeValue());
                        altListPrice.setPrice(altPriceNode.getTextContent());
                        
                        altPrcList.add(altListPrice);
                    }
                	
                	listPrice.setAltPriceList(altPrcList);
                	catEnt.setListPrice(listPrice);
                }
                
                // 4. 부모 카탈로그그룹 정보 저장
                if(prntGrpIdenNodeList.getLength() > 0)
                {
                    Map<String, String> catGrpMap = new HashMap<String, String>();
                    GenerateSOAPHelper.convertNodetoMap(catGrpMap, prntGrpIdenNodeList.item(i).getChildNodes());
                    
                   CatGroup catGrp = new CatGroup();
                   catGrp.setGroupIdentifier(catGrpMap.get("GroupIdentifier"));
                   catGrp.setOwnerID(catGrpMap.get("ownerID"));
                   catGrp.setUniqueID(catGrpMap.get("UniqueID"));
                    
                   catEnt.setPrntCatGrp(catGrp);
                }
                
                catentryList.add(catEnt);
            }

        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return catentryList;
    }
    
    /**
     * 
     * @param soapResponse
     * @return
     */
    private Map genResCatEntryAttribute(NodeList attrNodeList)
    {
    	
        Map catentAttrMap = new HashMap();
        
        List catentDefiAttrList = new ArrayList();	// defining_attr List
        List catentDescAttrList = new ArrayList();	// descriptive_attr List
        List catentClssAttrList = new ArrayList();	// classic_attr List
        
        Attribute attrbute = new Attribute();
        try
        {
                	
        	Node attrNode = attrNodeList.item(0);
            NodeList attrList = ((SOAPElement)attrNode).getElementsByTagNameNS(WS_CATALOG_NS_URI, "Attributes");
            
            for(int k = 0; k < attrList.getLength(); k++)
            {
            	SOAPElement attrEle = (SOAPElement)attrList.item(k);
            	
            	// 1. Defining Attribute일 경우에만 저장
            	if( attrEle.hasAttribute("usage") && "Defining".equals(attrEle.getAttribute("usage")) )
            	{
            		// Defining Attribute Value List 정보 저장
            		ArrayList<AttrValue> catentDefiAttrValList = new ArrayList<AttrValue>();
            		Map<String,String> attrValMap = new HashMap<String,String>();
            		
                    NodeList defNodeList = attrEle.getElementsByTagNameNS(WS_CATALOG_NS_URI, "AllowedValue");
                    for(int j = defNodeList.getLength()-1; j >= 0; j--)
                    {
                    	attrValMap = new HashMap();
                    	AttrValue attVal = new AttrValue();
                    	
                    	Node attrVal = defNodeList.item(j);
                    	attrValMap.put("displaySequence", ((SOAPElement)attrVal).getAttribute("displaySequence"));
                    	attrValMap.put("identifier", ((SOAPElement)attrVal).getAttribute("identifier"));
                    	GenerateSOAPHelper.convertNodetoMap(attrValMap, attrVal.getChildNodes());
                    	///////////////////////////////////////////////////////////////////
                    	attVal.setDisplaySequence(attrValMap.get("displaySequence"));
                    	attVal.setExtendedValue(attrValMap.get("ExtendedValue"));
                    	attVal.setIdentifier(attrValMap.get("identifier"));
                    	attVal.setName(attrValMap.get("Name"));
                    	attVal.setValue(attrValMap.get("Value"));
                    	///////////////////////////////////////////////////////////////////
                    	catentDefiAttrValList.add(attVal);
                    	
                    	attrEle.removeChild(attrVal);
                    }
                    
                    // Defining Attribute 기본정보 저장
                    Map<String,String> attrMap = new HashMap<String,String>();
                    attrMap.put("displaySequence", attrEle.getAttribute("displaySequence"));
            		if(attrEle.hasAttribute("language"))
            		{
            			attrMap.put("language", attrEle.getAttribute("language"));
            		}
            		GenerateSOAPHelper.convertNodetoMap(attrMap, attrEle.getChildNodes());
            		///////////////////////////////////////////////////////////////////
            		attrbute = new Attribute();
            		attrbute.setAttributeDataType(attrMap.get("AttributeDataType"));
            		attrbute.setDescription(attrMap.get("Description"));
            		attrbute.setDisplaySequence(attrMap.get("displaySequence"));
            		attrbute.setExtendedData(attrMap.get("ExtendedData"));
            		attrbute.setLanguage(attrMap.get("Language"));
            		attrbute.setName(attrMap.get("Name"));
            		attrbute.setUniqueID(attrMap.get("UniqueID"));
            		
            		///////////////////////////////////////////////////////////////////
            		// Defining Attribute Values 저장
            		attrbute.setValueList(catentDefiAttrValList);
            		
                    catentDefiAttrList.add(attrbute);
            	} // End If is Defining Node
            	
            	// 2. Descriptive Attribute 저장
            	else if( attrEle.hasAttribute("usage") && "Descriptive".equals(attrEle.getAttribute("usage")) )
            	{
            		Map<String,String> attrMap = new HashMap<String,String>();
            		
            		attrMap.put("displaySequence", attrEle.getAttribute("displaySequence"));
            		if(attrEle.hasAttribute("language"))
            		{
            			attrMap.put("language", attrEle.getAttribute("language"));
            		}
            		GenerateSOAPHelper.convertNodetoMap(attrMap, attrEle.getChildNodes());
                    
            		attrbute = new Attribute();
            		attrbute.setAttributeDataType(attrMap.get("AttributeDataType"));
            		attrbute.setDescription(attrMap.get("Description"));
            		attrbute.setDisplaySequence(attrMap.get("displaySequence"));
            		attrbute.setExtendedData(attrMap.get("ExtendedData"));
            		attrbute.setLanguage(attrMap.get("Language"));
            		attrbute.setName(attrMap.get("Name"));
            		attrbute.setUniqueID(attrMap.get("UniqueID"));
            		attrbute.setValue(attrMap.get("Value"));
            		
            		catentDescAttrList.add(attrbute);
            	}
            	// 3. Classical Attribute 저장
            	else
            	{
            		Map<String,String> attrMap = new HashMap<String,String>();
            		attrMap.put("displaySequence", attrEle.getAttribute("displaySequence"));
            		if(attrEle.hasAttribute("language"))
            		{
            			attrMap.put("language", attrEle.getAttribute("language"));
            		}
            		GenerateSOAPHelper.convertNodetoMap(attrMap, attrEle.getChildNodes());
                    
            		attrbute = new Attribute();
            		attrbute.setAttributeDataType(attrMap.get("AttributeDataType"));
            		attrbute.setDescription(attrMap.get("Description"));
            		attrbute.setDisplaySequence(attrMap.get("displaySequence"));
            		attrbute.setExtendedData(attrMap.get("ExtendedData"));
            		attrbute.setLanguage(attrMap.get("Language"));
            		attrbute.setName(attrMap.get("Name"));
            		attrbute.setUniqueID(attrMap.get("UniqueID"));
            		attrbute.setValue(attrMap.get("Value"));
            		
            		catentClssAttrList.add(attrbute);
            	}
            } // End For ( Attributes )

            catentAttrMap.put("clssAttrList", catentClssAttrList);
            catentAttrMap.put("defiAttrList", catentDefiAttrList);
            catentAttrMap.put("descAttrList", catentDescAttrList);
            
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return catentAttrMap;
    }

    
	
}
