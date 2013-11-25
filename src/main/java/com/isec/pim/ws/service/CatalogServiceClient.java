package com.isec.pim.ws.service;

import java.util.HashMap;
import java.util.Map;

public interface CatalogServiceClient
{

    public Map prcessCatalogEntry(HashMap hashmap);

    public Map changeCatalogEntry(HashMap hashmap);

    public Map getCatalogEntry(HashMap hashmap);
}
