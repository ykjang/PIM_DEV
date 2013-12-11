package com.isec.pim.ws.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Map;

public class ListPrice implements Serializable{
    
	String currency;
	String price;
	
	ArrayList<ListPrice> altPriceList = new ArrayList<ListPrice>();

	public String getCurrency() {
		return currency;
	}

	public void setCurrency(String currency) {
		this.currency = currency;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public ArrayList<ListPrice> getAltPriceList() {
		return altPriceList;
	}

	public void setAltPriceList(ArrayList<ListPrice> altPriceList) {
		this.altPriceList = altPriceList;
	}
	
	
}
