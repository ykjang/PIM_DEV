package com.isec.pim.ws.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class CatEntry implements Serializable {
    
	// 상품 필수정보
	private String UniqueID;
	private String PartNumber;
	private String ownerID;
	private String navigationPath;
	private String displaySequence;
	private String catalogEntryTypeCode;
	
	
	// 상품 상세속성 리스트 ( 상품명, Short/Long Description, Thumbnail/FullImage 등)
	private ArrayList<CatEntDesc> descList = new ArrayList<CatEntDesc>();
	
	// 상품 Classical Attribute 리스트 ( 제조사, onAuction, onSpecial 등)
	private List<Attribute> clssAttrList = new ArrayList<Attribute>();
	
	// 상품 Defining Attribute 리스트 ( SIZE, COLOR 등)
	private List<Attribute> defiAttrList = new ArrayList<Attribute>();
		
	// 상품 Descriptive Attribute 리스트 ( 부가속성 )
	private List<Attribute> descAttrList = new ArrayList<Attribute>();
 
	// 상품 ListPrice(통화별)
	private ListPrice listPrice;
	
	// 부모 카탈로그 그룹 정보
	private CatGroup prntCatGrp;
	
	
	public CatGroup getPrntCatGrp() {
		return prntCatGrp;
	}

	public void setPrntCatGrp(CatGroup prntCatGrp) {
		this.prntCatGrp = prntCatGrp;
	}

	public String getUniqueID() {
		return UniqueID;
	}

	public void setUniqueID(String uniqueID) {
		UniqueID = uniqueID;
	}

	public String getPartNumber() {
		return PartNumber;
	}

	public void setPartNumber(String partNumber) {
		PartNumber = partNumber;
	}

	public String getOwnerID() {
		return ownerID;
	}

	public void setOwnerID(String ownerID) {
		this.ownerID = ownerID;
	}

	public String getNavigationPath() {
		return navigationPath;
	}

	public void setNavigationPath(String navigationPath) {
		this.navigationPath = navigationPath;
	}

	public String getDisplaySequence() {
		return displaySequence;
	}

	public void setDisplaySequence(String displaySequence) {
		this.displaySequence = displaySequence;
	}

	public String getCatalogEntryTypeCode() {
		return catalogEntryTypeCode;
	}

	public void setCatalogEntryTypeCode(String catalogEntryTypeCode) {
		this.catalogEntryTypeCode = catalogEntryTypeCode;
	}

	public ListPrice getListPrice() {
		return listPrice;
	}

	public void setListPrice(ListPrice listPrice) {
		this.listPrice = listPrice;
	}

	public ArrayList<CatEntDesc> getDescList() {
		return descList;
	}

	public void setDescList(ArrayList<CatEntDesc> descList) {
		this.descList = descList;
	}

	public List<Attribute> getClssAttrList() {
		return clssAttrList;
	}

	public void setClssAttrList(ArrayList<Attribute> clssAttrList) {
		this.clssAttrList = clssAttrList;
	}

	public List<Attribute> getDefiAttrList() {
		return defiAttrList;
	}

	public void setDefiAttrList(ArrayList<Attribute> defiAttrList) {
		this.defiAttrList = defiAttrList;
	}

	public List<Attribute> getDescAttrList() {
		return descAttrList;
	}

	public void setDescAttrList(ArrayList<Attribute> descAttrList) {
		this.descAttrList = descAttrList;
	}
	
	
}
