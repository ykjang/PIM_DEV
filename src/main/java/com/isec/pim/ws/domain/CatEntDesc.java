package com.isec.pim.ws.domain;

import java.io.Serializable;

public class CatEntDesc implements Serializable {

	
	/*
	  Description[0]/Language
	  Description[0]/Name
	  Description[0]/ShortDescription
	  Description[0]/LongDescription
	  Description[0]/Thumbnail
	  Description[0]/FullImage
	  Description[0]/Keyword
	
	  Description[0]/Attributes/auxDescription1
	  Description[0]/Attributes/auxDescription2
	  Description[0]/Attributes/available
	  Description[0]/Attributes/published
	*/
	private String Language;
	private String Name;
	private String ShortDescription;
	private String LongDescription;
	private String Thumbnail;
	private String FullImage;
	private String Keyword;
	private String available;
	private String published;
	
	private String auxDescription1;
	private String auxDescription2;
	
	private String field1;
	private String field2;
	private String field3;
	
		
	
	public String getLanguage() {
		return Language;
	}
	public void setLanguage(String language) {
		Language = language;
	}
	public String getName() {
		return Name;
	}
	public void setName(String name) {
		Name = name;
	}
	public String getShortDescription() {
		return ShortDescription;
	}
	public void setShortDescription(String shortDescription) {
		ShortDescription = shortDescription;
	}
	public String getLongDescription() {
		return LongDescription;
	}
	public void setLongDescription(String longDescription) {
		LongDescription = longDescription;
	}
	public String getThumbnail() {
		return Thumbnail;
	}
	public void setThumbnail(String thumbnail) {
		Thumbnail = thumbnail;
	}
	public String getFullImage() {
		return FullImage;
	}
	public void setFullImage(String fullImage) {
		FullImage = fullImage;
	}
	public String getKeyword() {
		return Keyword;
	}
	public void setKeyword(String keyword) {
		Keyword = keyword;
	}
	public String getAvailable() {
		return available;
	}
	public void setAvailable(String available) {
		this.available = available;
	}
	public String getPublished() {
		return published;
	}
	public void setPublished(String published) {
		this.published = published;
	}
	public String getAuxDescription1() {
		return auxDescription1;
	}
	public void setAuxDescription1(String auxDescription1) {
		this.auxDescription1 = auxDescription1;
	}
	public String getAuxDescription2() {
		return auxDescription2;
	}
	public void setAuxDescription2(String auxDescription2) {
		this.auxDescription2 = auxDescription2;
	}
	public String getField1() {
		return field1;
	}
	public void setField1(String field1) {
		this.field1 = field1;
	}
	public String getField2() {
		return field2;
	}
	public void setField2(String field2) {
		this.field2 = field2;
	}
	public String getField3() {
		return field3;
	}
	public void setField3(String field3) {
		this.field3 = field3;
	}
	
	
}
