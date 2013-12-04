package com.isec.pim.ws.service;

import java.util.HashMap;
import java.util.Map;

public interface CatalogServiceClient
{

    public Map prcessCatalogEntry(Map hashmap);

    public Map changeCatalogEntry(Map hashmap);

    
    
    public Map getCatalogEntryAll(Map hashmap);
    
    public Map getCatalogEntryAttribute(Map hashmap);
    
    public Map getCatalogEntryPrice(Map hashmap);
}
