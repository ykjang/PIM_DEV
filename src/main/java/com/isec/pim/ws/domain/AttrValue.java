package com.isec.pim.ws.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Map;

public class AttrValue implements Serializable{
    
	String Value;
	String name;
	String identifier;
	String ExtendedValue;
	String displaySequence;
	
	
	public String getValue() {
		return Value;
	}
	public void setValue(String value) {
		Value = value;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getIdentifier() {
		return identifier;
	}
	public void setIdentifier(String identifier) {
		this.identifier = identifier;
	}
	public String getExtendedValue() {
		return ExtendedValue;
	}
	public void setExtendedValue(String extendedValue) {
		ExtendedValue = extendedValue;
	}
	public String getDisplaySequence() {
		return displaySequence;
	}
	public void setDisplaySequence(String displaySequence) {
		this.displaySequence = displaySequence;
	}
	
	
}
