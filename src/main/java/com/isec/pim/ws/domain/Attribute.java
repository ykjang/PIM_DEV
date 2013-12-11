package com.isec.pim.ws.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Map;

public class Attribute implements Serializable{
    
	String UniqueID;
	String Name;
	String Value;
	String language;
	String dataType;
	String ExtendedData;
	String displaySequence;
	String Description;
	String AttributeDataType;
	
	ArrayList<AttrValue> valueList = new ArrayList<AttrValue>();
	
	ArrayList<Map<String, Object>> extValueList = new ArrayList<Map<String,Object>>();

	public String getUniqueID() {
		return UniqueID;
	}

	public void setUniqueID(String uniqueID) {
		UniqueID = uniqueID;
	}

	public String getName() {
		return Name;
	}

	public void setName(String name) {
		Name = name;
	}

	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}

	public String getDataType() {
		return dataType;
	}

	public void setDataType(String dataType) {
		this.dataType = dataType;
	}

	public String getExtendedData() {
		return ExtendedData;
	}

	public void setExtendedData(String extendedData) {
		ExtendedData = extendedData;
	}

	public String getDisplaySequence() {
		return displaySequence;
	}

	public void setDisplaySequence(String displaySequence) {
		this.displaySequence = displaySequence;
	}

	public String getDescription() {
		return Description;
	}

	public void setDescription(String description) {
		Description = description;
	}

	public String getAttributeDataType() {
		return AttributeDataType;
	}

	public void setAttributeDataType(String attributeDataType) {
		AttributeDataType = attributeDataType;
	}

	public ArrayList<AttrValue> getValueList() {
		return valueList;
	}

	public void setValueList(ArrayList<AttrValue> valueList) {
		this.valueList = valueList;
	}

	public ArrayList<Map<String, Object>> getExtValueList() {
		return extValueList;
	}

	public void setExtValueList(ArrayList<Map<String, Object>> extValueList) {
		this.extValueList = extValueList;
	}

	public String getValue() {
		return Value;
	}

	public void setValue(String value) {
		Value = value;
	}

	
}
