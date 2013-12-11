package com.isec.pim.ws.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.xml.soap.SOAPMessage;

import com.isec.pim.ws.domain.CatEntry;

public interface CatalogServiceClient
{

    public Map prcessCatalogEntry(Map hashmap);

    public Map<String, SOAPMessage> changeCatalogEntry(Map<String, Object> hashmap);

    
    
    public Map<String, ArrayList<CatEntry>> getCatalogEntryAll(Map<String, Object> hashmap);
    
    public Map getCatalogEntryAttribute(Map hashmap);
    
    public Map getCatalogEntryPrice(Map hashmap);
}
