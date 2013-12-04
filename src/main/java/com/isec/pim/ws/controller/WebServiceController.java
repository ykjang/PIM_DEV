package com.isec.pim.ws.controller;

import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.xml.soap.MessageFactory;
import javax.xml.soap.MimeHeaders;
import javax.xml.soap.Name;
import javax.xml.soap.SOAPBody;
import javax.xml.soap.SOAPConnection;
import javax.xml.soap.SOAPConnectionFactory;
import javax.xml.soap.SOAPElement;
import javax.xml.soap.SOAPHeader;
import javax.xml.soap.SOAPMessage;
import javax.xml.soap.SOAPPart;
import javax.xml.soap.Text;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.google.gson.Gson;
import com.google.gson.internal.StringMap;
import com.isec.pim.ws.service.CatalogServiceClient;

/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value = "/ws")
public class WebServiceController {
	
	private static final Logger logger = LoggerFactory.getLogger(WebServiceController.class);
	
	
	@Autowired 
	private CatalogServiceClient catalogServiceClient;
	
	
	
	
	@RequestMapping(value = "/CatEntRegister.do")
	public String CatEntRegister(Locale locale, Model model){
		return "/ws/CatEntryRegister";
	}
	
	
	@RequestMapping(value = "/getCatEntByPCatGrpId.do")
	public String getCatEntByPCatGrpId(Locale locale, Model model){
		return "/ws/CatEntryList";
	}
	
	
	@RequestMapping(value = "/getCatEntDetail.do", method = RequestMethod.GET)
	public String getCatEntDetail( @RequestParam String param, 
												Locale locale, Model model){
		
		// JSON to Java Object
		HashMap<String, Object> paramObj = new Gson().fromJson(param, HashMap.class);
		
		// WebService Call
		HashMap<String, Object> resMap = (HashMap)catalogServiceClient.getCatalogEntryAll(paramObj);
		List dataList = (ArrayList)resMap.get("dataList");
		
		logger.info("[dataList]"+new Gson().toJson(dataList));
		
		model.addAttribute("dataList", dataList);
		return "/ws/CatEntryDetail";
	}
	
	@RequestMapping(value = "/getCatEntDefiAttr.do", method = RequestMethod.GET)
	public String getCatEntDefiAttr( @RequestParam String param, 
												Locale locale, Model model){
		
		// JSON to Java Object
		HashMap<String, Object> paramObj = new Gson().fromJson(param, HashMap.class);
		
		// WebService Call
		Map resMap = catalogServiceClient.getCatalogEntryAttribute(paramObj);
		
		logger.info("[dataMap]"+new Gson().toJson(resMap));
		
		model.addAttribute("dataMap", resMap);
		return "/ws/CatEntryDetail";
	}
	
	/**
	 	상위 카탈로그 그룹별 카탈로그 엔트리 목록 조회
	 	
	    [Action Expression]
		/CatalogEntry[ParentCatalogGroupIdentifier[(UniqueID=$uniqueId$)]]
		/CatalogEntry[ParentCatalogGroupIdentifier[ExternalIdentifier[(GroupIdentifier=$groupIdentifier$)]]]
	 
	 	[Service Provided]
	 	Get child catalog entries of a catalog group.
		Returns all child catalog entries of the given catalog group unique ID or identifier, except for SKUs having a parent product, 
		under the given catalog ID in the context
	 
	    [Client Library]
	    getCatalogEntryByParentCatalogGroupId 
	    getCatalogEntryDetailsByParentCatalogGroupId
	 */
	@RequestMapping(value = "/getCatEntByPCatGrpId.jsonp")
	public ModelAndView getCatEntListByPCatGrpId( @RequestParam String param) throws Exception{
		
		
		// JSON to Java Object
		HashMap<String, Object> paramObj = new Gson().fromJson(param, HashMap.class);
		
		// WebService Call
		HashMap<String, Object> resMap = (HashMap<String, Object>)catalogServiceClient.getCatalogEntryAll(paramObj);
		List dataList = (ArrayList)resMap.get("dataList");
			

		ModelAndView modelAndView=new ModelAndView("jsonView");
		modelAndView.addObject("dataList", dataList);
		
		return modelAndView;
		
	}
	
	
	
	@RequestMapping(value = "/RegisterCatEnt.jsonp", method=RequestMethod.POST)
	public ModelAndView registerCatEntry(@RequestBody String jsonCatEnt, HttpServletRequest request) {
		
		logger.info("[str]"+jsonCatEnt);
		
		// JSON to Java Object
		HashMap<String, Object> paramObj = new Gson().fromJson(jsonCatEnt, HashMap.class);
		
		//ProcessCatalogEntry XPath Expression String
      	logger.info("[ACTION_CODE]"+paramObj.get("ACTION_CODE"));
      	logger.info("[REQ_XPATH]"+paramObj.get("REQ_XPATH"));
      	//ProcessCatalogEntry BOD Parameter
      	
      	StringMap<Object> catEntObj = (StringMap<Object>)paramObj.get("CATENTRY");
      	
		// WebService Call
		HashMap<String, Object> resMap = (HashMap<String, Object>)catalogServiceClient.prcessCatalogEntry(paramObj);
		
		
		ModelAndView modelAndView=new ModelAndView("jsonView");
		modelAndView.addObject("RESULT", resMap);
		return modelAndView;
	}
	
	
	@RequestMapping(value = "/ChangeCatEnt.jsonp", method=RequestMethod.POST)
	public ModelAndView changeCatEntry(@RequestBody String jsonCatEnt, HttpServletRequest request) {
		
		logger.info("[str]"+jsonCatEnt);
		
		// JSON to Java Object
		HashMap<String, Object> paramObj = new Gson().fromJson(jsonCatEnt, HashMap.class);
		
		//ProcessCatalogEntry XPath Expression String
      	logger.info("[ACTION_CODE]"+paramObj.get("ACTION_CODE"));
      	logger.info("[REQ_XPATH]"+paramObj.get("REQ_XPATH"));
      	
      	
		HashMap<String, Object> resMap = (HashMap<String, Object>)catalogServiceClient.changeCatalogEntry(paramObj);
		
		
		ModelAndView modelAndView=new ModelAndView("jsonView");
		modelAndView.addObject("RESULT", "Y");
		return modelAndView;
	}
	
}