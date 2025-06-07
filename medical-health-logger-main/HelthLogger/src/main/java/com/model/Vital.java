package com.model;

import java.sql.Timestamp;

public class Vital {
	  private int id;
	    private int patientId;
	    private int bpLow;
	    private int bpHigh;
	    private int spo2;
	    private Timestamp recordedOn;
	    private String patientName;
	    private String patientPhone;
	 
	    // No-argument constructor
	    public Vital() {
	    }
	 
	    // Parameterized constructor
	    public Vital(int id, int patientId, int bpLow, int bpHigh, int spo2, Timestamp recordedOn, String patientName, String patientPhone) {
	        this.id = id;
	        this.patientId = patientId;
	        this.bpLow = bpLow;
	        this.bpHigh = bpHigh;
	        this.spo2 = spo2;
	        this.recordedOn = recordedOn;
	        this.patientName = patientName;
	        this.patientPhone = patientPhone;
	    }
	 
	    // Getters and Setters
	    public int getId() { return id; }
	    public void setId(int id) { this.id = id; }
	    public int getPatientId() { return patientId; }
	    public void setPatientId(int patientId) { this.patientId = patientId; }
	    public int getBpLow() { return bpLow; }
	    public void setBpLow(int bpLow) { this.bpLow = bpLow; }
	    public int getBpHigh() { return bpHigh; }
	    public void setBpHigh(int bpHigh) { this.bpHigh = bpHigh; }
	    public int getSpo2() { return spo2; }
	    public void setSpo2(int spo2) { this.spo2 = spo2; }
	    public Timestamp getRecordedOn() { return recordedOn; }
	    public void setRecordedOn(Timestamp recordedOn) { this.recordedOn = recordedOn; }
	    public String getPatientName() { return patientName; }
	    public void setPatientName(String patientName) { this.patientName = patientName; }
	    public String getPatientPhone() { return patientPhone; }
	    public void setPatientPhone(String patientPhone) { this.patientPhone = patientPhone; }
}
