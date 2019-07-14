package com.kh.lgtwhp.admin.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Client implements Serializable{
	private int clientNo;
	private String clientName;
	private String managerName;
	private String managerPhone;
	private String managerMail;
	private Date startDate;
	private Date endDate;
	private String productCode;
	private String product;
	private String paymentType;
	private String domainUrl;
	private String clientDB;
	private String maxUser;
	private String status;
	private int price;
	
	
	public Client() {}


	public Client(int clientNo, String clientName, String managerName, String managerPhone, String managerMail,
			Date startDate, Date endDate, String productCode, String product, String paymentType, String domainUrl,
			String clientDB, String maxUser, String status, int price) {
		super();
		this.clientNo = clientNo;
		this.clientName = clientName;
		this.managerName = managerName;
		this.managerPhone = managerPhone;
		this.managerMail = managerMail;
		this.startDate = startDate;
		this.endDate = endDate;
		this.productCode = productCode;
		this.product = product;
		this.paymentType = paymentType;
		this.domainUrl = domainUrl;
		this.clientDB = clientDB;
		this.maxUser = maxUser;
		this.status = status;
		this.price = price;
	}


	public int getClientNo() {
		return clientNo;
	}


	public String getClientName() {
		return clientName;
	}


	public String getManagerName() {
		return managerName;
	}


	public String getManagerPhone() {
		return managerPhone;
	}


	public String getManagerMail() {
		return managerMail;
	}


	public Date getStartDate() {
		return startDate;
	}


	public Date getEndDate() {
		return endDate;
	}


	public String getProductCode() {
		return productCode;
	}


	public String getProduct() {
		return product;
	}


	public String getPaymentType() {
		return paymentType;
	}


	public String getDomainUrl() {
		return domainUrl;
	}


	public String getClientDB() {
		return clientDB;
	}


	public String getMaxUser() {
		return maxUser;
	}


	public String getStatus() {
		return status;
	}


	public int getPrice() {
		return price;
	}


	public void setClientNo(int clientNo) {
		this.clientNo = clientNo;
	}


	public void setClientName(String clientName) {
		this.clientName = clientName;
	}


	public void setManagerName(String managerName) {
		this.managerName = managerName;
	}


	public void setManagerPhone(String managerPhone) {
		this.managerPhone = managerPhone;
	}


	public void setManagerMail(String managerMail) {
		this.managerMail = managerMail;
	}


	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}


	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}


	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}


	public void setProduct(String product) {
		this.product = product;
	}


	public void setPaymentType(String paymentType) {
		this.paymentType = paymentType;
	}


	public void setDomainUrl(String domainUrl) {
		this.domainUrl = domainUrl;
	}


	public void setClientDB(String clientDB) {
		this.clientDB = clientDB;
	}


	public void setMaxUser(String maxUser) {
		this.maxUser = maxUser;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public void setPrice(int price) {
		this.price = price;
	}


	@Override
	public String toString() {
		return "Client [clientNo=" + clientNo + ", clientName=" + clientName + ", managerName=" + managerName
				+ ", managerPhone=" + managerPhone + ", managerMail=" + managerMail + ", startDate=" + startDate
				+ ", endDate=" + endDate + ", productCode=" + productCode + ", product=" + product + ", paymentType="
				+ paymentType + ", domainUrl=" + domainUrl + ", clientDB=" + clientDB + ", maxUser=" + maxUser
				+ ", status=" + status + ", price=" + price + "]";
	}


	
	
}