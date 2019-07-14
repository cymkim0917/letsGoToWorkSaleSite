package com.kh.lgtwhp.admin.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Contract implements Serializable{
	private int fileNo;
	private String originName;
	private String changeName;
	private String filePath;
	private Date uploadDate;
	private int clientNo;
	
	public Contract() {}
	
	public Contract(int fileNo, String originName, String changeName, String filePath, Date uploadDate, int clientNo) {
		super();
		this.fileNo = fileNo;
		this.originName = originName;
		this.changeName = changeName;
		this.filePath = filePath;
		this.uploadDate = uploadDate;
		this.clientNo = clientNo;
	}
	public int getFileNo() {
		return fileNo;
	}
	public String getOriginName() {
		return originName;
	}
	public String getChangeName() {
		return changeName;
	}
	public String getFilePath() {
		return filePath;
	}
	public Date getUploadDate() {
		return uploadDate;
	}
	public int getClientNo() {
		return clientNo;
	}
	public void setFileNo(int fileNo) {
		this.fileNo = fileNo;
	}
	public void setOriginName(String originName) {
		this.originName = originName;
	}
	public void setChangeName(String changeName) {
		this.changeName = changeName;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public void setUploadDate(Date uploadDate) {
		this.uploadDate = uploadDate;
	}
	public void setClientNo(int clientNo) {
		this.clientNo = clientNo;
	}
	@Override
	public String toString() {
		return "Contract [fileNo=" + fileNo + ", originName=" + originName + ", changeName=" + changeName
				+ ", filePath=" + filePath + ", uploadDate=" + uploadDate + ", clientNo=" + clientNo + "]";
	}
	
	
	
}