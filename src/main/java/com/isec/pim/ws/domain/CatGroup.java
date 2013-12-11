package com.isec.pim.ws.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Map;

public class CatGroup implements Serializable{
	
	/**
	 *  CATGROUP_ID	BIGINT NOT NULL	The internal reference number of the catalog group.
		MEMBER_ID	BIGINT NOT NULL	The internal reference number that identifies the owner of the catalog group. Along with IDENTIFIER, these columns are a unique index.
		IDENTIFIER	VARCHAR (254)	The external name that is used to identify the catalog group. Along with MEMBER_ID, these columns are a unique index.
	 */
	String UniqueID;
	String ownerID;
	String GroupIdentifier;
	
	
	public String getUniqueID() {
		return UniqueID;
	}
	public void setUniqueID(String uniqueID) {
		UniqueID = uniqueID;
	}
	public String getOwnerID() {
		return ownerID;
	}
	public void setOwnerID(String ownerID) {
		this.ownerID = ownerID;
	}
	public String getGroupIdentifier() {
		return GroupIdentifier;
	}
	public void setGroupIdentifier(String groupIdentifier) {
		GroupIdentifier = groupIdentifier;
	}
}
