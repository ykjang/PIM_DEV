package com.isec.pim.ws.service;

import com.google.gson.internal.StringMap;
import com.isec.pim.ws.common.GenerateSOAPHelper;

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

    private static final String WS_CATALOG_ENDPOINT = "http://localhost/webapp/wcs/component/catalog/services/CatalogServices";
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
    public Map prcessCatalogEntry(Map paramMap)
    {
    	
    	
        Map resMap = new HashMap();
        SOAPConnection soapConnection = null;
        
        
        try
        {
            soapConnection = GenerateSOAPHelper.getSOAPConnnection();
            
            
            SOAPMessage reqMsg = GenerateSOAPHelper.genSOAPEnvelopNode();
            GenerateSOAPHelper.genSOAPHeaderInfoNode(reqMsg.getSOAPHeader());
            
            
            paramMap.put("BOD_NAME", WS_CATALOG_BOD_PROCESS_CATALOGENTRY);	// ProcessCatalogEntry
            paramMap.put("ACTION_TYPE", WS_CATALOG_ACTION_PROCESS_TYPE);	// Process
            
            paramMap.put("SVS_NS_PREFIX", WS_CATALOG_NS_PREFIX);			// _cat
            paramMap.put("SVS_NS_URI", WS_CATALOG_NS_URI);                  // http://www.ibm.com/xmlns/prod/commerce/9/catalog
           
            SOAPElement elemData = GenerateSOAPHelper.genSOAPDataAreaInitNode(reqMsg.getSOAPBody(), paramMap);
            
            // DataArea Node 의 CategoryEntry 데이타 객체생성
            genCatEntProcessNode(elemData, paramMap);
            
            // SOAP Request Message 저장
            MimeHeaders headers = reqMsg.getMimeHeaders();
            headers.addHeader("SOAPAction", WS_CATALOG_NS_URI);
            reqMsg.saveChanges();
            
            GenerateSOAPHelper.printSOAPResponse(reqMsg);
            
            // 웹서비스 Call
            SOAPMessage resMsg = soapConnection.call(reqMsg, WS_CATALOG_ENDPOINT);
            GenerateSOAPHelper.printSOAPResponse(resMsg);
            
            // SOAP Response 객체 -> List 변환 
            List dataList = getCatEntResponseList(resMsg);
            resMap.put("dataList", dataList);
            
            
            soapConnection.close();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return resMap;
    }

    public Map changeCatalogEntry(Map paramMap)
    {
    	Map resMap = new HashMap();
        SOAPConnection soapConnection = null;
        
        
        try
        {
            soapConnection = GenerateSOAPHelper.getSOAPConnnection();
            
            
            SOAPMessage reqMsg = GenerateSOAPHelper.genSOAPEnvelopNode();
            GenerateSOAPHelper.genSOAPHeaderInfoNode(reqMsg.getSOAPHeader());
            
            
            paramMap.put("BOD_NAME", WS_CATALOG_BOD_CHANGE_CATALOGENTRY);	// ChangeCatalogEntry
            paramMap.put("ACTION_TYPE", WS_CATALOG_ACTION_CHANGE_TYPE);	    // Change
            
            paramMap.put("SVS_NS_PREFIX", WS_CATALOG_NS_PREFIX);			// _cat
            paramMap.put("SVS_NS_URI", WS_CATALOG_NS_URI);                  // http://www.ibm.com/xmlns/prod/commerce/9/catalog
            
            SOAPElement elemData = GenerateSOAPHelper.genSOAPDataAreaInitNode(reqMsg.getSOAPBody(), paramMap);
            
            // DataArea Node 의 CategoryEntry 데이타 객체생성
            genCatEntChangeNode(elemData, paramMap);
            
            MimeHeaders headers = reqMsg.getMimeHeaders();
            headers.addHeader("SOAPAction", "http://www.ibm.com/xmlns/prod/commerce/9/catalog ");
            reqMsg.saveChanges();
            
            GenerateSOAPHelper.printSOAPResponse(reqMsg);
            
            SOAPMessage resMsg = soapConnection.call(reqMsg, WS_CATALOG_ENDPOINT);
            GenerateSOAPHelper.printSOAPResponse(resMsg);
            
            
            List dataList = getCatEntResponseList(resMsg);
            resMap.put("dataList", dataList);
            soapConnection.close();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return resMap;
    }

    public Map getCatalogEntry(Map paramMap)
    {
    	Map resMap = new HashMap();
        SOAPConnection soapConnection = null;
        
        try
        {
            soapConnection = GenerateSOAPHelper.getSOAPConnnection();
            
            
            SOAPMessage reqMsg = GenerateSOAPHelper.genSOAPEnvelopNode();
            GenerateSOAPHelper.genSOAPHeaderInfoNode(reqMsg.getSOAPHeader());
            
            paramMap.put("BOD_NAME", WS_CATALOG_BOD_GET_CATALOGENTRY);		// GetCatalogEntry
            paramMap.put("ACTION_TYPE", WS_CATALOG_ACTION_GET_TYPE);	    // Get
            
            paramMap.put("SVS_NS_PREFIX", WS_CATALOG_NS_PREFIX);			// _cat
            paramMap.put("SVS_NS_URI", WS_CATALOG_NS_URI);                  // http://www.ibm.com/xmlns/prod/commerce/9/catalog
            
            SOAPElement elemData = GenerateSOAPHelper.genSOAPDataAreaInitNode(reqMsg.getSOAPBody(), paramMap);
            
            MimeHeaders headers = reqMsg.getMimeHeaders();
            headers.addHeader("SOAPAction", "http://www.ibm.com/xmlns/prod/commerce/9/catalog ");
            reqMsg.saveChanges();
            
            
            GenerateSOAPHelper.printSOAPResponse(reqMsg);
            
            SOAPMessage resMsg = soapConnection.call(reqMsg, WS_CATALOG_ENDPOINT);
            GenerateSOAPHelper.printSOAPResponse(resMsg);
            
            
            List dataList = getCatEntResponseList(resMsg);
            resMap.put("dataList", dataList);
            soapConnection.close();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return resMap;
    }

    
    private void genCatEntProcessNode(SOAPElement elemData, Map reqParamMap) throws Exception
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
            genCatEntAtttributeNode(elemCatEnt_Attr, descriptiveAttrList, "Descriptive", WS_CATALOG_ACTION_PROCESS_TYPE);
        }
                
        /*         
         * Defining Attributes
         */
        if( catEntObj.containsKey("DefiningAttributes") ){
        	ArrayList definingAttrList = (ArrayList)catEntObj.get("DefiningAttributes");
            genCatEntAtttributeNode(elemCatEnt_Attr, definingAttrList, "Defining", WS_CATALOG_ACTION_PROCESS_TYPE);
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
        	SOAPElement elemListPrice1 = elemListPrice.addChildElement("Price", GenerateSOAPHelper.WS_GB_WCF_NS_PREFIX);
        				elemListPrice1.setAttribute("currency", (String)listPriceMap.get("currency"));
        				elemListPrice1.addTextNode((String)listPriceMap.get("price"));
        }
        /**
         * ------------------------------ ListPrice Node 생성 종료 ---------------------------------------
         */
        
        /**
         * ------------------------------ Price Node 생성 시작 ---------------------------------------
         * 
        	<_cat:Price>
				- <_wcf:StandardPrice>
				- <_wcf:Price>
				  <_wcf:Price currency="USD">26.75</_wcf:Price> 
				  </_wcf:Price>
				  </_wcf:StandardPrice>
				- <_wcf:ContractPrice minimumQuantity="1.0">
				- <_wcf:Price>
				  <_wcf:Price currency="USD">26.75</_wcf:Price> 
				  </_wcf:Price>
				- <_wcf:ContractIdentifier>
				  <_wcf:UniqueID>10001</_wcf:UniqueID> 
				- <_wcf:ExternalIdentifier majorVersionNumber="1" minorVersionNumber="0" origin="0" ownerID="7000000000000000002">
				  <_wcf:Name>AdvancedB2BDirect Contract number 1234</_wcf:Name> 
				  </_wcf:ExternalIdentifier>
				  </_wcf:ContractIdentifier>
				  </_wcf:ContractPrice>
			  </_cat:Price>
         */
        /*
         * if( catEntObj.containsKey("Price") ){
        	
        	Map priceMap = (Map)catEntObj.get("Price");
            SOAPElement elemPrice = elemCatEnt.addChildElement("Price", WS_CATALOG_NS_PREFIX);
            
            if( priceMap.containsKey("StandardPrice") ){
            	
            	Map stdPriceMap = (Map)priceMap.get("StandardPrice");
            	
            	SOAPElement elemStdPricePrice = elemPrice.addChildElement("StandardPrice", GenerateSOAPHelper.WS_GB_WCF_NS_PREFIX);
            	SOAPElement elemStdPricePrice1 = elemStdPricePrice.addChildElement("Price", GenerateSOAPHelper.WS_GB_WCF_NS_PREFIX);
            	SOAPElement elemStdPricePrice2 = elemStdPricePrice1.addChildElement("Price", GenerateSOAPHelper.WS_GB_WCF_NS_PREFIX);
            					elemStdPricePrice2.setAttribute("currency", (String)stdPriceMap.get("currency"));
            						elemStdPricePrice2.addTextNode((String)stdPriceMap.get("price"));
            }
        }
        */
        /**
         * ------------------------------ Price Node 생성 종료 ---------------------------------------
         */
        /**
         * ------------------------------ CatalogEntry Node 생성 종료 ---------------------------------------
         */
    }
    
    private void genCatEntChangeNode(SOAPElement elemData, Map reqParamMap) throws Exception
    {
        
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
            genCatEntAtttributeNode(elemCatEnt_Attr, descriptiveAttrList, "Descriptive", WS_CATALOG_ACTION_CHANGE_TYPE);
        }
                
        /*         
         * Defining Attributes
         */
        if( catEntObj.containsKey("DefiningAttributes") ){
        	ArrayList definingAttrList = (ArrayList)catEntObj.get("DefiningAttributes");
            genCatEntAtttributeNode(elemCatEnt_Attr, definingAttrList, "Defining", WS_CATALOG_ACTION_CHANGE_TYPE);
        }
        /**
         * ------------------------------ CatalogEntryAttributes Node 생성 종료 ---------------------------------------
         */
        
        
        /**
         * ------------------------------ ListPrice Node 생성 시작 ---------------------------------------
         */
        if( catEntObj.containsKey("ListPrice") ){
        	
        	Map listPriceMap = (Map)catEntObj.get("ListPrice");
        	
        	SOAPElement elemListPrice = elemCatEnt.addChildElement("ListPrice", WS_CATALOG_NS_PREFIX);
        	SOAPElement elemListPrice1 = elemListPrice.addChildElement("Price", GenerateSOAPHelper.WS_GB_WCF_NS_PREFIX);
        				elemListPrice1.setAttribute("currency", (String)listPriceMap.get("currency"));
        				elemListPrice1.addTextNode((String)listPriceMap.get("price"));
        }
        /**
         * ------------------------------ ListPrice Node 생성 종료 ---------------------------------------
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
    private SOAPElement genCatEntAtttributeNode(SOAPElement catEntAttr, ArrayList attList, String usage, String actionType) throws Exception{
    	
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
            
            if("Process".equals(actionType)){
            	String Name = (String)descAttrObj.get("Name");
                String Description = (String)descAttrObj.get("Description");
                descAttrNode.addChildElement("Name", WS_CATALOG_NS_PREFIX).addTextNode(Name);					// ATTRIBUTE.NAME
                descAttrNode.addChildElement("Description", WS_CATALOG_NS_PREFIX).addTextNode(Description);		// ATTRIBUTE.DESCRIPTION
            }
            
            
            // Descriptive Attribute
            /*
                <_cat:Value identifier="1000000000000000009" storeID="10101">30</_cat:Value> 
				<_cat:IntegerValue>
					<_cat:Value>30</_cat:Value> 
				</_cat:IntegerValue>
             */
            if("Descriptive".equals(usage)){
            	String Value = (String)descAttrObj.get("Value");
                String TypeValue = (String)descAttrObj.get("TypeValue");
                
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
	      	  	<_cat:ExtendedValue name="DisplaySequence">1.0</_cat:ExtendedValue>
	      	  </_cat:AllowedValue>
	          */
            if("Defining".equals(usage)){
            	
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
        }
    	
    	return catEntAttr;
    	
    }
    
    private ArrayList getCatEntResponseList(SOAPMessage soapResponse)
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
            NodeList prntEntIdenNodeList = resBody.getElementsByTagNameNS(WS_CATALOG_NS_URI, "ParentCatalogEntryIdentifier");
            NodeList listPriceNodeList = resBody.getElementsByTagNameNS(WS_CATALOG_NS_URI, "ListPrice");
            NodeList priceListNodeList = resBody.getElementsByTagNameNS(WS_CATALOG_NS_URI, "Price");
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
                catentryMap = GenerateSOAPHelper.convertNodetoMap(catentryMap, catentIdenNodeList.item(i).getChildNodes());
                NodeList descList = ((SOAPElement)cateNode).getElementsByTagNameNS(WS_CATALOG_NS_URI, "Description");
                for(int j = 0; j < descList.getLength(); j++)
                {
                    catentAttrMap = new HashMap();
                    Node descAttrNode = descList.item(j);
                    GenerateSOAPHelper.convertNodetoMap(catentAttrMap, descAttrNode.getChildNodes());
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
                        catentAttrList.add(GenerateSOAPHelper.convertNodetoMap(catentAttrMap, attrList.item(k).getChildNodes()));
                    }

                }
                catentryMap.put("ATTRIBUTE", catentAttrList);
                if(listPriceNodeList.getLength() > 0)
                {
                    catentAttrMap = new HashMap();
                    catentryMap.put("LISTPRICE", GenerateSOAPHelper.convertNodetoMap(catentAttrMap, listPriceNodeList.item(i).getChildNodes()));
                } else
                {
                    catentryMap.put("LISTPRICE", null);
                }
                if(prntGrpIdenNodeList.getLength() > 0)
                {
                    catentAttrMap = new HashMap();
                    catentryMap.put("PARENTGRPINFO", GenerateSOAPHelper.convertNodetoMap(catentAttrMap, prntGrpIdenNodeList.item(i).getChildNodes()));
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
    
}
